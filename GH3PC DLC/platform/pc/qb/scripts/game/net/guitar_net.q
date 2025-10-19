num_players_info = [
	{
		name = "2 Players"
		checksum = num_2
		num = 2
	}
]
num_private_slots = [
	{
		name = "0 Players"
		checksum = num_0
		num = 0
	}
	{
		name = "1 Players"
		checksum = num_1
		num = 1
	}
	{
		name = "2 Players"
		checksum = num_2
		num = 2
	}
]
FilterTypes = {
	diff = {
		values = [
			"ANY"
			"EASY"
			"MEDIUM"
			"HARD"
			"EXPERT"
		]
		checksum = [
			dont_care
			easy
			medium
			hard
			expert
		]
	}
	mode = {
		values = [
			"ANY"
			"FACE-OFF"
			"PRO FACE-OFF"
			"BATTLE"
			"CO-OP"
		]
		checksum = [
			dont_care
			p2_faceoff
			p2_pro_faceoff
			p2_battle
			p2_coop
		]
	}
	type = {
		values = [
			"PLAYER"
			"RANKED"
		]
		checksum = [
			player
			ranked
		]
	}
	num_songs = {
		values = [
			"ANY"
			"1"
			"Best of 3"
			"Best of 5"
			"Best of 7"
		]
		checksum = [
			dont_care
			num_1
			num_3
			num_5
			num_7
		]
	}
	tie = {
		values = [
			"ANY"
			"HOST"
			"CLIENT"
			"RANDOM"
		]
		checksum = [
			dont_care
			HOST
			CLIENT
			song_rand
		]
	}
	search = {
		values = [
			"ALL TIME"
			"MY RANK"
		]
	}
	song_type = {
		values = [
			"NORMAL SONGS"
			"CO-OP SONGS"
		]
	}
	vport = {
		values = [
			"DOUBLE"
			"SINGLE"
		]
	}
	lb_diff = {
		values = [
			"EASY"
			"MEDIUM"
			"HARD"
			"EXPERT"
		]
	}
}
Leaderboard_Difficulty_Lookup_Table = {
	easy = 'easy'
	medium = 'medium'
	hard = 'hard'
	expert = 'expert'
}
online_light_purple = [
	190
	180
	205
	250
]
online_dark_purple = [
	70
	40
	70
	250
]
online_light_blue = [
	180
	230
	250
	250
]
online_medium_blue = [
	35
	130
	175
	250
]
online_dark_blue = [
	0
	70
	100
	250
]
online_score_bars = [
	60
	50
	70
	128
]
online_trans_grey = [
	0
	0
	0
	200
]
online_grey = [
	75
	75
	75
	250
]
online_light_grey = [
	75
	75
	75
	150
]
online_red = [
	255
	0
	0
	255
]
online_yellow = [
	210
	210
	0
	255
]
online_orange = [
	255
	165
	0
	255
]
online_green = [
	0
	150
	0
	255
]
online_general_menu_pos = (640.0, 75.0)
online_general_menu_hi_lite_ypos = [
	0.0
	0.0
	0.0
	0.0
]
net_current_flow_state = none
net_can_send_approval = 1
net_safe_to_enter_net_play = 1
player1_song_selections = [
	null
	null
	null
]
player2_song_selections = [
	null
	null
	null
]
tie_breaker_song = bullsonparade
match_type = player
opponent_gamertag = null
online_song_count = 0
player2_present = 0
player1_max_song_selections = 0
player1_current_song_selections = 0
player2_max_song_selections = 0
player2_current_song_selections = 0
player1_selected_guitar = Instrument_Les_Paul_Black
player1_selected_bass = Instrument_LP_VBRST
player2_selected_guitar = Instrument_Les_Paul_Black
player2_selected_bass = Instrument_LP_VBRST
retrieved_message_of_the_day = 0
message_of_the_day = ""
OptionsGameModeValue = 0
OptionsDifficultyValue = 0
OptionsNumSongsValue = 0
OptionsTieBreakerValue = 0
OptionsHighwayValue = 0
LeaderboardSearchValue = 0
LeaderboardSongTypeValue = 0
LeaderboardDiffValue = 3
CopyOfGlobal = 0
SearchMatchTypeValue = 0
SearchGameModeValue = 0
SearchDifficultyValue = 0
SearchNumSongsValue = 0
SearchTieBreakerValue = 0
TempGameModeValue = 0
TempDifficultyValue = 0
TempNumSongsValue = 0
TempTieBreakerValue = 0
TempHighwayValue = 0
net_game_type_info = [
	{
		name = "PRO FACEOFF"
		description = "Play a song with the same notes."
		checksum = p2_pro_faceoff
	}
	{
		name = "FACEOFF"
		description = "Dueling sections on lead guitar."
		checksum = p2_faceoff
	}
	{
		name = "BATTLE"
		description = "Battle mode."
		checksum = p2_battle
	}
	{
		name = "CO-OP"
		description = "Mix lead guitar with bass/rhythm guitar."
		checksum = p2_coop
	}
]
xenon_invite_confirm_title = "GAME INVITE"
xenon_invite_confirm_dialog = "Accepting this invite will lose progress in any currently active goals. Do you want to continue?"
xenon_invite_confirm_yes = "YES"
xenon_invite_confirm_no = "NO"
xenon_session_confirm_title = "JOIN SESSION"
xenon_session_confirm_dialog = "Joining this session will lose progress in any currently active goals. Do you want to continue?"
xenon_session_confirm_yes = "YES"
xenon_session_confirm_no = "NO"
xenon_invite_confirm_inactive_title = "GAME INVITE"
xenon_invite_confirm_inactive_dialog = "You have been invited to play an online game. This title doesn't support inactive controllers joining an online game, so the invite has been rejected."
xenon_invite_confirm_inactive_ok = "OK"
xenon_session_confirm_inactive_title = "JOIN SESSION"
xenon_session_confirm_inactive_dialog = "This title doesn't support inactive controllers joining an online game, so you cannot join this session."
xenon_session_confirm_inactive_ok = "OK"
NO_NET_MODE = 0
LAN_MODE = 1
INTERNET_MODE = 2
new_net_logic = 0

script quit_network_game 
	printf \{"------ quitting network game"}
	LeaveServer
	Wait \{0.5
		seconds}
	RemoveTimeSyncTask
	NetSessionFunc \{obj = session
		func = unpost_game}
	EndGameNetScriptPump
	change \{battle_sudden_death = 0}
	if ($game_mode = p2_battle)
		change \{save_current_powerups_p1 = [
				0
				0
				0
			]}
		change \{save_current_powerups_p2 = [
				0
				0
				0
			]}
		change \{structurename = player1_status
			save_num_powerups = 0}
		change \{structurename = player2_status
			save_num_powerups = 0}
		change \{structurename = player1_status
			save_health = 0.0}
		change \{structurename = player2_status
			save_health = 0.0}
	endif
	SetNetworkPreference {field = 'private_slots' string = ($num_private_slots [0].name) checksum = ($num_private_slots [0].checksum) num = 0}
	SetNetworkPreference \{field = 'ranked'
		string = "player"
		checksum = player
		num = 1}
	change \{match_type = player}
	change \{net_ready_to_start = 0}
	change \{current_num_players = 1}
	change \{player2_present = 0}
	change \{g_tie_breaker_song = 0}
	change \{net_can_send_approval = 1}
	change \{net_current_flow_state = none}
	reset_setlist
	reset_net_stats_menu
	change \{net_song_num = 0}
	change \{structurename = player2_status
		is_local_client = 1}
	change \{structurename = player2_status
		net_id_first = 0}
	change \{structurename = player2_status
		net_id_second = 0}
	if NOT ($game_mode = p2_coop)
		change \{structurename = player1_status
			part = guitar}
		change \{structurename = player2_status
			part = guitar}
	endif
endscript

script shut_down_net_play 
	printf \{"shut_down_net_play"}
	change \{is_network_game = 0}
	change \{new_net_logic = 0}
	SetNetworkMode
	NetSessionFunc \{obj = match
		func = stop_server_list}
	NetSessionFunc \{obj = match
		func = free_server_list}
	NetSessionFunc \{func = match_uninit}
	NetSessionFunc \{func = voice_uninit}
	destroy_gamertags
	destroy_net_popup
	cleanup_sessionfuncs
	change \{structurename = player1_status
		highway_layout = default_highway}
	change \{structurename = player2_status
		highway_layout = default_highway}
endscript

script select_quit_network_game 
	if ScreenElementExists \{id = yourock_text}
		DestroyScreenElement \{id = yourock_text}
	endif
	if ScreenElementExists \{id = yourock_text_2}
		DestroyScreenElement \{id = yourock_text_2}
	endif
	quit_network_game_early
endscript

script quit_network_game_early 
	change \{disable_attacks = 1}
	if NOT ($is_network_game)
		return
	endif
	if ($is_network_game)
		change \{gIsInNetGame = 0}
	endif
	if ($playing_song)
		send_fail_song_message \{wait_frames = 1
			quit_early = 1}
	endif
	PauseGame
	quit_network_game
	if GotParam \{signin_change}
		shut_down_net_play
	else
		kill_gem_scroller
	endif
endscript

script cancel_join_server 
	printf \{"---cancel_join_server"}
	LeaveServer
	NetSessionFunc \{obj = session
		func = unpost_game}
	NetSessionFunc \{obj = match
		func = free_server_list}
	NetSessionFunc \{obj = match
		func = cancel_join_server}
endscript

script post_network_game 
	if (NetSessionFunc obj = match func = get_gamertag)
		SetNetworkPreference field = 'network_id' string = <name>
		SetNetworkPreference field = 'server_name' string = <name>
	endif
	NetSessionFunc \{obj = session
		func = post_game}
	SetServerMode
	StartServer
	SetJoinMode \{$JOIN_MODE_PLAY}
	JoinServer
endscript

script set_match_values 
	return {
		difficulty = ($current_difficulty)
		gamemode = ($game_mode)
		num_songs = ($num_songs)
	}
endscript

script set_network_preferences 
	if (($match_type) = player)
		printf \{"set_network_preferences - setting 'player' match"}
		SetNetworkPreference \{field = 'ranked'
			string = "player"
			checksum = player
			num = 1}
	else
		printf \{"set_network_preferences - setting 'ranked' match"}
		SetNetworkPreference \{field = 'ranked'
			string = "ranked"
			checksum = ranked
			num = 0}
	endif
endscript

script send_game_info_to_client 
	prepare_lobby_message
	SendNetMessage {
		type = lobby_setup
		game_mode_index = <game_mode_index>
		venue = ($current_level)
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		character = ($player1_status.character_id)
		outfit = ($player1_status.outfit)
		style = ($player1_status.style)
		guitar = ($player1_status.instrument_id)
		flow_state_index = <flow_state>
	}
	change \{structurename = player2_status
		character_id = axel}
	change \{structurename = player2_status
		outfit = 1}
	change \{structurename = player2_status
		style = 1}
	change \{structurename = player2_status
		instrument_id = Instrument_Les_Paul_Black}
	change \{net_match_send_available_items_dirty = 1}
	change \{character_select_highlighted_character_p2_dirty = 1}
	net_match_send_available_items
	if CompositeObjectExists \{name = bassist}
		bassist :unhide
		bassist :ragdoll_markforreset
	endif
endscript

script client_lobby_setup 
	printf \{"--- client_lobby_setup"}
	change \{current_num_players = 2}
	KillSpawnedScript \{name = coop_fail_song}
	set_character_hub_dirty
	change current_level = <venue>
	translate_lobby_message {
		game_mode_index = <game_mode_index>
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		p2_flow_state = <flow_state_index>
	}
	change structurename = player2_status character_id = <character>
	change structurename = player2_status outfit = <outfit>
	change structurename = player2_status style = <style>
	change structurename = player2_status instrument_id = <guitar>
	change \{structurename = player1_status
		character_id = axel}
	change \{structurename = player1_status
		outfit = 1}
	change \{structurename = player1_status
		style = 1}
	change \{structurename = player1_status
		instrument_id = Instrument_Les_Paul_Black}
	change \{net_match_send_available_items_dirty = 1}
	change \{character_select_highlighted_character_p2_dirty = 1}
	change \{generic_select_monitor_p1_changed = 1}
	change \{generic_select_monitor_p2_changed = 1}
	net_match_send_available_items
	ui_flow_manager_respond_to_action \{action = join_server}
	resolve_current_flow_state p2_current_flow_state = <p2_flow_state>
endscript

script prepare_lobby_message 
	switch ($game_mode)
		case p2_faceoff
		<game_mode_index> = 1
		case p2_pro_faceoff
		<game_mode_index> = 2
		case p2_battle
		<game_mode_index> = 3
		case p2_coop
		<game_mode_index> = 4
	endswitch
	switch ($current_difficulty)
		case easy
		<difficulty_index> = 1
		case medium
		<difficulty_index> = 2
		case hard
		<difficulty_index> = 3
		case expert
		<difficulty_index> = 4
	endswitch
	switch ($num_songs)
		case num_1
		<number_of_songs_index> = 1
		case num_3
		<number_of_songs_index> = 3
		case num_5
		<number_of_songs_index> = 5
		case num_7
		<number_of_songs_index> = 7
	endswitch
	switch ($tie_breaker)
		case HOST
		<tie_breaker_index> = 1
		case CLIENT
		<tie_breaker_index> = 2
	endswitch
	switch ($ui_flow_manager_state [0])
		case online_character_select_fs
		<flow_state> = 1
		case online_character_hub_fs
		<flow_state> = 2
		case online_select_outfit_fs
		<flow_state> = 3
		case online_select_style_fs
		<flow_state> = 4
		case online_select_guitar_fs
		<flow_state> = 5
		case online_select_guitar_finish_fs
		<flow_state> = 6
		case online_select_bass_fs
		<flow_state> = 7
	endswitch
	return {
		game_mode_index = <game_mode_index>
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		flow_state = <flow_state>
	}
endscript

script translate_lobby_message 
	switch (<game_mode_index>)
		case 1
		change \{game_mode = p2_faceoff}
		case 2
		change \{game_mode = p2_pro_faceoff}
		case 3
		change \{game_mode = p2_battle}
		case 4
		change \{game_mode = p2_coop}
	endswitch
	switch (<difficulty_index>)
		case 1
		change \{current_difficulty = easy}
		change \{current_difficulty2 = easy}
		case 2
		change \{current_difficulty = medium}
		change \{current_difficulty2 = medium}
		case 3
		change \{current_difficulty = hard}
		change \{current_difficulty2 = hard}
		case 4
		change \{current_difficulty = expert}
		change \{current_difficulty2 = expert}
	endswitch
	switch (<number_of_songs_index>)
		case 1
		change \{num_songs = num_1}
		case 3
		change \{num_songs = num_3}
		case 5
		change \{num_songs = num_5}
		case 7
		change \{num_songs = num_7}
	endswitch
	switch (<tie_breaker_index>)
		case 1
		change \{tie_breaker = HOST}
		case 2
		change \{tie_breaker = CLIENT}
	endswitch
	switch (<p2_flow_state>)
		case 1
		<p2_flow_state> = online_character_select_fs
		case 2
		<p2_flow_state> = online_character_hub_fs
		case 3
		<p2_flow_state> = online_select_outfit_fs
		case 4
		<p2_flow_state> = online_select_style_fs
		case 5
		<p2_flow_state> = online_select_guitar_fs
		case 6
		<p2_flow_state> = online_select_guitar_finish_fs
		case 7
		<p2_flow_state> = online_select_bass_fs
	endswitch
	return p2_flow_state = <p2_flow_state>
endscript

script resolve_current_flow_state 
	if CompositeObjectExists \{name = bassist}
		bassist :unhide
		bassist :ragdoll_markforreset
	endif
	set_other_player_present
	network_player_lobby_message \{type = open_comm
		action = update}
endscript

script choose_selected_server 
	NetSessionFunc obj = match func = choose_server params = <...>
endscript

script cleanup_sessionfuncs 
	printf \{"---cleanup sessionfuncs"}
	NetSessionFunc \{func = match_uninit}
	NetSessionFunc \{func = voice_uninit}
	NetSessionFunc \{func = motd_uninit}
endscript

script setup_sessionfuncs 
	printf \{"---setup_sessionfuncs"}
	NetSessionFunc \{func = match_init}
	NetSessionFunc \{func = stats_init}
	NetSessionFunc \{func = voice_init}
	NetSessionFunc \{func = motd_init}
	NetSessionFunc \{obj = voice
		func = enable}
	if NetSessionFunc \{obj = match
			func = get_gamertag}
		SetNetworkPreference field = 'network_id' string = <name>
		SetNetworkPreference field = 'server_name' string = <name>
	endif
	MassiveInit \{sku = 'atvi_guitar_hero_3_pc_na'
		startzone = 'GlobalZone'}
endscript

script get_current_level_name 
	return level_name = ($LevelZones.($current_level).title) level = 1
endscript

script GetCurrentAreaStringAndChecksum 
	<area_string> = 'z_online_venue'
	<area_checksum> = dummy_value
endscript

script dispatch_player_state 
	if ($<player_status>.player = 1)
		<other_player_status> = player2_status
	else
		<other_player_status> = player1_status
	endif
	if ($<other_player_status>.highway_layout = solo_highway)
		begin
		FormatText \{checksumname = type
			'%s'
			s = 'player_state_light'}
		SendNetMessage {
			type = <type>
			score = ($<player_status>.score)
			current_run = ($<player_status>.current_run)
			star_power_amount = ($<player_status>.star_power_amount)
			current_health = ($<player_status>.current_health)
		}
		Wait \{0.1
			seconds}
		repeat
	else
		begin
		GetHeldPattern controller = ($<player_status>.controller) player_status = <player_status>
		FormatText \{checksumname = type
			'%s'
			s = 'player_state'}
		SendNetMessage {
			type = <type>
			guitar_volume = ($<player_status>.guitar_volume)
			star_power_toggle = ($<player_status>.star_power_used)
			score = ($<player_status>.score)
			current_run = ($<player_status>.current_run)
			star_power_amount = ($<player_status>.star_power_amount)
			hold_pattern = <hold_pattern>
			whammy_length = ($<player_status>.net_whammy)
			current_health = ($<player_status>.current_health)
		}
		Wait \{0.1
			seconds}
		repeat
	endif
endscript

script load_and_sync_timing \{start_delay = 4000}
	if ($<player_status>.highway_layout = solo_highway)
		change \{current_num_players = 1}
	else
		change \{current_num_players = 2}
	endif
	EndGameNetScriptPump
	set_rich_presence_game_mode \{online = 1}
	change \{structurename = player2_status
		is_local_client = 0}
	Load_Venue
	printf \{"Starting Song with Zone = %i\\n"
		i = $current_level}
	change \{net_ready_to_start = 0}
	change \{current_transition = intro}
	SpawnScriptLater restart_gem_scroller params = {
		song_name = ($current_song)
		difficulty = ($current_difficulty)
		difficulty2 = ($current_difficulty2)
		device_num = ($player1_status.controller)
	}
endscript

script launch_network_game 
	change \{net_ready_to_start = 1}
endscript

script ranked_quit_fix_scores 
	get_number_of_songs
	song_index = 0
	begin
	if ($game_mode = p2_battle)
		SetArrayElement ArrayName = g_p1_scores GlobalArray index = <song_index> newvalue = 8
		SetArrayElement ArrayName = g_p2_scores GlobalArray index = <song_index> newvalue = -1
	else
		SetArrayElement ArrayName = g_p2_scores GlobalArray index = <song_index> newvalue = 0
	endif
	<song_index> = (<song_index> + 1)
	repeat <num_songs>
endscript

script network_player_update 
	if ((GameIsOver) || ($playing_song = 0))
		return
	endif
	change structurename = <player_status> score = <score>
	change structurename = <player_status> current_health = <current_health>
	old_star_power = ($<player_status>.star_power_amount)
	change structurename = <player_status> star_power_amount = <star_power_amount>
	if ((<old_star_power> < 50.0) && (<star_power_amount> >= 50.0))
		spawnscriptnow show_star_power_ready params = {player_status = <player_status>}
	endif
	if ($game_mode = p2_coop)
		if (($player1_status.star_power_amount) < ($<player_status>.star_power_amount) && ($player1_status.star_power_used = 0))
			change structurename = player1_status star_power_amount = <star_power_amount>
		endif
	endif
	if (($game_mode = p2_coop) && ($<player_status>.current_run > <current_run>))
		change structurename = player1_status current_run = <current_run>
	endif
	change structurename = <player_status> current_run = <current_run>
	if NOT ($player1_status.highway_layout = solo_highway)
		if NOT (($<player_status>.guitar_volume) = <volume>)
			change structurename = <player_status> guitar_volume = <volume>
			UpdateGuitarVolume
		endif
		BroadcastEvent type = net_button_check_p2 data = {hold_pattern = <hold_pattern> player_status = <player_status> whammy_len = <whammy_length>}
		if ($game_mode = p2_coop)
			return
		endif
		if NOT ($<player_status>.star_power_used = <star_power>)
			if (<star_power>)
				spawnscriptnow star_power_activate_and_drain params = {
					player_status = <player_status>
					player_text = ($<player_status>.text)
					player = ($<player_status>.player)}
			endif
		endif
	endif
endscript

script net_check_buttons 
	get_song_prefix song = <song_name>
	FormatText checksumname = guitar_stream '%s_guitar' s = <song_prefix> AddToStringLookup
	GuitarInputLogicInit player_status = <player_status> guitar_stream = <guitar_stream> time_offset = <time_offset>
	ExtendCRC button_up_pixel_array ($<player_status>.text) out = pixel_array
	<player_text> = ($<player_status>.text)
	GetArraySize \{$gem_colors}
	begin
	array_count = 0
	begin
	color = ($gem_colors [<array_count>])
	pixels = ($<pixel_array> [<array_count>])
	button_lip_name = ($button_up_models.<color>.name)
	ExtendCRC <button_lip_name> '_lip' out = button_lip_name
	ExtendCRC <button_lip_name> <player_text> out = button_lip_name
	button_mid_name = ($button_up_models.<color>.name)
	ExtendCRC <button_mid_name> '_mid' out = button_mid_name
	ExtendCRC <button_mid_name> <player_text> out = button_mid_name
	button_neck_name = ($button_up_models.<color>.name)
	ExtendCRC <button_neck_name> '_neck' out = button_neck_name
	ExtendCRC <button_neck_name> <player_text> out = button_neck_name
	button_head_name = ($button_up_models.<color>.name)
	ExtendCRC <button_head_name> '_head' out = button_head_name
	ExtendCRC <button_head_name> <player_text> out = button_head_name
	now_scale = (($nowbar_scale_x * (1.0, 0.0)) + ($nowbar_scale_y * (0.0, 1.0)))
	if ($<player_status>.lefthanded_button_ups = 1)
		<pos2d> = ($button_up_models.<color>.left_pos_2d)
	else
		<pos2d> = ($button_up_models.<color>.pos_2d)
	endif
	if ($<player_status>.lefthanded_button_ups = 1)
		<playline_scale> = (((0 - <now_scale>.(1.0, 0.0)) * (1.0, 0.0)) + (<now_scale>.(0.0, 1.0) * (0.0, 1.0)))
	else
		<playline_scale> = <now_scale>
	endif
	<y_scale> = ((<pixels> + $neck_lip_add) / $neck_sprite_size)
	<neck_scale> = (((<playline_scale>.(1.0, 0.0)) * (1.0, 0.0)) + (<y_scale> * (0.0, 1.0)))
	<head_pos> = (<pos2d> - (<pixels> * (0.0, 1.0)))
	if ScreenElementExists id = <button_lip_name>
		SetScreenElementProps id = <button_lip_name> z_priority = 4.9
	endif
	if ScreenElementExists id = <button_mid_name>
		SetScreenElementProps id = <button_mid_name> z_priority = 4.6
	endif
	if ScreenElementExists id = <button_neck_name>
		SetScreenElementProps id = <button_neck_name> z_priority = 4.7 scale = <neck_scale>
	endif
	if ScreenElementExists id = <button_head_name>
		SetScreenElementProps id = <button_head_name> z_priority = 4.8 pos = <head_pos>
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	array_count = 0
	GetDeltaTime
	sub_amount = (($button_up_pixels * <delta_time>) / $button_sink_time)
	begin
	pixels = ($<pixel_array> [<array_count>])
	pixels = (<pixels> - <sub_amount>)
	if (<pixels> < 0.0)
		<pixels> = 0.0
	endif
	SetArrayElement ArrayName = <pixel_array> GlobalArray index = <array_count> newvalue = <pixels>
	array_count = (<array_count> + 1)
	repeat <array_size>
	Wait \{1
		gameframe}
	repeat
endscript

script network_events 
	SetEventHandler \{response = call_script
		event = net_button_check_p2
		Scr = network_player_buttons}
	Block
endscript

script network_player_buttons 
	GetArraySize \{$gem_colors}
	check_button = 65536
	<mask> = ($player2_status.broken_string_mask)
	array_count = 0
	begin
	if NOT (<mask> && <check_button>)
		color = ($gem_colors [<array_count>])
		button_head_name = ($button_up_models.<color>.name)
		ExtendCRC <button_head_name> '_head' out = button_head_name
		ExtendCRC <button_head_name> ($<player_status>.text) out = button_head_name
		if ScreenElementExists id = <button_head_name>
			if (<hold_pattern> && <check_button>)
				SetScreenElementProps id = <button_head_name> material = ($button_up_models.<color>.material_down)
			else
				SetScreenElementProps id = <button_head_name> material = ($button_up_models.<color>.material_head)
			endif
		endif
	endif
	<check_button> = (<check_button> / 16)
	array_count = (<array_count> + 1)
	repeat <array_size>
	if ($display_debug_input = 1)
		input_debug <...>
	endif
endscript

script net_check_note_hold 
	CheckNoteHoldInit player = <player> player_status = <player_status> array_entry = <array_entry> time = <time> guitar_stream = <guitar_stream> song = <song> pattern = <pattern>
	begin
	if NOT CheckNoteHoldWait player = <player>
		break
	endif
	Wait \{1
		gameframe}
	repeat
	CheckNoteHoldStart player = <player>
	SpawnScriptLater net_control_whammy_pitch_loop params = {song = <song> array_entry = <array_entry> pattern = <pattern> player_status = <player_status> time = <time>}
	begin
	if NOT CheckNoteHoldPerFrame player = <player>
		break
	endif
	Wait \{1
		gameframe}
	repeat
	KillSpawnedScript \{name = net_whammy_pitch_shift}
	KillSpawnedScript \{name = net_control_whammy_pitch_loop}
	CheckNoteHoldEnd player = <player>
endscript

script net_control_whammy_pitch_loop 
	change \{pitch_dirty = 1}
	begin
	GetSongTime
	start_time = <songtime>
	Block \{type = net_button_check_p2}
	GetSongTime
	delta_time = (<songtime> - <start_time>)
	<time> = (<time> - (<delta_time> * 1000))
	KillSpawnedScript \{name = net_whammy_pitch_shift}
	spawnscriptnow net_whammy_pitch_shift params = {song = <song> array_entry = <array_entry> pattern = <pattern> player_status = <player_status> net_whammy_length = (<event_data>.whammy_len) time = <time>}
	repeat
	KillSpawnedScript \{name = net_whammy_pitch_shift}
endscript
pitch_dirty = 1
prev_len = 0

script net_whammy_pitch_shift 
	if ($pitch_dirty = 1)
		change \{pitch_dirty = 0}
		change prev_len = <net_whammy_length>
		begin
		control_whammy_pitchshift song = <song> array_entry = <array_entry> pattern = <pattern> player_status = <player_status> net_whammy_length = <net_whammy_length> time = <time>
		Wait \{1
			gameframe}
		repeat
	else
		<len_delta> = (<net_whammy_length> - $prev_len)
		<len_base> = ($prev_len)
		change prev_len = <net_whammy_length>
		<frames> = 5
		<scale> = (1.0 / <frames>)
		<scale_step> = <scale>
		begin
		<len> = (<len_base> + (<len_delta> * <scale>))
		set_whammy_pitchshift control = <len> player_status = <player_status>
		<whammy_scale> = (((<len> * 0.5) + 0.5) * 2.0)
		SetNewWhammyValue value = <whammy_scale> time_remaining = <time> player_status = <player_status> player = (<player_status>.player)
		<scale> = (<scale> + <scale_step>)
		Wait \{1
			gameframe}
		repeat <frames>
		begin
		set_whammy_pitchshift control = <net_whammy_length> player_status = <player_status>
		<whammy_scale> = (((<net_whammy_length> * 0.5) + 0.5) * 2.0)
		SetNewWhammyValue value = <whammy_scale> time_remaining = <time> player_status = <player_status> player = (<player_status>.player)
		Wait \{1
			gameframe}
		repeat
	endif
endscript

script set_net_client_highway 
	change structurename = <player_status> highway_layout = <layout>
endscript

script set_net_client_lefty 
	change structurename = player2_status lefthanded_gems = <lefty_flip_p2>
	change structurename = player2_status lefthanded_button_ups = <lefty_flip_p2>
endscript

script finalize_connection_to_peer 
	printf \{"---finalize_connection_to_peer"}
	change opponent_gamertag = <opponent_gamertag>
	change structurename = player1_status net_id_first = <p1_net_id_first>
	change structurename = player1_status net_id_second = <p1_net_id_second>
	change structurename = player2_status net_id_first = <p2_net_id_first>
	change structurename = player2_status net_id_second = <p2_net_id_second>
	FormatText \{checksumname = player_status
		'player1_status'}
	GetGlobalTags \{user_options}
	SendNetMessage {
		type = lefty_update
		lefty_flag = (<lefty_flip_p1>)
	}
	if IsHost
		ResetLobbyReady
		send_game_info_to_client
	endif
	StartGameNetScriptPump
endscript

script net_copy_intial_params 
	change globalname = <copy_to> newvalue = $<copy_from>
endscript

script net_commit_or_reset_params 
	if GotParam \{commit}
		change globalname = <copy_to> newvalue = $<copy_from>
	else
		if (<type> = loc)
			<text> :SetProps text = ($LevelZones.($LevelZoneArray [$<global>]).title)
		else
			<text> :SetProps text = ($FilterTypes.<type>.values [$<global>])
		endif
	endif
	change_coop_value_if_ranked
endscript

script net_custom_up_down \{direction = up}
	if (<type> = loc)
		GetArraySize ($LevelZoneArray)
	else
		GetArraySize ($FilterTypes.<type>.values)
	endif
	if (<direction> = up)
		if ((<array_size> -1) = $<global>)
			change globalname = <global> newvalue = 0
		else
			change globalname = <global> newvalue = ($<global> + 1)
		endif
	else
		if (0 = $<global>)
			change globalname = <global> newvalue = (<array_size> -1)
		else
			change globalname = <global> newvalue = (<global> - 1)
		endif
	endif
	if (<type> = loc)
		<text> :SetProps text = ($LevelZones.($LevelZoneArray [$<global>]).title) scale = 1.0
		fit_text_into_menu_item id = <text> max_width = 375
	else
		<text> :SetProps text = ($FilterTypes.<type>.values [$<global>]) scale = 1.0
		fit_text_into_menu_item id = <text> max_width = 375
	endif
	if (($SearchMatchTypeValue = 1) && (<type> = mode) && ($<global> = 4) && ($ui_flow_manager_state [0] = custom_match_fs))
		net_custom_up_down <...>
	endif
	if (($<global> = 2) && (<type> = search))
		if NOT isXenon
			net_custom_up_down <...>
		endif
	endif
endscript

script change_coop_value_if_ranked 
	if (($SearchMatchTypeValue = 1) && ($SearchGameModeValue = 4))
		net_custom_up_down \{direction = up
			type = mode
			global = SearchGameModeValue
			text = game_mode_selection_text}
	endif
endscript

script block_unblock_difficulty_actions \{diff_focus = off
		menu = search}
	if GotParam \{diff_focus}
		<change_color> = ($online_light_blue)
	else
		<change_color> = ($online_dark_purple)
	endif
	if (<menu> = search)
		<gamemode> = ($SearchGameModeValue)
		<new_text> = ($FilterTypes.diff.values [($SearchDifficultyValue)])
	else
		<gamemode> = ($OptionsGameModeValue)
		<new_text> = ($FilterTypes.diff.values [($OptionsDifficultyValue)])
	endif
	if ((<gamemode> = 0) || (<gamemode> = 2))
		if ScreenElementExists \{id = difficulty}
			difficulty :SetProps rgba = <change_color> unblock_events
		endif
		if ScreenElementExists \{id = difficulty_selection_text}
			difficulty_selection_text :SetProps rgba = <change_color> text = <new_text> unblock_events
		endif
	else
		if ScreenElementExists \{id = difficulty}
			difficulty :SetProps rgba = ($online_grey) block_events
		endif
		if ScreenElementExists \{id = difficulty_selection_text}
			difficulty_selection_text :SetProps rgba = ($online_grey) text = "N/A" block_events
		endif
	endif
endscript

script online_menu_init 
	printf \{"--- online_menu_init"}
	change player1_device = ($primary_controller)
	setup_online_player_settings
	change \{is_network_game = 1}
	change \{new_net_logic = 1}
	change \{current_num_players = 1}
	change \{player2_present = 0}
	change \{opponent_gamertag = null}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	create_guitarist \{name = Guitarist
		useOldPos
		no_strum
		animpak = 0}
	create_guitarist \{name = bassist
		useOldPos
		no_strum
		animpak = 0}
	SetNetworkMode \{$INTERNET_MODE}
	cleanup_sessionfuncs
	setup_sessionfuncs
	NetSessionFunc \{func = getnumplayers}
	create_menu_backdrop \{texture = Online_Background}
	begin
	if ($DEMONWARE_IS_READY = 1)
		break
	endif
	Wait \{1
		frame}
	repeat
endscript

script setup_online_player_settings 
	GetGlobalTags \{user_options}
	switch (<online_highway>)
		case 0
		change \{structurename = player1_status
			highway_layout = default_highway}
		case 1
		change \{structurename = player1_status
			highway_layout = solo_highway}
	endswitch
endscript

script get_random_song 
	first_song_index = (-1)
	last_song_index = (-1)
	array_entry = 0
	GetArraySize \{$gh3_songlist}
	begin
	song_checksum = ($gh3_songlist [<array_entry>])
	get_song_struct song = <song_checksum>
	if ((<song_struct>.version) = gh3)
		if (<first_song_index> = (-1))
			<first_song_index> = <array_entry>
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	<last_song_index> = (<array_entry> - 1)
	GetRandomValue name = random_value Integer a = <first_song_index> b = <last_song_index>
	return random_song = ($gh3_songlist [<random_value>])
endscript

script start_network_game 
	if IsHost
		startnetworkgame
	endif
endscript

script check_for_final_song_selection 
	if (($tie_breaker) = song_rand)
		return \{can_select_final_song = false}
	elseif (($tie_breaker) = HOST)
		if IsHost
			return \{can_select_final_song = true}
		else
			return \{can_select_final_song = false}
		endif
	elseif (($tie_breaker) = CLIENT)
		if IsHost
			return \{can_select_final_song = false}
		else
			return \{can_select_final_song = true}
		endif
	endif
endscript

script online_fail_song 
	printf \{"---online fail song"}
	change \{disable_attacks = 1}
	if (GameIsOver)
		change \{current_num_players = 2}
		return
	endif
	if (IsHost)
		loser = 0
	else
		loser = 1
	endif
	SendNetMessage {
		type = fail_song
		stars = ($player1_status.stars)
		note_streak = ($player1_status.best_run)
		notes_hit = ($player1_status.notes_hit)
		total_notes = ($player1_status.total_notes)
		quit_early_flag = 0
		loser = <loser>
	}
endscript

script online_win_song 
	if ($ui_flow_manager_state [0] = online_pause_fs)
		net_unpausegh3
	endif
	disable_pause
	printf \{"---online_win_song"}
	change \{disable_attacks = 1}
	change structurename = <player_status> stars = <stars>
	change structurename = <player_status> best_run = <note_streak>
	change structurename = <player_status> total_notes = <total_notes>
	change structurename = <player_status> notes_hit = <notes_hit>
	if (<quit_early>)
		change \{player2_present = 0}
		FormatText TextName = notification_text "%n\\n has quit" n = ($opponent_gamertag)
		if ($match_type = ranked)
			ranked_quit_fix_scores
		endif
		if ($game_mode = p2_battle)
			change \{structurename = player1_status
				current_health = 1.0}
			change \{structurename = player2_status
				current_health = 0.0}
		else
			change \{structurename = player2_status
				score = 0.0}
		endif
		create_net_popup popup_text = <notification_text>
		Wait \{3
			seconds}
		destroy_net_popup
	endif
	player_text = (<player_status>.text)
	change \{current_num_players = 2}
	if ($game_mode = p2_battle)
		if (<losing_player> = 1)
			change \{structurename = player1_status
				current_health = 0.0}
			change \{structurename = player2_status
				current_health = 1.0}
		else
			change \{structurename = player1_status
				current_health = 1.0}
			change \{structurename = player2_status
				current_health = 0.0}
		endif
		GuitarEvent_SongWon \{battle_win = 1}
	else
		ExtendCRC song_won <player_text> out = type
		BroadcastEvent type = <type>
	endif
endscript

script broadcast_received_winner_stats 
	change structurename = <player_status> stars = <stars>
	change structurename = <player_status> best_run = <note_streak>
	change structurename = <player_status> total_notes = <total_notes>
	change structurename = <player_status> notes_hit = <notes_hit>
	if ($game_mode = p2_battle)
		record_net_statistics
	endif
endscript

script set_rich_presence_searching 
	change \{rich_presence_context = presence_online_searching}
endscript

script set_rich_presence_game_mode \{online = 0}
	if (<online>)
		change \{rich_presence_context = presence_online_game_mode}
	else
		switch ($game_mode)
			case p1_career
			change \{rich_presence_context = presence_career}
			case p1_quickplay
			change \{rich_presence_context = presence_quick_play}
			case p2_career
			if ($coop_dlc_active)
				change \{rich_presence_context = presence_2player}
			else
				change \{rich_presence_context = presence_coop_career}
			endif
			case p2_pro_faceoff
			change \{rich_presence_context = presence_2player}
			case p2_faceoff
			change \{rich_presence_context = presence_2player}
			case p2_battle
			change \{rich_presence_context = presence_battle}
			case training
			change \{rich_presence_context = presence_practice}
		endswitch
	endif
endscript

script get_custom_match_search_params 
	GetPreferenceChecksum \{ranked}
	ranked = <checksum>
	GetPreferenceValue \{ranked}
	ranked_value = <value>
	if (($SearchGameModeValue = 0) || ($SearchGameModeValue = 2))
		difficulty_checksum = ($FilterTypes.diff.checksum [($SearchDifficultyValue)])
	else
		difficulty_checksum = dont_care
	endif
	return {
		difficulty = <difficulty_checksum>
		gamemode = ($FilterTypes.mode.checksum [($SearchGameModeValue)])
		num_songs = ($FilterTypes.num_songs.checksum [($SearchNumSongsValue)])
		tie_breaker = dont_care
		ranked = <ranked>
		ranked_value = <ranked_value>
	}
endscript

script get_quick_match_search_params 
	GetGlobalTags \{user_options}
	GetPreferenceChecksum \{ranked}
	ranked = <checksum>
	GetPreferenceValue \{ranked}
	ranked_value = <value>
	if ((<online_game_mode> = 0) || (<online_game_mode> = 2))
		difficulty_checksum = ($FilterTypes.diff.checksum [<online_difficulty>])
	else
		difficulty_checksum = dont_care
	endif
	return {
		difficulty = <difficulty_checksum>
		gamemode = ($FilterTypes.mode.checksum [<online_game_mode>])
		num_songs = ($FilterTypes.num_songs.checksum [<online_num_songs>])
		tie_breaker = dont_care
		ranked = <ranked>
		ranked_value = <ranked_value>
	}
endscript

script get_private_match_search_params 
	return {
		privateMatchId = ($gPrivateMatchId)
	}
endscript
bPS3SingleSignOnCheckComplete = 0

script xenon_singleplayer_session_init \{ps3_signin_callback = xenon_singleplayer_session_init}
	printscriptinfo \{"--- MJS xenon_singleplayer_session_init"}
	if CheckForSignIn
		if ($is_network_game = 1)
			NetSessionFunc \{func = motd_uninit}
			NetSessionFunc \{func = motd_init}
			if isXenon
				NetSessionFunc \{func = start_singleplayer_session
					obj = session}
				MassiveInit \{sku = 'atvi_guitar_hero_3_pc_na'
					startzone = 'GlobalZone'}
			endif
		endif
	else
		if ($is_attract_mode = 0)
			if NOT GotParam \{from_callback}
				if (0 = $bPS3SingleSignOnCheckComplete)
					NetSessionFunc func = onlinesignin params = {callback = <ps3_signin_callback>}
					change \{bPS3SingleSignOnCheckComplete = 1}
				endif
			else
				printf \{"PS3: unable to signin in to the network platform"}
			endif
		endif
	endif
endscript

script begin_singleplayer_game 
	if NetSessionFunc \{obj = session
			func = has_active_session}
		NetSessionFunc \{obj = session
			func = begin_singleplayer_game}
	endif
endscript

script xenon_singleplayer_session_begin_uninit 
	if isXenon
		NetSessionFunc \{func = stop_singleplayer_session
			obj = session}
	endif
endscript

script xenon_singleplayer_session_complete_uninit 
	printf \{"--- xenon_singleplayer_session_complete_uninit"}
	change \{net_safe_to_enter_net_play = 0}
	NetSessionFunc \{obj = session
		func = unpost_game}
	NetSessionFunc \{func = match_uninit}
	NetSessionFunc \{func = motd_uninit}
	change \{net_safe_to_enter_net_play = 1}
endscript

script send_leader_board_message 
	printscriptinfo \{"--- MJS send_leader_board_message"}
	player1_xuid = [0 0]
	player2_xuid = [0 0]
	switch (<diff>)
		case easy
		<rating> = 1
		case medium
		<rating> = 2
		case hard
		<rating> = 3
		case expert
		<rating> = 4
	endswitch
	if ($game_mode = p1_career)
		controller = ($primary_controller)
		GetNetID player = <controller>
		SetArrayElement ArrayName = player1_xuid index = 0 newvalue = <net_id_first>
		SetArrayElement ArrayName = player1_xuid index = 1 newvalue = <net_id_second>
		switch (<diff>)
			case easy
			<career_leaderboard_id> = lb_career_easy
			<campaign_leaderboard_id> = lb_campaign_easy
			case medium
			<career_leaderboard_id> = lb_career_med
			<campaign_leaderboard_id> = lb_campaign_med
			case hard
			<career_leaderboard_id> = lb_career_hard
			<campaign_leaderboard_id> = lb_campaign_hard
			case expert
			<career_leaderboard_id> = lb_career_expert
			<campaign_leaderboard_id> = lb_campaign_expert
		endswitch
		get_progression_globals game_mode = ($game_mode)
		summation_career_score tier_global = <tier_global>
		player_list = [
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <leaderboard_id>
						rating = <rating>
						score = <score>
						write_type = max
						columns = [
							{score = <score>}
							{score = <score>}
							{score = <score>}
						]
					}
					{
						leaderboard_id = <career_leaderboard_id>
						rating = 0
						score = <career_score>
						write_type = max
						columns = [
							{score = <career_score>}
							{score = <career_score>}
							{score = <career_score>}
						]
					}
					{
						leaderboard_id = <campaign_leaderboard_id>
						rating = 0
						score = <score>
						write_type = accumulate
						columns = [
							{score = <score>}
							{score = <score>}
							{score = <score>}
						]
					}
					{
						leaderboard_id = lb_campaign
						rating = 0
						score = <score>
						write_type = accumulate
						columns = [
							{score = <score>}
							{score = <score>}
							{score = <score>}
						]
					}
				]
			}
		]
	elseif (($game_mode = p2_career) && ($coop_dlc_active = 0))
		controller = ($primary_controller)
		GetNetID player = <controller>
		SetArrayElement ArrayName = player1_xuid index = 0 newvalue = <net_id_first>
		SetArrayElement ArrayName = player1_xuid index = 1 newvalue = <net_id_second>
		net_get_highest_coop_difficulty
		switch <highest_diff>
			case easy
			rating = 1
			career1_leaderboard_id = lb_coop_career_easy
			case medium
			rating = 2
			career1_leaderboard_id = lb_coop_career_med
			case hard
			rating = 3
			career1_leaderboard_id = lb_coop_career_hard
			case expert
			rating = 4
			career1_leaderboard_id = lb_coop_career_expert
		endswitch
		get_progression_globals game_mode = ($game_mode)
		summation_career_score tier_global = <tier_global>
		player_list = [
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <leaderboard_id>
						rating = <rating>
						score = <score>
						write_type = max
						columns = [
							{score = <score>}
							{score = <score>}
							{score = <score>}
						]
					}
					{
						leaderboard_id = <career1_leaderboard_id>
						rating = 0
						score = <career_score>
						write_type = max
						columns = [
							{score = <career_score>}
							{score = <career_score>}
							{score = <career_score>}
						]
					}
				]
			}
		]
	else
		controller = ($primary_controller)
		GetNetID player = <controller>
		SetArrayElement ArrayName = player1_xuid index = 0 newvalue = <net_id_first>
		SetArrayElement ArrayName = player1_xuid index = 1 newvalue = <net_id_second>
		player_list = [
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <leaderboard_id>
						rating = <rating>
						score = <score>
						write_type = max
						columns = [
							{score = <score>}
							{score = <score>}
							{score = 0}
						]
					}
				]
			}
		]
	endif
	NetSessionFunc func = stats_write_multiplayer obj = stats params = {player_list = <player_list>}
endscript

script net_write_single_player_stats 
	net_retrieve_primary_controller_score
	primary_player_score = <primary_score>
	secondary_player_score = <secondary_score>
	if (<primary_player_score> > 0)
		if NOT (($game_mode = p2_battle) || ($game_mode = practice) || $Cheat_NoFail = 1 || $Cheat_EasyExpert = 1)
			if ($game_mode = p2_career)
				primary_player_score = (<primary_player_score> + <secondary_player_score>)
				CastToInteger \{primary_player_score}
				get_song_struct song = ($current_song)
				FormatText checksumname = coop_song_checksum 'lb_coop_%s' s = (<song_struct>.name)
				send_leader_board_message score = <primary_player_score> leaderboard_id = <coop_song_checksum> diff = ($current_difficulty)
			else
				CastToInteger \{primary_player_score}
				send_leader_board_message score = <primary_player_score> leaderboard_id = ($current_song) diff = ($current_difficulty)
			endif
		else
			xenon_singleplayer_session_begin_uninit
		endif
	else
		xenon_singleplayer_session_begin_uninit
	endif
endscript

script net_retrieve_primary_controller_score 
	if (($player1_status.controller) = ($primary_controller))
		return primary_score = ($player1_status.score) secondary_score = ($player2_status.score)
	elseif (($player2_status.controller) = ($primary_controller))
		return primary_score = ($player2_status.score) secondary_score = ($player1_status.score)
	else
		return \{primary_score = 0
			secondary_score = 0}
	endif
endscript

script summation_career_score 
	setlist_prefix = ($<tier_global>.prefix)
	career_score = 0
	tier = 1
	begin
	FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	array_count = 0
	begin
	FormatText checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1) s = <tier>
	GetGlobalTags <song_checksum> param = score
	<career_score> = (<career_score> + <score>)
	array_count = (<array_count> + 1)
	repeat <array_size>
	tier = (<tier> + 1)
	repeat ($<tier_global>.num_tiers)
	return career_score = <career_score>
endscript

script online_song_end_write_stats \{song_type = single}
	printscriptinfo \{"MJS --- online_song_end_write_stats"}
	player1_score = ($player1_status.score)
	CastToInteger \{player1_score}
	if (<player1_score> > 0)
		player1_xuid = [0 0]
		SetArrayElement ArrayName = player1_xuid index = 0 newvalue = ($player1_status.net_id_first)
		SetArrayElement ArrayName = player1_xuid index = 1 newvalue = ($player1_status.net_id_second)
		if (<song_type> = coop)
			net_get_highest_coop_difficulty
			switch <highest_diff>
				case easy
				<player1_difficulty_index> = 1
				case medium
				<player1_difficulty_index> = 2
				case hard
				<player1_difficulty_index> = 3
				case expert
				<player1_difficulty_index> = 4
			endswitch
			get_song_struct song = ($net_setlist_songs [($net_song_num)])
			FormatText checksumname = leaderboard_id 'lb_coop_%s' s = (<song_struct>.name)
		else
			switch ($current_difficulty)
				case easy
				<player1_difficulty_index> = 1
				case medium
				<player1_difficulty_index> = 2
				case hard
				<player1_difficulty_index> = 3
				case expert
				<player1_difficulty_index> = 4
			endswitch
			leaderboard_id = ($net_setlist_songs [($net_song_num)])
		endif
		player_list = [
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <leaderboard_id>
						rating = <player1_difficulty_index>
						score = <player1_score>
						write_type = max
						columns = [
							{score = <player1_score>}
							{score = <player1_score>}
							{score = 0}
						]
					}
				]
			}
		]
	endif
	if GotParam \{player_list}
		NetSessionFunc func = stats_write_multiplayer obj = stats params = {player_list = <player_list> dontendsessionafterwrite}
	endif
endscript

script online_match_end_write_stats 
	printscriptinfo \{"MJS --- online_match_end_write_stats"}
	write_stats = 0
	if ($game_mode = p2_coop)
		write_stats = 0
	else
		write_stats = 1
	endif
	printscriptinfo \{"MJS --- checking write_stats"}
	if (<write_stats> = 1)
		printscriptinfo \{"MJS --- <write_stats> = 1"}
		GetGlobalTags \{net}
		net_get_game_mode_leaderboard_id
		switch ($game_mode)
			case p2_faceoff
			printscriptinfo \{"MJS --- <p2_faceoff>"}
			<total_win_lose_leaderboard_id> = lb_faceoff_winratio
			<streak_leaderboard_id> = lb_faceoff_win_streak
			<streak_score> = <face_off_streak>
			<wins> = <faceoff_wins>
			<loses> = <faceoff_loses>
			case p2_pro_faceoff
			printscriptinfo \{"MJS --- <p2_pro_faceoff>"}
			<total_win_lose_leaderboard_id> = lb_pro_faceoff_winratio
			<streak_leaderboard_id> = lb_pro_faceoff_win_streak
			<streak_score> = <pro_face_off_streak>
			<wins> = <pro_faceoff_wins>
			<loses> = <pro_faceoff_loses>
			case p2_battle
			printscriptinfo \{"MJS --- <p2_battle>"}
			<total_win_lose_leaderboard_id> = lb_battle_winratio
			<streak_leaderboard_id> = lb_battle_win_streak
			<streak_score> = <battle_streak>
			<wins> = <battle_wins>
			<loses> = <battle_loses>
		endswitch
		printscriptinfo \{"MJS --- calling prepare_player_list_array"}
		prepare_player_list_array {
			p1_leaderboard_id = <p1_leaderboard_id>
			p2_leaderboard_id = <p2_leaderboard_id>
			total_win_lose_leaderboard_id = <total_win_lose_leaderboard_id>
			streak_leaderboard_id = <streak_leaderboard_id>
			streak_score = <streak_score>
			wins = <wins>
			loses = <loses>
		}
		if GotParam \{player_list}
			printscriptinfo \{"MJS --- calling stats_write_multiplayer"}
			printstruct <player_list>
			NetSessionFunc func = stats_write_multiplayer obj = stats params = {player_list = <player_list> dontendsessionafterwrite}
		endif
	endif
	printscriptinfo \{"MJS --- end_write_stats"}
	Wait \{3
		seconds}
	NetSessionFunc \{obj = stats
		func = end_write_stats}
endscript

script net_get_highest_coop_difficulty 
	if (($current_difficulty = expert) || ($current_difficulty2 = expert))
		return \{highest_diff = expert}
	endif
	if (($current_difficulty = hard) || ($current_difficulty2 = hard))
		return \{highest_diff = hard}
	endif
	if (($current_difficulty = medium) || ($current_difficulty2 = medium))
		return \{highest_diff = medium}
	endif
	return \{highest_diff = easy}
endscript

script online_set_win_losses_streak \{out_come = lose}
	GetGlobalTags \{net}
	switch ($game_mode)
		case p2_battle
		if (<out_come> = win)
			SetGlobalTags net params = {battle_streak = (<battle_streak> + 1) battle_wins = (<battle_wins> + 1)}
		else
			SetGlobalTags net params = {battle_streak = 0 battle_loses = (<battle_loses> + 1)}
		endif
		case p2_faceoff
		if (<out_come> = win)
			SetGlobalTags net params = {face_off_streak = (<face_off_streak> + 1) faceoff_wins = (<faceoff_wins> + 1)}
		else
			SetGlobalTags net params = {face_off_streak = 0 faceoff_loses = (<faceoff_loses> + 1)}
		endif
		case p2_pro_faceoff
		if (<out_come> = win)
			SetGlobalTags net params = {pro_face_off_streak = (<pro_face_off_streak> + 1) pro_faceoff_wins = (<pro_faceoff_wins> + 1)}
		else
			SetGlobalTags net params = {pro_face_off_streak = 0 pro_faceoff_loses = (<pro_faceoff_loses> + 1)}
		endif
	endswitch
endscript

script net_get_game_mode_leaderboard_id 
	printf \{"net_get_game_mode_leaderboard_id"}
	switch ($game_mode)
		case p2_faceoff
		FormatText checksumname = leaderboard_id_p1 'lb_faceoff_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty))
		FormatText checksumname = leaderboard_id_p2 'lb_faceoff_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty2))
		case p2_pro_faceoff
		FormatText checksumname = leaderboard_id_p1 'lb_pro_faceoff_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty))
		FormatText checksumname = leaderboard_id_p2 'lb_pro_faceoff_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty2))
		case p2_battle
		FormatText checksumname = leaderboard_id_p1 'lb_battle_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty))
		FormatText checksumname = leaderboard_id_p2 'lb_battle_%s' s = ($Leaderboard_Difficulty_Lookup_Table.($current_difficulty2))
	endswitch
	return {p1_leaderboard_id = <leaderboard_id_p1> p2_leaderboard_id = <leaderboard_id_p2>}
endscript

script prepare_player_list_array 
	printscriptinfo \{"MJS --- prepare_player_list_array"}
	net_stats_calculate_wins
	player1_xuid = [0 0]
	player2_xuid = [0 0]
	SetArrayElement ArrayName = player1_xuid index = 0 newvalue = ($player1_status.net_id_first)
	SetArrayElement ArrayName = player1_xuid index = 1 newvalue = ($player1_status.net_id_second)
	SetArrayElement ArrayName = player2_xuid index = 0 newvalue = ($player2_status.net_id_first)
	SetArrayElement ArrayName = player2_xuid index = 1 newvalue = ($player2_status.net_id_second)
	printscriptinfo \{"MJS --- checking wins"}
	printf "p1=%a p2=%b" a = <p1_wins> b = <p2_wins>
	if (<p1_wins> = <p2_wins>)
		printscriptinfo \{"MJS --- wins are equal"}
		return
	elseif (<p1_wins> > <p2_wins>)
		printscriptinfo \{"MJS --- p1 is greater"}
		get_match_type_leaderboard_info \{p1_wins_value = 1
			p1_loses_value = 0
			p2_wins_value = 0
			p2_loses_value = 1}
		GetLeaderboardWinLoseValue win = (<wins> + 1) lose = <loses>
		online_set_win_losses_streak \{out_come = win}
		player_list = [
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <p1_leaderboard_id>
						rating = 0
						score = <score1>
						write_type = <write_type>
						columns = [
							{score = <attrib_acum1>}
							{score = <attrib_score1>}
							{score = <attrib_tot1>}
						]
					}
					{
						leaderboard_id = <total_win_lose_leaderboard_id>
						rating = 0
						score = <winlosevalue>
						write_type = last
						columns = [
							{score = <winlosevalue>}
							{score = <winlosevalue>}
							{score = <winlosevalue>}
						]
					}
					{
						leaderboard_id = <streak_leaderboard_id>
						rating = 0
						score = (<streak_score> + 1)
						write_type = last
						columns = [
							{score = (<streak_score> + 1)}
							{score = (<streak_score> + 1)}
							{score = (<streak_score> + 1)}
						]
					}
				]
			}
			{
				player_xuid = <player2_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <p2_leaderboard_id>
						rating = 0
						score = <score2>
						write_type = <write_type>
						columns =
						[
							{score = <attrib_acum2>}
							{score = <attrib_score2>}
							{score = <attrib_tot2>}
						]
					}
				]
			}
		]
	elseif (<p1_wins> < <p2_wins>)
		printscriptinfo \{"MJS --- p2 is greater"}
		get_match_type_leaderboard_info \{p1_wins_value = 0
			p1_loses_value = 1
			p2_wins_value = 1
			p2_loses_value = 0}
		GetLeaderboardWinLoseValue win = <wins> lose = (<loses> + 1)
		online_set_win_losses_streak \{outcome = lose}
		player_list = [
			{
				player_xuid = <player2_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <p2_leaderboard_id>
						rating = 0
						score = <score2>
						write_type = <write_type>
						columns = [
							{score = <attrib_acum2>}
							{score = <attrib_score2>}
							{score = <attrib_tot2>}
						]
					}
				]
			}
			{
				player_xuid = <player1_xuid>
				team = 0
				leaderboards = [
					{
						leaderboard_id = <p1_leaderboard_id>
						rating = 0
						score = <score1>
						write_type = <write_type>
						columns = [
							{score = <attrib_acum1>}
							{score = <attrib_score1>}
							{score = <attrib_tot1>}
						]
					}
					{
						leaderboard_id = <total_win_lose_leaderboard_id>
						rating = 0
						score = <winlosevalue>
						write_type = last
						columns = [
							{score = <winlosevalue>}
							{score = <winlosevalue>}
							{score = <winlosevalue>}
						]
					}
					{
						leaderboard_id = <streak_leaderboard_id>
						rating = 0
						score = 0
						write_type = last
						columns = [
							{score = 0}
							{score = 0}
							{score = 0}
						]
					}
				]
			}
		]
	endif
	printstruct <...>
	return player_list = <player_list>
endscript

script get_match_type_leaderboard_info 
	if NOT ($game_mode = p2_battle)
		net_stats_calculate_total_scores
		player1_score = <p1_score>
		CastToInteger \{player1_score}
		player2_score = <p2_score>
		CastToInteger \{player2_score}
		return {
			write_type = max
			score1 = <player1_score>
			attrib_acum1 = <player1_score>
			attrib_score1 = <player1_score>
			attrib_tot1 = 0
			score2 = <player2_score>
			attrib_acum2 = <player2_score>
			attrib_score2 = <player2_score>
			attrib_tot2 = 0
		}
	else
		return {
			write_type = accumulate
			score1 = <p1_wins_value>
			attrib_acum1 = <p1_wins_value>
			attrib_score1 = <p1_wins_value>
			attrib_tot1 = 0
			score2 = <p2_wins_value>
			attrib_acum2 = <p2_wins_value>
			attrib_score2 = <p2_wins_value>
			attrib_tot2 = 0
		}
	endif
endscript

script network_player_lobby_message 
	if NOT ((<type> = open_comm) || (<type> = ready_up))
		return
	endif
	switch <type>
		case character_select
		<selection_type> = 0
		case character_hub_select
		<selection_type> = 1
		case outfit_select
		<selection_type> = 2
		case style_select
		<selection_type> = 3
		case guitar_select
		<selection_type> = 4
		case skin_select
		<selection_type> = 5
		case song_select
		<selection_type> = 6
		case ready_up
		<selection_type> = 7
		case open_comm
		<selection_type> = 8
	endswitch
	switch <action>
		case update
		<selection_action> = 0
		case deselect
		<selection_action> = 1
		case select
		<selection_action> = 2
	endswitch
	if GotParam \{value1}
		<selection_index1> = <value1>
	else
		<selection_index1> = 0
	endif
	if GotParam \{value2}
		<selection_index2> = <value2>
	else
		<selection_index2> = 0
	endif
	if GotParam \{checksum}
		<checksum_value> = <checksum>
	else
		<checksum_value> = null
	endif
	SendNetMessage {
		type = lobby_selection
		selection_type = <selection_type>
		selection_action = <selection_action>
		selection_index1 = <selection_index1>
		selection_index2 = <selection_index2>
		net_checksum = <checksum_value>
	}
endscript

script net_request_play_show 
	if (($p1_ready = 1) && ($p2_ready = 1))
		return
	endif
	if (<action> = 1)
		if ($p1_ready = 0)
			if ScreenElementExists \{id = vmenu_character_hub_p1}
				LaunchEvent \{type = unfocus
					target = vmenu_character_hub_p1}
			endif
			SendNetMessage {
				type = lobby_ready
				ready_status = <action>
			}
		endif
	else
		if ($p1_ready = 1)
			if ScreenElementExists \{id = vmenu_character_hub_p1}
				LaunchEvent \{type = unfocus
					target = vmenu_character_hub_p1}
			endif
			SendNetMessage {
				type = lobby_ready
				ready_status = <action>
			}
		else
			character_hub_go_back \{player = 1}
		endif
	endif
endscript

script net_request_play_show_ack 
	if (($p1_ready = 1) && ($p2_ready = 1))
		return
	endif
	if GotParam \{action}
		if (<action> = 0)
			if (<player> = 1)
				character_hub_go_back player = <player>
			else
				character_hub_net_ready_back
			endif
		else
			if (<player> = 1)
				character_hub_select_play_show player = <player>
				if ScreenElementExists \{id = vmenu_character_hub_p1}
					LaunchEvent \{type = focus
						target = vmenu_character_hub_p1}
				endif
			else
				character_hub_net_ready
			endif
		endif
	endif
endscript

script network_player_lobby_update 
	if NOT (($player2_present) || (<selection_type> = 8))
		printf "The other player is not connected.  Ignoring this message type=%s" s = <selection_type>
		return
	endif
	switch <selection_type>
		case 0
		switch <selection_action>
			get_musician_profile_struct index = <checksum_value>
			case 0
			if (<selection_index1> = 0)
				cs_scroll_up_or_down \{player = 2
					dir = up}
			else
				cs_scroll_up_or_down \{player = 2
					dir = down}
			endif
			case 1
			net_cs_go_back \{player = 2}
			case 2
			if (<selection_index1> = ($character_select_highlighted_character_p2))
				character_select_choose \{player = 2}
			endif
		endswitch
		case 1
		switch <selection_action>
			case 1
			character_hub_go_back \{player = 2}
			case 2
			switch <selection_index1>
				case 1
				character_hub_select_change_outfit \{player = 2}
				case 2
				character_hub_select_change_guitar \{player = 2}
				case 3
				character_hub_select_change_guitar \{player = 2
					Bass}
			endswitch
		endswitch
		case 2
		switch <selection_action>
			case 0
			os_scroll_up_or_down \{player = 2}
			case 1
			select_outfit_go_back \{player = 2}
			case 2
			select_outfit_choose \{player = 2}
		endswitch
		case 3
		switch <selection_action>
			case 0
			select_outfit_style_highlight player = 2 index = <selection_index1>
			case 1
			destroy_select_style_menu \{player = 2}
			case 2
			select_outfit_style_choose \{player = 2}
		endswitch
		case 4
		switch <selection_action>
			case 0
			net_gs_scroll_up_or_down player = 2 dir_value = <selection_index1> instrument_type = <checksum_value>
			case 1
			spawnscriptnow \{select_guitar_go_back
				params = {
					player = 2
				}}
			case 2
			net_select_guitar player = 2 index = <selection_index1> instrument_type = <checksum_value>
		endswitch
		case 5
		switch <selection_action>
			case 0
			case 1
			net_select_guitar_go_back_from_finish_menu player = 2 instrument_type = <checksum_value>
			case 2
			net_select_guitar_finish_choose player = 2 index = <selection_index1> finish_index = <selection_index2> instrument_type = <checksum_value>
		endswitch
		case 6
		switch <selection_action>
			case 1
			online_song_deselect \{player = 2}
			case 2
			online_song_select song = <checksum_value> player = 2
		endswitch
		case 7
		switch <selection_action>
			case 1
			if (<checksum_value> = final)
				online_song_deselect \{player = 2}
				return
			endif
			character_hub_net_ready_back
			case 2
			if (<checksum_value> = final)
				online_song_select \{player = 2}
				return
			endif
			character_hub_net_ready
		endswitch
		case 8
		set_other_player_present
	endswitch
endscript

script net_lobby_state_message 
	switch <current_state>
		case none
		selection_type = 1
		case character_hub
		selection_type = 1
		case instrument
		selection_type = 2
		case difficulty
		selection_type = 3
		case song
		selection_type = 4
	endswitch
	switch <action>
		case request
		selection_action = 0
		case approval
		selection_action = 1
	endswitch
	if GotParam \{request_state}
		switch <request_state>
			case leaving_lobby
			value = 0
			case character_hub
			value = 1
			case instrument
			value = 2
			case difficulty
			value = 3
			case song
			value = 4
		endswitch
	else
		value = 1
	endif
	SendNetMessage {
		type = lobby_state
		selection_type = <selection_type>
		selection_action = <selection_action>
		selection_index = <value>
	}
endscript

script net_lobby_state_update 
	switch <selection_type>
		case 1
		change \{net_current_flow_state = character_hub}
		change \{net_can_send_approval = 1}
		case 2
		change \{structurename = player1_status
			part = guitar}
		change \{structurename = player2_status
			part = guitar}
		create_guitarist \{name = Guitarist
			useOldPos
			no_strum
			animpak = 0}
		create_guitarist \{name = bassist
			useOldPos
			no_strum
			animpak = 0}
		if IsHost
			ResetLobbyReady
		endif
		LaunchEvent \{type = focus
			target = si_vmenu_p1}
		change \{net_current_flow_state = instrument}
		change \{net_can_send_approval = 1}
		case 3
		if IsHost
			ResetLobbyReady
		endif
		LaunchEvent \{type = focus
			target = vmenu_select_difficulty}
		change \{net_current_flow_state = difficulty}
		change \{net_can_send_approval = 1}
		case 4
		if (IsHost)
			ResetLobbyReady
			if ($host_songs_to_pick = 0)
				LaunchEvent \{type = focus
					target = ready_container_p1}
			else
				LaunchEvent \{type = focus
					target = vmenu_setlist}
			endif
		else
			if ($client_songs_to_pick = 0)
				LaunchEvent \{type = focus
					target = ready_container_p1}
			else
				LaunchEvent \{type = focus
					target = vmenu_setlist}
			endif
		endif
		change \{net_current_flow_state = song}
		change \{net_can_send_approval = 1}
	endswitch
endscript

script net_pausegh3 
	ui_flow_manager_respond_to_action \{action = pause_game}
	Wait \{1
		gameframe}
endscript

script net_unpausegh3 
	ui_flow_manager_respond_to_action \{action = select_resume}
endscript

script gameinvite_server_unavailable 
	createjoinrefuseddialog \{reason = net_status_join_timeout}
endscript

script destroy_join_refuse_dialog 
	destroy_connection_dialog_scroller
	destroy_popup_warning_menu
endscript

script createjoinrefuseddialog 
	printf \{"--CreateJoinRefusedDialog"}
	destroy_net_popup
	destroy_pause_menu_frame
	destroy_menu \{menu_id = pu_warning_scroll}
	destroy_menu \{menu_id = popup_warning_container}
	switch (<reason>)
		case net_reason_banned
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_status_join_timeout
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_full_observers
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_wrong_password
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_default
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_rank_limit_low
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_rank_limit_high
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_default
		<connection_msg> = "SESSION IS NO LONGER AVAILABLE"
		case net_reason_full
		<connection_msg> = "THIS SERVER IS NOW FULL"
	endswitch
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [
			center
			center
		]
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = net_popup_container
		id = connection_dialog_scroller
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (640.0, 400.0)
		z_priority = 1.0}
	CreateScreenElement {
		type = VMenu
		parent = connection_dialog_scroller
		id = connection_dialog_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_choose destroy_popup_warning_menu}
			{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
			{pad_choose cancel_join_server}
			{pad_choose destroy_join_refuse_dialog}
		]
		exclusive_device = ($primary_controller)
	}
	add_searching_menu_item \{vmenu_id = connection_dialog_vmenu
		choose_script = empty_script
		z = 200.1
		text = "CONTINUE"}
	displaySprite id = connect_message_top parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 200.0) dims = (448.0, 64.0) just = [center top] z = 200
	displaySprite \{id = connect_message_top_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 200.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200}
	displaySprite id = connect_message_body parent = net_popup_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (640.0, 264.0) dims = (448.0, 128.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_body_fill
		parent = net_popup_container
		tex = window_fill_body_large
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 264.0)
		dims = (448.0, 128.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	displaySprite id = connect_message_bottom parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 392.0) dims = (448.0, 64.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_bottom_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 392.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	CreateScreenElement {
		type = TextBlockElement
		parent = net_popup_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = ($online_light_blue)
		text = <connection_msg>
		pos = (640.0, 300.0)
		dims = (375.0, 200.0)
		z_priority = 200.0
		just = [center center]
	}
	LaunchEvent \{type = focus
		target = connection_dialog_vmenu}
endscript

script create_connection_lost_dialog 
	printf \{"---create_connection_lost_dialog"}
	change \{player2_present = 0}
	KillSpawnedScript \{name = net_hub_stream}
	if ($ui_flow_manager_state [0] = online_loading_fs)
		RemoveTimeSyncTask
		change \{net_ready_to_start = 1}
	endif
	wait_for_safe_shutdown
	if (GotParam from_invite)
		FormatText \{TextName = gt_lost_connection_text
			"The invite server has been filled."
			DontAssertForChecksums}
	elseif (GotParam player_quit)
		if ($opponent_gamertag = null)
			FormatText \{TextName = gt_lost_connection_text
				"Your opponent has quit"
				DontAssertForChecksums}
		else
			FormatText TextName = gt_lost_connection_text "%n\\n has quit" n = ($opponent_gamertag) DontAssertForChecksums
		endif
	else
		if ($opponent_gamertag = null)
			FormatText \{TextName = gt_lost_connection_text
				"LOST CONNECTION TO YOUR OPPONENT"
				DontAssertForChecksums}
		else
			FormatText TextName = gt_lost_connection_text "LOST CONNECTION TO\\n%g" g = ($opponent_gamertag) DontAssertForChecksums
		endif
	endif
	create_net_popup popup_text = <gt_lost_connection_text>
	if ($playing_song = 1)
		if ($gHandlingWindowClosed = 0)
			Wait \{2
				seconds}
		endif
		if ($ui_flow_manager_state [0] = online_play_song_fs)
			connection_lost_end_song
		elseif ($ui_flow_manager_state [0] = online_pause_fs)
			ui_flow_manager_respond_to_action \{action = select_resume}
			connection_lost_end_song
		else
			destroy_net_popup
			leaving_lobby_select_yes
			return
		endif
		Wait \{2
			seconds}
	else
		if (($ui_flow_manager_state [0] = online_fail_song_fs) || ($ui_flow_manager_state [0] = online_win_song_fs))
			cleanup_newspaper_other_player_quit
			Wait \{4
				seconds}
		else
			Wait \{4
				seconds}
			lobby_connection_lost
		endif
	endif
	destroy_net_popup
endscript

script create_net_popup \{parent = root_window
		pos = (640.0, 325.0)}
	destroy_net_popup
	destroy_pause_menu_frame
	destroy_menu \{menu_id = pu_warning_scroll}
	destroy_menu \{menu_id = popup_warning_container}
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		id = net_popup_container
		just = [center center]
		pos = (0.0, 0.0)
	}
	displaySprite id = connect_message_top parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (<pos> - (0.0, 125.0)) dims = (448.0, 64.0) just = [center top] z = 200
	displaySprite id = connect_message_top_fill parent = net_popup_container tex = window_fill_cap rgba = ($online_trans_grey) pos = (<pos> - (0.0, 125.0)) dims = (448.0, 64.0) just = [center top] z = 200
	displaySprite id = connect_message_body parent = net_popup_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (<pos> - (0.0, 61.0)) dims = (448.0, 128.0) just = [center top] z = 200 flip_h
	displaySprite id = connect_message_body_fill parent = net_popup_container tex = window_fill_body_large rgba = ($online_trans_grey) pos = (<pos> - (0.0, 61.0)) dims = (448.0, 128.0) just = [center top] z = 200 flip_h
	displaySprite id = connect_message_bottom parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (<pos> + (0.0, 67.0)) dims = (448.0, 64.0) just = [center top] z = 200 flip_h
	displaySprite id = connect_message_bottom_fill parent = net_popup_container tex = window_fill_cap rgba = ($online_trans_grey) pos = (<pos> + (0.0, 67.0)) dims = (448.0, 64.0) just = [center top] z = 200 flip_h
	CreateScreenElement {
		type = TextBlockElement
		id = net_popup_text
		parent = net_popup_container
		font = fontgrid_title_gh3
		scale = 0.65000004
		rgba = ($online_light_blue)
		text = <popup_text>
		pos = <pos>
		dims = (375.0, 200.0)
		z_priority = 200.1
		just = [center center]
	}
	if GotParam \{add_waiting_dots}
		RunScriptOnScreenElement id = net_popup_text append_animating_dots params = {id = net_popup_text text = <popup_text>}
	endif
endscript

script append_animating_dots 
	printf \{"---append_animating_dots"}
	num_dots = 0
	if ScreenElementExists id = <id>
		begin
		FormatText TextName = new_text "%a\\n%b" a = <text> b = ($dots_array [<num_dots>])
		<id> :SetProps text = <new_text>
		if (<num_dots> = 3)
			<num_dots> = 0
		else
			<num_dots> = (<num_dots> + 1)
		endif
		Wait \{0.5
			second}
		repeat
	endif
endscript

script destroy_net_popup 
	if ScreenElementExists \{id = net_popup_container}
		DestroyScreenElement \{id = net_popup_container}
	endif
endscript

script showjointimeoutnotice 
	cancel_join_server
	setup_sessionfuncs
	spawnscriptnow \{timeout_connection_attempt}
endscript

script timeout_connection_attempt 
	create_timeout_dialog
	ui_flow_manager_respond_to_action \{action = timeout}
	net_repeat_last_search
endscript

script failedtocreategame 
	cancel_join_server
	setup_sessionfuncs
	create_failed_connection_dialog
endscript

script destroy_connection_dialog_scroller 
	if ScreenElementExists \{id = connection_dialog_scroller}
		DestroyScreenElement \{id = connection_dialog_scroller}
	endif
	destroy_net_popup
endscript

script create_timeout_dialog 
	destroy_pause_menu_frame
	destroy_menu \{menu_id = pu_warning_scroll}
	destroy_menu \{menu_id = popup_warning_container}
	CreateScreenElement \{type = VScrollingMenu
		parent = root_window
		id = connection_dialog_scroller
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (640.0, 400.0)
		z_priority = 1.0}
	CreateScreenElement {
		type = VMenu
		parent = connection_dialog_scroller
		id = connection_dialog_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
			{pad_choose destroy_connection_dialog_scroller}
		]
		exclusive_device = ($primary_controller)
	}
	add_searching_menu_item \{vmenu_id = connection_dialog_vmenu
		choose_script = empty_script
		z = 200.1
		text = "CONTINUE"}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [
			center
			center
		]
		pos = (0.0, 0.0)}
	displaySprite id = connect_message_top parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 200.0) dims = (448.0, 64.0) just = [center top] z = 200
	displaySprite \{id = connect_message_top_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 200.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200}
	displaySprite id = connect_message_body parent = net_popup_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (640.0, 264.0) dims = (448.0, 128.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_body_fill
		parent = net_popup_container
		tex = window_fill_body_large
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 264.0)
		dims = (448.0, 128.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	displaySprite id = connect_message_bottom parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 392.0) dims = (448.0, 64.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_bottom_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 392.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	CreateScreenElement {
		type = TextBlockElement
		parent = net_popup_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = ($online_light_blue)
		text = "CONNECTION TIMED OUT"
		pos = (640.0, 300.0)
		dims = (375.0, 200.0)
		z_priority = 200.0
		just = [center center]
	}
	LaunchEvent \{type = focus
		target = connection_dialog_vmenu}
endscript

script create_failed_connection_dialog 
	destroy_pause_menu_frame
	destroy_menu \{menu_id = pu_warning_scroll}
	destroy_menu \{menu_id = popup_warning_container}
	CreateScreenElement \{type = VScrollingMenu
		parent = root_window
		id = connection_dialog_scroller
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (640.0, 400.0)
		z_priority = 1.0}
	CreateScreenElement {
		type = VMenu
		parent = connection_dialog_scroller
		id = connection_dialog_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
			{pad_choose cancel_join_server}
			{pad_choose destroy_connection_dialog_scroller}
		]
		exclusive_device = ($primary_controller)
	}
	add_searching_menu_item \{vmenu_id = connection_dialog_vmenu
		choose_script = empty_script
		z = 200.1
		text = "CONTINUE"}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [
			center
			center
		]
		pos = (0.0, 0.0)}
	displaySprite id = connect_message_top parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 200.0) dims = (448.0, 64.0) just = [center top] z = 200
	displaySprite \{id = connect_message_top_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 200.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200}
	displaySprite id = connect_message_body parent = net_popup_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (640.0, 264.0) dims = (448.0, 128.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_body_fill
		parent = net_popup_container
		tex = window_fill_body_large
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 264.0)
		dims = (448.0, 128.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	displaySprite id = connect_message_bottom parent = net_popup_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (640.0, 392.0) dims = (448.0, 64.0) just = [center top] z = 200 flip_h
	displaySprite \{id = connect_message_bottom_fill
		parent = net_popup_container
		tex = window_fill_cap
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 392.0)
		dims = (448.0, 64.0)
		just = [
			center
			top
		]
		z = 200
		flip_h}
	CreateScreenElement {
		type = TextBlockElement
		parent = net_popup_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = ($online_light_blue)
		text = "FAILED TO CONNECT TO GAME"
		pos = (640.0, 315.0)
		dims = (375.0, 200.0)
		z_priority = 200.0
		just = [center center]
	}
	LaunchEvent \{type = focus
		target = connection_dialog_vmenu}
endscript

script net_repeat_last_search 
	Wait \{1
		gameframe}
	ui_flow_manager_respond_to_action \{action = select_done}
endscript

script check_if_selecting_tie_breaker \{player = 1}
	if IsHost
		if (($tie_breaker = HOST) && (<player> = 1))
			return \{selecting_tiebreaker = 1}
		endif
		if (($tie_breaker = CLIENT) && (<player> = 2))
			return \{selecting_tiebreaker = 1}
		endif
	else
		if (($tie_breaker = HOST) && (<player> = 2))
			return \{selecting_tiebreaker = 1}
		endif
		if (($tie_breaker = CLIENT) && (<player> = 1))
			return \{selecting_tiebreaker = 1}
		endif
	endif
	return \{selecting_tiebreaker = 0}
endscript

script get_num_players_by_gamemode 
	if (($game_mode = p1_career) || ($game_mode = p1_quickplay))
		return \{num_players = 1}
	else
		return \{num_players = 2}
	endif
endscript

script connection_lost_end_song 
	printf \{"connection_lost_end_song"}
	change \{current_num_players = 2}
	if ($playing_song = 0)
		return
	endif
	if ($game_mode = p2_battle)
		change \{structurename = player1_status
			current_health = 1.0}
		change \{structurename = player2_status
			current_health = 0.0}
		GuitarEvent_SongWon \{battle_win = 1}
	else
		ExtendCRC \{song_won
			'p1'
			out = type}
		BroadcastEvent type = <type>
	endif
endscript

script test_events \{passed_in_value = 'test value'}
	printf \{"test_events"}
	printstruct <...>
	NetSessionFunc \{obj = stats
		func = write_key_value
		params = {
			wtf_value = 'test value'
			key = 'test key'
		}}
endscript

script net_failed_signin 
	printf \{"--- net_failed_signin"}
	if ($respond_to_signin_changed = 0)
		return
	endif
	if (($ui_flow_manager_state [0]) = online_signin_fs)
		ui_flow_manager_respond_to_action \{action = go_back}
	endif
endscript

script xbox360_live_not_allowed 
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{id = warning_message_container}
		DestroyScreenElement \{id = warning_message_container}
	endif
	create_menu_backdrop \{texture = Online_Background}
	event_handlers = [
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
		{pad_back online_signin_select_cancel}
	]
	z = 100.0
	<menu_pos> = (640.0, 465.0)
	<bookend_r_pos> = (710.0, 533.0)
	<bookend_l_pos> = (500.0, 533.0)
	new_menu scrollid = sign_in_scoller vmenuid = sign_in_vmenu use_backdrop = (0) menu_pos = <menu_pos> just = [left top] event_handlers = <event_handlers> spacing = -45
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = signin_container
		pos = (0.0, 0.0)}
	change \{menu_focus_color = [
			180
			50
			50
			255
		]}
	change \{menu_unfocus_color = [
			0
			0
			0
			255
		]}
	create_pause_menu_frame \{parent = signin_container
		z = 5}
	displaySprite \{parent = signin_container
		tex = Dialog_Title_BG
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = signin_container
		tex = Dialog_Title_BG
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	displaySprite \{parent = signin_container
		id = options_bg_1
		tex = dialog_bg
		pos = (640.0, 500.0)
		dims = (320.0, 64.0)
		z = 9
		just = [
			center
			botom
		]}
	displaySprite \{parent = signin_container
		id = options_bg_2
		tex = dialog_bg
		pos = (640.0, 530.0)
		dims = (320.0, 64.0)
		z = 9
		just = [
			center
			top
		]
		flip_h}
	CreateScreenElement \{type = TextElement
		parent = signin_container
		font = fontgrid_title_gh3
		scale = 1.3
		rgba = [
			223
			223
			223
			250
		]
		text = "WARNING"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 175.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	if isXenon
		<sign_in_text> = "The current Gamer Profile is not enabled for Xbox LIVE multiplayer game play."
	else
		if GotParam \{age_restricted}
			<sign_in_text> = "Online service is disabled on your PLAYSTATION®Network account due to parental control restrictions."
		else
			<sign_in_text> = "You must be signed in to enter the lobby."
		endif
	endif
	scale = 1
	StringLength string = <sign_in_text>
	printf "len = %d" d = <str_len>
	if (<str_len> >= 135)
		<scale> = 0.8
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = signin_container
		font = fontgrid_title_gh3
		scale = 0.6
		rgba = [210 210 210 250]
		text = <sign_in_text>
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = 10.0
		pos = (640.0, 310.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	CreateScreenElement \{type = ContainerElement
		parent = sign_in_vmenu
		dims = (0.0, 100.0)
		event_handlers = [
			{
				focus
				net_warning_focus
			}
			{
				unfocus
				net_warning_unfocus
			}
			{
				pad_choose
				ui_flow_manager_respond_to_action
				params = {
					action = go_back
				}
			}
		]}
	container_id = <id>
	CreateScreenElement {
		type = TextElement
		parent = <container_id>
		local_id = text
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($menu_unfocus_color)
		text = "CONTINUE"
		just = [center top]
		z_priority = (<z> + 5)
	}
	fit_text_into_menu_item id = <id> max_width = 240
	GetScreenElementDims id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_left
		texture = Dialog_Highlight
		just = [right center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)))
		alpha = 0.0
		z_priority = (<z> + 6)
		scale = (1.0, 1.0)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_right
		texture = Dialog_Highlight
		just = [left center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)))
		alpha = 0.0
		z_priority = (<z> + 6)
		scale = (1.0, 1.0)
	}
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	LaunchEvent \{type = focus
		target = sign_in_vmenu}
endscript

script xenon_auto_load_progress 
	printf \{"--- xenon_auto_load_progress"}
	if (($ui_flow_manager_state [0]) = online_signin_fs)
		if ($online_signin_autoload_required = 1)
			change \{online_signin_autoload_required = 0}
			change \{respond_to_signin_changed = 0}
			fadetoblack \{on
				time = 0
				alpha = 1.0
				z_priority = 20000
				id = invite_screenfader}
			Wait \{1
				gameframe}
			stoprendering
			shutdown_game_for_signin_change \{signin_change = 1}
			LaunchEvent \{type = unfocus
				target = root_window}
			startrendering
			Wait \{1
				gameframe}
			fadetoblack \{off
				time = 0
				id = invite_screenfader}
			Wait \{1
				gameframe}
			change invite_controller = ($primary_controller)
			start_flow_manager \{flow_state = bootup_press_any_button_fs}
		else
			ui_flow_manager_respond_to_action \{action = online_enabled}
		endif
	endif
endscript

script scale_element_to_size \{time = 0}
	if NOT GotParam \{id}
		printf \{'Did not pass in id to scale_element_to_size! Returning'}
		return
	endif
	GetScreenElementDims id = <id>
	orig_height = <Height>
	orig_width = <width>
	if NOT GotParam \{target_width}
		target_width = <orig_width>
	endif
	if NOT GotParam \{target_height}
		target_height = <orig_height>
	endif
	xScale = (<target_width> / (<orig_width> * 1.0))
	yScale = (<target_height> / (<orig_height> * 1.0))
	<id> :DoMorph scale = (<xScale> * (1.0, 0.0) + <yScale> * (0.0, 1.0)) time = <time>
endscript

script translate_screen_element \{time = 0}
	if NOT GotParam \{id}
		printf \{'Did not pass in id to translate_screen_element! Returning'}
		return
	endif
	if NOT GotParam \{pos}
		GetScreenElementPosition id = <id>
		new_position = <screenelementpos>
	else
		new_position = <pos>
	endif
	<id> :DoMorph pos = <new_position> time = <time>
endscript

script get_my_highway_layout 
	player = 1
	begin
	FormatText checksumname = player_status 'player%p_status' p = <player>
	if ($<player_status>.is_local_client)
		return my_highway = ($<player_status>.highway_layout)
	endif
	<player> = (<player> + 1)
	repeat 2
endscript

script agora_update 
	if ($coop_dlc_active = 1)
		return
	endif
	get_game_mode_name
	get_current_band_info
	GetGlobalTags <band_info>
	band_id = <band_unique_id>
	FormatText TextName = band_name '%s' s = <name>
	if NOT GotParam \{new_band}
		get_difficulty_text_nl difficulty = ($current_difficulty)
		if (<game_mode_name> = p2_career)
			coop_difficulty = <difficulty_text_nl>
			get_diff_completion_percentage \{for_p2_career = 1}
		else
			career_difficulty = <difficulty_text_nl>
			get_diff_completion_percentage
		endif
		if ($game_mode = p2_career)
			coop_percent_complete_easy = (<diff_completion_percentage> [0])
			coop_score_overall_easy = (<diff_completion_score> [0])
			coop_percent_complete_medium = (<diff_completion_percentage> [1])
			coop_score_overall_medium = (<diff_completion_score> [1])
			coop_percent_complete_hard = (<diff_completion_percentage> [2])
			coop_score_overall_hard = (<diff_completion_score> [2])
			coop_percent_complete_expert = (<diff_completion_percentage> [3])
			coop_score_overall_expert = (<diff_completion_score> [3])
		else
			career_percent_complete_easy = (<diff_completion_percentage> [0])
			career_score_overall_easy = (<diff_completion_score> [0])
			career_percent_complete_medium = (<diff_completion_percentage> [1])
			career_score_overall_medium = (<diff_completion_score> [1])
			career_percent_complete_hard = (<diff_completion_percentage> [2])
			career_score_overall_hard = (<diff_completion_score> [2])
			career_percent_complete_expert = (<diff_completion_percentage> [3])
			career_score_overall_expert = (<diff_completion_score> [3])
		endif
	endif
	GetGlobalTags \{achievement_info}
	printstruct <...>
	CastToInteger \{total_points_in_career_mode_easy}
	campaign_score_easy = <total_points_in_career_mode_easy>
	CastToInteger \{total_points_in_career_mode_medium}
	campaign_score_medium = <total_points_in_career_mode_medium>
	CastToInteger \{total_points_in_career_mode_hard}
	campaign_score_hard = <total_points_in_career_mode_hard>
	CastToInteger \{total_points_in_career_mode_expert}
	campaign_score_expert = <total_points_in_career_mode_expert>
	campaign_score_overall = (<total_points_in_career_mode_expert> + <total_points_in_career_mode_hard> + <total_points_in_career_mode_medium> + <total_points_in_career_mode_easy>)
	achievements = 'what achievements?'
	purchases = 'test purchases'
	WriteUpdate <...>
endscript

script agora_write_stats 
	printf \{"agora_write_stats %s"
		s = $game_mode}
	if ($coop_dlc_active = 1)
		quickplay = 1
	endif
	if ($game_mode = p1_quickplay)
		quickplay = 1
	endif
	if ($boss_battle = 1)
		return
	endif
	player_id = ($player1_status.controller)
	get_num_players_by_gamemode
	GetGlobalTags \{user_options
		param = lefty_flip_p1}
	get_current_band_info
	GetGlobalTags <band_info>
	band_id = <band_unique_id>
	if ($is_network_game)
		if (NetSessionFunc obj = match func = get_gamertag)
			FormatText TextName = gamertag1 '%s' s = <name>
		endif
		FormatText TextName = gamertag2 '%s' s = ($opponent_gamertag)
		p1_name = <gamertag1>
		p2_name = <gamertag2>
		retrieve_player_net_id \{player = 2}
		player_id2 = <net_id>
	else
		player_id2 = ($player2_status.controller)
		if ($coop_dlc_active = 0)
			if (($game_mode = p1_career) || ($game_mode = p2_career))
				menu_ebn_get_band_name_text
				StringRemoveTrailingWhitespace string = <band_name_text_string>
				FormatText TextName = band_text '%s' s = <band_name_text_string>
				<p1_name> = <band_text>
				<p2_name> = <band_text>
			else
			endif
		endif
	endif
	venue = (($LevelZones.$current_level).name)
	get_game_mode_name
	switch <game_mode_name>
		case 'p2_battle'
		mode = 'battle'
		case 'p2_faceoff'
		mode = 'face_off'
		case 'p2_pro_faceoff'
		mode = 'pro_face_off'
		case 'p2_career'
		if ($coop_dlc_active = 1)
			mode = 'quickplay_coop'
		else
			mode = 'local_coop'
		endif
		case 'p2_coop'
		mode = 'online_coop'
	endswitch
	get_song_prefix song = ($current_song)
	title = <song_prefix>
	if ($player1_status.part = guitar)
		part = 'guitar'
	elseif ($player1_status.part = Bass)
		part = 'bass'
	else
		part = 'rhythm'
	endif
	get_difficulty_text_nl difficulty = ($current_difficulty)
	difficulty = <difficulty_text_nl>
	score = ($player1_status.score)
	CastToInteger \{score}
	stars = ($player1_status.stars)
	notes_hit = ($player1_status.notes_hit)
	notes_missed = (($player1_status.total_notes) - ($player1_status.notes_hit))
	best_streak = ($player1_status.best_run)
	star_power_achieved = ($player1_status.sp_phrases_hit)
	star_power_available = ($player1_status.sp_phrases_total)
	if (<lefty_flip_p1>)
		lefty = true
	else
		lefty = false
	endif
	get_character_name \{player = 1}
	p1_character_name = <character_name>
	get_character_outfit_name \{player = 1}
	outfit = <outfit_name>
	character_color = ($player1_status.style)
	get_player_instrument_desc_name \{player = 1}
	guitar = <instrument_name>
	skin = <instrument_name>
	if (<num_players> = 2)
		if ($player1_status.score > $player2_status.score)
			winner = 'participant_1'
		else
			winner = 'participant_2'
		endif
		if ($player2_status.part = guitar)
			part2 = 'guitar'
		elseif ($player2_status.part = Bass)
			part2 = 'bass'
		else
			part2 = 'rhythm'
		endif
		get_difficulty_text_nl difficulty = ($current_difficulty2)
		difficulty2 = <difficulty_text_nl>
		score2 = ($player2_status.score)
		CastToInteger \{score2}
		stars2 = ($player2_status.stars)
		notes_hit2 = ($player2_status.notes_hit)
		notes_missed2 = (($player2_status.total_notes) - ($player2_status.notes_hit))
		best_streak2 = ($player2_status.best_run)
		star_power_received2 = ($player2_status.sp_phrases_hit)
		if ($player2_status.lefthanded_button_ups = 1)
			lefty2 = true
		else
			lefty2 = false
		endif
		get_character_name \{player = 2}
		character_name2 = <character_name>
		get_character_outfit_name \{player = 2}
		outfit2 = <outfit_name>
		character_color2 = ($player2_status.style)
		get_player_instrument_desc_name \{player = 2}
		guitar2 = <instrument_name>
		skin2 = <instrument_name>
		character_name = <p1_character_name>
		WriteMultiPerformance <...>
	else
		winner = <p1_name>
		WritePerformance <...>
	endif
endscript

script WritePerformance \{band_id = default_band_id
		venue = 'test venue'
		mode = 'test mode'
		submode = 'test submode'
		cheats = 'all cheats'
		title = 'killing me softly'
		difficulty = 'test'
		Speed = 'test'
		star_power_available = 0
		player_id = 0
		part = 'guitar'
		score = 1
		stars = 0
		notes_hit = 2
		notes_missed = 0
		best_streak = 5
		star_power_achieved = 1
		lefty = true
		character_name = 'test'
		character_color = 1
		guitar = 'test'
		skin = 'test'
		outfit = 'test'}
	if ($Cheat_AirGuitar = 1)
		air_guitar_active = air_guitar_active
	endif
	if ($Cheat_PerformanceMode = 1)
		performance_mode = performance_mode
	endif
	if ($Cheat_Hyperspeed > 0)
		hyper_speed = hyper_speed
	endif
	if ($Cheat_NoFail = 1)
		no_fail = no_fail
	endif
	if ($Cheat_EasyExpert = 1)
		easy_expert = easy_expert
	endif
	if ($Cheat_PrecisionMode = 1)
		precision_mode = precision_mode
	endif
	if ($Cheat_BretMichaels = 1)
		bret_michaels = bret_michaels
	endif
	printf \{"WritePerformance"}
	NetSessionFunc obj = stats func = write_performance params = {<...>}
endscript

script WriteMultiPerformance \{winner = 'participant_1'
		venue = 'test venue'
		mode = 'test mode'
		cheats = 'all cheats'
		title = 'killing me softly'
		difficulty = 'test'
		Speed = 'test'
		star_power_available = 0
		player_id = 0
		part = 'guitar'
		score = 1
		stars = 0
		notes_hit = 2
		notes_missed = 0
		best_streak = 5
		star_power_achieved = 0
		lefty = true
		character_name = 'test'
		character_color = 1
		guitar = 'test'
		skin = 'test'
		outfit = 'test'
		player_id2 = 1
		part2 = 'bass'
		score2 = 1
		stars2 = 0
		notes_hit2 = 2
		notes_missed2 = 0
		best_streak2 = 5
		star_power_achieved2 = 1
		lefty2 = true
		character_name2 = 'test'
		character_color2 = 'test'
		guitar2 = 'test'
		skin2 = 'test'
		outfit2 = 'test'}
	NetSessionFunc obj = stats func = write_multi_match params = {<...>}
endscript

script WriteUpdate \{band_id = 0
		band_name = 'test name'
		Cash = 100
		campaign_score_easy = 0
		campaign_score_medium = 0
		campaign_score_hard = 0
		campaign_score_expert = 0
		campaign_score_overall = 0
		achievements = 'temp achievement string'}
	NetSessionFunc obj = stats func = write_update params = {<...>}
endscript

script invite_accepted 
	if ($primary_controller_assigned = 0)
		change invite_controller = <controllerid>
		return
	elseif ($primary_controller != <controllerid>)
		change invite_controller = <controllerid>
	endif
	if ((($is_network_game = 0) && ($playing_song)) &&
			(($game_mode = p2_battle) || ($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff) || ($game_mode = p2_career)))
		if (GameIsPaused)
			destroy_pause_menu
		endif
		create_popup_warning_menu {
			textblock = {
				text = "Are you sure you want to leave this game session?"
				pos = (640.0, 380.0)
			}
			player_device = <controllerid>
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = accepted_invite_agree
					text = "YES"
				}
				{
					func = accepted_invite_disagree
					text = "NO"
				}
			]
			no_background
		}
	else
		do_join_invite_stuff <...> accepted_invite
	endif
endscript

script accepted_invite_agree 
	if (GameIsPaused)
		unpausegh3
	endif
	do_join_invite_stuff <...> accepted_invite
endscript

script accepted_invite_disagree 
	destroy_popup_warning_menu
	if (GameIsPaused)
		create_pause_menu
	else
		pausegh3
	endif
endscript

script send_fail_song_message \{wait_frames = 30
		quit_early = 0}
	if (IsHost)
		loser = 0
	else
		loser = 1
	endif
	SendNetMessage {
		type = fail_song
		stars = ($player1_status.stars)
		note_streak = ($player1_status.best_run)
		notes_hit = ($player1_status.notes_hit)
		total_notes = ($player1_status.total_notes)
		quit_early_flag = <quit_early>
		loser = <loser>
	}
	Wait <wait_frames> gameframes
endscript

script do_join_invite_stuff 
	printf \{"--- do_join_invite_stuff"}
	if GotParam \{accepted_invite}
		printf \{"accepted invite"}
		change \{online_signin_autoload_required = 0}
		wait_for_safe_shutdown
		printf \{"do_join_invite_stuff started"}
		disable_pause
		if ($primary_controller_assigned = 1 && $primary_controller != $invite_controller && $invite_controller != -1)
			fadetoblack \{on
				time = 0
				alpha = 1.0
				z_priority = 20000
				id = invite_screenfader}
			Wait \{1
				gameframe}
			stoprendering
			shutdown_game_for_signin_change \{signin_change = 1}
			LaunchEvent \{type = unfocus
				target = root_window}
			startrendering
			Wait \{1
				gameframe}
			fadetoblack \{off
				time = 0
				id = invite_screenfader}
			Wait \{1
				gameframe}
			start_flow_manager \{flow_state = bootup_press_any_button_fs}
		else
			stoprendering
			shutdown_game_for_signin_change \{unloadcontent = 0}
			change \{invite_controller = -1}
			LaunchEvent \{type = unfocus
				target = root_window}
			online_menu_init
			start_flow_manager \{flow_state = invite_joining_game_fs}
			startrendering
			if NOT ($primary_controller = $player1_status.controller)
				change structurename = player1_status controller = ($primary_controller)
				GetGlobalTags \{user_options}
				change structurename = player1_status lefthanded_gems = <lefty_flip_p2>
				change structurename = player1_status lefthanded_button_ups = <lefty_flip_p2>
			endif
			JoinInviteServer
		endif
	else
		printf \{"didn't get an invite"}
		if (($ui_flow_manager_state [0]) = online_signin_fs)
			ui_flow_manager_respond_to_action \{action = online_enabled}
		endif
	endif
endscript

script ui_print_gamertags \{pos1 = (235.0, 100.0)
		pos2 = (1045.0, 100.0)
		just1 = [
			left
			top
		]
		just2 = [
			right
			top
		]
		offscreen = 0}
	if (NetSessionFunc obj = match func = get_gamertag)
		ui_print_gamertag name = <name> start_pos = <pos1> color = ($player1_color) player = 1 just = <just1> dims = <dims> offscreen = <offscreen>
	endif
	ui_print_gamertag name = ($opponent_gamertag) start_pos = <pos2> color = ($player2_color) player = 2 just = <just2> dims = <dims> offscreen = <offscreen>
endscript

script ui_print_gamertag start_pos = (235.0, 100.0) color = ($player1_color) player = 1 dims = (450.0, 35.0) z = 60 offscreen = 0
	if NOT GotParam \{name}
		get_character_name player = <player>
		name = <display_name>
	endif
	if NOT ScreenElementExists \{id = gamertag_container}
		if (<offscreen> = 1)
			CreateScreenElement {
				type = ContainerElement
				id = gamertag_container
				parent = root_window
				pos = (0.0, -400.0)
				just = [center center]
				z_priority = <z>
			}
		else
			CreateScreenElement {
				type = ContainerElement
				id = gamertag_container
				parent = root_window
				pos = (0.0, 0.0)
				just = [center center]
				z_priority = <z>
			}
		endif
	endif
	FormatText checksumname = gamertag_text_px 'gamertag_text_p%d' d = <player>
	FormatText checksumname = debug_gamertag_container_px 'debug_gamertag_container_p%d' d = <player>
	FormatText checksumname = gt_frame_top 'gt_frame_top_p%d' d = <player>
	FormatText checksumname = gt_frame_top_fill 'gt_frame_top_fill_p%d' d = <player>
	FormatText checksumname = gt_frame_bottom 'gt_frame_bottom_p%d' d = <player>
	FormatText checksumname = gt_frame_bottom_fill 'gt_frame_bottom_fill_p%d' d = <player>
	if (ScreenElementExists id = <gamertag_text_px>)
		if ScreenElementExists \{id = gamertag_icon_container}
			SetScreenElementProps \{id = gamertag_icon_container
				alpha = 1}
		endif
		return
	endif
	CreateScreenElement {
		type = TextElement
		parent = gamertag_container
		font = fontgrid_title_gh3
		rgba = <color>
		text = <name>
		id = <gamertag_text_px>
		pos = (<start_pos> + (0.0, 3.0))
		just = <just>
		scale = 0.75
		z_priority = (<z> + 1)
	}
	GetScreenElementDims id = <gamertag_text_px>
	x_dim = ((<dims>.(1.0, 0.0)) * 0.5625)
	y_dim = (<dims>.(0.0, 1.0) * 0.75)
	x_scale = 1.0
	y_scale = 1.0
	if (<width> > <x_dim>)
		<x_scale> = (<x_dim> / <width>)
	endif
	if (<Height> > <y_dim>)
		<y_scale> = (<y_dim> / <Height>)
	endif
	scale_pair = ((1.0, 0.0) * <x_scale> + (0.0, 1.0) * <y_scale>)
	SetScreenElementProps {id = <gamertag_text_px> scale = <scale_pair>}
	displaySprite {
		id = <gt_frame_top>
		parent = gamertag_container
		tex = window_frame_cap
		rgba = ($online_medium_blue)
		pos = <start_pos>
		just = <just>
		z = <z>
	}
	displaySprite {
		id = <gt_frame_top_fill>
		parent = gamertag_container
		tex = window_fill_cap
		rgba = ($online_trans_grey)
		pos = <start_pos>
		just = <just>
		z = <z>
	}
	GetScreenElementDims id = <gamertag_text_px>
	text_w = (<width> + 80)
	text_h = (<dims>.(0.0, 1.0) + 10)
	GetScreenElementDims id = <gt_frame_top>
	frame_w = (<width> / 1.0)
	frame_h = (<Height> / 1.0)
	frame_scale_x = (<text_w> / <frame_w>)
	frame_scale_y = (<text_h> / <frame_h>)
	frame_scale = ((<frame_scale_x> * (1.0, 0.0)) + (<frame_scale_y> * (0.0, 0.5625)))
	SetScreenElementProps {id = <gt_frame_top> scale = <frame_scale>}
	SetScreenElementProps {id = <gt_frame_top_fill> scale = <frame_scale>}
	x_adjust = (0.0, 0.0)
	y_adjust = (0.0, 0.0)
	y_adjust = ((0.0, 1.0) * ((-5 * <y_scale>) -5))
	if ((<just> [0]) = right)
		x_adjust = ((1.0, 0.0) * 40)
	elseif ((<just> [0]) = left)
		x_adjust = ((1.0, 0.0) * -40)
	endif
	new_pos = (<start_pos> + (<x_adjust> + <y_adjust>))
	SetScreenElementProps {id = <gt_frame_top> pos = <new_pos>}
	SetScreenElementProps {id = <gt_frame_top_fill> pos = <new_pos>}
	GetScreenElementProps id = <gt_frame_top>
	GetScreenElementDims id = <gt_frame_top>
	displaySprite {
		id = <gt_frame_bottom>
		parent = gamertag_container
		tex = window_frame_cap
		rgba = ($online_medium_blue)
		pos = (<pos> + (<Height> * (0.0, 1.0)))
		just = <just>
		scale = <scale>
		z = (<z> + 5)
		flip_h
	}
	displaySprite {
		id = <gt_frame_bottom_fill>
		parent = gamertag_container
		tex = window_fill_cap
		rgba = ($online_trans_grey)
		pos = (<pos> + (<Height> * (0.0, 1.0)))
		just = <just>
		scale = <scale>
		z = <z>
		flip_h
	}
	GetPlatform
endscript

script destroy_gamertags 
	if ScreenElementExists \{id = gamertag_container}
		DestroyScreenElement \{id = gamertag_container}
	endif
	if ScreenElementExists \{id = gamertag_container_p1}
		DestroyScreenElement \{id = gamertag_container_p1}
	endif
	if ScreenElementExists \{id = gamertag_container_p2}
		DestroyScreenElement \{id = gamertag_container_p2}
	endif
	if ScreenElementExists \{id = debug_gamertag_container_p1}
		DestroyScreenElement \{id = debug_gamertag_container_p1}
	endif
	if ScreenElementExists \{id = debug_gamertag_container_p2}
		DestroyScreenElement \{id = debug_gamertag_container_p2}
	endif
endscript

script destroy_gamertag_container \{player = 1}
	FormatText checksumname = gamertag_container 'gamertag_container_p%d' d = <player>
	if ScreenElementExists id = <gamertag_container>
		DestroyScreenElement id = <gamertag_container>
	endif
endscript

script morph_gamertags 
	if ScreenElementExists \{id = gamertag_container}
		move_gamertag_pos = ((1.0 - <delta>) * (($g_hud_2d_struct_used).offscreen_gamertag_pos) + (<delta> * ((($g_hud_2d_struct_used).final_gamertag_pos) + <off_set>)))
		doScreenElementMorph id = gamertag_container pos = <move_gamertag_pos> time = <time_to_move>
		if ScreenElementExists \{id = gamertag_icon_container}
			SetScreenElementProps \{id = gamertag_icon_container
				alpha = 0}
		endif
	endif
endscript
net_star_power_pending = 0

script coop_attempt_star_power 
	if ($net_star_power_pending)
		return
	endif
	change \{net_star_power_pending = 1}
	SendNetMessage \{type = coop_star_power_notify}
	Wait \{30
		frames}
	change \{net_star_power_pending = 0}
endscript

script test_write_leaderboards 
	printf \{"test_write_leaderboards"}
	begin_singleplayer_game
	Wait \{0.3
		seconds
		ignoreslomo}
	if NOT should_update_stats_leader_board
		return
	endif
	NetSessionFunc obj = stats func = write_stats params = {leaderboard_id = anarchy_in_the_uk score = 10000 rating = <rating_val>}
endscript

script test_read_leaderboards 
	NetSessionFunc \{obj = stats
		func = get_stats
		params = {
			leaderboard_id = m_test_gh3
			callback = test_callback
			num_rows = 10
			listtype = rating
			rating_val = 5
			columns = 0
		}}
endscript

script menu_show_gamercard 
	if NOT (($is_network_game) && (isXenon))
		return
	endif
	retrieve_player_net_id \{player = 2}
	NetSessionFunc func = showGamerCard params = {player_xuid = <net_id>}
endscript

script menu_show_gamercard_from_netid 
	if NOT ($is_network_game = 1)
		return
	endif
	if GotParam \{net_id}
		NetSessionFunc func = showGamerCard params = {player_xuid = <net_id>}
	endif
endscript

script new_net_logic_init 
	change boss_controller = ($player2_status.controller)
	change \{boss_pattern = 0}
	change \{boss_strum = 0}
	change \{boss_lastwhammytime = 0}
	change \{boss_lastbrokenstringtime = 0}
	change \{boss_hammer_count = 0}
endscript

script new_net_logic_deinit 
	if ($is_network_game)
		change structurename = player2_status controller = ($boss_oldcontroller)
		change \{boss_pattern = 0}
		change \{boss_strum = 0}
		change \{boss_lastwhammytime = 0}
		change \{boss_lastbrokenstringtime = 0}
		change \{boss_hammer_count = 0}
	endif
endscript

script win_now 
	ExtendCRC \{song_won
		'p1'
		out = type}
	BroadcastEvent type = <type>
endscript
new_message_of_the_day = 0

script splash_callback 
	printf \{"splash_callback"}
	printstruct <...>
	if GotParam \{motd_text}
		change \{new_message_of_the_day = 1}
	else
		change \{new_message_of_the_day = 0}
	endif
endscript

script test_send 
	test1 = 'does this get sent?'
	test2 = DoesThisGetSent
	test3 = DoesThisGetSent2
	printstruct <...>
	SendStructure callback = test_callback data_to_send = <...>
endscript

script test_callback 
	printf \{"test_callback"}
	printstruct <...>
endscript

script cleanup_online_lobby_select 
	shut_down_character_hub
	destroy_pause_menu_frame \{container_id = net_quit_warning}
	if ScreenElementExists \{id = ready_container_p1}
		DestroyScreenElement \{id = ready_container_p1}
	endif
	if ScreenElementExists \{id = ready_container_p2}
		DestroyScreenElement \{id = ready_container_p2}
	endif
	destroy_pause_menu_frame
	if ScreenElementExists \{id = warning_message_container}
		DestroyScreenElement \{id = warning_message_container}
	endif
	if ScreenElementExists \{id = leaving_lobby_dialog_menu}
		DestroyScreenElement \{id = leaving_lobby_dialog_menu}
	endif
	destroy_gamertags
	shut_down_flow_manager \{player = 2}
	clean_up_user_control_helpers
	destroy_menu \{menu_id = scrolling_character_hub_p1}
	destroy_menu \{menu_id = character_hub_p1_container}
	destroy_menu \{menu_id = scrolling_character_hub_p2}
	destroy_menu \{menu_id = character_hub_p2_container}
	KillCamAnim \{name = gs_view_cam}
	<player> = 1
	begin
	FormatText checksumname = scrolling_select_outfit 'scrolling_select_outfit_p%i' i = <player>
	FormatText checksumname = s_container 's_container_p%i' i = <player>
	destroy_menu menu_id = <scrolling_select_outfit>
	destroy_menu menu_id = <s_container>
	<player> = (<player> + 1)
	repeat 2
	<player> = 1
	begin
	FormatText checksumname = scrolling_select_style 'scrolling_select_style_p%i' i = <player>
	FormatText checksumname = s_container 's_container_p%i' i = <player>
	destroy_menu menu_id = <scrolling_select_style>
	destroy_menu menu_id = <s_container>
	<player> = (<player> + 1)
	repeat 2
	destroy_menu \{menu_id = scrolling_select_guitar_p1}
	destroy_menu \{menu_id = scrolling_guitar_finish_menu_p1}
	destroy_menu \{menu_id = gs_instrument_info_scroll_window}
	destroy_menu \{menu_id = select_guitar_container}
	destroy_menu \{menu_id = select_finish_container}
	destroy_menu \{menu_id = scrolling_select_guitar_p2}
	destroy_menu \{menu_id = scrolling_guitar_finish_menu_p2}
	destroy_menu \{menu_id = select_guitar_container_p2}
	destroy_menu \{menu_id = select_finish_container_p2}
	<player> = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player>
	<band_member> = ($<player_status>.band_member)
	if CompositeObjectExists name = <band_member>
		if <band_member> :Anim_AnimNodeExists id = BodyTimer
			<band_member> :Anim_Command target = BodyTimer command = Timer_SetSpeed params = {Speed = 1.0}
		endif
	endif
	<player> = (<player> + 1)
	repeat 2
	<player> = 1
	begin
	FormatText checksumname = scrolling_select_finish 'scrolling_select_finish_p%i' i = <player>
	destroy_menu menu_id = <scrolling_select_finish>
	<player> = (<player> + 1)
	repeat 2
	ui_flow_manager_respond_to_action \{action = continue}
endscript
gSavedElementInFocus = 0

script create_link_unplugged_dialog 
	PauseGame
	SaveAndClearFocus
	if (GotParam reason)
		if ($winport_is_in_online_menu_system = 1)
			text = "Your username has been used to login elsewhere. Your network connection is being disconnected. Returning to the main menu."
		else
			text = "Your username has been used to login elsewhere. Your network connection is being disconnected."
		endif
	else
		if ($winport_is_in_online_menu_system = 1)
			text = "Your network connection has been disconnected. Returning to the main menu."
		else
			text = "Your network connection has been disconnected."
		endif
	endif
	z = 999
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = connectionLostContainer
		pos = (0.0, 0.0)
		z_priority = <z>
	}
	CreateScreenElement {
		type = VScrollingMenu
		parent = connectionLostContainer
		just = [center top]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = <z>
	}
	menu_id = <id>
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		id = connectionLostMenu
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		z_priority = <z>
		event_handlers = [
			{pad_choose connection_lost_resume_play}
		]
	}
	create_pause_menu_frame parent = connectionLostContainer container_id = connectionLostFrame z = (<z> -10)
	displaySprite parent = connectionLostContainer tex = Dialog_Title_BG dims = (224.0, 224.0) pos = (640.0, 100.0) just = [right top] flip_v z = (<z> -5)
	displaySprite parent = connectionLostContainer tex = Dialog_Title_BG dims = (224.0, 224.0) pos = (640.0, 100.0) just = [left top] z = (<z> -5)
	CreateScreenElement {
		type = TextElement
		parent = connectionLostContainer
		font = fontgrid_title_gh3
		scale = 0.8
		rgba = [223 223 223 250]
		text = "DISCONNECTED"
		just = [center top]
		z_priority = <z>
		pos = (640.0, 188.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = connectionLostContainer
		id = statusMessage
		text = <text>
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = 1.0
		z_priority = <z>
		pos = (640.0, 300.0)
		dims = (800.0, 420.0)
		line_spacing = 1.0
	}
	fit_text_into_menu_item id = <id> max_width = 420
	displaySprite parent = connectionLostContainer id = options_bg_1 tex = dialog_bg pos = (640.0, 500.0) dims = (320.0, 64.0) z = (<z> + 0.1) just = [center botom]
	displaySprite parent = connectionLostContainer id = options_bg_2 tex = dialog_bg pos = (640.0, 530.0) dims = (320.0, 64.0) z = (<z> + 0.1) just = [center top] flip_h
	CreateScreenElement \{type = ContainerElement
		parent = connectionLostMenu
		dims = (100.0, 50.0)
		event_handlers = [
			{
				focus
				net_warning_focus
			}
			{
				unfocus
				net_warning_unfocus
			}
			{
				pad_choose
				connection_lost_resume_play
			}
		]}
	container_id = <id>
	CreateScreenElement {
		type = TextElement
		parent = <container_id>
		local_id = text_continue
		font = fontgrid_title_gh3
		scale = 0.8
		rgba = [180 50 50 255]
		text = "CONTINUE"
		just = [center top]
		z_priority = (<z> + 0.9)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	fit_text_into_menu_item id = <id> max_width = 200
	GetScreenElementDims id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_left
		texture = Dialog_Highlight
		just = [right center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
		z_priority = (<z> + 20.0)
		scale = (1.0, 1.0)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_right
		texture = Dialog_Highlight
		just = [left center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
		z_priority = (<z> + 20.0)
		scale = (1.0, 1.0)
	}
	LaunchEvent \{type = focus
		target = connectionLostMenu}
endscript

script connection_lost_resume_play 
	printf \{"---connection_lost_resume_play"}
	DestroyScreenElement \{id = connectionLostContainer}
	RestoreFocus
	UnPauseGame
	change \{g_connection_loss_dialogue = 0}
	if ($winport_is_in_online_menu_system = 1)
		shut_down_flow_manager
		start_flow_manager \{flow_state = main_menu_fs}
	endif
endscript

script removeobserverbg 
endscript

script coop_fail_song 
	if ($ui_flow_manager_state [0] = online_pause_fs)
		net_unpausegh3
	endif
	disable_pause
	if (<quit_early>)
		change \{player2_present = 0}
		FormatText TextName = notification_text "%n\\n has quit" n = ($opponent_gamertag)
		create_net_popup popup_text = <notification_text>
		Wait \{3
			seconds}
		destroy_net_popup
	endif
	change structurename = <player_status> stars = <stars>
	change structurename = <player_status> best_run = <note_streak>
	change structurename = <player_status> total_notes = <total_notes>
	change structurename = <player_status> notes_hit = <notes_hit>
	player_text = (<player_status>.text)
	KillSpawnedScript \{name = GuitarEvent_SongWon_Spawned}
	spawnscriptnow \{GuitarEvent_SongFailed_Spawned}
endscript

script add_searching_menu_item \{z = 2.1}
	if GotParam \{vmenu_id}
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (210.0, 35.0)
			pos = (0.0, 0.0)
			just = [center top]
			internal_just = [center top]
		}
		<container_element> = <id>
		<id> :SetProps {
			event_handlers = [
				{focus searching_menu_focus params = {parent = <id>}}
				{unfocus searching_menu_unfocus params = {parent = <id>}}
				{pad_choose <choose_script>}
			]
		}
		CreateScreenElement {
			type = TextElement
			parent = <container_element>
			local_id = text_string
			font = fontgrid_title_gh3
			scale = 0.65000004
			rgba = ($online_light_blue)
			text = <text>
			just = [center top]
			pos = (105.0, 0.0)
			z_priority = <z>
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_element>
			local_id = highlight_bar
			texture = white
			dims = (250.0, 35.0)
			rgba = ($online_light_blue)
			pos = (105.0, -3.0)
			just = [center top]
			z_priority = <z>
			alpha = 0.0
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_element>
			local_id = left_bookend
			texture = character_hub_hilite_bookend
			dims = (35.0, 35.0)
			rgba = ($online_light_blue)
			pos = (-20.0, -3.0)
			just = [center top]
			z_priority = <z>
			alpha = 0.0
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_element>
			local_id = right_bookend
			texture = character_hub_hilite_bookend
			dims = (35.0, 35.0)
			rgba = ($online_light_blue)
			pos = (240.0, -3.0)
			just = [center top]
			z_priority = <z>
			alpha = 0.0
		}
	endif
endscript

script start_final_song 
	change current_song = ($net_setlist_songs [($net_song_num)])
	SpawnScriptLater \{load_and_sync_timing
		params = {
			start_delay = 3000
			player_status = player1_status
		}}
endscript

script server_disconnection_cleanup 
	printf \{"---server_disconnection_cleanup"}
	determine_if_game_over
	change \{player2_present = 0}
	if ($ui_flow_manager_state [0] = online_loading_fs)
	elseif ($playing_song = 0)
		if (($ui_flow_manager_state [0] = online_win_song_fs) || ($ui_flow_manager_state [0] = online_fail_song_fs) || ($ui_flow_manager_state [0] = online_match_stats_fs))
			if NOT ScreenElementExists \{net_popup_container}
				get_number_of_songs
				if NOT (<game_over>)
					create_connection_lost_dialog \{player_quit}
				endif
			endif
		else
			create_connection_lost_dialog \{player_quit}
		endif
	endif
endscript

script searching_menu_focus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = text_string}
		doScreenElementMorph id = {<ObjID> child = text_string} rgba = ($online_dark_purple)
	endif
	if ScreenElementExists id = {<ObjID> child = highlight_bar}
		doScreenElementMorph id = {<ObjID> child = highlight_bar} alpha = 1.0
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		doScreenElementMorph id = {<ObjID> child = left_bookend} alpha = 1.0
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		doScreenElementMorph id = {<ObjID> child = right_bookend} alpha = 1.0
	endif
endscript

script searching_menu_unfocus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = text_string}
		doScreenElementMorph id = {<ObjID> child = text_string} rgba = ($online_light_blue)
	endif
	if ScreenElementExists id = {<ObjID> child = highlight_bar}
		doScreenElementMorph id = {<ObjID> child = highlight_bar} alpha = 0.0
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		doScreenElementMorph id = {<ObjID> child = left_bookend} alpha = 0.0
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		doScreenElementMorph id = {<ObjID> child = right_bookend} alpha = 0.0
	endif
endscript

script set_other_player_present 
	printf \{"set_other_player_present"}
	if NOT ($player2_present)
		change \{player2_present = 1}
		spawnscriptnow \{net_hub_stream}
	endif
	if ScreenElementExists \{id = character_hub_p1_continue}
		character_hub_p1_continue :SetProps \{rgba = [
				180
				100
				60
				255
			]
			unblock_events}
	endif
	ui_print_gamertag name = ($opponent_gamertag) start_pos = (1045.0, 50.0) color = ($player2_color) player = 2 just = [right top] dims = (450.0, 35.0)
endscript

script test_multi_leaderboards 
	player_list = [
		{
			leaderboards = [
				{
					write_type = max
					leaderboard_id = anarchyintheuk
					rating = 4
					score = 100
					columns = [
						{
							score = 100
						}
						{
							score = 200
						}
						{
							score = 300
						}
					]
				}
				{
					write_type = max
					leaderboard_id = avalancha
					rating = 3
					score = 100
					columns = [
						{
							score = 100
						}
						{
							score = 200
						}
						{
							score = 300
						}
					]
				}
			]
		}
	]
	NetSessionFunc obj = stats func = stats_write_multiplayer params = {dontendsessionafterwrite <...>}
endscript

script retrieve_player_net_id 
	net_id = [0 0]
	if GotParam \{player}
		FormatText checksumname = player_status 'player%i_status' i = <player>
		SetArrayElement ArrayName = net_id index = 0 newvalue = ($<player_status>.net_id_first)
		SetArrayElement ArrayName = net_id index = 1 newvalue = ($<player_status>.net_id_second)
	else
		SetArrayElement ArrayName = net_id index = 0 newvalue = ($player1_status.net_id_first)
		SetArrayElement ArrayName = net_id index = 1 newvalue = ($player1_status.net_id_second)
	endif
	printf \{"retrieve_player_net_id"}
	printstruct <...>
	return net_id = <net_id>
endscript

script host_handle_dropped_client 
	printf \{"---host_handle_dropped_client"}
	determine_if_game_over
	change \{player2_present = 0}
	KillSpawnedScript \{name = net_hub_stream}
	EndGameNetScriptPump
	if ($ui_flow_manager_state [0] = online_character_select_fs)
		drop_client_from_character_select
		net_lobby_state_message \{current_state = character_hub
			action = request
			request_state = leaving_lobby}
		ResetLobbyReady
	elseif ($ui_flow_manager_state [0] = online_loading_fs)
	elseif (($ui_flow_manager_state [0] = online_fail_song_fs) || ($ui_flow_manager_state [0] = online_win_song_fs) || ($ui_flow_manager_state [0] = online_match_stats_fs))
		if NOT ScreenElementExists \{net_popup_container}
			get_number_of_songs
			if NOT (<game_over>)
				create_connection_lost_dialog \{player_quit}
			endif
		endif
	else
		if ($game_mode = p2_coop)
			change \{structurename = player1_status
				part = guitar}
			change \{structurename = player2_status
				part = guitar}
			create_guitarist \{name = Guitarist
				useOldPos
				no_strum
				animpak = 0}
			create_guitarist \{name = bassist
				useOldPos
				no_strum
				animpak = 0}
		endif
		net_lobby_state_message {
			current_state = ($net_current_flow_state)
			action = request
			request_state = leaving_lobby
		}
		Wait \{2
			frame}
		if ($playing_song = 0)
			destroy_gamertags
			if (NetSessionFunc obj = match func = get_gamertag)
				ui_print_gamertag name = <name> start_pos = (235.0, 50.0) color = ($player1_color) player = 1 just = [left top] dims = (450.0, 35.0)
			endif
		endif
		ResetLobbyReady
		change \{net_can_send_approval = 1}
		ui_flow_manager_respond_to_action \{action = handle_dropped_client}
	endif
	if ($playing_song = 0)
		if CompositeObjectExists \{name = bassist}
			bassist :hide
		endif
	endif
endscript

script drop_client_from_character_select 
	destroy_gamertags
	if (NetSessionFunc obj = match func = get_gamertag)
		ui_print_gamertag name = <name> start_pos = (235.0, 50.0) color = ($player1_color) player = 1 just = [left top] dims = (450.0, 35.0)
	endif
	KillSpawnedScript \{name = cs_rotate_hilites_p2}
	change \{g_cs_scroll_ready_p2 = 1}
	change \{g_cs_choose_ready_p2 = 0}
	destroy_menu \{menu_id = char_select_character_container_p2}
	destroy_menu \{menu_id = char_select_container_p2}
	destroy_menu \{menu_id = char_select_hilite_container_p2}
	destroy_menu \{menu_id = scrolling_character_select_p2}
	change \{player2_present = 0}
	change \{opponent_gamertag = null}
	destroy_menu \{menu_id = ready_container_p2}
	if CompositeObjectExists \{name = bassist}
		bassist :hide
	endif
endscript

script host_wait_for_client 
	if NOT (IsHost)
		return
	endif
	create_net_popup \{popup_text = "Waiting for other player to join"
		add_waiting_dots
		pos = (640.0, 275.0)}
	begin
	if ($player2_present = 1)
		break
	endif
	Wait \{30
		gameframes}
	repeat
	destroy_net_popup
	cs_event_handlers = [
		{pad_up cs_scroll_up_or_down params = {player = 1 dir = up}}
		{pad_down cs_scroll_up_or_down params = {player = 1 dir = down}}
		{pad_back net_cs_go_back params = {player = 1}}
		{pad_choose character_select_choose params = {player = 1}}
		{pad_start menu_show_gamercard}
	]
	SetScreenElementProps id = vmenu_character_select_p1 event_handlers = <cs_event_handlers> replace_handlers
endscript

script net_battle_select_icon 
	begin
	if ScreenElementExists id = <icon_id>
		<icon_id> :SetProps texture = <icon_texture>
		return
	endif
	Wait \{1
		gameframe}
	repeat 600
	printf "Couldn't find battle icon id=%i" i = <icon_id>
endscript

script net_hub_stream 
	player_status = player1_status
	begin
	char_data = {
		char_id = ($player1_status.character_id)
		outfit = ($player1_status.outfit)
		style = ($player1_status.style)
		instrument_id = ($player1_status.instrument_id)
	}
	SendStructure callback = update_net_character data_to_send = {char_data = <char_data>}
	Wait \{1
		second}
	repeat
endscript

script update_net_character 
	player_status = player2_status
	change_made = 0
	char_id = (<char_data>.char_id)
	outfit = (<char_data>.outfit)
	style = (<char_data>.style)
	instrument_id = (<char_data>.instrument_id)
	valid = 0
	if find_profile_by_id id = <char_id>
		if is_musician_profile_downloaded index = <index>
			valid = 1
		endif
	endif
	if (<valid> = 0)
		printf \{"Invalid Character found - changing to axel"}
		char_id = axel
		outfit = 1
		style = 1
	endif
	valid = 0
	if find_instrument_index desc_id = <instrument_id>
		if is_musician_instrument_downloaded index = <index>
			valid = 1
		endif
	endif
	if (<valid> = 0)
		printf \{"Invalid Instrument found - changing to les paul black"}
		instrument_id = Instrument_Les_Paul_Black
	endif
	if NOT ($<player_status>.character_id = <char_id>)
		change structurename = <player_status> character_id = <char_id>
		<change_made> = 1
	endif
	if NOT ($<player_status>.outfit = <outfit>)
		change structurename = <player_status> outfit = <outfit>
		<change_made> = 1
	endif
	if NOT ($<player_status>.style = <style>)
		change structurename = <player_status> style = <style>
		<change_made> = 1
	endif
	if NOT ($<player_status>.instrument_id = <instrument_id>)
		get_musician_instrument_type desc_id = <instrument_id>
		if GotParam (instrument_type)
			if (<instrument_type> = guitar)
				if NOT (<instrument_id> = ($player2_selected_guitar))
					change player2_selected_guitar = <instrument_id>
				endif
			else
				if NOT (<instrument_id> = ($player2_selected_guitar))
					change player2_selected_bass = <instrument_id>
				endif
			endif
			change structurename = <player_status> instrument_id = <instrument_id>
			<change_made> = 1
		endif
	endif
	if (<change_made> = 1)
		change \{generic_select_monitor_p2_changed = 1}
	endif
endscript

script character_hub_net_ready 
	if NOT (ScreenElementExists id = ready_container_p2)
		create_ready_icons \{pos2 = (825.0, 450.0)
			parent2 = root_window}
	endif
	if ($p2_ready = 0)
		change \{p2_ready = 1}
		if ScreenElementExists \{id = ready_container_p2}
			ready_container_p2 :Obj_SpawnScriptLater \{drop_in_ready_sign
				params = {
					player = 2
				}}
		endif
	endif
	if (($p1_ready = 1) && ($p2_ready = 1))
		if ScreenElementExists \{id = vmenu_character_hub_p1}
			LaunchEvent \{type = unfocus
				target = vmenu_character_hub_p1}
		endif
		Wait \{0.4
			seconds}
		clean_up_user_control_helpers
		shut_down_flow_manager \{player = 2}
		shut_down_character_hub
		destroy_ready_icons
		change \{p1_ready = 0}
		change \{p2_ready = 0}
		KillSpawnedScript \{name = net_hub_stream}
		ui_flow_manager_respond_to_action \{action = select_ready
			player = 1
			create_params = {
				player = 1
			}}
	endif
endscript

script character_hub_net_ready_back 
	change \{p2_ready = 0}
	if NOT (ScreenElementExists id = ready_container_p2)
		create_ready_icons \{pos2 = (825.0, 450.0)
			parent2 = root_window}
	endif
	drop_out_ready_sign \{player = 2}
endscript

script debug_print_coop_stats \{identifier = ""}
	printf "TMR ---------------------------- %s -------------------------" s = <identifier>
	p1_score = ($player1_status.score)
	p2_score = ($player2_status.score)
	p1_health = ($player1_status.current_health)
	p2_health = ($player2_status.current_health)
	p1_note_streak = ($player1_status.best_run)
	p2_note_streak = ($player2_status.best_run)
	p1_total_notes = ($player1_status.total_notes)
	p2_total_notes = ($player2_status.total_notes)
	<p1_percent_complete> = (100 * $player1_status.notes_hit / $player1_status.total_notes)
	<p2_percent_complete> = (100 * $player2_status.notes_hit / $player2_status.total_notes)
	printstruct <...>
endscript

script get_musician_instrument_type 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<desc_id> = <info_struct>.desc_id)
		return instrument_type = (<info_struct>.type)
	endif
	index = (<index> + 1)
	repeat <array_size>
endscript

script scale_element_width_to_size \{max_text_width = 400}
	if NOT GotParam \{id}
		return
	endif
	GetScreenElementDims id = <id>
	if (<width> > <max_text_width>)
		SetScreenElementProps {
			id = <id>
			scale = ((1.0, 0.0) + (0.0, 1.0) * (<text_scale>.(0.0, 1.0)))
		}
		scale_element_to_size {
			id = <id>
			target_width = <max_text_width>
		}
	endif
endscript

script net_dl_content_compatabilty_warning_fade_out 
	Wait \{10
		seconds}
	if ScreenElementExists id = <id>
		<id> :DoMorph alpha = 0.0 time = 1.0
	endif
	Wait \{1
		frame}
	if ScreenElementExists \{id = dl_content_warning}
		DestroyScreenElement \{id = dl_content_warning}
	endif
endscript

script net_dl_content_compatabilty_warning \{z = 100
		pos = (0.0, 0.0)}
	if NOT GotParam \{parent}
		return
	endif
	if ScreenElementExists \{id = dl_content_warning}
		DestroyScreenElement \{id = dl_content_warning}
	endif
	CreateScreenElement {
		type = ContainerElement
		id = dl_content_warning
		parent = <parent>
		pos = <pos>
	}
	menu_anchor = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_frame_cap
		dims = (128.0, 64.0)
		rgba = ($online_medium_blue)
		pos = (0.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_fill_cap
		dims = (128.0, 64.0)
		rgba = ($online_trans_grey)
		pos = (0.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_frame_body_tall
		dims = (128.0, 512.0)
		rgba = ($online_medium_blue)
		pos = (64.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_fill_body_large
		dims = (128.0, 512.0)
		rgba = ($online_trans_grey)
		pos = (64.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_frame_cap
		dims = (128.0, 64.0)
		rgba = ($online_medium_blue)
		pos = (576.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_anchor>
		texture = window_fill_cap
		dims = (128.0, 64.0)
		rgba = ($online_trans_grey)
		pos = (576.0, 0.0)
		just = [center top]
		z_priority = <z>
		rot_angle = -90
		alpha = 1.0
		flip_h
	}
	text = "Both players need to have the same Downloaded Songs in order to use them in multiplayer games."
	CreateScreenElement {
		type = TextBlockElement
		parent = <menu_anchor>
		font = text_a4
		scale = (0.7, 0.55)
		rgba = ($online_light_blue)
		text = <text>
		just = [center top]
		z_priority = (<z> + 0.1)
		pos = (320.0, -55.0)
		dims = (830.0, 185.0)
		allow_expansion
	}
	<menu_anchor> :Obj_SpawnScriptLater net_dl_content_compatabilty_warning_fade_out params = {id = <menu_anchor>}
endscript

script fit_text_into_menu_item 
	if ScreenElementExists id = <id>
		GetScreenElementDims id = <id>
		if (<width> > <max_width>)
			SetScreenElementProps {
				id = <id>
				scale = 1.0
			}
			scale_element_to_size {
				id = <id>
				target_width = <max_width>
				target_height = <Height>
			}
		endif
	endif
endscript

script net_coop_init_star_power 
	printf \{"Trying to init star power"}
	if NOT (($player1_status.star_power_used = 1) || ($player2_status.star_power_used = 1))
		spawnscriptnow \{star_power_activate_and_drain
			params = {
				player_status = player1_status
				player = 1
				player_text = 'p1'
			}}
		spawnscriptnow \{star_power_activate_and_drain
			params = {
				player_status = player2_status
				player = 2
				player_text = 'p2'
			}}
	endif
endscript
DEMONWARE_IS_READY = 1

script set_ready_for_input 
	change \{DEMONWARE_IS_READY = 1}
endscript

script set_demonware_failed 
	change \{DEMONWARE_IS_READY = 1}
endscript

script set_disable_demonware_input 
	change \{DEMONWARE_IS_READY = 0}
endscript

script online_end_song 
	printf \{"---online_end_song"}
	if GameIsOver
		printf \{"Game is over already, no song win event"}
		return
	endif
	if ($game_mode = p2_battle)
		if (IsHost)
			printf \{"Host sending end_song to client"}
			SendEndSong
			client_handle_end_song
		endif
	else
		client_handle_end_song
	endif
endscript

script client_handle_end_song 
	printf \{"client_handle_end_song - Broadcasting song won event."}
	ExtendCRC \{song_won
		'p1'
		out = type}
	BroadcastEvent type = <type>
endscript
gHandlingWindowClosed = 0
gIsInNetGame = 0

script netNotifyWindowClosed 
	printf \{"GTB - netNotifyWindowClosed"}
	if ($gIsInNetGame = 1)
		if ($gHandlingWindowClosed = 0)
			change \{gHandlingWindowClosed = 1}
			create_connection_lost_dialog
		endif
	endif
endscript
