// Guitar stem starts unmuted
script start_gem_scroller \{starttime = 0
		practice_intro = 0
		training_mode = 0
		endtime = 99999999
		devil_finish_restart = 0
		end_credits_restart = 0}
	if (<devil_finish_restart> = 1)
		printf \{"FINISH DEVIL RESTART"}
	else
		change \{devil_finish = 0}
		if ($current_song = bossdevil)
			<starttime> = 0
		endif
	endif
	if (<end_credits_restart> = 1)
		printf \{"END CREDITS RESTART"}
	else
		if NOT ($current_song = thrufireandflames)
			change \{end_credits = 0}
		endif
	endif
	change \{playing_song = 1}
	mark_unsafe_for_shutdown
	dragonforce_hack_off
	menu_music_off
	guitarevent_entervenue
	init_play_log
	load_songqpak song_name = <song_name> async = 1
	if isxenon
		change \{default_gem_offset = $xenon_gem_offset}
		change \{default_input_offset = $xenon_input_offset}
		change \{default_drums_offset = $xenon_drums_offset}
		change \{default_practice_mode_pitchshift_offset_song = $xenon_practice_mode_pitchshift_offset_song}
		change \{default_practice_mode_pitchshift_offset_slow = $xenon_practice_mode_pitchshift_offset_slow}
		change \{default_practice_mode_pitchshift_offset_slower = $xenon_practice_mode_pitchshift_offset_slower}
		change \{default_practice_mode_pitchshift_offset_slowest = $xenon_practice_mode_pitchshift_offset_slowest}
	else
		if isps3
			change \{default_gem_offset = $ps3_gem_offset}
			change \{default_input_offset = $ps3_input_offset}
			change \{default_drums_offset = $ps3_drums_offset}
			change \{default_practice_mode_pitchshift_offset_song = $ps3_practice_mode_pitchshift_offset_song}
			change \{default_practice_mode_pitchshift_offset_slow = $ps3_practice_mode_pitchshift_offset_slow}
			change \{default_practice_mode_pitchshift_offset_slower = $ps3_practice_mode_pitchshift_offset_slower}
			change \{default_practice_mode_pitchshift_offset_slowest = $ps3_practice_mode_pitchshift_offset_slowest}
		else
			change \{default_gem_offset = $ps2_gem_offset}
			change \{default_input_offset = $ps2_input_offset}
			change \{default_drums_offset = $ps2_drums_offset}
			change \{default_practice_mode_pitchshift_offset_song = $ps2_practice_mode_pitchshift_offset_song}
			change \{default_practice_mode_pitchshift_offset_slow = $ps2_practice_mode_pitchshift_offset_slow}
			change \{default_practice_mode_pitchshift_offset_slower = $ps2_practice_mode_pitchshift_offset_slower}
			change \{default_practice_mode_pitchshift_offset_slowest = $ps2_practice_mode_pitchshift_offset_slowest}
		endif
	endif
	begin_singleplayer_game
	change current_song = <song_name>
	change current_difficulty = <difficulty>
	change current_difficulty2 = <difficulty2>
	change current_starttime = <starttime>
	change current_endtime = <endtime>
	change \{boss_play = 0}
	change \{showing_raise_axe = 0}
	progression_setprogressionnodeflags
	get_song_struct song = <song_name>
	if structurecontains structure = <song_struct> boss
		change current_boss = (<song_struct>.boss)
		change \{boss_battle = 1}
		change \{current_num_players = 2}
		change boss_oldcontroller = ($player2_status.controller)
		getinputhandlerbotindex \{player = 2}
		change structurename = player2_status controller = <controller>
		if structurecontains \{structure = $current_boss
				name = character_profile}
			profile = ($current_boss.character_profile)
			change structurename = player2_status character_id = <profile>
			change \{structurename = player2_status
				outfit = 1}
			change \{structurename = player2_status
				style = 1}
		endif
		printf \{channel = log
			"Starting bot for boss"}
	else
		if (($player2_status.bot_play = 1) || ($new_net_logic))
			change boss_oldcontroller = ($player2_status.controller)
			getinputhandlerbotindex \{player = 2}
			change structurename = player2_status controller = <controller>
			printf \{channel = log
				"Starting bot for player 2"}
		endif
	endif
	if ($player1_status.bot_play = 1)
		getinputhandlerbotindex \{player = 1}
		change structurename = player1_status controller = <controller>
		printf \{channel = log
			"Starting bot for player 1"}
	endif
	if ($game_mode = p2_battle)
		printf \{"Initiating Battlemode"}
		battlemode_init
	endif
	if ($boss_battle = 1)
		printf \{"Initiating BossBattle"}
		bossbattle_init
	endif
	if ($new_net_logic)
		new_net_logic_init
	endif
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"Now playing %s %d"
		s = $current_song
		d = $current_difficulty}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	song_start_time = <starttime>
	call_startup_scripts <...>
	setup_bg_viewport
	create_cameracuts <...>
	starttimeafterintro = <starttime>
	printf "Current Transition = %s" s = ($current_transition)
	if ($current_transition = none)
		change \{current_transition = fastintro}
	endif
	transition_gettime type = ($current_transition)
	starttime = (<starttime> - <transition_time>)
	setslomo \{0.001}
	reset_song_time starttime = <starttime>
	if NOT ($use_character_debug_cam = 1)
	endif
	create_movie_viewport
	create_crowd_models
	crowd_create_lighters
	crowd_stagediver_hide
	change \{structurename = guitarist_info
		stance = stance_a}
	change \{structurename = guitarist_info
		next_stance = stance_a}
	change \{structurename = guitarist_info
		current_anim = idle}
	change \{structurename = guitarist_info
		cycle_anim = true}
	change \{structurename = guitarist_info
		next_anim = none}
	change \{structurename = guitarist_info
		playing_missed_note = false}
	change \{structurename = guitarist_info
		waiting_for_cameracut = false}
	change \{structurename = bassist_info
		stance = stance_a}
	change \{structurename = bassist_info
		next_stance = stance_a}
	change \{structurename = bassist_info
		current_anim = idle}
	change \{structurename = bassist_info
		cycle_anim = true}
	change \{structurename = bassist_info
		next_anim = none}
	change \{structurename = bassist_info
		playing_missed_note = false}
	change \{structurename = bassist_info
		waiting_for_cameracut = false}
	change \{structurename = vocalist_info
		stance = stance_a}
	change \{structurename = vocalist_info
		next_stance = stance_a}
	change \{structurename = vocalist_info
		current_anim = idle}
	change \{structurename = vocalist_info
		cycle_anim = true}
	change \{structurename = vocalist_info
		next_anim = none}
	change \{structurename = drummer_info
		stance = stance_a}
	change \{structurename = drummer_info
		next_stance = stance_a}
	change \{structurename = drummer_info
		current_anim = idle}
	change \{structurename = drummer_info
		cycle_anim = true}
	change \{structurename = drummer_info
		next_anim = none}
	change \{structurename = drummer_info
		twist = 0.0}
	change \{structurename = drummer_info
		desired_twist = 0.0}
	change \{structurename = drummer_info
		last_left_arm_note = 0}
	change \{structurename = drummer_info
		last_right_arm_note = 0}
	if (<training_mode> = 0)
		if NOT create_band \{async = 1}
			downloadcontentlost
		endif
	endif
	if ($game_mode = training)
		practicemode_init
	endif
	preload_song song_name = <song_name> starttime = <song_start_time>
	calc_score = true
	if NOT (<devil_finish_restart> = 1 || $end_credits = 1)
		if ($use_last_player_scores = 0)
			reset_score \{player_status = player1_status}
		else
			change \{use_last_player_scores = 0}
			<calc_score> = false
		endif
	endif
	reset_score \{player_status = player2_status}
	getglobaltags \{user_options}
	setarrayelement \{arrayname = currently_holding
		globalarray
		index = 0
		newvalue = 0}
	setarrayelement \{arrayname = currently_holding
		globalarray
		index = 1
		newvalue = 0}
	player = 1
	begin
	if (<player> = 2)
		if gotparam \{difficulty2}
			<difficulty> = <difficulty2>
		endif
	endif
	formattext checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	formattext textname = player_text 'p%i' i = <player> addtostringlookup
	change structurename = <player_status> guitar_volume = 100  // here
	updateguitarvolume
	getglobaltags \{user_options}
	if (<player> = 1)
		change structurename = <player_status> lefthanded_gems = (<lefty_flip_p1>)
		change structurename = <player_status> lefthanded_button_ups = (<lefty_flip_p1>)
	else
		if ($is_network_game = 0)
			change structurename = <player_status> lefthanded_gems = (<lefty_flip_p2>)
			change structurename = <player_status> lefthanded_button_ups = (<lefty_flip_p2>)
		endif
	endif
	get_resting_whammy_position controller = ($<player_status>.controller)
	if gotparam \{resting_whammy_position}
		change structurename = <player_status> resting_whammy_position = <resting_whammy_position>
	endif
	get_star_power_position controller = ($<player_status>.controller)
	if gotparam \{star_power_position}
		change structurename = <player_status> star_tilt_threshold = <star_power_position>
	endif
	if ($tutorial_disable_hud = 0)
		setup_hud <...>
	endif
	if ($output_gpu_log = 1)
		textoutputstart
	endif
	if NOT gotparam \{no_score_update}
		spawnscriptlater update_score_fast params = {<...>}
	endif
	if (($is_network_game) && ($player1_status.highway_layout = solo_highway))
		spawnscriptlater \{update_score_fast
			params = {
				player_status = player2_status
			}}
	endif
	if (<training_mode> = 0)
		if NOT (<devil_finish_restart> = 1)
			crowd_reset <...>
		endif
	endif
	star_power_reset <...>
	difficulty_setup <...>
	setup_highway <...>
	if (<training_mode> = 0)
		reset_hud <...>
	endif
	spawnscriptnow gem_scroller params = {<...>}
	if ((<player> = 1) || ($new_net_logic) || ($is_network_game = 0))
		spawnscriptnow button_checker params = {<...>}
	endif
	if NOT (($is_network_game) && (<player> = 2))
		spawnscriptlater check_for_star_power params = {<...>}
	endif
	if (<calc_score> = true)
		calc_songscoreinfo player_status = <player_status>
	endif
	player = (<player> + 1)
	repeat $current_num_players
	getpakmancurrent \{map = zones}
	if ($boss_battle = 1)
		if should_play_boss_intro
			if ($current_transition = boss)
				gh_sfx_preload_boss_intro_audio
			endif
		endif
	endif
	gh3_set_guitar_verb_and_echo_to_dry
	transition_play type = ($current_transition)
	change \{current_transition = none}
	change \{check_for_unplugged_controllers = 1}
	wait \{1
		gameframe}
	if ($is_network_game)
		syncandlaunchnetgame
		begin
		if (($net_ready_to_start) || ($player2_present = 0))
			ui_flow_manager_respond_to_action \{action = net_begin_song}
			ui_print_gamertags \{pos1 = (365.0, 50.0)
				pos2 = (940.0, 50.0)
				dims = (310.0, 25.0)
				just1 = [
					center
					top
				]
				just2 = [
					center
					top
				]
				offscreen = 1}
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
	stoprendering
	destroy_loading_screen
	setslomo \{$current_speedfactor}
	if ($player2_present = 0)
		if NOT ((screenelementexists net_popup) || (scriptexists create_connection_lost_dialog))
			spawnscriptnow \{create_connection_lost_dialog}
		endif
	endif
	spawnscriptnow begin_song_after_intro params = {starttimeafterintro = <starttimeafterintro>}
	if ($boss_battle = 1)
		if ($show_boss_helper_screen = 1)
			disable_bg_viewport
			if screenelementexists \{id = battlemode_container}
				battlemode_container :setprops \{alpha = 0}
			endif
			getpakmancurrent \{map = zones}
			if should_play_boss_intro
				spawnscriptnow \{wait_and_show_boss_helper_after_intro}
			else
				spawnscriptlater \{show_boss_helper_now}
			endif
		else
			enable_bg_viewport
		endif
	endif
	mark_safe_for_shutdown
endscript