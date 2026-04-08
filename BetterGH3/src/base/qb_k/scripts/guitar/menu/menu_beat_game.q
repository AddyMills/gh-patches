beat_game_title = "\\c0%d \\c6난이도에서 GUITAR HERO III 클리어\\c6!\\c0"
beat_game_message = "사람들의 혼을 빼놓을 준비가 다 되었다고\\n 생각하십니까? \\c1%n\\c0에서 출시된 이 나쁜 녀석을 사용해보십시오. 성공한다면 보상이 주어질 수도 있습니다. 고통, 유명세, 영광이 기다리고 있습니다."
beat_game_message_expert = "와. 당신은 전문가를 마스터했습니다. 지금 당장 밴드를 하셔도 되겠습니다! \\c1%n\\c0와 함께 다음 단계에 도전해보십시오! 치트는 옵션 메뉴에서 잠금을 해제할 수 있습니다."

script create_beat_game_menu 
	create_menu_backdrop \{texture = Beat_Game_BG}
	menu_font = fontgrid_title_gh3
	get_current_band_info
	GetGlobalTags <band_info> param = name
	band_name = <name>
	FormatText textname = band_name_text "%s" s = <band_name>
	difficulty_text = "전문가"
	next_difficulty_text = "정밀 모드 치트"
	<difficulty> = ($current_difficulty)
	if ($game_mode = p2_career)
		<index1> = ($difficulty_list_props.($current_difficulty).index)
		<index2> = ($difficulty_list_props.($current_difficulty2).index)
		if (<index2> < <index1>)
			<difficulty> = ($current_difficulty2)
		endif
	endif
	switch (<difficulty>)
		case easy
		<difficulty_text> = "쉬움"
		next_difficulty = medium
		<next_difficulty_text> = "보통"
		case medium
		<difficulty_text> = "보통"
		next_difficulty = hard
		<next_difficulty_text> = "어려움"
		case hard
		<difficulty_text> = "어려움"
		next_difficulty = expert
		<next_difficulty_text> = "전문가"
	endswitch
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = beat_game_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_band_name
		just = [center top]
		font = <menu_font>
		text = <band_name_text>
		scale = 1.38
		rgba = [140 70 70 255]
		pos = (640.0, 366.0)
	}
	GetScreenElementDims \{id = bgs_band_name}
	if (<width> > 300)
		fit_text_in_rectangle \{id = bgs_band_name
			dims = (1060.0, 130.0)
			pos = (640.0, 366.0)}
	endif
	FormatText textname = title_text $beat_game_title d = <difficulty_text>
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_under_title
		just = [left top]
		font = <menu_font>
		text = <title_text>
		scale = 1.0
		rgba = [250 245 145 255]
	}
	fit_text_in_rectangle \{id = bgs_under_title
		dims = (700.0, 65.0)
		pos = (300.0, 428.0)}
	if (<difficulty> = expert)
		FormatText textname = motivation_text ($beat_game_message_expert) n = <next_difficulty_text>
	else
		FormatText textname = motivation_text ($beat_game_message) n = <next_difficulty_text>
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = beat_game_container
		font = text_a4
		text = <motivation_text>
		dims = (1100.0, 700.0)
		pos = (640.0, 468.0)
		rgba = [250 245 145 255]
		just = [center top]
		internal_just = [center top]
		scale = 0.7
		z_priority = 3
	}
	<cheat> = "질풍노도의 리프 x 2"
	FormatText textname = cheat_text "치트 힌트: %c" c = <cheat>
	if (<difficulty> = expert)
		CreateScreenElement {
			type = TextElement
			parent = beat_game_container
			id = bgs_cheat_text
			just = [center top]
			font = <menu_font>
			text = <cheat_text>
			scale = 0.5
			pos = (640.0, 622.0)
			rgba = [250 245 145 255]
		}
	endif
	button_font = buttonsxenon
	displaySprite \{id = bgs_black_banner
		parent = beat_game_container
		tex = white
		pos = (0.0, -2.0)
		dims = (1240.0, 100.0)
		rgba = [
			0
			0
			0
			255
		]
		z = -2}
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = continue_text
		scale = 1.0
		pos = (40.0, 20.0)
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action Params = {action = continue}}
		]
	}
	spawnscriptnow scroll_band_name Params = {band_text = <band_name_text>}
	LaunchEvent \{type = focus
		target = continue_text}
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = "계속"
		button = green
		z = 100}
endscript

script destroy_beat_game_menu 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = beat_game_container}
	destroy_menu_backdrop
	killspawnedscript \{name = scroll_band_name}
endscript

script scroll_band_name 
	displayText id = scrolling_bandname1 parent = beat_game_container pos = (0.0, 34.0) scale = 1 font = <menu_font> text = <band_text> rgba = [124 77 65 255] z = -1
	GetScreenElementDims \{id = scrolling_bandname1}
	multi = (1280 / <width>)
	band_text_with_space = (<band_text> + " ")
	long_band_text = <band_text_with_space>
	StringLength string = <band_text_with_space>
	<band_text_with_space_length> = <str_len>
	begin
	StringLength string = <long_band_text>
	<long_band_text_length> = <str_len>
	if NOT (<long_band_text_length> < (127 - <band_text_with_space_length>))
		break
	endif
	<long_band_text> = (<long_band_text> + <band_text_with_space>)
	SetScreenElementProps id = scrolling_bandname1 text = <long_band_text>
	GetScreenElementDims \{id = scrolling_bandname1}
	if (<width> > 1280)
		break
	endif
	repeat <multi>
	SetScreenElementProps id = scrolling_bandname1 text = <long_band_text>
	fit_text_in_rectangle id = scrolling_bandname1 dims = ((1280.0, 0.0) + (<height> * (0.0, 1.0))) pos = (0.0, 34.0)
	displayText id = scrolling_bandname2 parent = beat_game_container scale = 1 font = <menu_font> text = <long_band_text> rgba = [124 77 65 255] z = -1
	GetScreenElementDims \{id = scrolling_bandname1}
	fit_text_in_rectangle id = scrolling_bandname2 dims = ((1280.0, 0.0) + (<height> * (0.0, 1.0))) pos = (((1.0, 0.0) * <width>) + (0.0, 34.0))
	first = 1
	begin
	if (<first>)
		doScreenElementMorph id = scrolling_bandname1 pos = (((-1.0, 0.0) * <width>) + (0.0, 34.0)) time = 5
		doScreenElementMorph \{id = scrolling_bandname2
			pos = (0.0, 34.0)
			time = 5}
	else
		doScreenElementMorph id = scrolling_bandname2 pos = (((-1.0, 0.0) * <width>) + (0.0, 34.0)) time = 5
		doScreenElementMorph \{id = scrolling_bandname1
			pos = (0.0, 34.0)
			time = 5}
	endif
	Wait \{5
		seconds}
	if (<first>)
		SetScreenElementProps id = scrolling_bandname1 pos = (((1.0, 0.0) * <width>) + (0.0, 34.0))
		SetScreenElementProps \{id = scrolling_bandname2
			pos = (0.0, 34.0)}
		<first> = 0
	else
		SetScreenElementProps id = scrolling_bandname2 pos = (((1.0, 0.0) * <width>) + (0.0, 34.0))
		SetScreenElementProps \{id = scrolling_bandname1
			pos = (0.0, 34.0)}
		<first> = 1
	endif
	repeat
endscript
