// Instant memcard check/save/load

script memcard_choose_storage_device \{StorageSelectorForce = 0}
	printscriptinfo \{qs("==> memcard_choose_storage_device")}
	create_checking_memory_card_screen
	//Wait \{1
	//	seconds}
	MC_SetActivePlayer userid = ($MemcardController)
	if NOT CardIsInSlot
		if (<StorageSelectorForce> = 0)
			// persist cache if a new profile overrides globals
			//change lnlwl_dlc_already_scanned = 1  // referenced in download.q
			// ^ we dont need this in ghsh
			goto \{create_storagedevice_warning_menu}
		endif
	endif
	dump
	ShowStorageSelector force = <StorageSelectorForce> filetype = progress
endscript

script memcard_save_file \{overwriteconfirmed = 0}
	printf \{qs("\L==> memcard_save_file")}
	mark_unsafe_for_shutdown
	change \{memcardsavingorloading = saving}
	memcard_check_for_card
	resettimer
	<overwrite> = 0
	if mc_folderexists \{foldername = $memcard_content_name}
		if (<overwriteconfirmed> = 1)
			<overwrite> = 1
			create_overwrite_menu
			resettimer
			mc_setactivefolder \{foldername = $memcard_content_name}
		else
			goto \{create_confirm_overwrite_menu}
		endif
	else
		if NOT MC_SpaceForNewFolder \{desc = guitarcontent}
			memcard_error \{error = create_out_of_space_menu}
		endif
		create_save_menu
		resettimer
		mc_createfolder \{name = $memcard_content_name
			desc = guitarcontent}
		if (<result> = false)
			if (<errorcode> = outofspace)
				memcard_error \{error = create_out_of_space_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
		get_savegame_from_controller controller = ($MemcardController)
		SetGlobalTags user_options savegame = <savegame> Params = {autosave = 1}
	endif
	mc_setactivefolder \{foldername = $memcard_content_name}
	mc_loadtocinactivefolder
	memcard_pre_save_progress
	write_globals_to_global_tags
	PushTempMemCardPools \{heap = heap_bink}
	savetomemorycard \{filename = $memcard_file_name
		filetype = progress
		usepaddingslot = always}
	PopTempMemCardPools
	if (<result> = false)
		if (<errorcode> = outofspace)
			memcard_error \{error = create_out_of_space_menu}
		else
			if (<errorcode> = corrupt)
				memcard_error \{error = create_corrupted_data_menu}
			elseif (<overwrite> = 1)
				memcard_error \{error = create_overwrite_failed_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	refresh_jam_directory_contents
	change \{memcardsuccess = true}
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
	mc_waitasyncopsfinished
	if isps3
		CreateScreenElement \{type = SpriteElement
			id = ps3_delete_fader
			parent = root_window
			texture = black
			rgba = [
				0
				0
				0
				255
			]
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			z_priority = $ps3_fade_overlay_z
			alpha = 1.0}
		mc_startps3forcedelete
		begin
		if mc_isps3forcedeletefinished
			break
		endif
		Wait \{1
			gameframes}
		repeat
		refresh_jam_directory_contents
		if NOT (<file_type> = jam_file)
			mc_setactivefolder \{foldername = $memcard_content_name}
			mc_loadtocinactivefolder
		endif
		DestroyScreenElement \{id = ps3_delete_fader}
	else
		if (<file_type> = `default`)
			if mc_folderexists \{foldername = $memcard_content_name}
				resettimer
				mc_deletefolder \{foldername = $memcard_content_name}
				if (<result> = false)
					memcard_error \{error = create_delete_failed_menu}
				endif
				//memcard_wait_for_timer
			endif
		endif
		if (<file_type> = jam_file)
			if mc_folderexists \{foldername = $memcard_content_jamsession_name}
				resettimer
				mc_deletefolder \{foldername = $memcard_content_jamsession_name}
				if (<result> = false)
					memcard_error \{error = create_delete_failed_menu}
				endif
				//memcard_wait_for_timer
				create_delete_success_menu
			endif
		endif
		//Wait \{1
		//	seconds}
	endif
	if NotCD
		DeleteAllSongDataFromFile
	endif
	memcard_check_for_card
	memcard_sequence_retry
endscript

script memcard_load_file \{loadconfirmed = 0}
	mark_unsafe_for_shutdown
	printf \{qs("\L==> memcard_load_file")}
	change \{memcardsavingorloading = loading}
	mc_waitasyncopsfinished
	memcard_check_for_card
	resettimer
	if mc_folderexists \{foldername = $memcard_content_name}
		if (<loadconfirmed> = 1)
			mc_setactivefolder \{foldername = $memcard_content_name}
		else
			goto \{create_confirm_load_menu}
		endif
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	mc_setactivefolder \{foldername = $memcard_content_name}
	create_load_file_menu
	PushTempMemCardPools \{heap = heap_bink}
	loadfrommemorycard \{filename = $memcard_file_name
		filetype = progress}
	PopTempMemCardPools
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	refresh_jam_directory_contents
	change \{memcardsuccess = true}
	//memcard_wait_for_timer
	create_load_success_menu
	memcard_post_load_progress
	//Wait \{1
	//	seconds}
	memcard_sequence_quit
endscript

script memcard_save_jam \{overwriteconfirmed = 0
		card_was_in_slot = true}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcardsavingorloading = saving}
	memcard_check_for_card
	resettimer
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam")}
	memcard_enum_folders
	create_save_menu
	if mc_folderexists \{foldername = $memcard_jamsession_content_name}
		if (<card_was_in_slot> = false)
			if (<overwriteconfirmed> = 1)
				<overwrite> = 1
				create_overwrite_menu
				resettimer
				mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
			else
				goto \{create_confirm_overwrite_menu}
			endif
		else
			mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
		endif
	else
		if NOT MC_SpaceForNewFolder \{desc = guitarcontent}
			memcard_error \{error = create_out_of_space_menu}
		endif
		mc_createfolder \{name = $memcard_jamsession_content_name
			desc = JamSessionsContent}
		if (<result> = false)
			if (<errorcode> = outofspace)
				memcard_error \{error = create_out_of_space_menu}
			else
				memcard_error \{error = create_save_failed_menu}
			endif
		endif
	endif
	mc_loadtocinactivefolder
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
	savetomemorycard \{filename = $memcard_jamsession_file_name
		filetype = jamsession
		usepaddingslot = never}
	if (<result> = false)
		if (<errorcode> = outofspace)
			memcard_error \{error = create_out_of_space_menu}
		elseif (<errorcode> = badfolder)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_save_failed_menu}
		endif
	endif
	loadfrommemorycard \{filename = $memcard_jamsession_file_name
		filetype = jamsession}
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	change \{jam_selected_song = $memcard_jamsession_file_name}
	getmemcarddirectorylisting
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam end")}
	change \{memcardsuccess = true}
	//memcard_wait_for_timer
	create_save_success_menu
	guitar_memcard_save_success_sound
	change \{save_data_dirty = 0}
	//Wait \{1
	//	seconds}
	if NOT mc_folderexists \{foldername = $memcard_content_name}
		if NOT MC_SpaceForNewFolder \{desc = guitarcontent}
			memcard_error \{error = create_out_of_space_menu
				Params = {
					message_type = progress
				}}
		endif
	endif
	memcard_sequence_quit
	printf \{channel = jam_mode
		qs("\Lmemcard_save_jam quit")}
endscript

script memcard_load_jam 
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcardsavingorloading = loading}
	memcard_check_for_card
	resettimer
	printf \{channel = jam_mode
		qs("\Lmemcard_load_jam")}
	memcard_enum_folders
	create_load_file_menu
	if mc_folderexists \{foldername = $memcard_jamsession_content_name}
		mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	mc_loadtocinactivefolder
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	loadfrommemorycard \{filename = $memcard_jamsession_file_name
		filetype = jamsession}
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	change \{jam_selected_song = $memcard_jamsession_file_name}
	printf \{channel = jam_mode
		qs("\Lmemcard_load_jam end")}
	change \{memcardsuccess = true}
	//memcard_wait_for_timer
	create_load_success_menu
	//Wait \{1
	//	seconds}
	memcard_sequence_quit
endscript

script memcard_rename_jam 
	printf \{channel = jam_mode
		qs("\Lmemcard_rename_jam")}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcardsavingorloading = loading}
	memcard_check_for_card
	resettimer
	printf \{channel = jam_mode
		qs("\Ljamsession_renamememcardfile")}
	memcard_enum_folders
	create_save_menu
	if mc_folderexists \{foldername = $memcard_jamsession_content_name}
		mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	mc_loadtocinactivefolder
	mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	RenameMemCardFile \{filename = $memcard_jamsession_file_name
		filetype = jamsession
		newfilename = $memcard_jamsession_new_file_name}
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_load_failed_menu}
		endif
	endif
	savetomemorycard \{filename = $memcard_jamsession_new_file_name
		filetype = jamsession
		usepaddingslot = never}
	if (<result> = false)
		if (<errorcode> = outofspace)
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
	getmemcarddirectorylisting
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	printf \{channel = jam_mode
		qs("\Ljamsession_renamememcardfile end")}
	change \{memcardsuccess = true}
	//memcard_wait_for_timer
	create_rename_success_menu
	guitar_memcard_save_success_sound
	//Wait \{1
	//	seconds}
	memcard_sequence_quit
endscript

script memcard_delete_jam 
	printf \{channel = jam_mode
		qs("\Lmemcard_delete_jam")}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcardsavingorloading = saving}
	memcard_check_for_card
	resettimer
	memcard_enum_folders
	create_delete_menu
	if mc_folderexists \{foldername = $memcard_jamsession_content_name}
		mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	else
		memcard_error \{error = create_no_save_found_menu}
	endif
	mc_loadtocinactivefolder
	mc_setactivefolder \{foldername = $memcard_jamsession_content_name}
	deletememcardfile \{filename = $memcard_jamsession_file_name
		filetype = jamsession}
	if (<result> = false)
		if (<errorcode> = corrupt)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		elseif (<errorcode> = badfolder)
			memcard_error \{error = create_corrupted_data_menu
				Params = {
					file_type = jam_file
				}}
		else
			memcard_error \{error = create_save_failed_menu}
		endif
	endif
	getmemcarddirectorylisting
	jam_update_controller_directory_listing controller = ($MemcardController) directorylisting = <directorylisting>
	change jam_curr_directory_listing = <directorylisting>
	change \{memcardsuccess = true}
	//memcard_wait_for_timer
	create_delete_success_menu
	guitar_memcard_save_success_sound
	//Wait \{1
	//	seconds}
	memcard_sequence_quit
	printf \{channel = jam_mode
		qs("\Lmemcard_delete_jam end")}
endscript