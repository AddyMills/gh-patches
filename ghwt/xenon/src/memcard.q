lnlwl_dlc_already_scanned = 0

// instant check/save/load

script memcard_choose_storage_device \{StorageSelectorForce = 0}
	printscriptinfo \{qs("==> memcard_choose_storage_device")}
	create_checking_memory_card_screen
	MC_SetActivePlayer userid = ($MemcardController)
	if NOT CardIsInSlot
		if (<StorageSelectorForce> = 0)
			// persist cache if a new profile overrides globals
			change lnlwl_dlc_already_scanned = 1
			goto \{create_storagedevice_warning_menu}
		endif
	endif
	dump
	ShowStorageSelector force = <StorageSelectorForce> FileType = Progress
endscript

// This one might need some time
script memcard_save_file \{OverwriteConfirmed = 0}
	printf \{qs("\L==> memcard_save_file")}
	mark_unsafe_for_shutdown
	change \{MemcardSavingOrLoading = Saving}
	memcard_check_for_card
	ResetTimer
	<overwrite> = 0
	if MC_FolderExists \{FolderName = $memcard_content_name}
		if (<OverwriteConfirmed> = 1)
			<overwrite> = 1
			create_overwrite_menu
			ResetTimer
			MC_SetActiveFolder \{FolderName = $memcard_content_name}
		else
			goto \{create_confirm_overwrite_menu}
		endif
	else
		if NOT MC_SpaceForNewFolder \{desc = GuitarContent}
			memcard_error \{error = create_out_of_space_menu}
		endif
		create_save_menu
		ResetTimer
		MC_CreateFolder \{name = $memcard_content_name
			desc = GuitarContent}
		if (<result> = false)
			if (<ErrorCode> = OutOfSpace)
				memcard_error \{error = create_out_of_space_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	MC_SetActiveFolder \{FolderName = $memcard_content_name}
	MC_LoadTOCInActiveFolder
	memcard_pre_save_progress
	write_globals_to_global_tags
	PushTempMemCardPools \{heap = heap_bink}
	SaveToMemoryCard \{filename = $memcard_file_name
		FileType = Progress
		usepaddingslot = always}
	PopTempMemCardPools
	if (<result> = false)
		if (<ErrorCode> = OutOfSpace)
			memcard_error \{error = create_out_of_space_menu}
		else
			if (<ErrorCode> = corrupt)
				memcard_error \{error = create_corrupted_data_menu}
			elseif (<overwrite> = 1)
				memcard_error \{error = create_overwrite_failed_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	refresh_jam_directory_contents
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	if (<overwrite> = 1)
		create_overwrite_success_menu
	else
		create_save_success_menu
	endif
	change \{save_data_dirty = 0}
	guitar_memcard_save_success_sound
	//Wait \{1
	//	seconds}
	memcard_sequence_quit
endscript

script memcard_delete_file \{file_type = `default`}
	printf \{qs("\L==> memcard_delete_file")}
	mark_unsafe_for_shutdown
	create_delete_file_menu
	MC_WaitAsyncOpsFinished
	if IsPs3
		fade_overlay_on \{alpha = 1.0}
		MC_StartPS3ForceDelete
		begin
		if MC_IsPS3ForceDeleteFinished
			break
		endif
		Wait \{1
			gameframes}
		repeat
		refresh_jam_directory_contents
		if NOT (<file_type> = jam_file)
			MC_SetActiveFolder \{FolderName = $memcard_content_name}
			MC_LoadTOCInActiveFolder
		endif
		fade_overlay_off
	else
		if (<file_type> = `default`)
			if MC_FolderExists \{FolderName = $memcard_content_name}
				ResetTimer
				MC_DeleteFolder \{FolderName = $memcard_content_name}
				if (<result> = false)
					memcard_error \{error = create_delete_failed_menu}
				endif
				//memcard_wait_for_timer
			endif
		endif
		if (<file_type> = jam_file)
			if MC_FolderExists \{FolderName = $memcard_content_jamsession_name}
				ResetTimer
				MC_DeleteFolder \{FolderName = $memcard_content_jamsession_name}
				if (<result> = false)
					memcard_error \{error = create_delete_failed_menu}
				endif
				//memcard_wait_for_timer
				create_delete_success_menu
			endif
		endif
	endif
	if NotCD
		DeleteAllSongDataFromFile
	endif
	memcard_check_for_card
	memcard_sequence_retry
endscript

script memcard_load_file \{LoadConfirmed = 0}
	mark_unsafe_for_shutdown
	printf \{qs("\L==> memcard_load_file")}
	change \{MemcardSavingOrLoading = loading}
	MC_WaitAsyncOpsFinished
	memcard_check_for_card
	ResetTimer
	if MC_FolderExists \{FolderName = $memcard_content_name}
		if (<LoadConfirmed> = 1)
			MC_SetActiveFolder \{FolderName = $memcard_content_name}
		else
			goto \{create_confirm_load_menu}
		endif
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	MC_SetActiveFolder \{FolderName = $memcard_content_name}
	create_load_file_menu
	PushTempMemCardPools \{heap = heap_bink}
	LoadFromMemoryCard \{filename = $memcard_file_name
		FileType = Progress}
	PopTempMemCardPools
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	refresh_jam_directory_contents
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	create_load_success_menu
	memcard_post_load_progress
	memcard_sequence_quit
endscript

script memcard_save_jam \{OverwriteConfirmed = 0
		card_was_in_slot = true}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardSavingOrLoading = Saving}
	memcard_check_for_card
	ResetTimer
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam")}
	memcard_enum_folders
	create_save_menu
	if MC_FolderExists \{FolderName = $memcard_jamsession_content_name}
		if (<card_was_in_slot> = false)
			if (<OverwriteConfirmed> = 1)
				<overwrite> = 1
				create_overwrite_menu
				ResetTimer
				MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
			else
				goto \{create_confirm_overwrite_menu}
			endif
		else
			MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
		endif
	else
		if NOT MC_SpaceForNewFolder \{desc = GuitarContent}
			memcard_error \{error = create_out_of_space_menu}
		endif
		MC_CreateFolder \{name = $memcard_jamsession_content_name
			desc = JamSessionsContent}
		if (<result> = false)
			if (<ErrorCode> = OutOfSpace)
				memcard_error \{error = create_out_of_space_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	MC_LoadTOCInActiveFolder
	jam_publish_update_playback_track \{guitar_num = 1}
	jam_publish_update_playback_track \{guitar_num = 2}
	jam_publish_update_playback_drumvocal_track
	downloaded = 0
	GetSongInfo
	change memcard_jamsession_song_version = <song_version>
	change memcard_jamsession_downloaded = <downloaded>
	if GotParam \{file_id}
		change memcard_jamsession_fileid = <file_id>
	endif
	change memcard_jamsession_artist = <artist>
	change memcard_jamsession_playback_track1 = <playback_track1>
	change memcard_jamsession_playback_track2 = <playback_track2>
	change memcard_jamsession_playback_track_drums = <playback_track_drums>
	change memcard_jamsession_playback_track_vocals = <playback_track_vocals>
	SaveToMemoryCard \{filename = $memcard_jamsession_file_name
		FileType = jamsession
		usepaddingslot = never}
	if (<result> = false)
		if (<ErrorCode> = OutOfSpace)
			memcard_error \{error = create_out_of_space_menu}
		elseif (<ErrorCode> = badfolder)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_save_failed_menu}
		endif
	endif
	LoadFromMemoryCard \{filename = $memcard_jamsession_file_name
		FileType = jamsession}
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	change \{jam_selected_song = $memcard_jamsession_file_name}
	GetMemCardDirectoryListing
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam end")}
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	create_save_success_menu
	guitar_memcard_save_success_sound
	change \{save_data_dirty = 0}
	if NOT MC_FolderExists \{FolderName = $memcard_content_name}
		if NOT MC_SpaceForNewFolder \{desc = GuitarContent}
			memcard_error \{error = create_out_of_space_menu
				params = {
					message_type = Progress
				}}
		endif
	endif
	memcard_sequence_quit
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam quit")}
endscript

script memcard_load_jam 
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardSavingOrLoading = loading}
	memcard_check_for_card
	ResetTimer
	printf \{channel = jam_mode
		qs("\Lmemcard_load_jam")}
	memcard_enum_folders
	create_load_file_menu
	if MC_FolderExists \{FolderName = $memcard_jamsession_content_name}
		MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	MC_LoadTOCInActiveFolder
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	LoadFromMemoryCard \{filename = $memcard_jamsession_file_name
		FileType = jamsession}
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	change \{jam_selected_song = $memcard_jamsession_file_name}
	printf \{channel = jam_mode
		qs("\Lmemcard_load_jam end")}
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	create_load_success_menu
	memcard_sequence_quit
endscript

script memcard_rename_jam 
	printf \{channel = jam_mode
		qs("\Lmemcard_rename_jam")}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardSavingOrLoading = loading}
	memcard_check_for_card
	ResetTimer
	printf \{channel = jam_mode
		qs("\Ljamsession_renamememcardfile")}
	memcard_enum_folders
	create_save_menu
	if MC_FolderExists \{FolderName = $memcard_jamsession_content_name}
		MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	MC_LoadTOCInActiveFolder
	MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	RenameMemCardFile \{filename = $memcard_jamsession_file_name
		FileType = jamsession
		newfilename = $memcard_jamsession_new_file_name}
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	SaveToMemoryCard \{filename = $memcard_jamsession_new_file_name
		FileType = jamsession
		usepaddingslot = never}
	if (<result> = false)
		if (<ErrorCode> = OutOfSpace)
			memcard_error \{error = create_out_of_space_menu}
		else
			if (<overwrite> = 1)
				memcard_error \{error = create_overwrite_failed_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	change \{jam_selected_song = $memcard_jamsession_new_file_name}
	change \{memcard_jamsession_file_name = $memcard_jamsession_new_file_name}
	GetMemCardDirectoryListing
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	printf \{channel = jam_mode
		qs("\Ljamsession_renamememcardfile end")}
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	create_rename_success_menu
	guitar_memcard_save_success_sound
	memcard_sequence_quit
endscript

script memcard_delete_jam 
	printf \{channel = jam_mode
		qs("\Lmemcard_delete_jam")}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardSavingOrLoading = Saving}
	memcard_check_for_card
	ResetTimer
	memcard_enum_folders
	create_delete_menu
	if MC_FolderExists \{FolderName = $memcard_jamsession_content_name}
		MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	MC_LoadTOCInActiveFolder
	MC_SetActiveFolder \{FolderName = $memcard_jamsession_content_name}
	DeleteMemCardFile \{filename = $memcard_jamsession_file_name
		FileType = jamsession}
	if (<result> = false)
		if (<ErrorCode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		elseif (<ErrorCode> = badfolder)
			memcard_error \{error = create_corrupted_data_menu
				params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_save_failed_menu}
		endif
	endif
	GetMemCardDirectoryListing
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	change \{MemcardSuccess = true}
	//memcard_wait_for_timer
	create_delete_success_menu
	guitar_memcard_save_success_sound
	memcard_sequence_quit
	printf \{channel = jam_mode
		qs("\Lmemcard_delete_jam end")}
endscript

// only scan dlc once
// fuck me bro
script boot_download_scan \{event_params = {
			event = menu_replace
			data = {
				state = uistate_boot_guitar
			}
		}}
	if ($lnlwl_dlc_already_scanned = 0)
		Wait \{1
			gameframes}
		startrendering \{reason = menu_transition}
		if NOT ui_event_exists_in_stack \{name = 'mainmenu'}
			if ControllerPressed x <controller>
				if ControllerPressed circle <controller>
					if ControllerPressed square <controller>
						if ControllerPressed triangle <controller>
							printf \{qs("\LClearing download cache")}
							RemoveContentFiles \{playerid = -1
								clear_cache}
						endif
					endif
				endif
			endif
		endif
		GetStartTime
		Downloads_EnumContent controller = <controller>
		get_current_first_play
		begin
		GetElapsedTime StartTime = <StartTime>
		if (<ElapsedTime> > 1000)
			break
		endif
		Wait \{1
			gameframe}
		repeat
		if ($shutdown_game_for_signin_change_flag = 1)
			return
		endif
		change lnlwl_dlc_already_scanned = 1
	endif
	ui_event_wait <event_params>
	if ((<event_params>.data.state) = uistate_jam)
		create_loading_screen \{jam_mode = 1}
	endif
	change respond_to_signin_changed = ($store_respond_to_signin_changed)
endscript