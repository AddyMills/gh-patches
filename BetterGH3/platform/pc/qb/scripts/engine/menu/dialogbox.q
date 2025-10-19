
script create_snazzy_dialog_box \{title = "Title"
		text = "Default text"
		anchor_id = dialog_box_anchor
		vmenu_id = dialog_box_vmenu
		container_id = dialog_box_container
		title_font = text_a1
		font = text_a1
		text_font = text_a1
		pos = (320.0, 230.0)
		just = [
			center
			top
		]
		scale = 0.8
		line_spacing = 1
		title_scale = 0.7
		text_scale = 0.6
		text_dims = (530.0, 0.0)
		exclusive_device = -1
		pos_tweak = (0.0, -50.0)
		bg_rgba = [
			8
			15
			24
			170
		]
		title_rgba = [
			90
			90
			70
			255
		]
		text_rgba = [
			90
			70
			50
			255
		]
		bg_scale = 1
		hmenu_pos = (0.0, 50.0)
		z_priority = 40
		no_bg
		destroy_on_event = 1}
	if ScreenElementExists id = <anchor_id>
		dialog_box_exit anchor_id = <anchor_id>
	endif
	if NOT InNetGame
		if NOT InFrontend
		endif
	endif
	SetScreenElementLock \{id = root_window
		off}
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = <anchor_id>
		dims = (640.0, 480.0)
		pos = <pos>
		just = [center center]
		z_priority = <z_priority>
		priority = <priority>
		exclusive_device = <exclusive_device>
	}
	CreateScreenElement {
		type = ContainerElement
		id = <container_id>
		parent = <anchor_id>
		dims = (640.0, 480.0)
		pos = <pos>
		just = [center center]
		z_priority = <z_priority>
		priority = <priority>
	}
	CreateScreenElement {
		type = ContainerElement
		parent = <anchor_id>
		dims = (640.0, 480.0)
		pos = (320.0, 240.0)
		just = [center center]
		z_priority = <z_priority>
	}
	<bg_anchor_id> = <id>
	if GotParam \{from_cas}
		make_cas_bg_elements parent = <bg_anchor_id>
	else
		if InFrontend
			if NOT GotParam \{no_bg}
			endif
		endif
	endif
	if GotParam \{forced_pos}
		pos = <forced_pos>
	endif
	CreateScreenElement {
		type = VMenu
		parent = <container_id>
		id = <vmenu_id>
		pos = <pos>
		just = [center top]
		internal_just = [center top]
		scale = <scale>
		z_priority = <z_priority>
		padding_scale = 0.8
		exclusive_device = <exclusive_device>
	}
	if NOT GotParam \{no_helper_text}
		if GotParam \{buttons}
			GetArraySize <buttons>
			if GotParam \{pad_back_script}
				if (<array_size> = 1)
					create_helper_text {anchor_id = <helper_text_anchor_id>
						parent = <bg_anchor_id>
						$generic_dialog_helper_text3
						bg_rgba = <helper_text_bg_rgba>
						z_priority = <z_priority>
					}
				else
					create_helper_text {anchor_id = <helper_text_anchor_id>
						parent = <bg_anchor_id>
						$generic_helper_text
						bg_rgba = <helper_text_bg_rgba>
						z_priority = <z_priority>
					}
				endif
			else
				if (<array_size> = 1)
					create_helper_text {anchor_id = <helper_text_anchor_id>
						parent = <bg_anchor_id>
						$generic_dialog_helper_text
						bg_rgba = <helper_text_bg_rgba>
						z_priority = <z_priority>
					}
				else
					create_helper_text {anchor_id = <helper_text_anchor_id>
						parent = <bg_anchor_id>
						$generic_dialog_helper_text2
						bg_rgba = <helper_text_bg_rgba>
						z_priority = <z_priority>
					}
				endif
			endif
		endif
	endif
	CreateScreenElement {
		type = TextElement
		parent = <vmenu_id>
		local_id = dbox_title
		font = <title_font>
		text = <title>
		just = [center top]
		rgba = <title_rgba>
		scale = <title_scale>
		z_priority = <z_priority>
		not_focusable
		padding_scale = 0.55
	}
	<title_id> = <id>
	GetScreenElementDims id = <title_id>
	if GotParam \{use_goalmenu_bg}
		bg_rgba = [20 30 40 80]
		CreateScreenElement {
			type = SpriteElement
			parent = {<vmenu_id> child = dbox_title}
			texture = dialog_frame
			just = [center top]
			pos = (85.0, -20.0)
			rgba = [0 10 20 255]
			scale = (2.125, 1.0)
			z_priority = (<z_priority> -1)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = {<vmenu_id> child = dbox_title}
			texture = dialog_middle
			just = [center top]
			pos = (85.0, 10.0)
			rgba = [0 10 20 255]
			scale = (2.125, 1.5)
			z_priority = (<z_priority> -1)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = {<vmenu_id> child = dbox_title}
			texture = dialog_frame_b
			just = [center top]
			pos = (85.0, 30.0)
			rgba = [0 10 20 255]
			scale = (2.125, 1.0)
			z_priority = (<z_priority> -1)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = {<vmenu_id> child = dbox_title}
			texture = menu_selection_white_02
			just = [center top]
			pos = (85.0, 50.0)
			rgba = [5 15 25 70]
			scale = (1.5, 1.0)
			z_priority = (<z_priority> -1)
		}
		CreateScreenElement {
			type = SpriteElement
			parent = {<vmenu_id> child = dbox_title}
			texture = dialog_frame_b
			just = [center top]
			pos = (85.0, 103.0)
			rgba = [5 15 25 100]
			scale = (2.125, 0.25)
			z_priority = (<z_priority> -1)
		}
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = <vmenu_id>
		font = <text_font>
		text = <text>
		just = [center top]
		dims = <text_dims>
		rgba = <text_rgba>
		scale = <text_scale>
		line_spacing = <line_spacing>
		allow_expansion
		not_focusable
		padding_scale = 0.65000004
	}
	<text_id> = <id>
	GetScreenElementDims id = <text_id>
	if GotParam \{buttons}
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (<text_dims> + (50.0, 40.0))
			not_focusable
		}
	endif
	if GotParam \{logo}
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			just = [center center]
			dims = (0.0, 88.0)
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <id>
			texture = <logo>
			just = [center top]
			rgba = [100 100 100 255]
			scale = ((1.4, 1.3) * 1.4)
		}
		no_icon = no_icon
	endif
	if GotParam \{pad_back_script}
		SetScreenElementProps {
			id = <vmenu_id>
			event_handlers = [{pad_back <pad_back_script> params = <pad_back_params>}]
			replace_handlers
		}
	endif
	SetScreenElementLock id = <vmenu_id> on
	SetScreenElementLock id = <vmenu_id> off
	GetScreenElementDims id = <vmenu_id>
	section_width = ((<width> / 100.0) + 0.0)
	if GotParam \{buttons}
		ForEachIn <buttons> do = create_dialog_button params = {
			font = <font>
			parent = <vmenu_id>
			z_priority = (<z_priority> + 4)
			width = <section_width>
			pad_focus_script = <pad_focus_script>
			destroy_on_event = <destroy_on_event>
		}
		GetArraySize <buttons>
		if (<array_size> > 1)
			SetScreenElementProps {
				id = <vmenu_id>
				event_handlers = [
					{pad_up generic_menu_up_or_down_sound params = {up}}
					{pad_down generic_menu_up_or_down_sound params = {down}}
				]
			}
		endif
	endif
	if GotParam \{sub_logo}
		CreateScreenElement {
			type = SpriteElement
			parent = <vmenu_id>
			texture = <sub_logo>
			just = [center center]
			rgba = [128 128 128 88]
			scale = (1.25, 1.0)
			not_focusable
		}
		no_icon = no_icon
	endif
	SetScreenElementLock id = <vmenu_id> on
	SetScreenElementLock id = <vmenu_id> off
	GetScreenElementDims id = <vmenu_id>
	section_width = ((<width> / 100.0) + 0.0)
	section_height = 32
	num_parts = (((<Height> * 1.0) / (<section_height> * 1.0)) -1.0)
	if NOT GotParam \{forced_pos}
		centered_pos = ((320.0, 0.0) + ((0.0, 1.0) * (480 - <Height>) / 2) + <pos_tweak>)
		SetScreenElementProps id = <vmenu_id> pos = <centered_pos>
	else
		centered_pos = <forced_pos>
	endif
	<bg_x_scale> = 1.2
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		pos = <centered_pos>
		just = [center bottom]
		texture = dialog_frame
		scale = ((1.0, 0.0) * <bg_x_scale> + (0.0, 1.0))
		rgba = <bg_rgba>
		z_priority = 38
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = dialog_middle
		pos = (<centered_pos> - (0.0, 16.0))
		scale = (((1.0, 0.0) * <bg_x_scale>) + (0.0, 1.0) * (<Height> / 16.0))
		just = [center top]
		rgba = <bg_rgba>
		z_priority = 38
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		pos = (<centered_pos> + (0.0, 1.0) * (<Height>) + (0.0, 15.0))
		just = [center bottom]
		texture = dialog_frame_b
		scale = ((1.0, 0.0) * <bg_x_scale> + (0.0, 1.0))
		rgba = <bg_rgba>
		z_priority = 38
	}
	kill_start_key_binding
	if ObjectExists \{id = no_button}
		LaunchEvent type = focus target = <vmenu_id> data = {child_id = no_button}
	else
		LaunchEvent type = focus target = <vmenu_id>
	endif
	if GotParam \{delay_input}
		RunScriptOnScreenElement id = <anchor_id> dialog_box_delay_input params = {delay_input_time = <delay_input_time>}
	endif
	if NOT GotParam \{no_animate}
		if GotParam \{style}
			RunScriptOnScreenElement id = <anchor_id> <style> params = <...>
		else
			if NOT GotParam \{full_animate}
				RunScriptOnScreenElement id = <container_id> animate_dialog_box_in params = <...>
			else
				RunScriptOnScreenElement id = <anchor_id> animate_dialog_box_in params = <...>
			endif
		endif
	endif
	if ObjectExists \{id = current_menu_anchor}
		LaunchEvent \{type = unfocus
			target = current_menu_anchor}
	endif
	if ObjectExists \{id = current_menu}
		LaunchEvent \{type = unfocus
			target = current_menu}
	endif
endscript

script special_dialog_style 
	GetScreenElementDims id = <vmenu_id>
	GetScreenElementPosition id = <vmenu_id>
	CreateScreenElement {
		type = SpriteElement
		parent = dialog_box_container
		id = left_star
		pos = (<screenelementpos> + (40.0, 12.0))
		texture = PA_goals
		scale = 1.8
		flip_v
		rgba = [128 128 128 128]
	}
	CreateScreenElement {
		type = SpriteElement
		parent = dialog_box_container
		id = right_star
		pos = ((1.0, 0.0) * <width> + <screenelementpos> + (-30.0, 12.0))
		texture = PA_goals
		scale = 1.8
		flip_v
		rot_angle = -10
		rgba = [100 100 100 255]
	}
	CreateScreenElement {
		type = SpriteElement
		parent = dialog_box_container
		id = flash3
		pos = ((1.0, 0.0) * <width> + <screenelementpos> + (-275.0, 130.0))
		texture = spec_B_M
		scale = (7.3, 6.0)
		flip_v
		rgba = [126 2 84 58]
		z_priority = 11
	}
	CreateScreenElement {
		type = SpriteElement
		parent = dialog_box_container
		id = topline
		pos = ((1.0, 0.0) * <width> + <screenelementpos> + (-275.0, 22.0))
		texture = white2
		scale = (60.0, 0.2)
		flip_v
		rgba = [13 121 4 128]
		z_priority = 11
	}
	CreateScreenElement {
		type = SpriteElement
		parent = dialog_box_container
		id = topline2
		pos = ((1.0, 0.0) * <width> + <screenelementpos> + (-275.0, -5.0))
		texture = white2
		scale = (60.0, 0.2)
		flip_v
		rgba = [13 121 4 128]
		z_priority = 11
	}
	RunScriptOnScreenElement \{id = left_star
		spin_star
		params = {
			dir = cw
		}}
	RunScriptOnScreenElement \{id = right_star
		spin_star
		params = {
			dir = ccw
		}}
	<title_id> :Obj_SpawnScriptLater pulse_dialog_title params = {id = <title_id>}
	RunScriptOnScreenElement id = dialog_box_container animate_special_dialog_box_in params = <...>
endscript

script animate_special_dialog_box_in 
	DoMorph \{pos = (1000.0, 260.0)
		alpha = 0
		time = 0
		scale = 0
		rot_angle = -220}
	DoMorph \{pos = (320.0, 260.0)
		alpha = 1
		time = 0.3
		scale = 1.0
		rot_angle = 0}
endscript

script spin_star \{dir = cw}
	do_random_effect
endscript

script burst_star 
	DoMorph \{time = 0
		scale = 0
		alpha = 0}
	DoMorph \{time = 0.4
		scale = (7.5, 3.8)
		alpha = 0.6}
endscript

script pulse_dialog_title 
	begin
	if ObjectExists id = <id>
		doScreenElementMorph id = <id> time = 0.2 scale = (1.8, 2.0) rgba = [13 121 4 128]
		Wait \{0.2
			seconds}
	else
		break
	endif
	if ObjectExists id = <id>
		doScreenElementMorph id = <id> time = 0.2 scale = (1.5, 1.5) rgba = [13 121 4 128]
		Wait \{0.2
			seconds}
	else
		break
	endif
	repeat
endscript

script theme_dialog_background \{parent = current_menu_anchor
		width = 1
		pos = (320.0, 120.0)
		num_parts = 2
		top_height = 1}
	if ScreenElementExists \{id = dialog_box_bg_vmenu}
		DestroyScreenElement \{id = dialog_box_bg_vmenu}
	endif
	dialog_bg_rgba = [30 30 35 216]
	SetScreenElementLock id = <parent> off
	CreateScreenElement {
		type = VMenu
		parent = <parent>
		id = dialog_box_bg_vmenu
		font = text_a1
		just = [left top]
		pos = <pos>
		padding_scale = 1
		internal_scale = 1
		internal_just = [center center]
	}
	middle_parts = <num_parts>
	CastToInteger \{middle_parts}
	partial_scale = (<num_parts> - <middle_parts>)
	printf "partial_scale = %p" p = <partial_scale>
	build_theme_dialog_top parent = dialog_box_bg_vmenu width = <width> dialog_bg_rgba = <dialog_bg_rgba> z_priority = <z_priority> Height = <top_height>
	if (<middle_parts> > 0)
		begin
		build_theme_dialog_middle parent = dialog_box_bg_vmenu width = <width> dialog_bg_rgba = <dialog_bg_rgba> z_priority = <z_priority>
		repeat <middle_parts>
	endif
	build_theme_dialog_middle parent = dialog_box_bg_vmenu width = <width> dialog_bg_rgba = <dialog_bg_rgba> scale_height = <partial_scale> z_priority = <z_priority>
	build_theme_dialog_bottom parent = dialog_box_bg_vmenu width = <width> dialog_bg_rgba = <dialog_bg_rgba> scale_height = <partial_scale> z_priority = <z_priority> no_icon = <no_icon> add_loading_anim = <add_loading_anim>
endscript

script build_theme_dialog_top 
	CreateScreenElement {
		type = ContainerElement
		dims = (0.0, 32.0)
		parent = <parent>
	}
	anchor_id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_T_M
		pos = (0.0, 0.0)
		just = [center top]
		rgba = <dialog_bg_rgba>
		scale = ((1.0, 0.0) * <width> + (0.0, 1.0) * <Height>)
		z_priority = <z_priority>
	}
	<top_height> = <Height>
	GetScreenElementDims id = <id>
	right_pos = ((0.5, 0.0) * <width>)
	left_pos = ((-0.5, 0.0) * <width>)
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_T_L
		pos = <left_pos>
		just = [right top]
		rgba = <dialog_bg_rgba>
		scale = ((1.0, 0.0) + (0.0, 1.0) * <top_height>)
		z_priority = <z_priority>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_T_R
		pos = <right_pos>
		just = [left top]
		rgba = <dialog_bg_rgba>
		scale = ((1.0, 0.0) + (0.0, 1.0) * <top_height>)
		z_priority = <z_priority>
	}
endscript

script build_theme_dialog_middle \{scale_height = 1}
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		dims = (0.0, 32.0)
	}
	anchor_id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_M_M
		pos = (0.0, 0.0)
		just = [center top]
		rgba = <dialog_bg_rgba>
		scale = ((1.0, 0.0) * <width> + <scale_height> * (0.0, 1.0))
		z_priority = <z_priority>
	}
	GetScreenElementDims id = <id>
	right_pos = ((0.5, 0.0) * <width>)
	left_pos = ((-0.5, 0.0) * <width>)
	side_scale = ((1.0, 0.0) * 1 + <scale_height> * (0.0, 1.0))
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_M_L
		pos = <left_pos>
		just = [right top]
		rgba = <dialog_bg_rgba>
		scale = <side_scale>
		z_priority = <z_priority>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_M_R
		pos = <right_pos>
		just = [left top]
		rgba = <dialog_bg_rgba>
		scale = <side_scale>
		z_priority = <z_priority>
	}
endscript

script build_theme_dialog_bottom 
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		dims = (0.0, 32.0)
	}
	anchor_id = <id>
	pos = ((0.0, -1.0) * (32 - (<scale_height> * 32)))
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_B_M
		pos = <pos>
		just = [center top]
		rgba = <dialog_bg_rgba>
		scale = ((1.0, 0.0) * <width> + (0.0, 1.0))
		z_priority = <z_priority>
	}
	GetScreenElementDims id = <id>
	right_pos = ((0.5, 0.0) * <width> + <pos>)
	left_pos = ((-0.5, 0.0) * <width> + <pos>)
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_B_L
		pos = <left_pos>
		just = [right top]
		rgba = <dialog_bg_rgba>
		scale = (1.0, 1.0)
		z_priority = <z_priority>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = snaz_B_R
		pos = <right_pos>
		just = [left top]
		rgba = <dialog_bg_rgba>
		scale = (1.0, 1.0)
		z_priority = <z_priority>
	}
	if NOT GotParam \{no_icon}
		FormatText checksumname = theme_icon '%i_snaz_icon' i = (THEME_PREFIXES [$current_theme_prefix])
		if GotParam \{add_loading_anim}
			loading_color = [128 123 20 255]
		else
			<loading_color> = [90 90 90 70]
		endif
		CreateScreenElement {
			type = SpriteElement
			parent = <anchor_id>
			texture = <theme_icon>
			pos = ((0.0, 10.0) + <pos>)
			just = [center center]
			rgba = <loading_color>
			scale = (1.3, 1.3)
			z_priority = (<z_priority> + 1)
			alpha = 0.7
		}
		if GotParam \{add_loading_anim}
			RunScriptOnScreenElement id = <id> spin_dialog_icon
		endif
	endif
endscript

script spin_dialog_icon 
	<rot_angle> = 0
	begin
	DoMorph rot_angle = <rot_angle>
	<rot_angle> = (<rot_angle> + 6)
	if (<rot_angle> > 360)
		<rot_angle> = (<rot_angle> - 360)
	endif
	Wait \{1
		gameframes}
	repeat
endscript

script create_error_box \{delay_input_time = 1000}
	create_dialog_box <...> error_box
endscript

script create_dialog_box 
	create_snazzy_dialog_box <...>
endscript

script button_choose_script 
	destroy_dialog_box
	<callBack_Script> <callback_params>
endscript

script create_dialog_button \{focus_script = main_theme_focus
		focus_params = {
			highlighted_text_rgba = [
				0
				20
				30
				255
			]
		}
		unfocus_script = main_theme_unfocus
		unfocus_params = {
			text_rgba = [
				80
				90
				100
				255
			]
		}
		pad_choose_script = destroy_dialog_box
		font = text_a1
		parent = dialog_box_vmenu
		width = 3
		z_priority = 14
		button_text_scale = 0.5
		button_dims = (0.0, 30.0)
		text_color = [
			80
			90
			100
			255
		]
		destroy_on_event = 1}
	SetScreenElementLock \{id = root_window
		off}
	SetScreenElementLock id = <parent> off
	if NOT GotParam \{ignore_default_option}
		if (<text> = "No")
			id = no_button
		endif
	endif
	if (<destroy_on_event> = 1)
		<pad_choose_params> = {callBack_Script = <pad_choose_script> callback_params = <pad_choose_params>}
		<pad_choose_script> = button_choose_script
	else
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		id = <id>
		dims = <button_dims>
		just = [center center]
		event_handlers =
		[
			{focus <focus_script> params = <focus_params>}
			{unfocus <unfocus_script> params = <unfocus_params>}
			{pad_choose generic_menu_pad_choose_sound}
			{pad_start generic_menu_pad_choose_sound}
			{pad_choose <pad_choose_script> params = <pad_choose_params>}
			{pad_start <pad_choose_script> params = <pad_choose_params>}
		]
		<not_focusable>
	}
	anchor_id = <id>
	CreateScreenElement {
		type = TextElement
		parent = <anchor_id>
		pos = (0.0, 0.0)
		font = <font>
		text = <text>
		just = [center center]
		scale = <button_text_scale>
		rgba = <text_color>
		z_priority = <z_priority>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = menu_selection_white_01
		scale = (0.6, 0.5)
		rgba = [86 88 90 155]
		z_priority = (<z_priority> -1)
		local_id = highlight_bar
		alpha = 0
		Random (@ flip_h @ flip_v @ )
	}
	highlight_angle = 0
	bar_scale = ((<width> + 2) * (0.5, 0.0) + (0.0, 0.7))
	highlight_angle = (<highlight_angle> / (<bar_scale>.(1.0, 0.0)))
endscript

script destroy_dialog_box \{anchor_id = dialog_box_anchor}
	if NOT GotParam \{dont_restore_input}
		SetButtonEventMappings \{unblock_menu_input}
	endif
	Debounce \{x
		time = 0.3}
	if ObjectExists id = <anchor_id>
		DestroyScreenElement id = <anchor_id>
	endif
	if NOT GotParam \{dont_focus}
		if ObjectExists \{id = current_menu_anchor}
			LaunchEvent \{type = focus
				target = current_menu_anchor}
		endif
	endif
endscript

script dialog_box_exit \{anchor_id = dialog_box_anchor}
	destroy_dialog_box <...>
	if NOT GotParam \{dont_restore_input}
		SetButtonEventMappings \{unblock_menu_input}
	endif
	Debounce \{x
		time = 0.3}
	if ObjectExists id = <anchor_id>
		DestroyScreenElement id = <anchor_id>
	endif
	if NOT GotParam \{no_pad_start}
		if NOT InFrontend
			restore_start_key_binding
		endif
	endif
endscript

script dialog_box_delay_input \{delay_input_time = 2000}
	TemporarilyDisableInput time = <delay_input_time>
endscript
dont_create_speech_boxes = 0

script create_speech_box 
	KillSpawnedScript \{id = create_speech_box_guts}
	spawnscriptnow create_speech_box_guts params = {<...>}
endscript

script create_speech_box_guts \{pos = (640.0, 560.0)
		bg_rgba = [
			8
			15
			24
			50
		]
		text_rgba = [
			100
			90
			80
			255
		]
		anchor_id = speech_box_anchor
		scale = (1.7, 0.71999997)
		pad_choose_script = speech_box_exit
		pad_choose_params = {
		}
		parent = root_window
		bg_x_scale = 1.12
		pause_input_time = 1000}
	font = text_a1
	if ObjectExists id = <anchor_id>
		DestroyScreenElement id = <anchor_id>
	endif
	SetScreenElementLock \{id = root_window
		off}
	CreateScreenElement {
		type = ContainerElement
		parent = <parent>
		id = <anchor_id>
		pos = <pos>
		just = [center bottom]
		scale = <scale>
		z_priority = <z_priority>
	}
	if NOT GotParam \{no_pad_choose}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_choose speech_box_input_debounce}
				{pad_choose <pad_choose_script> params = <pad_choose_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_back_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_back speech_box_input_debounce}
				{pad_back <pad_back_script> params = <pad_back_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_option_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [
				{pad_option <pad_option_script> params = <pad_option_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_option2_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_option2 speech_box_input_debounce}
				{pad_option2 <pad_option2_script> params = <pad_option2_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_up_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_up <pad_up_script> params = <pad_up_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_down_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_down <pad_down_script> params = <pad_down_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_left_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_left <pad_left_script> params = <pad_left_params>}]
			replace_handlers
		}
	endif
	if GotParam \{pad_right_script}
		SetScreenElementProps {
			id = <anchor_id>
			event_handlers = [{pad_right <pad_right_script> params = <pad_right_params>}]
			replace_handlers
		}
	endif
	if NOT GotParam \{no_pad_start}
		SetScreenElementProps {
			id = root_window
			event_handlers = [{pad_start <pad_choose_script> params = <pad_choose_params>}]
			replace_handlers
		}
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = <anchor_id>
		font = <font>
		dims = (540.0, 0.0)
		just = [center bottom]
		text = <text>
		rgba = <text_rgba>
		scale = (0.5, 1.05)
		allow_expansion
	}
	<speech_text> = <id>
	GetScreenElementDims id = <speech_text>
	speech_text_height = <Height>
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		just = [center top]
		texture = dialog_frame_b
		scale = ((1.0, 0.0) * <bg_x_scale> + (0.0, 1.0))
		rgba = <bg_rgba>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		pos = ((0.0, -1.0) * <speech_text_height>)
		just = [center bottom]
		texture = dialog_frame
		scale = ((1.0, 0.0) * <bg_x_scale> + (0.0, 1.0))
		rgba = <bg_rgba>
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <anchor_id>
		texture = dialog_middle
		scale = (((1.0, 0.0) * <bg_x_scale>) + ((0.0, 1.0) * (<speech_text_height> / 16.0)))
		just = [center bottom]
		rgba = <bg_rgba>
	}
	GetScreenElementProps id = <id>
	pos_top = (<pos> [1])
	if GotParam \{style}
		RunScriptOnScreenElement id = <anchor_id> <style> params = <...>
	endif
	LaunchEvent type = focus target = <anchor_id>
	if GotParam \{pause_input}
		SpawnScriptLater TemporarilyDisableInput params = {time = <pause_input_time>}
	endif
endscript

script speech_box_exit \{anchor_id = speech_box_anchor}
	if ObjectExists id = <anchor_id>
		DestroyScreenElement id = <anchor_id>
	endif
	Debounce \{x
		time = 0.3}
	Debounce \{circle
		time = 0.3}
	if NOT GotParam \{no_pad_start}
		restore_start_key_binding
	endif
	LaunchEvent \{type = speech_box_destroyed}
endscript

script speech_box_input_debounce 
	Debounce \{x
		time = 0.3
		Clear = 1}
	Debounce \{circle
		time = 0.3
		Clear = 1}
	Debounce \{square
		time = 0.3
		Clear = 1}
	Debounce \{triangle
		time = 0.3
		Clear = 1}
endscript

script speech_box_style 
	RunScriptOnScreenElement id = <speech_text> hide_speech_text params = <...>
	DoMorph \{time = 0
		scale = (1.0, 1.0)
		alpha = 1}
	Wait \{4
		frame}
	DoMorph \{time = 0.2
		scale = (1.0, 1.0)
		alpha = 1}
	RunScriptOnScreenElement id = <speech_text> speech_box_style_scale_text params = <...>
endscript

script hide_speech_text 
	DoMorph \{time = 0
		scale = 0}
endscript

script speech_box_style_scale_text 
	Wait \{0.05
		second}
	DoMorph \{time = 0
		scale = (1.0, 1.0)
		alpha = 0}
	DoMorph \{time = 0.5
		scale = (1.0, 1.0)
		alpha = 1}
	LaunchEvent type = focus target = <anchor_id>
endscript

script animate_dialog_box_in 
	if GotParam \{full_animate}
		SetScreenElementProps {
			id = <bg_anchor_id>
			hide
		}
	endif
	if NOT GotParam \{delay_input}
		<bg_anchor_id> :Obj_SpawnScriptLater dialog_box_delay_input params = {delay_input_time = 300}
	endif
	DoMorph \{time = 0
		scale = (0.0, 0.0)
		alpha = 0.1}
	DoMorph \{time = 0.15
		scale = (1.0, 0.0)
		alpha = 0.4}
	DoMorph \{time = 0.15
		scale = (1.0, 1.0)
		alpha = 1.0}
	if GotParam \{full_animate}
		SetScreenElementProps {
			id = <bg_anchor_id>
			unhide
		}
	endif
endscript

script create_test_dialog 
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	create_dialog_box \{pad_back_script = create_test_menu
		buttons = [
			{
				font = text_a1
				text = "No"
				pad_choose_script = create_test_menu
			}
			{
				font = text_a1
				text = "Yes"
				pad_choose_script = null_script
			}
		]}
endscript

script dialog_box_accept 
	dialog_box_exit
	LaunchEvent \{type = message_accept}
endscript
