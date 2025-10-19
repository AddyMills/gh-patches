
script create_leaving_lobby_dialog \{menu_id = leaving_lobby_dialog_menu
		vmenu_id = leaving_lobby_dialog_vmenu
		pad_back_script = leaving_lobby_select_cancel
		pad_choose_script = leaving_lobby_select_yes
		pos = (640.0, 520.0)
		z = 110}
	if (($ui_flow_manager_state [0]) = online_pause_fs)
		clean_up_user_control_helpers
	endif
	if GotParam \{parent}
		parent = <parent>
	else
		parent = root_window
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		id = warning_message_container
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		exclusive_device = ($primary_controller)
		type = VScrollingMenu
		parent = warning_message_container
		id = <menu_id>
		just = [center top]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1
	}
	CreateScreenElement {
		exclusive_device = ($primary_controller)
		type = VMenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_back <pad_back_script>}
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
		]
	}
	go_to_net_warning_from_pause_menu
	<menu_pos> = (575.0, 487.0)
	<bookend_r_pos> = (675.0, 533.0)
	<bookend_l_pos> = (540.0, 533.0)
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
	create_pause_menu_frame container_id = net_quit_warning parent = warning_message_container z = <z>
	displaySprite parent = warning_message_container tex = Dialog_Title_BG scale = (1.7, 1.7) z = (<z> + 4) pos = (640.0, 100.0) just = [right top] flip_v
	displaySprite parent = warning_message_container tex = Dialog_Title_BG scale = (1.7, 1.7) z = (<z> + 4) pos = (640.0, 100.0) just = [left top]
	displaySprite parent = warning_message_container tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = (<z> + 5)
	displaySprite parent = warning_message_container tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = (<z> + 5)
	displaySprite parent = warning_message_container tex = dialog_bg pos = (480.0, 500.0) scale = (1.25, 1.0) z = (<z> + 4) just = [left botom]
	displaySprite parent = warning_message_container tex = dialog_bg pos = (480.0, 530.0) scale = (1.25, 1.0) z = (<z> + 4) just = [left top] flip_h
	CreateScreenElement {
		type = TextElement
		parent = warning_message_container
		font = fontgrid_title_gh3
		scale = 1.3
		rgba = [223 223 223 250]
		text = "WARNING"
		just = [center top]
		z_priority = (<z> + 5)
		pos = (640.0, 175.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = warning_message_container
		font = fontgrid_title_gh3
		scale = 0.6
		rgba = [210 210 210 250]
		text = "You are about to leave the current game. Are you sure you want to leave?"
		just = [center top]
		internal_just = [center top]
		z_priority = (<z> + 5)
		pos = (640.0, 310.0)
		dims = (700.0, 320.0)
		line_spacing = 1.0
	}
	CreateScreenElement {
		type = ContainerElement
		parent = leaving_lobby_dialog_vmenu
		dims = (100.0, 50.0)
		event_handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose <pad_back_script>}
		]
	}
	container_id = <id>
	CreateScreenElement {
		type = TextElement
		parent = <container_id>
		local_id = text
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($menu_unfocus_color)
		text = "NO"
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
		alpha = 1.0
		just = [right center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
		z_priority = (<z> + 6)
		scale = (1.0, 1.0)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_right
		texture = Dialog_Highlight
		alpha = 1.0
		just = [left center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
		z_priority = (<z> + 6)
		scale = (1.0, 1.0)
	}
	CreateScreenElement {
		type = ContainerElement
		parent = leaving_lobby_dialog_vmenu
		dims = (100.0, 50.0)
		event_handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose <pad_choose_script> params = <pad_choose_params>}
		]
	}
	container_id = <id>
	CreateScreenElement {
		type = TextElement
		parent = <container_id>
		local_id = text
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($menu_unfocus_color)
		text = "YES"
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
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
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
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
		alpha = 0.0
		z_priority = (<z> + 6)
		scale = (1.0, 1.0)
	}
	if (($ui_flow_manager_state [0]) = online_pause_fs)
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
		add_user_control_helper text = "SELECT" button = green z = (<z> - 10)
		add_user_control_helper text = "BACK" button = red z = (<z> - 10)
		add_user_control_helper text = "UP/DOWN" button = strumbar z = (<z> - 10)
	endif
	leaving_lobby_dialog_focus
endscript

script net_warning_focus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = text}
		doScreenElementMorph id = {<ObjID> child = text} rgba = ($menu_focus_color)
	endif
	if ScreenElementExists id = {<ObjID> child = bookend_right}
		doScreenElementMorph id = {<ObjID> child = bookend_right} alpha = 1.0 preserve_flip
	endif
	if ScreenElementExists id = {<ObjID> child = bookend_left}
		doScreenElementMorph id = {<ObjID> child = bookend_left} alpha = 1.0 preserve_flip
	endif
endscript

script net_warning_unfocus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = text}
		doScreenElementMorph id = {<ObjID> child = text} rgba = ($menu_unfocus_color)
	endif
	if ScreenElementExists id = {<ObjID> child = bookend_right}
		doScreenElementMorph id = {<ObjID> child = bookend_right} alpha = 0.0 preserve_flip
	endif
	if ScreenElementExists id = {<ObjID> child = bookend_left}
		doScreenElementMorph id = {<ObjID> child = bookend_left} alpha = 0.0 preserve_flip
	endif
endscript

script net_cs_go_back 
	if (<player> = 1)
		create_leaving_lobby_dialog \{z = 300
			parent = Menu_Container}
	else
		drop_client_from_character_select
		if IsHost
			net_lobby_state_message \{current_state = character_hub
				action = request
				request_state = leaving_lobby}
		endif
	endif
endscript

script leaving_lobby_select_yes 
	leaving_lobby_dialog_unfocus
	if ScreenElementExists \{id = vmenu_character_select_p1}
		LaunchEvent \{type = unfocus
			target = vmenu_character_select_p1}
	endif
	destroy_leaving_lobby_dialog
	destroy_net_popup
	EndGameNetScriptPump
	KillSpawnedScript \{name = net_hub_stream}
	destroy_ready_icons
	network_player_lobby_message \{type = character_select
		action = deselect}
	cs_go_back \{params = {
			player = 1
		}}
endscript

script leaving_lobby_select_cancel 
	leaving_lobby_dialog_unfocus
	destroy_leaving_lobby_dialog
endscript

script destroy_leaving_lobby_dialog 
	destroy_pause_menu_frame \{container_id = net_quit_warning}
	if (($ui_flow_manager_state [0]) = online_pause_fs)
		clean_up_user_control_helpers
	endif
	if ScreenElementExists \{id = warning_message_container}
		DestroyScreenElement \{id = warning_message_container}
	endif
	if ScreenElementExists \{id = leaving_lobby_dialog_menu}
		DestroyScreenElement \{id = leaving_lobby_dialog_menu}
	endif
endscript

script leaving_lobby_dialog_focus 
	if ScreenElementExists \{id = vmenu_character_select_p1}
		LaunchEvent \{type = unfocus
			target = vmenu_character_select_p1}
	endif
	if ScreenElementExists \{id = leaving_lobby_dialog_vmenu}
		LaunchEvent \{type = focus
			target = leaving_lobby_dialog_vmenu}
	endif
endscript

script leaving_lobby_dialog_unfocus 
	if ScreenElementExists \{id = leaving_lobby_dialog_vmenu}
		LaunchEvent \{type = unfocus
			target = leaving_lobby_dialog_vmenu}
	endif
	if ScreenElementExists \{id = vmenu_character_select_p1}
		LaunchEvent \{type = focus
			target = vmenu_character_select_p1}
	endif
endscript

script go_to_net_warning_from_pause_menu 
	if ScreenElementExists \{id = pause_menu_frame_container}
		destroy_pause_menu_frame \{container_id = net_quit_warning}
		destroy_menu \{menu_id = scrolling_pause}
		destroy_menu \{menu_id = pause_menu_frame_container}
		KillSpawnedScript \{name = animate_bunny_flame}
	endif
endscript

script return_to_pause_menu_from_net_warning 
	destroy_leaving_lobby_dialog
	create_pause_menu
endscript

script pause_menu_really_quit_net_game 
	leaving_lobby_dialog_unfocus
	destroy_leaving_lobby_dialog
	ui_flow_manager_respond_to_action \{action = select_quit
		create_params = {
			player = 1
		}}
endscript
