data_settings_menu_font = text_a10

script create_data_settings_menu \{for_loaddevice = 0}
	create_menu_backdrop \{texture = Venue_BG}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = data_settings_container}
	rot = -3
	displaySprite parent = data_settings_container tex = data_settings_poster pos = (640.0, 360.0) dims = (384.0, 768.0) just = [center center] rot_angle = <rot>
	change \{menu_unfocus_color = [
			60
			60
			30
			255
		]}
	change \{menu_focus_color = [
			235
			240
			200
			255
		]}
	text_params = {
		type = TextElement
		font = $data_settings_menu_font
		rgba = $menu_unfocus_color
		rot_angle = <rot>
		z_priority = 5
	}
	if (<for_loaddevice> = 1)
		new_menu \{scrollid = cds_scroll
			vmenuid = cds_vmenu
			menu_pos = (520.0, 80.0)
			spacing = -10
			default_colors = 0}
		CreateScreenElement {
			<text_params>
			parent = cds_vmenu
			text = "CHOOSE DEVICE"
			id = ds_choosedevice
			event_handlers = [
				{focus menu_data_settings_choosedevice_focus}
				{unfocus menu_data_settings_choosedevice_unfocus}
				{pad_choose ui_flow_manager_respond_to_action params = {action = continue}}
			]
			rot_angle = -6
		}
		CreateScreenElement {
			<text_params>
			parent = cds_vmenu
			text = "CANCEL"
			id = ds_cancel
			event_handlers = [
				{focus menu_data_settings_cancel_focus}
				{unfocus menu_data_settings_cancel_unfocus}
				{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
			]
			rot_angle = -6
		}
	else
		new_menu \{scrollid = cds_scroll
			vmenuid = cds_vmenu
			menu_pos = (830.0, 105.0)
			spacing = -10
			default_colors = 0
			just = [
				center
				top
			]}
		CreateScreenElement \{type = ContainerElement
			parent = cds_vmenu
			dims = (200.0, 52.0)
			event_handlers = [
				{
					focus
					menu_data_settings_savegame_focus
				}
				{
					unfocus
					menu_data_settings_savegame_unfocus
				}
				{
					pad_choose
					menu_data_settings_select_save_game
				}
			]}
		CreateScreenElement {
			<text_params>
			parent = <id>
			text = "SAVE GAME"
			id = ds_savegame
			rot_angle = -3
		}
		CreateScreenElement \{type = ContainerElement
			parent = cds_vmenu
			dims = (200.0, 52.0)
			event_handlers = [
				{
					focus
					menu_data_settings_loadgame_focus
				}
				{
					unfocus
					menu_data_settings_loadgame_unfocus
				}
				{
					pad_choose
					menu_data_settings_select_load_game
				}
			]}
		CreateScreenElement {
			<text_params>
			parent = <id>
			text = "LOAD GAME"
			id = ds_loadgame
			rot_angle = -1
			shadow
			shadow_rgba = [175 175 150 255]
			shadow_offs = (5.0, 5.0)
		}
		CreateScreenElement \{type = ContainerElement
			parent = cds_vmenu
			dims = (200.0, 52.0)
			event_handlers = [
				{
					focus
					menu_data_settings_autosave_focus
				}
				{
					unfocus
					menu_data_settings_autosave_unfocus
				}
				{
					pad_choose
					menu_data_settings_toggle_autosave
				}
			]}
		CreateScreenElement {
			<text_params>
			parent = <id>
			text = "Autosave:"
			id = ds_autosave
			shadow
			shadow_rgba = [175 175 150 255]
			shadow_offs = (5.0, 5.0)
		}
		SetScreenElementLock \{id = ds_autosave
			off}
		SetScreenElementLock \{id = ds_autosave
			on}
		GetScreenElementDims \{id = ds_autosave}
		fit_text_in_rectangle id = ds_autosave dims = ((140.0, 0.0) + (0.0, 1.0) * <Height>) only_if_larger_x = 1
		autosave_tex = data_settings_xmark
		GetGlobalTags \{user_options}
		if (<autosave> = 1)
			<autosave_tex> = data_settings_checkmark
		endif
		CreateScreenElement {
			type = SpriteElement
			parent = data_settings_container
			id = ds_autosave_tex
			pos = ($data_settings_hilite_pos.auto + (100.0, -10.0))
			just = [center center]
			texture = <autosave_tex>
			z_priority = 5
			rot_angle = <rot>
		}
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = data_settings_container
		pos = ($data_settings_hilite_pos.save)
		id = ds_hilite
		just = [center center]
		texture = data_settings_hilite
		z_priority = 4
		rgba = [180 55 25 255]
		rot_angle = <rot>
	}
	CreateScreenElement {
		type = TextElement
		parent = data_settings_container
		text = "DATA SETTINGS"
		font = text_a10
		pos = (650.0, 600.0)
		just = [center center]
		z_priority = 5
		rgba = [223 223 223 255]
		rot_angle = <rot>
	}
	GetScreenElementDims id = <id>
	fit_text_in_rectangle id = <id> dims = ((240.0, 0.0) + (0.0, 1.0) * <Height>) pos = (650.0, 600.0) only_if_larger_x = 1
	CreateScreenElement \{type = SpriteElement
		parent = data_settings_container
		texture = Tape_H_02
		pos = (480.0, 90.0)
		z_priority = 20
		dims = (128.0, 64.0)
		flip_h
		flip_v}
	CreateScreenElement {
		type = SpriteElement
		parent = <id>
		texture = Tape_H_02
		pos = (10.0, 10.0)
		rgba = [0 0 0 128]
		just = [left top]
		z_priority = 19
	}
	CreateScreenElement \{type = SpriteElement
		parent = data_settings_container
		texture = Tape_H_02
		pos = (800.0, 630.0)
		z_priority = 20
		dims = (128.0, 64.0)
		rot_angle = -25}
	CreateScreenElement {
		type = SpriteElement
		parent = <id>
		texture = Tape_H_02
		pos = (10.0, 10.0)
		rgba = [0 0 0 128]
		just = [left top]
		z_priority = 19
	}
	CreateScreenElement \{type = SpriteElement
		parent = data_settings_container
		texture = tape_V_02
		pos = (820.0, 260.0)
		z_priority = 20
		dims = (64.0, 128.0)
		rot_angle = -25
		flip_v}
	CreateScreenElement {
		type = SpriteElement
		parent = <id>
		texture = tape_V_02
		pos = (-20.0, 20.0)
		rgba = [0 0 0 128]
		just = [left top]
		z_priority = 19
	}
	CreateScreenElement \{type = SpriteElement
		parent = data_settings_container
		texture = venue_overlay
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = 99
		rgba = [
			255
			255
			255
			255
		]}
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
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
endscript

script destroy_data_settings_menu \{destroy = 1}
	if (<destroy>)
		clean_up_user_control_helpers
		destroy_menu \{menu_id = data_settings_container}
		destroy_menu \{menu_id = cds_scroll}
	endif
endscript
data_settings_hilite_pos = {
	save = (630.0, 141.0)
	load = (630.0, 180.0)
	auto = (630.0, 225.0)
}

script menu_data_settings_choosedevice_focus 
	retail_menu_focus
	if ScreenElementExists \{id = ds_choosedevice}
		ds_choosedevice :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.save) time = 0.05
	endif
endscript

script menu_data_settings_choosedevice_unfocus 
	retail_menu_unfocus
	if ScreenElementExists \{id = ds_choosedevice}
		ds_choosedevice :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_overwrite_focus 
	retail_menu_focus
	if ScreenElementExists \{id = ds_overwrite}
		ds_overwrite :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.save) time = 0.05
	endif
endscript

script menu_data_settings_overwrite_unfocus 
	retail_menu_unfocus
	if ScreenElementExists \{id = ds_overwrite}
		ds_overwrite :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_cancel_focus 
	retail_menu_focus
	if ScreenElementExists \{id = ds_cancel}
		ds_cancel :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.load) time = 0.05
	endif
endscript

script menu_data_settings_cancel_unfocus 
	retail_menu_unfocus
	if ScreenElementExists \{id = ds_cancel}
		ds_cancel :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_savegame_focus 
	retail_menu_focus \{id = ds_savegame}
	if ScreenElementExists \{id = ds_savegame}
		ds_savegame :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.save) time = 0.05
	endif
endscript

script menu_data_settings_savegame_unfocus 
	retail_menu_unfocus \{id = ds_savegame}
	if ScreenElementExists \{id = ds_savegame}
		ds_savegame :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_loadgame_focus 
	retail_menu_focus \{id = ds_loadgame}
	if ScreenElementExists \{id = ds_loadgame}
		ds_loadgame :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.load) time = 0.05
	endif
endscript

script menu_data_settings_loadgame_unfocus 
	retail_menu_unfocus \{id = ds_loadgame}
	if ScreenElementExists \{id = ds_loadgame}
		ds_loadgame :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_autosave_focus 
	retail_menu_focus \{id = ds_autosave}
	if ScreenElementExists \{id = ds_autosave}
		ds_autosave :SetProps \{no_shadow}
	endif
	if ScreenElementExists \{id = ds_hilite}
		ds_hilite :DoMorph pos = ($data_settings_hilite_pos.auto) time = 0.05
	endif
endscript

script menu_data_settings_autosave_unfocus 
	retail_menu_unfocus \{id = ds_autosave}
	if ScreenElementExists \{id = ds_autosave}
		ds_autosave :SetProps \{shadow
			shadow_rgba = [
				175
				175
				150
				255
			]
			shadow_offs = (5.0, 5.0)}
	endif
endscript

script menu_data_settings_select_save_game 
	ui_flow_manager_respond_to_action \{action = select_save_game}
endscript

script menu_data_settings_select_load_game 
	ui_flow_manager_respond_to_action \{action = select_load_game}
endscript

script menu_data_settings_toggle_autosave \{time = 0.075}
	GetGlobalTags \{user_options}
	if (<autosave> = 1)
		SoundEvent \{event = Generic_Menu_Back_SFX}
		<autosave> = 0
		if ScreenElementExists \{id = ds_autosave_tex}
			ds_autosave_tex :DoMorph alpha = 0 time = <time>
			SetScreenElementProps \{id = ds_autosave_tex
				texture = data_settings_xmark}
			ds_autosave_tex :DoMorph alpha = 1 time = <time>
		endif
	else
		SoundEvent \{event = ui_sfx_select}
		<autosave> = 1
		if ScreenElementExists \{id = ds_autosave_tex}
			ds_autosave_tex :DoMorph alpha = 0 time = <time>
			SetScreenElementProps \{id = ds_autosave_tex
				texture = data_settings_checkmark}
			ds_autosave_tex :DoMorph alpha = 1 time = <time>
		endif
	endif
	SetGlobalTags user_options params = {autosave = <autosave>}
endscript
