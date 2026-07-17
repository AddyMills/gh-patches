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
			GameFrame}
		repeat
		if ($shutdown_game_for_signin_change_flag = 1)
			return
		endif
		change lnlwl_dlc_already_scanned = 1
	endif
	if ($invite_controller != -1)
		change \{signin_jam_mode = 0}
		spawnscriptnow \{ui_boot_guitar_follow_invite}
		return
	endif
	if NOT ui_event_exists_in_stack \{name = 'mainmenu'}
		if isRBDrum \{controller = $primary_controller}
			ui_event_wait event = menu_replace data = {state = uistate_optimal_drum event_params = <event_params>}
		else
			ui_event_wait <event_params>
		endif
	else
		ui_event_wait <event_params>
	endif
	if structurecontains structure = (<event_params>.data) state
		if ((<event_params>.data.state) = uistate_jam)
			create_loading_screen \{jam_mode = 1}
		endif
	endif
	change respond_to_signin_changed = ($store_respond_to_signin_changed)
endscript

// Don't blow away dlc when sign in changed (remaining funcs)
script main_menu_signin_changed 
	printf \{qs("\Lmain_menu_signin_changed")}
	//RemoveContentFiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
	MonitorControllerStates
endscript

script ui_signin_changed_func 
	printf \{qs("\Lui_signin_changed_func")}
	//RemoveContentFiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
endscript

script ui_band_mode_signin_changed 
	printf \{qs("\Lui_band_mode_signin_changed")}
	if (($primary_controller = <controller>) && ($is_network_game = 1))
		handle_signin_changed
		return
	endif
	//RemoveContentFiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
	get_player_num_from_controller controller_index = <controller>
	ui_band_mode_kill_character player = <player_num>
	MyInterfaceElement :GetTags
	controller_signin = <controller>
	index = 0
	GetArraySize <menus>
	begin
	current_menu = (<menus> [<index>])
	<current_menu> :GetSingleTag controller
	if (<controller> = <controller_signin>)
		break
	endif
	index = (<index> + 1)
	repeat <array_size>
	current_desc = (<descs> [<index>])
	<current_desc> :SE_SetProps reposition_pos = (0.0, 450.0) ready_banner_pos = (0.0, 500.0) time = 0.1 motion = ease_in
	begin
	if NOT scriptisrunning \{ui_band_mode_signin}
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	<current_menu> :GetSingleTag menu
	if (($is_network_game = 1) && (<menu> = net_remote_root))
		menu = net_remote_root
	else
		menu = join
	endif
	<current_menu> :SetTags {menu = <menu> instrument = none difficulty = none marked_in = 0}
	ui_band_mode_helper_text
	<current_menu> :Obj_SpawnScriptNow ui_band_mode_update_menu
	<current_menu> :GetSingleTag controller_instrument
	switch <controller_instrument>
		case guitar
		MyInterfaceElement :SetTags {current_guitar = (<current_guitar> - 1)}
		case drum
		MyInterfaceElement :SetTags {current_drum = (<current_drum> - 1)}
		case mic
		if (($allow_controller_for_all_instruments) = 0)
			MyInterfaceElement :SetTags {current_mic = (<current_mic> - 1)}
		endif
	endswitch
	<current_menu> :SetTags controller_instrument = none
endscript

script ui_band_name_logo_signin_changed controller = ($primary_controller)
	printf \{qs("\Lui_band_name_logo_signin_changed")}
	if (($primary_controller = <controller>) ||
			($band_name_logo_controller = <controller>))
		handle_signin_changed
		return
	endif
	//RemoveContentFiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
endscript

script shutdown_game_for_signin_change \{unloadcontent = 1
		signin_change = 0}
	printf \{qs("\Lshutdown_game_for_signin_change")}
	killspawnedscript \{name = SpawnedOneShotBeginRepeatLoop}
	killspawnedscript \{name = OneShotsBetweenSongs}
	killspawnedscript \{name = SurgeBetweenSongs}
	spawnscriptnow \{Kill_Transition_Preload_Streams}
	change \{shutdown_game_for_signin_change_flag = 1}
	StopAllSounds
	KillMenuMusic
	killspawnedscript \{name = net_init}
	killspawnedscript \{name = do_calibration_update}
	killspawnedscript \{name = cl_do_ping}
	killspawnedscript \{name = kill_off_and_finish_calibration}
	killspawnedscript \{name = menu_calibrate_lag_create_circles}
	killspawnedscript \{name = gameplay_end_game}
	killspawnedscript \{name = matchmaking_countdown_end_game_script_spawned}
	killspawnedscript \{name = net_party_lost_party_connection_kill_popup}
	netsessionfunc \{obj = match
		func = cancel_join_server}
	set_demonware_failed
	destroy_player_drop_events
	destroy_alert_popup \{force = 1
		no_sound = 1}
	end_practice_song_slomo
	memcard_sequence_cleanup_generic
	destroy_leaving_lobby_dialog
	kill_intro_celeb_ui
	killspawnedscript \{name = create_exploding_text}
	destroy_all_exploding_text
	cheat_turnoffalllocked
	destroy_credits_menu
	quit_network_game_early \{signin_change}
	killspawnedscript \{name = gameplay_end_game}
	killspawnedscript \{name = play_song_game_over_spawned}
	setup_sessionfuncs
	if netsessionfunc \{obj = session
			func = has_active_session}
		netsessionfunc \{obj = session
			func = stop_singleplayer_session}
	endif
	tutorial_shutdown
	deregisteratoms
	kill_gem_scroller \{no_render = 1
		restarting}
	destroy_movie_viewport
	clean_up_user_control_helpers
	menu_music_off
	unload_songqpak
	SetPakManCurrentBlock \{map = Zones
		pak = none
		block_scripts = 1}
	destroy_band \{unload_paks}
	destroy_downloads_EnumContent
	if (<unloadcontent> = 1)
		//Downloads_UnloadContent
		//RemoveContentFiles \{playerid = -1}
		reset_globaltags_all
	endif
	if ScreenElementExists \{id = ready_container_p2}
		DestroyScreenElement \{id = ready_container_p2}
	endif
	set_default_misc_globals
	cleanup_songwon_event
	clear_wait_for_net_match_available_items
	unpausegame
	change \{shutdown_game_for_signin_change_flag = 0}
	printf \{qs("\Lshutdown_game_for_signin_change end")}
endscript

script sysnotify_handle_signin_change 
	printf \{qs("\L--------------------------------")}
	printf qs("\Lsysnotify_handle_signin_change %d") d = <controller>
	printf \{qs("\L--------------------------------")}
	if ($invite_controller = <controller>)
		change \{invite_controller = -1}
	endif
	if ($signin_change_happening = 1)
		printf \{qs("\LALREADY BEING PROCESSED")}
		return
	endif
	if (<message> = live_connection_lost)
		if NOT ($is_network_game)
			printf \{qs("\LDISCARDING CONNECTION LOSS IN OFFLINE GAME")}
			return
		endif
	endif
	change \{signin_change_happening = 1}
	sysnotify_wait_until_safe
	if ($ui_x360_sign_in_checked = 1)
		change \{ui_x360_sign_in_checked = 0}
		change \{signin_change_happening = 0}
		return
	endif
	switch <message>
		case live_connection_lost
		if NOT ($is_network_game)
			SoftAssert \{qs("\LInternal signin error")}
			change \{signin_change_happening = 0}
			return
		else
			sysnotify_handle_connection_loss
		endif
		case live_connection_gained
		if (($playing_song) && ($is_network_game = 0))
			xenon_singleplayer_session_init
			change \{signin_change_happening = 0}
			return
		else
			change \{signin_change_happening = 0}
			return
		endif
		case user_changed
		printf \{qs("\Lsysnotify_handle_signin_change - user changed")}
		if ($respond_to_signin_changed = 1)
			if (<controller> = ($primary_controller))
				printf \{qs("\Lsysnotify_handle_signin_change - user changed - primary")}
				handle_signin_changed
			else
				if ($respond_to_signin_changed_all_players = 1)
					printf \{qs("\Lsysnotify_handle_signin_change - user changed - all_players ")}
					if ($is_network_game)
						get_local_players_in_game
					else
						GameMode_GetNumPlayersShown
						num_local_players = <num_players_shown>
					endif
					index = 1
					if (<num_local_players> > 0)
						begin
						FormatText checksumname = player_status 'player%d_status' d = <index>
						printstruct <...>
						if ($<player_status>.controller = <controller>)
							printf qs("\Lsysnotify_handle_signin_change - user changed - secondary %i %c") i = <index> c = <controller>
							handle_signin_changed
							change \{signin_change_happening = 0}
							return
						endif
						index = (<index> + 1)
						repeat <num_local_players>
					endif
					if ($playing_song = 1)
						//RemoveContentFiles playerid = <controller>
						mark_globaltags_to_invalidate savegame = <controller>
						cheat_turnoffalllocked
					else
						//RemoveContentFiles playerid = <controller>
						reset_globaltags savegame = <controller>
						cheat_turnoffalllocked
					endif
				else
					printf \{qs("\Lsysnotify_handle_signin_change - user changed - all_players resetting")}
					//RemoveContentFiles playerid = <controller>
					reset_globaltags savegame = <controller>
					cheat_turnoffalllocked
				endif
			endif
		else
			printf \{qs("\Lrespond_to_signin_changed_func")}
			if NOT ($respond_to_signin_changed_func = none)
				func = ($respond_to_signin_changed_func)
				<func> <...>
			endif
		endif
		default
		printf \{qs("\L- no response required")}
		change \{signin_change_happening = 0}
		return
	endswitch
	change \{signin_change_happening = 0}
endscript

// fucjk
script DownloadContentLost_Spawned 
	if NOT ($shutdown_game_for_signin_change_flag = 0)
		return
	endif
	if ($respond_to_signin_changed = 0)
		return
	endif
	change \{respond_to_signin_changed = 0}
	printf \{qs("\LDownloadContentLost_Spawned")}
	disable_pause
	create_loading_screen \{no_bink}
	ui_event_block \{event = menu_back
		data = {
			state = UIstate_Null
		}}
	shutdown_game_for_signin_change
	// actually rescan if dlc is really bad
	change lnlwl_dlc_already_scanned = 0
	RemoveContentFiles \{playerid = -1
		clear_cache}
	ui_event_block \{event = menu_change
		data = {
			state = uistate_signin_changed
			clear_previous_stack
		}}
	destroy_loading_screen \{force = 1}
	LaunchEvent \{type = unfocus
		target = root_window}
	create_downloadcontentlost_menu
	startrendering
	SetButtonEventMappings \{unblock_menu_input}
	printf \{qs("\LDownloadContentLost")}
endscript