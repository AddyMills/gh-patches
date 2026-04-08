info_text = [
	"플레이어 매치에 바로 뛰어들어 가용한 첫 번째 락커와 함께 집이 떠나가라 락을 불러보십시오"
	"랭킹 매치에 바로 뛰어들어 가용한 첫 번째 락커와 함께 집이 떠나가라 락을 불러보십시오"
	"특정 형식의 온라인 매치를 검색합니다."
	"친구가 생성한 1:1 매치에 참가합니다."
	"자신만의 온라인 매치를 생성하고 호스트합니다."
	"퀵 매치 옵션을 설정합니다."
	"누가 최고 중의 최고인지와 자신의 랭킹을 확인합니다."
	"다운로드는 곧 공개됩니다!"
	"Guitar Hero 세계의 최신 소식을 보시려면 '오늘의 메시지'를 선택하십시오."
	"온라인 계정을 관리합니다."
]
online_main_menu_pos = (470.0, 110.0)
online_info_pane_pos = (890.0, 150.0)

script create_online_main_menu \{menu_title_xenon = "온라인 주 메뉴"
		menu_title_ps3 = "온라인 주 메뉴"
		menu_id = online_main_menu
		vmenu_id = online_main_vmenu}
	change \{winport_block_net_pause = 0}
	change \{gIsInNetGame = 0}
	change \{online_main_menu_pos = (470.0, 110.0)}
	change \{online_info_pane_pos = (890.0, 150.0)}
	change \{gPrivateMatchId = 0}
	online_menu_init
	change \{rich_presence_context = presence_main_menu}
	spawnscriptnow \{menu_music_on}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = main_menu_anchor
		pos = (0.0, 0.0)}
	CreateScreenElement {
		type = VScrollingMenu
		parent = main_menu_anchor
		id = <menu_id>
		just = [center top]
		dims = (400.0, 480.0)
		pos = (($online_main_menu_pos) + (0.0, 75.0))
		z_priority = 1
	}
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (47.5, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_back return_from_online_main_menu}
			{pad_back generic_menu_pad_back}
			{pad_up generic_menu_up_or_down_sound Params = {up}}
			{pad_down generic_menu_up_or_down_sound Params = {down}}
		]
		exclusive_device = ($primary_controller)
	}
	CreateScreenElement \{type = ContainerElement
		parent = main_menu_anchor
		id = online_main_menu_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = online_main_menu_container
		id = online_main_menu_text_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = main_menu_anchor
		id = online_info_pane_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = online_info_pane_container
		id = online_info_pane_text_container
		pos = (0.0, 0.0)}
	create_menu_backdrop \{texture = online_background}
	displaySprite id = online_frame parent = online_main_menu_container tex = Online_Frame_Large pos = ($online_main_menu_pos) dims = (660.0, 480.0) just = [center top] z = 2
	displaySprite id = online_frame_crown parent = online_main_menu_container tex = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -62.0)) dims = (256.0, 105.0) just = [center top] z = 3
	displaySprite id = motd_top parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_top_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_body parent = online_info_pane_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_body_fill parent = online_info_pane_container tex = window_fill_body_large rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = info_divide parent = online_info_pane_text_container tex = store_frame_bottom_bg rgba = ($online_light_blue) pos = (($online_info_pane_pos) + (-5.0, 240.0)) dims = (320.0, 56.0) just = [center center] z = 6
	if isxenon
		CreateScreenElement {
			type = TextElement
			parent = online_main_menu_text_container
			id = online_title
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($online_dark_purple)
			pos = (($online_main_menu_pos) + (0.0, 35.0))
			text = <menu_title_xenon>
			just = [center top]
			z_priority = 4.0
		}
	else
		CreateScreenElement {
			type = TextElement
			parent = online_main_menu_text_container
			id = online_title
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($online_dark_purple)
			pos = (($online_main_menu_pos) + (0.0, 35.0))
			text = <menu_title_ps3>
			just = [center top]
			z_priority = 4.0
		}
	endif
	GetScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps {
			id = <id>
			scale = 1.0
		}
		scale_element_to_size {
			id = <id>
			target_width = 420
			target_height = <height>
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "퀵 매치"
		info_text_index = 0
		pad_choose_script = online_menu_select_quickmatch_player
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "매치 찾아보기"
		info_text_index = 2
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_custom_match}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "1:1 매치 참가"
		info_text_index = 3
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_join_private}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "매치 생성"
		info_text_index = 4
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_create_match}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "퀵 매치 플레이어 옵션"
		info_text_index = 5
		pad_choose_script = online_menu_select_options
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "순위표"
		info_text_index = 6
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_leaderboards}
	}
	if isxenon
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = "다운로드 콘텐츠"
			info_text_index = 7
			pad_choose_script = null_script
			pad_choose_script2 = soundevent
			choose_script_params2 = {event = ui_sfx_select}
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "오늘의 메시지"
		info_text_index = 8
		pad_choose_script = online_menu_select_motd
		pad_choose_script2 = soundevent
		choose_script_params2 = {event = ui_sfx_select}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "계정 관리"
		info_text_index = 9
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_account_management}
		pad_choose_script2 = soundevent
		choose_script_params2 = {event = ui_sfx_select}
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = online_info_pane_text_container
		id = help_info_text_block
		font = text_a4
		scale = (0.75, 0.65000004)
		rgba = ($online_light_blue)
		text = ($info_text [0])
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (($online_info_pane_pos) + (-4.0, 20.0))
		dims = (320.0, 370.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = online_info_pane_text_container
		id = motd_info_pane_title
		font = text_a4
		text = "오늘의 메시지"
		scale = 0.65000004
		rgba = ($online_light_blue)
		pos = (($online_info_pane_pos) + (0.0, 264.0))
		just = [center top]
		z_priority = 6.0
	}
	CreateScreenElement {
		type = WindowElement
		parent = online_info_pane_text_container
		id = motd_ticker_window
		pos = (($online_info_pane_pos) + (0.0, 312.0))
		dims = (248.0, 32.0)
		just = [center top]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_ticker_window
		id = motd_ticker_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ""
		font = text_a4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{get_motd_and_start_ticker}
	if NOT isxenon
		if NOT netsessionfunc \{obj = voice
				func = voice_allowed}
			CreateScreenElement {
				type = TextBlockElement
				parent = online_info_pane_container
				just = [center top]
				internal_just = [center top]
				pos = (640.0, 585.0)
				scale = (0.55, 0.55)
				text = "귀하의 PLAYSTATION®Network 계정은 보호자 통제 기능으로 인해 채팅 기능이 제한되어 있습니다."
				font = text_a4
				rgba = ($online_light_blue)
				z_priority = 6.0
				dims = (1500.0, 120.0)
			}
		endif
	endif
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	create_online_main_menu_helper_buttons
	LaunchEvent type = focus target = <vmenu_id>
endscript

script destroy_online_main_menu 
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{id = main_menu_anchor}
		DestroyScreenElement \{id = main_menu_anchor}
	endif
	killspawnedscript \{name = scroll_motd_ticker}
endscript

script create_online_main_menu_helper_buttons 
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
	add_user_control_helper \{text = "선택"
		button = green
		z = 100}
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	add_user_control_helper \{text = "위/아래"
		button = strumbar
		z = 100}
endscript

script get_motd_and_start_ticker 
	if ($retrieved_message_of_the_day = 0)
		netsessionfunc \{obj = motd
			func = get_demonware_motd
			Params = {
				callback = motd_callback
			}}
	else
		motd_ticker_text_block :SetProps text = ($message_of_the_day)
		spawnscriptnow \{scroll_motd_ticker
			Params = {
				id = motd_ticker_text_block
			}}
	endif
endscript

script motd_callback 
	if GotParam \{motd_text}
		change \{retrieved_message_of_the_day = 1}
		change message_of_the_day = <motd_text>
		if ScreenElementExists \{id = motd_ticker_text_block}
			motd_ticker_text_block :SetProps text = ($message_of_the_day)
			spawnscriptnow \{scroll_motd_ticker
				Params = {
					id = motd_ticker_text_block
				}}
		endif
	endif
endscript

script scroll_motd_ticker \{scroll_time = 20}
	<end_pos> = (-1000.0, 0.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam \{children}
		begin
		begin
		Wait \{2
			seconds}
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait \{5
			seconds}
		getscreenelementprops id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait \{2.0
			seconds}
		<this_id> :domorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait \{0.5
			seconds}
		<this_id> :domorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script return_from_online_main_menu 
	printf \{"--- deinitializing network layer"}
	shut_down_net_play
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script online_menu_select_quickmatch_player 
	change \{match_type = player}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_player}
endscript

script online_menu_select_quickmatch_ranked 
	change \{match_type = ranked}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_ranked}
endscript

script online_menu_select_options 
	ui_flow_manager_respond_to_action \{action = select_online_options}
endscript

script lobby_connection_lost 
	printf \{"---lobby_connection_lost performing net cleanup"}
	EndGameNetScriptPump
	if (IsHost)
		isHosting = 1
	else
		isHosting = 0
	endif
	if ($gHandlingWindowClosed = 1 || <isHosting> = 0)
		quit_network_game
		setup_sessionfuncs
		destroy_popup_warning_menu
		ui_flow_manager_respond_to_action \{action = connection_lost}
	endif
	change \{gHandlingWindowClosed = 0}
endscript

script online_menu_select_website 
	create_link_text
	hide_unhide_menu_elements \{id = online_info_pane_container
		time = 0.2
		hide}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_main_menu_text_container
		time = 0.2
		hide}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2
		hide}
	translate_and_scale_online_menu
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			Params = {
				id = gh_link_container
				alpha = 1.0
				time = 0.2
			}}
	endif
	ghlink_vmenu :SetProps \{enable_pad_handling}
	LaunchEvent \{type = focus
		target = ghlink_vmenu}
endscript

script online_menu_unselect_website 
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			Params = {
				id = gh_link_container
				alpha = 0.0
				time = 0.2
			}}
	endif
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = gh_link_container}
		DestroyScreenElement \{id = gh_link_container}
	endif
	translate_and_scale_online_menu \{revert}
	hide_unhide_menu_elements \{id = online_main_menu_text_container
		time = 0.2}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_info_pane_container
		time = 0.2}
	Wait \{0.3
		seconds}
	LaunchEvent \{type = focus
		target = online_main_vmenu}
endscript

script create_link_text 
	CreateScreenElement \{type = ContainerElement
		parent = online_main_menu_container
		id = gh_link_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = gh_link_container
		id = ghlink
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (320.0, 200.0)
		z_priority = 1}
	CreateScreenElement {
		type = VMenu
		parent = ghlink
		id = ghlink_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back soundevent Params = {event = Generic_Menu_Back_SFX}}
			{pad_back online_menu_unselect_website}
			{pad_back clean_up_user_control_helpers}
			{pad_back create_online_main_menu_helper_buttons}
		]
	}
	<id> :SetProps disable_pad_handling
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_dark_purple)
		text = "www.guitarhero.com"
		just = [center top]
		pos = (640.0, 111.0)
		z_priority = 4.0
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "기타의 영웅이 될 준비가 되셨습니까? \\n웹 커뮤니티와 통계를 연동하는 방법은 다음과 같습니다."
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (640.0, 160.0)
		dims = (950.0, 200.0)
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "- www.guitarhero.com 방문\\n- 새 계정 생성 또는 로그인\\n- 'Link Account(계정 연결)' 클릭\\n- 다음의 VIP 패스코드 입력"
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (640.0, 240.0)
		dims = (1010.0, 600.0)
	}
	netsessionfunc \{func = get_agora_token}
	FormatText textname = vip_code "%a" a = <token>
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		font = text_a3
		scale = 1.25
		rgba = ($online_light_blue)
		text = <vip_code>
		just = [center top]
		z_priority = 6.0
		pos = (640.0, 410.0)
		font_spacing = 5
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "웹에서는 자신의 프로필을 개인화하고 게임의 순위표를 살펴볼 수도 있으며 온라인 밴드와 합주를 하고 동료를 모으고 토너먼트에 참가하는 등의 행동을 할 수 있습니다!"
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (648.0, 460.0)
		dims = (1010.0, 600.0)
	}
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			Params = {
				id = gh_link_container
				alpha = 0.0
			}}
	endif
	clean_up_user_control_helpers
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
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	LaunchEvent \{type = unfocus
		target = online_main_vmenu}
endscript

script online_menu_select_motd 
	create_motd_text
	hide_unhide_menu_elements \{id = online_main_menu_container
		time = 0.2
		hide}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2
		hide}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_info_pane_text_container
		time = 0.2
		hide}
	translate_and_scale_info_pane
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = MOTD_Container}
		RunScriptOnScreenElement \{id = MOTD_Container
			doScreenElementMorph
			Params = {
				id = MOTD_Container
				alpha = 1.0
				time = 0.2
			}}
	endif
	LaunchEvent \{type = focus
		target = motd_vmenu}
	motd_vmenu :SetProps \{enable_pad_handling}
endscript

script online_menu_unselect_motd 
	if ScreenElementExists \{id = MOTD_Container}
		RunScriptOnScreenElement \{id = MOTD_Container
			doScreenElementMorph
			Params = {
				id = MOTD_Container
				alpha = 0.0
				time = 0.2
			}}
	endif
	Wait \{0.3
		seconds}
	destroy_menu \{menu_id = motd_scroller}
	if ScreenElementExists \{id = MOTD_Container}
		DestroyScreenElement \{id = MOTD_Container}
	endif
	translate_and_scale_info_pane \{revert}
	hide_unhide_menu_elements \{id = online_info_pane_text_container
		time = 0.2}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2}
	hide_unhide_menu_elements \{id = online_main_menu_container
		time = 0.2}
	Wait \{0.3
		seconds}
	LaunchEvent \{type = focus
		target = online_main_vmenu}
endscript

script create_motd_text 
	CreateScreenElement \{type = ContainerElement
		parent = online_info_pane_container
		id = MOTD_Container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = MOTD_Container
		id = motd_scroller
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (640.0, 0.0)
		z_priority = 1}
	CreateScreenElement {
		type = VMenu
		parent = motd_scroller
		id = motd_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back soundevent Params = {event = Generic_Menu_Back_SFX}}
			{pad_back online_menu_unselect_motd}
			{pad_back clean_up_user_control_helpers}
			{pad_back create_online_main_menu_helper_buttons}
		]
	}
	<id> :SetProps disable_pad_handling
	CreateScreenElement {
		type = TextElement
		parent = MOTD_Container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_light_blue)
		text = "오늘의 메시지"
		just = [center top]
		pos = (640.0, 160.0)
		z_priority = 10.0
	}
	CreateScreenElement \{type = WindowElement
		parent = MOTD_Container
		id = motd_info_scroll_window
		pos = (633.0, 220.0)
		dims = (500.0, 300.0)
		just = [
			center
			top
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_info_scroll_window
		id = motd_info_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ($message_of_the_day)
		font = text_a4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{scroll_motd_info
		Params = {
			id = motd_info_text_block
		}}
	if ScreenElementExists \{id = MOTD_Container}
		MOTD_Container :SetProps \{alpha = 0.0}
	endif
	clean_up_user_control_helpers
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
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	LaunchEvent \{type = unfocus
		target = online_main_vmenu}
endscript

script scroll_motd_info \{scroll_time = 60}
	<end_pos> = (0.0, -1000.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam \{children}
		GetArraySize (<children>)
		<line_nums> = <array_size>
	else
		return
	endif
	if (<line_nums> > 10)
		begin
		begin
		Wait \{5
			seconds}
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait ((<line_nums> - 10) * 1.8) seconds
		getscreenelementprops id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait \{4.0
			seconds}
		<this_id> :domorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait \{0.5
			seconds}
		<this_id> :domorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script translate_and_scale_online_menu 
	if NOT GotParam \{revert}
		RunScriptOnScreenElement id = online_frame doScreenElementMorph Params = {id = online_frame pos = (($online_main_menu_pos) + (170.0, -35.0)) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph Params = {id = online_frame_crown pos = (($online_main_menu_pos) + (180.0, -88.0)) time = 0.2}
		RunScriptOnScreenElement \{id = online_frame
			scale_element_to_size
			Params = {
				id = online_frame
				target_width = 760
				target_height = 500
				time = 0.2
			}}
	else
		RunScriptOnScreenElement id = online_frame doScreenElementMorph Params = {id = online_frame pos = ($online_main_menu_pos) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph Params = {id = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -62.0)) time = 0.2}
		online_frame :SetProps \{scale = 1.0}
		RunScriptOnScreenElement \{id = online_frame
			scale_element_to_size
			Params = {
				id = online_frame
				target_width = 660
				target_height = 480
				time = 0.2
			}}
	endif
endscript

script translate_and_scale_info_pane 
	if NOT GotParam \{revert}
		RunScriptOnScreenElement id = motd_top doScreenElementMorph Params = {id = motd_top pos = (($online_info_pane_pos) + (-250.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph Params = {id = motd_top_fill pos = (($online_info_pane_pos) + (-250.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph Params = {id = motd_body pos = (($online_info_pane_pos) + (-250.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph Params = {id = motd_body_fill pos = (($online_info_pane_pos) + (-250.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph Params = {id = motd_end pos = (($online_info_pane_pos) + (-250.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph Params = {id = motd_end_fill pos = (($online_info_pane_pos) + (-250.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement \{id = motd_top
			scale_element_to_size
			Params = {
				id = motd_top
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_top_fill
			scale_element_to_size
			Params = {
				id = motd_top_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body
			scale_element_to_size
			Params = {
				id = motd_body
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body_fill
			scale_element_to_size
			Params = {
				id = motd_body_fill
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end
			scale_element_to_size
			Params = {
				id = motd_end
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end_fill
			scale_element_to_size
			Params = {
				id = motd_end_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
	else
		RunScriptOnScreenElement id = motd_top doScreenElementMorph Params = {id = motd_top pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph Params = {id = motd_top_fill pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph Params = {id = motd_body pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph Params = {id = motd_body_fill pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph Params = {id = motd_end pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph Params = {id = motd_end_fill pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement \{id = motd_top
			scale_element_to_size
			Params = {
				id = motd_top
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_top_fill
			scale_element_to_size
			Params = {
				id = motd_top_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body
			scale_element_to_size
			Params = {
				id = motd_body
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body_fill
			scale_element_to_size
			Params = {
				id = motd_body_fill
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end
			scale_element_to_size
			Params = {
				id = motd_end
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end_fill
			scale_element_to_size
			Params = {
				id = motd_end_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
	endif
endscript

script hide_unhide_menu_elements \{time = 0.0}
	if ScreenElementExists id = <id>
		if GotParam \{hide}
			RunScriptOnScreenElement id = <id> doScreenElementMorph Params = {alpha = 0.0 time = <time> id = <id>}
		else
			RunScriptOnScreenElement id = <id> doScreenElementMorph Params = {alpha = 1.0 time = <time> id = <id>}
		endif
	endif
endscript

script create_net_play_song_menu 
endscript

script destroy_net_play_song_menu 
endscript

script online_select_downloads 
	netsessionfunc \{func = ShowMarketPlaceUI}
	wait_for_blade_complete
	SetPakManCurrentBlock \{map = Zones
		pak = none
		block_scripts = 1}
	destroy_band
	Downloads_UnloadContent
	ui_flow_manager_respond_to_action \{action = select_downloadable_content}
endscript

script net_add_item_to_main_menu \{line_spacing = 40}
	if GotParam \{info_text_index}
		eventparams = [
			{focus net_main_menu_focus}
			{focus SetScreenElementProps Params = {id = help_info_text_block text = ($info_text [<info_text_index>])}}
			{unfocus net_main_menu_unfocus}
		]
	else
		eventparams = [
			{focus net_main_menu_focus}
			{unfocus net_main_menu_unfocus}
		]
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = <VMenu>
		dims = ((100.0, 0.0) + (0.0, 1.0) * <line_spacing>)
		event_handlers = <eventparams>
	}
	menu_item_container = <id>
	if GotParam \{pad_choose_script}
		if GotParam \{choose_script_params}
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script> Params = {<choose_script_params>}}]
		else
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script>}]
		endif
	endif
	if GotParam \{pad_choose_script2}
		if GotParam \{choose_script_params2}
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script2> Params = {<choose_script_params2>}}]
		else
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script2>}]
		endif
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = highlightbar
		texture = white
		dims = (450.0, 40.0)
		rgba = ($online_light_blue)
		pos = (0.0, 7.5)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = left_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		pos = (-227.0, 3.0)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = right_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		pos = (240.0, 3.0)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = TextElement
		parent = <menu_item_container>
		local_id = text
		font = text_a4
		scale = 0.75
		rgba = ($online_light_blue)
		text = <text>
		just = [center top]
		z_priority = 4.0
	}
	GetScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps {
			id = <id>
			scale = 1.0
		}
		scale_element_to_size {
			id = <id>
			target_width = 420
			target_height = <height>
		}
	endif
	if (<text> = "퀵 매치: 랭킹 매치")
		GetGlobalTags \{user_options}
		if (<online_game_mode> = 4)
			SetScreenElementProps {
				id = <menu_item_container>
				not_focusable
			}
			SetScreenElementProps {
				id = {<menu_item_container> child = text}
				rgba = ($online_grey)
			}
		endif
	endif
endscript

script net_main_menu_focus 
	obj_getid
	if ScreenElementExists id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			id = {<ObjID> child = highlightbar}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = left_bookend}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = right_bookend}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = text}
		SetScreenElementProps {
			id = {<ObjID> child = text}
			rgba = ($online_dark_purple)
		}
	endif
endscript

script net_main_menu_unfocus 
	obj_getid
	if ScreenElementExists id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			id = {<ObjID> child = highlightbar}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = left_bookend}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = right_bookend}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = text}
		SetScreenElementProps {
			id = {<ObjID> child = text}
			rgba = ($online_light_blue)
		}
	endif
endscript
