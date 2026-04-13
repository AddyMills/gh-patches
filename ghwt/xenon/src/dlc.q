
script issongavailable \{for_bonus = 0}
	GameMode_GetType
	check_allowed_in_quickplay = 0
	if (($is_network_game = 1) || (<type> = quickplay) || (<type> = training))
		check_allowed_in_quickplay = 1
	endif
	if (($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff) || ($game_mode = p2_battle))
		check_allowed_in_quickplay = 1
	endif
	if (<check_allowed_in_quickplay> = 1)
		get_song_allowed_in_quickplay song = <song>
		if (<allowed_in_quickplay> = 0)
			return \{false}
		endif
	endif
	if structurecontains structure = ($gh_songlist_props.<song>) never_show_in_setlist
		return \{false}
	endif
	if ($is_network_game = 1)
		if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_vocals
			GameMode_GetNumPlayers
			GameMode_GetProperty \{prop = cooperative}
			if (<cooperative> = false)
				GameMode_GetProperty \{prop = faceoff}
				<should_disallow_vocals> = false
				if (<num_players> = 2 && <faceoff> = true)
					<should_disallow_vocals> = true
				elseif (<num_players> = 1)
					<should_disallow_vocals> = true
				endif
				if (<should_disallow_vocals> = true)
					<player_idx> = 1
					begin
					GetPlayerInfo <player_idx> part
					if (<part> = Vocals)
						return \{false}
					endif
					<player_idx> = (<player_idx> + 1)
					repeat <num_players>
				endif
			endif
		endif
		if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_drums
			GameMode_GetNumPlayers
			GameMode_GetProperty \{prop = cooperative}
			if (<cooperative> = false)
				GameMode_GetProperty \{prop = faceoff}
				<0x1fc258bb> = false
				if (<num_players> = 2 && <faceoff> = true)
					<0x1fc258bb> = true
				elseif (<num_players> = 1)
					<0x1fc258bb> = true
				endif
				if (<0x1fc258bb> = true)
					<player_idx> = 1
					begin
					GetPlayerInfo <player_idx> part
					if (<part> = drum)
						return \{false}
					endif
					<player_idx> = (<player_idx> + 1)
					repeat <num_players>
				endif
			endif
		endif
		if NOT is_song_downloaded song_checksum = <song>
			return \{false}
		endif
		if GlobalTagExists <song> noassert = 1
			GetGlobalTags <song>
			if ($net_match_dlc_sync_finished = 1)
				if (<available_on_other_client> = 0)
					return \{false}
				endif
			elseif (<download> = 1)
				return \{false}
			endif
		endif
		if ($is_multiplayer_beta = 0)
			get_song_saved_in_globaltags song = <song>
			if (<saved_in_globaltags> = 1)
				return \{true}
			endif
		else
			GetArraySize \{$OnlineBetaSongs}
			if (<array_size> > 0)
				index = 0
				begin
				if (<song> = ($OnlineBetaSongs [<index>]))
					return \{true}
				endif
				<index> = (<index> + 1)
				repeat <array_size>
			endif
		endif
	else
		if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_vocals
			GameMode_GetNumPlayers
			GameMode_GetProperty \{prop = cooperative}
			if (<cooperative> = false)
				GameMode_GetProperty \{prop = faceoff}
				<should_disallow_vocals> = false
				if (<num_players> = 2 && <faceoff> = true)
					<should_disallow_vocals> = true
				elseif (<num_players> = 1)
					<should_disallow_vocals> = true
				endif
				if (<should_disallow_vocals> = true)
					<player_idx> = 1
					begin
					GetPlayerInfo <player_idx> controller
					if NOT isguitarcontroller controller = <controller>
						if NOT IsDrumController controller = <controller>
							return \{false}
						endif
					endif
					<player_idx> = (<player_idx> + 1)
					repeat <num_players>
				endif
			endif
		endif
		if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_drums
			GameMode_GetNumPlayers
			GameMode_GetProperty \{prop = cooperative}
			if (<cooperative> = false)
				GameMode_GetProperty \{prop = faceoff}
				0x1fc258bb = false
				if (<num_players> = 2 && <faceoff> = true)
					0x1fc258bb = true
				elseif (<num_players> = 1)
					0x1fc258bb = true
				endif
				if (<0x1fc258bb> = true)
					<player_idx> = 1
					begin
					GetPlayerInfo <player_idx> controller
					if IsDrumController controller = <controller>
						return \{false}
					endif
					<player_idx> = (<player_idx> + 1)
					repeat <num_players>
				endif
			endif
		endif
		if NOT is_song_downloaded song_checksum = <song>
			return \{false}
		endif
		if (<download> = 1)
			return \{true}
		endif
		if structurecontains structure = ($gh_songlist_props.<song>) always_unlocked
			return \{true}
		endif
		get_song_saved_in_globaltags song = <song>
		if (<saved_in_globaltags> = 1)
			GetGlobalTags <song> param = unlocked
			if (<unlocked> = 1)
				return \{true}
			endif
			GetGlobalTags \{user_options}
			if (<cheat_index13> = 1)
				if (<song> != PullMeUnder)
					return \{true}
				endif
			endif
		endif
	endif
	return \{false}
endscript

script load_songqpak \{async = 0}
	get_song_performance song = <song_name>
	if NOT (<song_name> = $current_song_qpak &&
			<song_performance> = $current_song_qpak_performance)
		Transitions_ResetZone \{profile = $Profile_Ven_Camera_Obj}
		unload_songqpak
		if ($in_tutorial_mode = 0)
			guitar_force_unload_anim_paks \{not_wli}
		endif
		if (<song_name> = jamsession)
		else
			if (<song_performance> = 0)
				song_perf_ext = ''
			else
				FormatText textname = song_perf_ext '_perf%i' i = (<song_performance> + 1)
			endif
			get_song_prefix song = <song_name>
			is_song_downloaded song_checksum = <song_name>
			if (<download> = 1)
				if (<song_name> = DLC11 ||
						<song_name> = DLC12 ||
						<song_name> = DLC13 ||
						<song_name> = DLC14 ||
						<song_name> = DLC15 ||
						<song_name> = DLC16 ||
						<song_name> = DLC17 ||
						<song_name> = DLC18 ||
						<song_name> = DLC19 ||
						<song_name> = DLC20 ||
						<song_name> = DLC21)
					FormatText textname = songqpak 'a%i%s_song.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
				else
					FormatText textname = songqpak 'a%i%s_s.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
				endif
			else
				FormatText textname = songqpak 'songs/%i%s_song.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
			endif
			printf qs("\LLoading Song q pak : %i") i = <songqpak>
			EnableDuplicateSymbolWarning \{off}
			if NOT LoadPakAsync pak_name = <songqpak> heap = heap_song no_vram async = <async>
				EnableDuplicateSymbolWarning
				downloadcontentlost
				return
			endif
			EnableDuplicateSymbolWarning
		endif
		change current_song_qpak = <song_name>
		change current_song_qpak_performance = <song_performance>
		if GotParam \{song_prefix}
			FormatText checksumname = song_setup '%s_setup' s = <song_prefix>
			if ScriptExists <song_setup>
				spawnscriptnow <song_setup>
			endif
		endif
	endif
endscript

script unload_songqpak 
	if NOT ($current_song_qpak = none)
		if ($current_song_qpak = jamsession)
			jamsession_unload \{song_prefix = 'jamsession'}
			ClearJamSession
		else
			if ($current_song_qpak_performance = 0)
				song_perf_ext = ''
			else
				FormatText textname = song_perf_ext '_perf%i' i = ($current_song_qpak_performance + 1)
			endif
			get_song_prefix song = ($current_song_qpak)
			is_song_downloaded song_checksum = ($current_song_qpak)
			song_name = ($current_song_qpak)
			if (<download> = 1)
				if (<song_name> = DLC11 ||
						<song_name> = DLC12 ||
						<song_name> = DLC13 ||
						<song_name> = DLC14 ||
						<song_name> = DLC15 ||
						<song_name> = DLC16 ||
						<song_name> = DLC17 ||
						<song_name> = DLC18 ||
						<song_name> = DLC19 ||
						<song_name> = DLC20 ||
						<song_name> = DLC21)
					FormatText textname = songqpak 'a%i%s_song.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
				else
					FormatText textname = songqpak 'a%i%s_s.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
				endif
			else
				FormatText textname = songqpak 'songs/%i%s_song.pak' i = <song_prefix> s = <song_perf_ext> addtostringlookup = true
			endif
			printf qs("\LUnLoading Song q pak : %i") i = <songqpak>
			UnloadPak <songqpak>
		endif
		change \{current_song_qpak = none}
		change \{current_song_qpak_performance = 0}
	endif
endscript

script is_song_downloaded \{song_checksum = schoolsout}
	if structurecontains structure = ($download_songlist_props) <song_checksum>
		if (<song_checksum> = DLC11 ||
				<song_checksum> = DLC12 ||
				<song_checksum> = DLC13 ||
				<song_checksum> = DLC14 ||
				<song_checksum> = DLC15 ||
				<song_checksum> = DLC16 ||
				<song_checksum> = DLC17 ||
				<song_checksum> = DLC18 ||
				<song_checksum> = DLC19 ||
				<song_checksum> = DLC20 ||
				<song_checksum> = DLC21)
			FormatText textname = filename 'a%s_song.pak' s = (($download_songlist_props.<song_checksum>).name)
		else
			FormatText textname = filename 'a%s_s.pak' s = (($download_songlist_props.<song_checksum>).name)
		endif
		GetContentFolderIndexFromFile <filename>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	else
		return \{download = 0
			true}
	endif
endscript

script Downloads_LoadLanguageContent 
	if StringEquals a = <stem> b = 'adl1'
		FormatText textname = pakname '%s_text.pak' s = <stem>
		if english
			FormatText textname = pakname '%s_text.pak' s = <stem>
		elseif french
			FormatText textname = pakname '%s_text_f.pak' s = <stem>
		elseif italian
			FormatText textname = pakname '%s_text_i.pak' s = <stem>
		elseif German
			FormatText textname = pakname '%s_text_g.pak' s = <stem>
		elseif Spanish
			FormatText textname = pakname '%s_text_s.pak' s = <stem>
		endif
	else
		FormatText textname = pakname '%s_t.pak' s = <stem>
		if english
			FormatText textname = pakname '%s_t.pak' s = <stem>
		elseif french
			FormatText textname = pakname '%s_t_f.pak' s = <stem>
		elseif italian
			FormatText textname = pakname '%s_t_i.pak' s = <stem>
		elseif German
			FormatText textname = pakname '%s_t_g.pak' s = <stem>
		elseif Spanish
			FormatText textname = pakname '%s_t_s.pak' s = <stem>
		endif
	endif
	GetContentFolderIndexFromFile <pakname>
	if (<device> = content)
		printf qs("\LDownload Language Content found %s") s = <pakname>
		mark_unsafe_for_shutdown
		EnableDuplicateSymbolWarning \{off}
		if NOT LoadPakAsync pak_name = <pakname> heap = heap_downloads async = 1
			EnableDuplicateSymbolWarning
			mark_safe_for_shutdown
			downloadcontentlost
			return
		endif
		EnableDuplicateSymbolWarning
		change global_content_index_pak_language = <pakname>
		mark_safe_for_shutdown
	else
		printf qs("\LDownload Language Content no found %s") s = <pakname>
	endif
endscript

script intro_song_info 
	begin
	GetSongTimeMs
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	if ($current_intro.song_title_on_time = 0)
		return
	endif
	get_song_title song = ($current_song)
	get_song_artist_text song = ($current_song)
	get_song_artist song = ($current_song)
	if ($current_song = jamsession)
		year = 2008
		if ui_event_exists_in_stack \{name = 'setlist'}
			jam_directory_index = ($temp_jamsession_song_list [($quickplay_song_list_current)])
			GetArraySize ($jam_curr_directory_listing) param = directory_size
			if (<jam_directory_index> > 0 && <jam_directory_index> < <directory_size>)
				<year> = ($jam_curr_directory_listing [<jam_directory_index>].year)
			endif
		elseif ui_event_exists_in_stack \{name = 'jam'}
			jam_struct = ($jamsession_songlist_props.jamsession)
			year = (<jam_struct>.year_num)
		endif
		if NOT GotParam \{song_artist}
			get_savegame_from_controller controller = ($primary_controller)
			get_current_band_info
			GetGlobalTags savegame = <savegame> <band_info>
			song_artist = qs("Custom Song")
			if GotParam \{name}
				if (<name> != qs("\L"))
					song_artist = <name>
				endif
			endif
			FormatText textname = year_text qs("\L, %d") d = <year>
			song_artist = (<song_artist> + <year_text>)
		endif
	endif
	CreateScreenElement {
		parent = root_window
		id = intro_container
		type = DescInterface
		desc = 'song_intro'
		alpha = 0
		z_priority = 500
		intro_artist_text = <song_artist>
		intro_title_text = <song_title>
		intro_performed_text = <song_artist_text>
	}
	get_song_struct song = ($current_song)
	if structurecontains structure = <song_struct> covered_by
		CreateScreenElement {
			parent = intro_container
			id = 0x9097eb51
			type = TextBlockElement
			text = (<song_struct>.covered_by_text)
			pos = (132.0, 178.0)
			dims = (10.0, 720.0)
			fit_width = `expand dims`
			fit_height = `scale down if larger`
			just = [left top]
			font = fontgrid_text_A11_b
			rgba = [192 , 64 , 0 , 255]
			z_priority = 1.0
			scale = 0.4
			use_shadow = true
			shadow_rgba = [0 , 0 , 0 , 255]
			shadow_offs = (3.0, 2.0)
		}
		GetScreenElementDims \{id = 0x9097eb51}
		CreateScreenElement {
			parent = intro_container
			id = 0xd42ba709
			type = TextBlockElement
			text = (<song_struct>.covered_by)
			pos = ((132.0, 175.0) + (9.0, 0.0) + ((1.0, 0.0) * <width>))
			dims = (1280.0, 720.0)
			just = [left top]
			rgba = [192 , 64 , 0 , 255]
			font = fontgrid_text_a10
			z_priority = 1.0
			scale = 0.3
			use_shadow = true
			shadow_rgba = [0 , 0 , 0 , 255]
			shadow_offs = (3.0, 2.0)
		}
	endif
	intro_container :SE_SetProps alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	intro_container :SE_WaitProps
	Wait ($current_intro.song_title_on_time / 1000.0) seconds
	intro_container :SE_SetProps alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	intro_container :SE_WaitProps
	DestroyScreenElement \{id = intro_container}
endscript

script ui_setlist_focus_song \{time = 0.1}
	GetTags
	printf \{qs("\Lui_setlist_focus_song")}
	printstruct <...>
	if NOT GotParam \{index}
		return
	endif
	SE_GetParentId
	<parent_id> :GetTags
	if (<prev_index> > <index>)
		pos_move = (0.0, -10.0)
	else
		pos_move = (0.0, 10.0)
	endif
	<selected_song_highlighted> = false
	if (<for_custom_setlist> = 1)
		if song_is_in_temp_quickplay_song_list song = <song>
			<selected_song_highlighted> = true
			if GotParam \{jam_song}
				if (<example_songs> = 1)
					<jam_song> = (<jam_song> + 1000)
				endif
				if NOT song_is_in_temp_jamsession_song_list jam_song = <jam_song>
					<selected_song_highlighted> = false
				endif
			endif
		endif
	endif
	<should_update_pad_choose> = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			<should_update_pad_choose> = 1
		endif
	else
		<should_update_pad_choose> = 1
	endif
	if (<should_update_pad_choose> = 1)
		if (<selected_song_highlighted> = true)
			SE_SetProps {
				event_handlers = [
					{pad_choose ui_setlist_custom_remove Params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
				]
				replace_handlers
			}
		else
			<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist>}
			if (<song> = jamsession)
				<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <jam_song> example_songs = <example_songs>}
			endif
			printstruct <...>
			SE_SetProps {
				event_handlers = [
					{pad_choose ui_setlist_choose_song Params = <pad_choose_params>}
				]
				replace_handlers
			}
		endif
	endif
	setlist_menu :SetTags last_focused_song = <song>
	if NOT GotParam \{jam_song}
		setlist_update_current_section index = <tag_selected_index> song = <song>
	else
		setlist_update_current_section index = <tag_selected_index> song = <song> jam_song = <jam_song>
	endif
	<info_scores_container_alpha> = 1.0
	<instrument_icons_alpha> = 0.0
	if (($game_mode = p2_battle) || ($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff))
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 0.0
	endif
	if NOT (<tag_selected_index> < <section_breaker_index_3>)
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 1.0
		setlist_get_jammode_playback_tracks jam_song = <jam_song> example_songs = <example_songs>
		icon_no_instrument_guitar_alpha = 1
		icon_no_instrument_bass_alpha = 1
		icon_no_instrument_drums_alpha = 1
		icon_no_instrument_mic_alpha = 1
		if GotParam \{playback_track1}
			if (<playback_track1> > -1)
				icon_no_instrument_guitar_alpha = 0
			endif
		endif
		if GotParam \{playback_track2}
			if (<playback_track2> > -1)
				icon_no_instrument_bass_alpha = 0
			endif
		endif
		if GotParam \{playback_track_drums}
			if (<playback_track_drums> > 0)
				icon_no_instrument_drums_alpha = 0
			endif
		endif
		if GotParam \{playback_track_vocals}
			if (<playback_track_vocals> > 0)
				icon_no_instrument_mic_alpha = 0
			endif
		endif
	endif
	if 0x625968db song = <song>
		FormatText textname = song_text qs("\L%t %s: \cD%a") a = <song_artist> t = <song_title> s = qs("(COVER)*")
	else
		FormatText textname = song_text qs("\L%t: \cD%a") a = <song_artist> t = <song_title>
	endif
	StringToCharArray string = <song_text>
	GetArraySize <char_array>
	if (<array_size> >= 45)
		if 0x625968db song = <song>
			FormatText textname = song_text qs("\L%t %s\n\cD%a") a = <song_artist> t = <song_title> s = qs("(COVER)*")
		else
			FormatText textname = song_text qs("\L%t\n\cD%a") a = <song_artist> t = <song_title>
		endif
	endif
	SE_SetProps {
		desc = 'setlist_b_info_desc'
		auto_dims = false
		dims = (0.0, 150.0)
		setlist_info_title_artist_text = <song_text>
		setlist_info_title_artist_alpha = 0
		setlist_info_title_artist_wrap_alpha = 0
		setlist_info_title_artist_pos = {<pos_move> relative}
		<score_text>
		info_scores_container_alpha = <info_scores_container_alpha>
		instrument_icons_alpha = <instrument_icons_alpha>
		icon_no_instrument_guitar_alpha = <icon_no_instrument_guitar_alpha>
		icon_no_instrument_bass_alpha = <icon_no_instrument_bass_alpha>
		icon_no_instrument_drums_alpha = <icon_no_instrument_drums_alpha>
		icon_no_instrument_mic_alpha = <icon_no_instrument_mic_alpha>
	}
	obj_getid
	percent_index = 0
	percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
	percent_aliases = [
		alias_Setlist_B_stars_beginner
		alias_Setlist_B_stars_easy
		alias_Setlist_B_stars_medium
		alias_Setlist_B_stars_hard
		alias_Setlist_B_stars_expert
	]
	star_diffs = [
		beginner_stars
		easy_stars
		medium_stars
		hard_stars
		expert_stars
	]
	begin
	FormatText checksumname = percent100 '%s_percent100' s = (<percent_diffs> [<percent_index>])
	if GotParam <percent100>
		if <ObjID> :Desc_ResolveAlias name = (<percent_aliases> [<percent_index>])
			if (<...>.<percent100> = 1)
				<resolved_id> :SE_SetProps star_texture = song_complete_star_perfect star_rgba = [255 255 255 255]
			endif
			if <resolved_id> :Desc_ResolveAlias name = alias_stars
				GetScreenElementChildren id = <resolved_id>
				num_stars = (<...>.(<star_diffs> [<percent_index>]))
				if (<num_stars> = 0)
					<resolved_id> :SE_SetProps alpha = 0
				else
					GetArraySize <children>
					stars_left = <array_size>
					if (<num_stars> < 5 && <stars_left> = 5)
						if ScreenElementExists id = (<children> [0])
							DestroyScreenElement id = (<children> [0])
							stars_left = (<stars_left> - 1)
						endif
					endif
					if (<num_stars> < 4 && <stars_left> = 4)
						if ScreenElementExists id = (<children> [1])
							DestroyScreenElement id = (<children> [1])
						endif
					endif
				endif
			endif
		endif
	endif
	percent_index = (<percent_index> + 1)
	repeat 5
	if NOT (<array_size> >= 45)
		SE_SetProps {
			setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
			setlist_info_title_artist_alpha = 1
			time = <time>
		}
	else
		SE_SetProps {
			setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
			setlist_info_title_artist_wrap_alpha = 1
			time = <time>
		}
	endif
	<ratio> = (<index> / (<total_songs> * 1.0))
	pos = ((0.0, 1.0) * ((<ratio> * 385) - 185))
	bg_pos = ((0.0, -1.0) * (<ratio> * (4400 - 720)))
	bg_runnerC_pos = ((0.0, -1.0) * (<ratio> * (2200 - 720)))
	bg_runnerL_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (-640.0, 0.0))
	bg_runnerR_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (640.0, 0.0))
	SetlistInterface :SE_SetProps {
		setlist_B_scrollthumb_pos = <pos>
		setlist_B_BG_pos = <bg_pos>
		setlist_B_BG_runnerC_pos = <bg_runnerC_pos>
		setlist_B_BG_runnerL_pos = <bg_runnerL_pos>
		setlist_B_BG_runnerR_pos = <bg_runnerR_pos>
		time = <time>
	}
	<parent_id> :SetTags prev_index = <index>
	obj_getid
	create_custom_setlist_circle id = <ObjID>
	if (<tag_selected_index> < <section_breaker_index_3>)
		gig_posters_song_focus song = <song>
	else
		gig_posters_song_focus
	endif
endscript

script ui_create_setlist_spawned \{for_custom_setlist = 1}
	if NOT GotParam \{from_leaderboard}
		change \{rich_presence_context = presence_gigboard_and_setlist}
	endif
	stoprendering
	if ($is_network_game = 1)
		<for_custom_setlist> = 0
	endif
	if ($game_mode = training || $game_mode = tutorial)
		<for_custom_setlist> = 0
	endif
	if (($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff) || ($game_mode = p2_battle))
		<for_custom_setlist> = 0
	endif
	allow_jammode = 1
	begin
	if ($setlist_songpreview_changing = 0)
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	show_quit_warning = 1
	if (<for_custom_setlist> = 1)
		if ($sort_restore_selections = 0)
			reset_temp_quickplay_song_list
			reset_temp_jamsession_song_list
		endif
	else
		show_quit_warning = 0
	endif
	if NOT GotParam \{keep_current_level}
		if NOT ($game_mode = training)
			startrendering
			frontend_load_soundcheck \{loadingscreen}
			stoprendering
		endif
	endif
	for_createagig = 0
	if GotParam \{createagig}
		<for_createagig> = 1
	endif
	if GotParam \{no_jamsession}
		allow_jammode = 0
	endif
	if GotParam \{from_top_rocker}
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
	endif
	if GotParam \{from_leaderboard}
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
	endif
	menu_music_off
	gig_posters_song_focus
	if GotParam \{use_all_controllers}
		get_all_exclusive_devices
	else
		<exclusive_device> = ($primary_controller)
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				player_idx = 1
				GameMode_GetNumPlayers
				begin
				GetPlayerInfo <player_idx> is_local_client
				if (<is_local_client> = 1)
					GetPlayerInfo <player_idx> net_obj_id
					if ($online_song_choice_id = <net_obj_id>)
						GetPlayerInfo <player_idx> controller
						<exclusive_device> = <controller>
						break
					endif
				endif
				<player_idx> = (<player_idx> + 1)
				repeat <num_players>
			endif
		endif
	endif
	update_ingame_controllers controller = <exclusive_device>
	CreateScreenElement {
		parent = root_window
		id = SetlistInterface
		type = DescInterface
		desc = 'setlist_b'
		exclusive_device = <exclusive_device>
	}
	if SetlistInterface :Desc_ResolveAlias \{name = alias_setlist_menu}
		AssignAlias id = <resolved_id> alias = setlist_menu
		setlist_menu :SE_SetProps {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound Params = {up}}
				{pad_down generic_menu_up_or_down_sound Params = {down}}
				{pad_back ui_setlist_back Params = {show_quit_warning = <show_quit_warning>}}
				{pad_option2 setlist_switch_sort Params = {for_custom_setlist = <for_custom_setlist>}}
			]
			tags = {
				from_top_rocker = <from_top_rocker>
				from_leaderboard = <from_leaderboard>
				for_custom_setlist = 0
				current_section = 1
				last_focused_song = none
				custom_setlist_num_id_1 = null
				custom_setlist_num_id_2 = null
				custom_setlist_num_id_3 = null
				custom_setlist_num_id_4 = null
				custom_setlist_num_id_5 = null
				custom_setlist_num_id_6 = null
				section_breaker_index_1 = 99999
				section_breaker_index_2 = 99999
				section_breaker_index_3 = 99999
			}
		}
	endif
	if GotParam \{next_state}
		setlist_menu :SetTags next_state = <next_state>
	endif
	if GotParam \{for_custom_setlist}
		setlist_menu :SetTags for_custom_setlist = <for_custom_setlist>
		if (<for_custom_setlist> = 1)
			setlist_menu :SE_SetProps {
				event_handlers = [
					{pad_start ui_setlist_compact_and_continue}
					{pad_l1 ui_setlist_custom_remove_all Params = {for_custom_setlist = <for_custom_setlist>}}
					{pad_r1 ui_setlist_custom_remove_all Params = {for_custom_setlist = <for_custom_setlist>}}
				]
			}
		endif
	endif
	setlist_menu :SE_SetProps {
		event_handlers = [
			{pad_option setlist_jump_down_section Params = {for_custom_setlist = <for_custom_setlist>}}
		]
	}
	CreateScreenElement \{parent = setlist_menu
		type = DescInterface
		desc = 'setlist_b_head_desc'
		auto_dims = false
		dims = (0.0, 300.0)
		just = [
			center
			center
		]
		setlist_b_head_text_text = qs("Setlist")
		not_focusable}
	if ($band_mode_mode = quickplay)
		part = Band
	else
		GetPlayerInfo \{1
			part}
	endif
	final_array = [gh_songlist GH4_download_songlist jammode_songs]
	final_array_text = [qs("WORLD TOUR SONGS") qs("DOWNLOADABLE CONTENT") qs("MUSIC STUDIO SONGS")]
	final_array_index = 0
	GetArraySize <final_array>
	final_array_size = <array_size>
	if (<allow_jammode> = 0)
		<final_array_size> = (<final_array_size> - 1)
	endif
	if (<for_custom_setlist> = 1)
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = custom_setlist_helper_container
			pos = (640.0, 600.0)
			z_priority = 100000}
		CreateScreenElement \{type = SpriteElement
			parent = custom_setlist_helper_container
			texture = pill_128_fill
			dims = (192.0, 38.0)
			just = [
				center
				top
			]
			rgba = [
				20
				20
				20
				255
			]}
		sprite_params = {
			type = SpriteElement
			texture = setlist_custom_circle_sm_empty
			parent = custom_setlist_helper_container
			dims = (32.0, 32.0)
			just = [center top]
			rgba = [255 255 255 255]
			z_priority = 200000
		}
		text_params = {
			type = TextElement
			font = fontgrid_text_a8
			scale = (0.65000004, 0.65000004)
			just = [center top]
			rgba = [0 0 0 255]
			z_priority = 300000
		}
		circle_num = 1
		circle_pos = (-69.0, 3.0)
		begin
		CreateScreenElement <sprite_params> pos = <circle_pos>
		FormatText checksumname = circle_full_id 'cs_dot_helper_circle_%d' d = <circle_num>
		CreateScreenElement <sprite_params> pos = <circle_pos> texture = setlist_custom_circle_sm id = <circle_full_id>
		FormatText textname = num_text qs("\L%d") d = <circle_num>
		text_pos = (16.0, 0.0)
		if (<circle_num> = 1)
			text_pos = (<text_pos> + (-2.0, 0.0))
		endif
		CreateScreenElement <text_params> pos = <text_pos> text = <num_text> parent = <id>
		<circle_pos> = (<circle_pos> + (28.0, 0.0))
		<circle_num> = (<circle_num> + 1)
		repeat 6
		setup_custom_setlist_helpers
	else
	endif
	GameMode_GetType
	<game_mode_type> = <type>
	if ($current_progression_flag = Career_Band && $is_network_game = 0)
		GetSavegameFromController controller = ($band_mode_current_leader)
	else
		GetSavegameFromController controller = ($primary_controller)
	endif
	final_num_songs = 0
	begin
	CreateScreenElement {
		parent = setlist_menu
		type = DescInterface
		desc = 'setlist_b_divider_desc'
		auto_dims = false
		dims = (0.0, 50.0)
		setlist_divider_title_text = (<final_array_text> [<final_array_index>])
		not_focusable
	}
	Wait \{1
		GameFrame}
	if <id> :Desc_ResolveAlias name = alias_setlist_divider
		AssignAlias id = <resolved_id> alias = setlist_divider_menu
		GetScreenElementDims \{id = setlist_divider_menu}
		<id> :SE_GetProps
		if GotParam \{setlist_divider_title_dims}
			container_width = 980
			divider_width = ((<container_width> - (<setlist_divider_title_dims>.(1.0, 0.0))) / 2)
			divider_bar_dims = (<divider_width> * (1.0, 0.0) + (<setlist_list_divider_L_dims>.(0.0, 1.0) * (0.0, 1.0)))
			<id> :SE_SetProps setlist_list_divider_L_dims = <divider_bar_dims> setlist_list_divider_R_dims = <divider_bar_dims>
		endif
	endif
	song_array = (<final_array> [<final_array_index>])
	if (<song_array> = jammode_songs)
		<cur_songs> = <final_num_songs>
		setlist_create_jammode_songs <...>
		<jam_song> = 1
		if NOT (<cur_songs> = <final_num_songs>)
			setlist_menu :SetTags {section_breaker_index_3 = (<cur_songs> + 3)}
		endif
	else
		if (<for_createagig> = 1 && <song_array> != GH4_download_songlist)
			get_songs_available_for_create_a_setlist
			GetArraySize <unlocked_songs_array>
		else
			GetArraySize $<song_array>
		endif
		total_songs = <array_size>
		if (<total_songs> > 0)
			if (<final_array_index> = 0)
				setlist_menu :SetTags {section_breaker_index_1 = (<final_num_songs> + 1)}
			elseif (<final_array_index> = 1)
				setlist_menu :SetTags {section_breaker_index_2 = (<final_num_songs> + 2)}
			endif
			sortable_songlist = []
			i = 0
			begin
			if (<for_createagig> = 1 && <song_array> != GH4_download_songlist)
				song = (<unlocked_songs_array> [<i>])
			else
				song = ($<song_array> [<i>])
			endif
			get_song_title song = <song>
			GetUpperCaseString <song_title>
			<song_title> = <uppercasestring>
			get_song_artist song = <song>
			GetUpperCaseString <song_artist>
			<song_artist> = <uppercasestring>
			if (<for_createagig> = 1 && <song_array> != GH4_download_songlist)
				element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
				AddArrayElement array = <sortable_songlist> element = <element_to_add>
				sortable_songlist = <array>
			elseif ((GotParam from_top_rocker) || (GotParam from_leaderboard))
				if NOT structurecontains structure = ($gh_songlist_props.<song>) never_show_in_setlist
					get_song_saved_in_globaltags song = <song>
					get_song_allowed_in_quickplay song = <song>
					no_vocals = 0
					if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_vocals
						if GotParam \{from_leaderboard}
							if (($current_leaderboard_instrument) = mic)
								no_vocals = 1
							endif
						elseif GotParam \{from_top_rocker}
							GetPlayerInfo \{1
								part}
							if (<part> = Vocals)
								no_vocals = 1
							endif
						endif
					endif
					if ((<saved_in_globaltags> = 1) && (<allowed_in_quickplay> = 1) && (<no_vocals> = 0))
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						AddArrayElement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
					endif
				endif
			else
				if issongavailable song = <song>
					element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
					AddArrayElement array = <sortable_songlist> element = <element_to_add>
					sortable_songlist = <array>
				endif
			endif
			i = (<i> + 1)
			repeat <total_songs>
			if ((<song_array> = GH4_download_songlist) && ($setlist_sorts [$setlist_sort_index].name = career_order))
				SortAndBuildSonglist songlist = <sortable_songlist> sortby = artist_alphabetical
			else
				SortAndBuildSonglist songlist = <sortable_songlist> sortby = ($setlist_sorts [$setlist_sort_index].name)
			endif
			GetArraySize <sorted_songlist>
			total_songs = <array_size>
			if (<total_songs> > 0)
				i = 0
				begin
				song = (<sorted_songlist> [<i>])
				get_song_prefix song = <song>
				beginner_skull_alpha = 1
				easy_skull_alpha = 1
				medium_skull_alpha = 1
				hard_skull_alpha = 1
				expert_skull_alpha = 1
				ghost_skull_alpha = 0.25
				beginner_text_alpha = 1
				easy_text_alpha = 1
				medium_text_alpha = 1
				hard_text_alpha = 1
				expert_text_alpha = 1
				ghost_text_alpha = 0
				highest_difficulty_texture = icon_difficulty_beginner
				highest_difficulty_alpha = 0
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy_rhythm'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'easy_rhythm' part = ($part_list_props.<part>.text_nl)
				endif
				FormatText textname = score_easy_rhythm_text qs("%s") s = <score>
				if (<score> = 0 || $game_mode = training)
					<beginner_skull_alpha> = <ghost_skull_alpha>
					<beginner_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_beginner
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
				endif
				FormatText textname = score_easy_text qs("%s") s = <score>
				if (<score> = 0 || $game_mode = training)
					<easy_skull_alpha> = <ghost_skull_alpha>
					<easy_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_easy
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
				endif
				FormatText textname = score_medium_text qs("%s") s = <score>
				if (<score> = 0 || $game_mode = training)
					<medium_skull_alpha> = <ghost_skull_alpha>
					<medium_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_medium
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
				endif
				FormatText textname = score_hard_text qs("%s") s = <score>
				if (<score> = 0 || $game_mode = training)
					<hard_skull_alpha> = <ghost_skull_alpha>
					<hard_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_hard
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
				endif
				FormatText textname = score_expert_text qs("%s") s = <score>
				if (<score> = 0 || $game_mode = training)
					<expert_skull_alpha> = <ghost_skull_alpha>
					<expert_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_expert
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy_rhythm'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'easy_rhythm' part = ($part_list_props.<part>.text_nl)
				endif
				beginner_stars = <stars>
				beginner_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
				endif
				easy_stars = <stars>
				easy_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
				endif
				medium_stars = <stars>
				medium_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
				endif
				hard_stars = <stars>
				hard_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
				endif
				expert_stars = <stars>
				expert_percent100 = <percent100>
				score_text = {
					score_beginner_text = <score_easy_rhythm_text>
					score_easy_text = <score_easy_text>
					score_medium_text = <score_medium_text>
					score_hard_text = <score_hard_text>
					score_expert_text = <score_expert_text>
					icon_difficulty_beginner_alpha = <beginner_skull_alpha>
					icon_difficulty_easy_alpha = <easy_skull_alpha>
					icon_difficulty_medium_alpha = <medium_skull_alpha>
					icon_difficulty_hard_alpha = <hard_skull_alpha>
					icon_difficulty_expert_alpha = <expert_skull_alpha>
					score_beginner_alpha = <beginner_text_alpha>
					score_easy_alpha = <easy_text_alpha>
					score_medium_alpha = <medium_text_alpha>
					score_hard_alpha = <hard_text_alpha>
					score_expert_alpha = <expert_text_alpha>
				}
				skull_tags = {
					icon_difficulty_texture = <highest_difficulty_texture>
					icon_difficulty_alpha = <highest_difficulty_alpha>
				}
				get_song_title song = <song>
				GetUpperCaseString <song_title>
				<song_title> = <uppercasestring>
				get_song_artist song = <song>
				GetUpperCaseString <song_artist>
				<song_artist> = <uppercasestring>
				if 0x625968db song = <song>
					FormatText textname = song_text qs("\L%t %s \c9%a") a = <song_artist> t = <song_title> s = qs("(COVER)*")
				else
					FormatText textname = song_text qs("\L%t \c9%a") a = <song_artist> t = <song_title>
				endif
				CreateScreenElement {
					parent = setlist_menu
					type = DescInterface
					desc = 'setlist_b_listing_desc'
					auto_dims = false
					dims = (0.0, 50.0)
					event_handlers = [
						{focus ui_setlist_focus_song Params = {for_custom_setlist = <for_custom_setlist>}}
						{unfocus ui_setlist_unfocus_song}
					]
					tags = {
						custom_setlist_num = 0
						song_title = <song_title>
						song_artist = <song_artist>
						score_text = <score_text>
						skull_tags = <skull_tags>
						song = <song>
						index = <final_num_songs>
						beginner_stars = <beginner_stars>
						easy_stars = <easy_stars>
						medium_stars = <medium_stars>
						hard_stars = <hard_stars>
						expert_stars = <expert_stars>
						beginner_percent100 = <beginner_percent100>
						easy_percent100 = <easy_percent100>
						medium_percent100 = <medium_percent100>
						hard_percent100 = <hard_percent100>
						expert_percent100 = <expert_percent100>
					}
					just = [center center]
					listing_text = <song_text>
					<skull_tags>
				}
				if ($is_network_game = 1)
					if local_player_is_choosing_song
						<id> :SE_SetProps event_handlers = [{pad_choose ui_setlist_choose_song Params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
					endif
				else
					<id> :SE_SetProps event_handlers = [{pad_choose ui_setlist_choose_song Params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
				endif
				final_num_songs = (<final_num_songs> + 1)
				if ($sort_restore_selections = 1)
					get_song_index_from_temp_quickplay_song_list song = <song>
					if (<quickplay_index> != -1)
						<id> :ui_setlist_choose_song for_custom_setlist = <for_custom_setlist> song = <song> custom_index = <quickplay_index> no_sound
					endif
				endif
				i = (<i> + 1)
				repeat <total_songs>
			endif
			<jam_song> = 0
		endif
	endif
	<final_array_index> = (<final_array_index> + 1)
	repeat <final_array_size>
	CreateScreenElement \{parent = setlist_menu
		type = ContainerElement
		id = setlist_b_footer
		not_focusable}
	CreateScreenElement \{parent = setlist_b_footer
		type = SpriteElement
		texture = setlist_B_foot
		rgba = [
			220
			220
			220
			255
		]
		just = [
			right
			center
		]
		pos = (0.0, 50.0)
		not_focusable}
	CreateScreenElement \{parent = setlist_b_footer
		type = SpriteElement
		texture = setlist_B_foot
		rgba = [
			220
			220
			220
			255
		]
		just = [
			left
			center
		]
		flip_v
		pos = (0.0, 50.0)
		not_focusable}
	setlist_menu :SetTags total_songs = <final_num_songs> prev_index = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			menu_finish
		else
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100}
		endif
	else
		add_user_control_helper \{text = qs("SELECT SONG")
			button = green
			z = 100}
		setlist_show_jump_helper_text
		add_user_control_helper \{text = qs("BACK")
			button = red
			z = 100}
	endif
	killspawnedscript \{name = destroy_setlist_songpreview_monitor}
	if ($is_network_game = 0)
		SpawnScriptLater \{setlist_songpreview_monitor}
	endif
	if ResolveScreenElementId id = {setlist_menu child = <selected_index>}
		if ($is_network_game = 0)
			<resolved_id> :obj_spawnscript ui_setlist_focus_song Params = {time = 0.0 for_custom_setlist = <for_custom_setlist>}
		endif
	endif
	if ($is_network_game = 0)
		setlist_menu :obj_spawnscript wait_and_unblock_setlist_menu Params = {selected_index = <selected_index>}
	else
		LaunchEvent type = focus target = setlist_menu data = {child_index = <selected_index>}
		startrendering
	endif
	if ($is_network_game = 1)
		if ($g_disable_song_chooser_spinner = 1)
			create_setlist_popup \{parent_element = SetlistInterface}
			LaunchEvent type = focus target = setlist_menu data = {child_index = <selected_index>}
		else
			if ($refresh_from_sort = 0)
				create_song_chooser_spinner selected_index = <selected_index>
			else
				SpawnScriptLater \{setlist_songpreview_monitor}
				create_setlist_popup \{parent_element = SetlistInterface}
			endif
		endif
	endif
	change \{sort_restore_selections = 0}
	change \{refresh_from_sort = 0}
	destroy_loading_screen
endscript

script ui_setlist_unfocus_song 
	GetTags
	if 0x625968db song = <song>
		FormatText textname = song_text qs("\L%t %s \c9%a") a = <song_artist> t = <song_title> s = qs("(COVER)*")
	else
		FormatText textname = song_text qs("\L%t \c9%a") a = <song_artist> t = <song_title>
	endif
	SE_SetProps {
		desc = 'setlist_b_listing_desc'
		auto_dims = false
		dims = (0.0, 50.0)
		listing_text = <song_text>
		<skull_tags>
	}
	obj_getid
	create_custom_setlist_circle id = <ObjID> use_small_circle
endscript

script 0x625968db \{song = invalid}
	if structurecontains structure = $gh_songlist_props <song>
		if structurecontains structure = ($gh_songlist_props.<song>) covered_by
			return \{true}
		else
			return \{false}
		endif
	endif
	printstruct <...>
	scriptassert \{qs("\LSong not found")}
endscript
Practice_NoteMapping = [
	{
		MidiNote = 60
		Scr = play_drum_sample
		Params = {
			pad = kick
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 61
		Scr = play_drum_sample
		Params = {
			pad = tom2
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 62
		Scr = play_drum_sample
		Params = {
			pad = tom2
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 63
		Scr = play_drum_sample
		Params = {
			pad = tom1
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 64
		Scr = play_drum_sample
		Params = {
			pad = snare
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 65
		Scr = play_drum_sample
		Params = {
			pad = hihat
			buss = PracticeMode_Drums
			velocity = 50
		}
	}
	{
		MidiNote = 66
		Scr = play_drum_sample
		Params = {
			pad = hihat
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 67
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = PracticeMode_Drums
			velocity = 50
		}
	}
	{
		MidiNote = 68
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = PracticeMode_Drums
		}
	}
	{
		MidiNote = 69
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = PracticeMode_Drums
			velocity = 90
		}
	}
]
Practice_Slomo_Drum_NoteMapping = [
	{
		MidiNote = 60
		Scr = play_drum_sample
		Params = {
			pad = kick
			buss = Drums_InGame_Kick
		}
	}
	{
		MidiNote = 61
		Scr = play_drum_sample
		Params = {
			pad = tom2
			buss = Drums_InGame_Toms
		}
	}
	{
		MidiNote = 62
		Scr = play_drum_sample
		Params = {
			pad = tom2
			buss = Drums_InGame_Toms
		}
	}
	{
		MidiNote = 63
		Scr = play_drum_sample
		Params = {
			pad = tom1
			buss = Drums_InGame_Toms
		}
	}
	{
		MidiNote = 64
		Scr = play_drum_sample
		Params = {
			pad = snare
			buss = Drums_InGame_Snare
		}
	}
	{
		MidiNote = 65
		Scr = play_drum_sample
		Params = {
			pad = hihat
			buss = Drums_InGame_Cymbals
			velocity = 50
		}
	}
	{
		MidiNote = 66
		Scr = play_drum_sample
		Params = {
			pad = hihat
			buss = Drums_InGame_Cymbals
		}
	}
	{
		MidiNote = 67
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = Drums_InGame_Cymbals
			velocity = 50
		}
	}
	{
		MidiNote = 68
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = Drums_InGame_Cymbals
		}
	}
	{
		MidiNote = 69
		Scr = play_drum_sample
		Params = {
			pad = cymbal
			buss = Drums_InGame_Cymbals
			velocity = 90
		}
	}
]
