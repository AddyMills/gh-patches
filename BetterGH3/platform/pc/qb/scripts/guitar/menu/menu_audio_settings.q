audio_settings_menu_font = fontgrid_title_gh3
audio_settings_editing = Band
aom_menu_pos = (480.0, 100.0)
as_pointer_pos = [
	(264.0, 160.0)
	(264.0, 330.0)
	(264.0, 500.0)
]
as_pointer_index = 0
as_pointer_scale = 1
as_is_popup = 0
as_ping_index = 0
audio_settings_locked = 0

script create_audio_settings_menu \{popup = 0}
	exclusive_params = {}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = aom_container
		pos = (0.0, 0.0)}
	if (<popup> = 1)
		kill_start_key_binding
		z = 100
		change \{as_is_popup = 1}
		new_menu {
			scrollid = as_scroll
			vmenuid = as_vmenu
			menu_pos = (420.0, 280.0)
			exclusive_device = ($last_start_pressed_device)
			text_right
			spacing = 40
		}
		create_pause_menu_frame z = (<z> - 10)
		change \{menu_focus_color = [
				254
				204
				55
				255
			]}
		change \{menu_unfocus_color = [
				182
				182
				182
				255
			]}
		text_params = {
			parent = as_vmenu
			type = TextElement
			font = text_a6
			rgba = ($menu_unfocus_color)
			z_priority = <z>
			scale = 0.7
			shadow
			shadow_offs = (2.0, 2.0)
			shadow_rgba = [0 0 0 255]
		}
		CreateScreenElement {
			type = SpriteElement
			parent = aom_container
			texture = menu_pause_frame_banner
			pos = (640.0, 540.0)
			just = [center center]
			z_priority = (<z> + 100)
		}
		CreateScreenElement {
			type = TextElement
			parent = <id>
			text = "AUDIO"
			font = text_a6
			pos = (125.0, 53.0)
			rgba = [170 90 30 255]
			scale = 0.8
		}
		if NOT isSinglePlayerGame
			FormatText TextName = player_paused_text "PLAYER %d PAUSED. ONLY PLAYER %d OPTIONS ARE AVAILABLE." d = (($last_start_pressed_device) + 1)
			displaySprite {
				parent = pause_menu_frame_container
				id = pause_helper_text_bg
				tex = control_pill_body
				pos = (640.0, 600.0)
				just = [center center]
				rgba = [96 0 0 255]
				z = (<z> + 10)
			}
			displayText {
				parent = pause_menu_frame_container
				pos = (640.0, 604.0)
				just = [center center]
				text = <player_paused_text>
				rgba = [186 105 0 255]
				scale = (0.45000002, 0.6)
				z = (<z> + 11)
				font = text_a6
			}
			GetScreenElementDims id = <id>
			bg_dims = (<width> * (1.0, 0.0) + (0.0, 32.0))
			pause_helper_text_bg :SetProps dims = <bg_dims>
			displaySprite {
				parent = pause_menu_frame_container
				tex = control_pill_end
				pos = ((640.0, 600.0) - <width> * (0.5, 0.0))
				rgba = [96 0 0 255]
				just = [right center]
				flip_v
				z = (<z> + 10)
			}
			displaySprite {
				parent = pause_menu_frame_container
				tex = control_pill_end
				pos = ((640.0, 600.0) + <width> * (0.5, 0.0))
				rgba = [96 0 0 255]
				just = [left center]
				z = (<z> + 10)
			}
		endif
		displaySprite \{parent = aom_container
			tex = Options_Audio_Knob
			pos = (725.0, 295.0)
			just = [
				center
				center
			]
			dims = (96.0, 96.0)
			rgba = [
				150
				150
				150
				255
			]
			z = 150}
		displaySprite \{parent = aom_container
			tex = Options_Audio_Knob
			pos = (825.0, 365.0)
			just = [
				center
				center
			]
			dims = (96.0, 96.0)
			rgba = [
				150
				150
				150
				255
			]
			z = 150}
		displaySprite \{parent = aom_container
			tex = Options_Audio_Knob
			pos = (725.0, 440.0)
			just = [
				center
				center
			]
			dims = (96.0, 96.0)
			rgba = [
				150
				150
				150
				255
			]
			z = 150}
		displaySprite \{parent = aom_container
			id = aom_knob_line_1
			tex = Options_Audio_Knob_Line
			pos = (725.0, 295.0)
			dims = (48.0, 12.0)
			z = 151
			rgba = [
				230
				190
				70
				255
			]
			just = [
				1.0
				0.0
			]}
		displaySprite \{parent = aom_container
			id = aom_knob_line_2
			tex = Options_Audio_Knob_Line
			pos = (825.0, 365.0)
			dims = (48.0, 12.0)
			z = 151
			rgba = [
				230
				190
				70
				255
			]
			just = [
				1.0
				0.0
			]}
		displaySprite \{parent = aom_container
			id = aom_knob_line_3
			tex = Options_Audio_Knob_Line
			pos = (725.0, 440.0)
			dims = (48.0, 12.0)
			z = 151
			rgba = [
				230
				190
				70
				255
			]
			just = [
				1.0
				0.0
			]}
	else
		change \{as_is_popup = 0}
		spacing = 105
		new_menu scrollid = as_scroll vmenuid = as_vmenu spacing = <spacing> menu_pos = $aom_menu_pos exclusive_device = ($primary_controller)
		create_menu_backdrop \{texture = Venue_BG}
		CreateScreenElement \{type = SpriteElement
			parent = aom_container
			id = as_light_overlay
			texture = venue_overlay
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			z_priority = 99}
		set_focus_color \{rgba = [
				230
				190
				70
				255
			]}
		set_unfocus_color \{rgba = [
				150
				150
				150
				255
			]}
		displaySprite \{parent = aom_container
			tex = Options_Audio_Poster
			pos = (340.0, 40.0)
			dims = (672.0, 672.0)}
		displaySprite \{parent = aom_container
			tex = Tape_H_01
			pos = (360.0, 40.0)
			dims = (192.0, 96.0)
			z = 10
			rot_angle = -20}
		displaySprite \{parent = aom_container
			tex = Tape_H_01
			rgba = [
				0
				0
				0
				128
			]
			pos = (360.0, 48.0)
			dims = (192.0, 96.0)
			z = 10
			rot_angle = -20}
		displaySprite \{parent = aom_container
			tex = Tape_V_01
			pos = (870.0, 550.0)
			dims = (96.0, 192.0)
			z = 10
			rot_angle = 16}
		displaySprite \{parent = aom_container
			tex = Tape_V_01
			rgba = [
				0
				0
				0
				128
			]
			pos = (875.0, 551.0)
			dims = (96.0, 192.0)
			z = 10
			rot_angle = 16}
		displaySprite parent = aom_container tex = Options_Audio_Knob pos = ($aom_menu_pos + (15.0, 50.0)) dims = (96.0, 96.0) rgba = [150 150 150 255] z = 9
		displaySprite parent = aom_container tex = Options_Audio_Knob pos = ($aom_menu_pos + (15.0, 219.0)) dims = (96.0, 96.0) rgba = [150 150 150 255] z = 9
		displaySprite parent = aom_container tex = Options_Audio_Knob pos = ($aom_menu_pos + (15.0, 386.0)) dims = (96.0, 96.0) rgba = [150 150 150 255] z = 9
		displaySprite \{parent = aom_container
			id = aom_belly_strings
			tex = Options_Audio_Bellystrings
			pos = (744.0, 146.0)
			dims = (74.0, 318.0)
			z = 10}
		displaySprite parent = aom_container id = aom_pointer tex = Options_Audio_Pointer_V2 pos = ($as_pointer_pos [0]) dims = (256.0, 128.0) relative_scale z = 10
		displaySprite parent = aom_container id = aom_knob_line_1 tex = Options_Audio_Knob_Line pos = ($aom_menu_pos + (63.0, 94.0)) dims = (48.0, 12.0) z = 10 rgba = [230 190 70 255] just = [1.0 0.0]
		displaySprite parent = aom_container id = aom_knob_line_2 tex = Options_Audio_Knob_Line pos = ($aom_menu_pos + (63.0, 263.0)) dims = (48.0, 12.0) z = 10 rgba = [230 190 70 255] just = [1.0 0.0]
		displaySprite parent = aom_container id = aom_knob_line_3 tex = Options_Audio_Knob_Line pos = ($aom_menu_pos + (63.0, 430.0)) dims = (48.0, 12.0) z = 10 rgba = [230 190 70 255] just = [1.0 0.0]
		GetScreenElementProps id = <id>
		text_params = {parent = as_vmenu type = TextElement font = ($audio_settings_menu_font) rgba = ($menu_unfocus_color)}
	endif
	i = 0
	begin
	FormatText checksumname = ping_id 'aom_ping_%d' d = <i>
	displaySprite parent = aom_container id = <ping_id> tex = Options_Audio_Ping alpha = 0 scale = 1 z = 180 just = [center center]
	<i> = (<i> + 1)
	repeat 11
	GetGlobalTags \{user_options}
	FormatText TextName = band_volume_text "%d" d = <band_volume>
	if (<popup>)
		FormatText TextName = text "BAND: %d" d = <band_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{parent = pause_menu_frame_container
			tex = newspaper_circle
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 295.0)
			dims = (58.0, 58.0)
			just = [
				center
				center
			]
			z = 200}
		displaySprite \{parent = pause_menu_frame_container
			id = band_yeller
			tex = newspaper_circle
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 295.0)
			dims = (44.0, 44.0)
			just = [
				center
				center
			]
			z = 201}
		displayText {
			parent = pause_menu_frame_container
			id = band_volume_text_id
			pos = (613.0, 298.0)
			just = [center center]
			rgba = ($menu_unfocus_color)
			z = 202
			scale = 0.8
			font = text_a6
			text = <band_volume_text>
			noshadow
		}
	else
		text = "BAND"
		displayText parent = aom_container id = band_volume_id text = <band_volume_text> pos = ($aom_menu_pos + (130.0, 75.0)) z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps id = aom_knob_line_1 rot_angle = ((<band_volume> / 11.0) * 180.0)
	CreateScreenElement {
		<text_params>
		text = "BAND"
		id = as_band
		pos = (600.0, 32.0)
		event_handlers = [
			{focus menu_audio_settings_focus params = {editing = Band}}
			{unfocus menu_audio_settings_unfocus params = {editing = Band}}
			{pad_choose menu_audio_settings_lock_selection}
			{pad_back menu_audio_settings_press_back}
			{pad_left menu_audio_settings_lower_selection_volume}
			{pad_right menu_audio_settings_increase_selection_volume}
		]
		<exclusive_params>
	}
	FormatText TextName = guitar_volume_text "%d" d = <guitar_volume>
	if (<popup>)
		FormatText TextName = text "GUITAR: %d" d = <guitar_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{parent = pause_menu_frame_container
			tex = HUD_score_nixie_2a
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 365.0)
			dims = (58.0, 58.0)
			just = [
				center
				center
			]
			z = 200}
		displaySprite \{parent = pause_menu_frame_container
			id = guitar_yeller
			tex = newspaper_circle
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 365.0)
			dims = (44.0, 44.0)
			just = [
				center
				center
			]
			z = 201}
		displayText {
			parent = pause_menu_frame_container
			id = guitar_volume_text_id
			pos = (613.0, 368.0)
			just = [center center]
			rgba = ($menu_unfocus_color)
			z = 202
			scale = 0.8
			font = text_a6
			noshadow
			text = <guitar_volume_text>
		}
	else
		displayText parent = aom_container id = guitar_volume_id text = <guitar_volume_text> pos = ($aom_menu_pos + (130.0, 243.0)) z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps id = aom_knob_line_2 rot_angle = ((<guitar_volume> / 11.0) * 180.0)
	CreateScreenElement {
		<text_params>
		text = "GUITAR"
		id = as_guitar
		event_handlers = [
			{focus menu_audio_settings_focus params = {editing = guitar}}
			{unfocus menu_audio_settings_unfocus params = {editing = guitar}}
			{pad_choose menu_audio_settings_lock_selection}
			{pad_back menu_audio_settings_press_back}
			{pad_left menu_audio_settings_lower_selection_volume}
			{pad_right menu_audio_settings_increase_selection_volume}
		]
		<exclusive_params>
	}
	FormatText TextName = sfx_volume_text "%d" d = <sfx_volume>
	if (<popup>)
		FormatText TextName = text "FX: %d" d = <sfx_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{parent = pause_menu_frame_container
			tex = HUD_score_nixie_2a
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 440.0)
			dims = (58.0, 58.0)
			just = [
				center
				center
			]
			z = 200}
		displaySprite \{parent = pause_menu_frame_container
			id = fx_yeller
			tex = newspaper_circle
			rgba = [
				0
				0
				0
				255
			]
			pos = (615.0, 440.0)
			dims = (44.0, 44.0)
			just = [
				center
				center
			]
			z = 201}
		displayText {
			parent = pause_menu_frame_container
			id = fx_volume_text_id
			pos = (613.0, 443.0)
			just = [center center]
			rgba = ($menu_unfocus_color)
			z = 202
			scale = 0.8
			font = text_a6
			text = <sfx_volume_text>
			noshadow
		}
	else
		displayText parent = aom_container id = sfx_volume_id text = <sfx_volume_text> pos = ($aom_menu_pos + (130.0, 409.0)) z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps id = aom_knob_line_3 rot_angle = ((<sfx_volume> / 11.0) * 180.0)
	CreateScreenElement {
		<text_params>
		text = "FX"
		id = as_sfx
		event_handlers = [
			{focus menu_audio_settings_focus params = {editing = sfx}}
			{unfocus menu_audio_settings_unfocus params = {editing = sfx}}
			{pad_choose menu_audio_settings_lock_selection}
			{pad_back menu_audio_settings_press_back}
			{pad_left menu_audio_settings_lower_selection_volume}
			{pad_right menu_audio_settings_increase_selection_volume}
		]
		<exclusive_params>
	}
	if (<popup>)
		GetScreenElementDims \{id = as_band}
		fit_text_in_rectangle id = as_band only_if_larger_x = 1 dims = ((160.0, 0.0) + <Height> * (0.0, 1.0)) start_x_scale = 0.7 start_y_scale = 0.7
		GetScreenElementDims \{id = as_guitar}
		fit_text_in_rectangle id = as_guitar only_if_larger_x = 1 dims = ((160.0, 0.0) + <Height> * (0.0, 1.0)) start_x_scale = 0.7 start_y_scale = 0.7
		GetScreenElementDims \{id = as_sfx}
		fit_text_in_rectangle id = as_sfx only_if_larger_x = 1 dims = ((160.0, 0.0) + <Height> * (0.0, 1.0)) start_x_scale = 0.7 start_y_scale = 0.7
	endif
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

script destroy_audio_settings_menu 
	clean_up_user_control_helpers
	change \{audio_settings_locked = 0}
	change \{as_pointer_index = 0}
	destroy_menu \{menu_id = aom_container}
	destroy_menu \{menu_id = as_scroll}
	destroy_menu \{menu_id = as_highlight_sprite}
	destroy_menu_backdrop
	destroy_pause_menu_frame
endscript

script menu_audio_settings_focus 
	retail_menu_focus
	change audio_settings_editing = <editing>
	last_index = $as_pointer_index
	switch (<editing>)
		case Band
		change \{as_pointer_index = 0}
		if ($as_is_popup)
			SetScreenElementProps id = band_yeller rgba = ($menu_focus_color)
			SetScreenElementProps \{id = band_volume_text_id
				rgba = [
					0
					0
					0
					255
				]}
		endif
		case guitar
		change \{as_pointer_index = 1}
		if ($as_is_popup)
			SetScreenElementProps id = guitar_yeller rgba = ($menu_focus_color)
			SetScreenElementProps \{id = guitar_volume_text_id
				rgba = [
					0
					0
					0
					255
				]}
		endif
		case sfx
		change \{as_pointer_index = 2}
		if ($as_is_popup)
			SetScreenElementProps id = fx_yeller rgba = ($menu_focus_color)
			SetScreenElementProps \{id = fx_volume_text_id
				rgba = [
					0
					0
					0
					255
				]}
		endif
	endswitch
	aom_hilite_knob
	if NOT ($as_is_popup)
		aom_move_pointer last_index = <last_index>
	endif
endscript

script menu_audio_settings_unfocus 
	retail_menu_unfocus
	if ($as_is_popup)
		switch (<editing>)
			case Band
			SetScreenElementProps \{id = band_yeller
				rgba = [
					0
					0
					0
					255
				]}
			SetScreenElementProps id = band_volume_text_id rgba = ($menu_unfocus_color)
			case guitar
			SetScreenElementProps \{id = guitar_yeller
				rgba = [
					0
					0
					0
					255
				]}
			SetScreenElementProps id = guitar_volume_text_id rgba = ($menu_unfocus_color)
			case sfx
			SetScreenElementProps \{id = fx_yeller
				rgba = [
					0
					0
					0
					255
				]}
			SetScreenElementProps id = fx_volume_text_id rgba = ($menu_unfocus_color)
		endswitch
	endif
endscript

script menu_audio_settings_lock_selection 
	if NOT ($audio_settings_locked)
		SoundEvent \{event = ui_sfx_select}
	endif
	GetTags
	LaunchEvent \{type = unfocus
		target = as_vmenu}
	Wait \{1
		gameframe}
	LaunchEvent type = focus target = <id>
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{pad_up menu_audio_settings_increase_volume_guitar_check}
			{pad_down menu_audio_settings_lower_volume_guitar_check}
		]
		replace_handlers
	}
	menu_audio_settings_highlight_item
	change \{audio_settings_locked = 1}
endscript

script menu_audio_settings_press_back 
	SoundEvent \{event = Generic_Menu_Back_SFX}
	GetTags
	LaunchEvent type = unfocus target = <id>
	Wait \{1
		gameframe}
	LaunchEvent \{type = focus
		target = as_vmenu}
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{pad_up null_script}
			{pad_down null_script}
		]
		replace_handlers
	}
	menu_audio_settings_remove_highlight
	change \{audio_settings_locked = 0}
endscript

script ChangeSpinalTapVolume \{spinal_tap_volume_max = 11}
	<spinal_tap_volume> = (<spinal_tap_volume> + <change>)
	if (<spinal_tap_volume> < 0)
		<spinal_tap_volume> = 0
	elseif (<spinal_tap_volume> > <spinal_tap_volume_max>)
		<spinal_tap_volume> = <spinal_tap_volume_max>
	endif
	return volume = <spinal_tap_volume>
endscript

script menu_audio_settings_lower_selection_volume 
	GetGlobalTags \{user_options}
	switch ($audio_settings_editing)
		case Band
		ChangeSpinalTapVolume spinal_tap_volume = <band_volume> change = -1
		SetGlobalTags user_options params = {band_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = band_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = band_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_1 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_band_volume vol = <volume>
		if NOT (<band_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_band_volume_sound
		else
			do_ping = 0
		endif
		case guitar
		ChangeSpinalTapVolume spinal_tap_volume = <guitar_volume> change = -1
		SetGlobalTags user_options params = {guitar_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = guitar_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = guitar_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_2 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_guitar_volume vol = <volume>
		if NOT (<guitar_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_guitar_volume_sound
		else
			do_ping = 0
		endif
		case sfx
		ChangeSpinalTapVolume spinal_tap_volume = <sfx_volume> change = -1
		SetGlobalTags user_options params = {sfx_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = fx_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = sfx_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_3 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_sfx_volume vol = <volume>
		if NOT (<sfx_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_fx_volume_sound
		else
			do_ping = 0
		endif
	endswitch
	if (<do_ping>)
		FormatText \{checksumname = ping_id
			'aom_ping_%d'
			d = $as_ping_index}
		change as_ping_index = ($as_ping_index + 1)
		if ($as_ping_index > 10)
			change \{as_ping_index = 0}
		endif
		RunScriptOnScreenElement id = <ping_id> aom_spawn_ping
	endif
endscript

script menu_audio_settings_increase_selection_volume 
	GetGlobalTags \{user_options}
	switch ($audio_settings_editing)
		case Band
		ChangeSpinalTapVolume spinal_tap_volume = <band_volume> change = 1
		SetGlobalTags user_options params = {band_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = band_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = band_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_1 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_band_volume vol = <volume>
		if NOT (<band_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_band_volume_sound
		else
			do_ping = 0
		endif
		case guitar
		ChangeSpinalTapVolume spinal_tap_volume = <guitar_volume> change = 1
		SetGlobalTags user_options params = {guitar_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = guitar_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = guitar_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_2 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_guitar_volume vol = <volume>
		if NOT (<guitar_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_guitar_volume_sound
		else
			do_ping = 0
		endif
		case sfx
		ChangeSpinalTapVolume spinal_tap_volume = <sfx_volume> change = 1
		SetGlobalTags user_options params = {sfx_volume = <volume>}
		if ($as_is_popup)
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = fx_volume_text_id text = <text>
		else
			FormatText TextName = text "%d" d = <volume>
			SetScreenElementProps id = sfx_volume_id text = <text>
		endif
		SetScreenElementProps id = aom_knob_line_3 rot_angle = ((<volume> / 11.0) * 180.0)
		menu_audio_settings_update_sfx_volume vol = <volume>
		if NOT (<sfx_volume> = <volume>)
			do_ping = 1
			menu_audio_settings_fx_volume_sound
		else
			do_ping = 0
		endif
	endswitch
	if (<do_ping>)
		FormatText \{checksumname = ping_id
			'aom_ping_%d'
			d = $as_ping_index}
		change as_ping_index = ($as_ping_index + 1)
		if ($as_ping_index > 10)
			change \{as_ping_index = 0}
		endif
		RunScriptOnScreenElement id = <ping_id> aom_spawn_ping
	endif
endscript

script menu_audio_settings_increase_volume_guitar_check 
	if IsGuitarController controller = <device_num>
		menu_audio_settings_lower_selection_volume
	else
		menu_audio_settings_increase_selection_volume
	endif
endscript

script menu_audio_settings_lower_volume_guitar_check 
	if IsGuitarController controller = <device_num>
		menu_audio_settings_increase_selection_volume
	else
		menu_audio_settings_lower_selection_volume
	endif
endscript

script menu_audio_settings_highlight_item 
	if NOT ScreenElementExists \{id = as_highlight_sprite}
		GetTags
		GetScreenElementDims id = <id>
		GetScreenElementPosition id = <id> absolute
		if ($as_is_popup = 0)
			<highlight_pos> = (<screenelementpos> + (-0.05, 0.0) * <width> + (0.0, -0.05) * <Height>)
			<highlight_dims> = ((1.1, 0.0) * <width> + (0.0, 0.8) * <Height>)
		else
			<highlight_pos> = (<screenelementpos> + (-5.0, -3.0))
			<highlight_dims> = ((1.0, 0.0) * <width> + (0.0, 1.0) * <Height> + (12.0, 0.0))
		endif
		CreateScreenElement {
			type = SpriteElement
			parent = root_window
			id = as_highlight_sprite
			pos = <highlight_pos>
			dims = <highlight_dims>
			rgba = [210 130 0 125]
			just = [left top]
			z_priority = 99
		}
	endif
endscript

script menu_audio_settings_remove_highlight 
	if ScreenElementExists \{id = as_highlight_sprite}
		DestroyScreenElement \{id = as_highlight_sprite}
	endif
endscript

script menu_audio_settings_get_buss_volume 
	switch <volume>
		case 11
		<vol> = 0
		case 10
		<vol> = -1.2
		case 9
		<vol> = -2.4
		case 8
		<vol> = -3.7
		case 7
		<vol> = -4.9
		case 6
		<vol> = -6.2
		case 5
		<vol> = -8
		case 4
		<vol> = -10
		case 3
		<vol> = -13
		case 2
		<vol> = -17
		case 1
		<vol> = -21
		case 0
		<vol> = -100
	endswitch
	return vol = <vol>
endscript

script menu_audio_settings_update_guitar_volume \{vol = 11}
	menu_audio_settings_get_buss_volume volume = <vol>
	SoundBussUnlock \{User_Guitar}
	SetSoundBussParams {User_Guitar = {vol = <vol>}}
	SoundBussLock \{User_Guitar}
endscript

script menu_audio_settings_update_band_volume \{vol = 11}
	menu_audio_settings_get_buss_volume volume = <vol>
	SoundBussUnlock \{User_Band}
	SetSoundBussParams {User_Band = {vol = <vol>}}
	SoundBussLock \{User_Band}
endscript

script menu_audio_settings_update_sfx_volume \{vol = 11}
	printf "Got vol = %v" v = <vol>
	menu_audio_settings_get_buss_volume volume = <vol>
	printf "Got vol-post = %v" v = <vol>
	SoundBussUnlock \{User_Sfx}
	printf channel = sfx "setting user_sfx to %s " s = <vol>
	SetSoundBussParams {User_Sfx = {vol = <vol>}}
	SoundBussLock \{User_Sfx}
endscript

script aom_move_pointer 
	if NOT ($as_pointer_index = <last_index>)
		if (<last_index> < $as_pointer_index)
			middle_pos = (($as_pointer_pos [$as_pointer_index]) + (-80.0, 85.0))
		else
			middle_pos = (($as_pointer_pos [$as_pointer_index]) + (-80.0, -85.0))
		endif
		doScreenElementMorph id = aom_pointer pos = <middle_pos> scale = ($as_pointer_scale / 2.0) time = 0.1 relative_scale
		Wait \{0.1
			seconds}
		doScreenElementMorph id = aom_pointer pos = ($as_pointer_pos [$as_pointer_index]) scale = $as_pointer_scale time = 0.1 relative_scale
		Wait \{0.1
			seconds}
		<last_index> = $as_pointer_index
	endif
endscript

script aom_hilite_knob 
	switch ($as_pointer_index)
		case 0
		SetScreenElementProps \{id = aom_knob_line_1
			rgba = [
				230
				190
				70
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = band_volume_id
				rgba = [
					230
					190
					70
					255
				]}
		endif
		SetScreenElementProps \{id = aom_knob_line_2
			rgba = [
				150
				150
				150
				255
			]}
		SetScreenElementProps \{id = aom_knob_line_3
			rgba = [
				150
				150
				150
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = guitar_volume_id
				rgba = [
					150
					150
					150
					255
				]}
			SetScreenElementProps \{id = sfx_volume_id
				rgba = [
					150
					150
					150
					255
				]}
		endif
		case 1
		SetScreenElementProps \{id = aom_knob_line_2
			rgba = [
				230
				190
				70
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = guitar_volume_id
				rgba = [
					230
					190
					70
					255
				]}
		endif
		SetScreenElementProps \{id = aom_knob_line_1
			rgba = [
				150
				150
				150
				255
			]}
		SetScreenElementProps \{id = aom_knob_line_3
			rgba = [
				150
				150
				150
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = band_volume_id
				rgba = [
					150
					150
					150
					255
				]}
			SetScreenElementProps \{id = sfx_volume_id
				rgba = [
					150
					150
					150
					255
				]}
		endif
		case 2
		SetScreenElementProps \{id = aom_knob_line_3
			rgba = [
				230
				190
				70
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = sfx_volume_id
				rgba = [
					230
					190
					70
					255
				]}
		endif
		SetScreenElementProps \{id = aom_knob_line_1
			rgba = [
				150
				150
				150
				255
			]}
		SetScreenElementProps \{id = aom_knob_line_2
			rgba = [
				150
				150
				150
				255
			]}
		if NOT ($as_is_popup)
			SetScreenElementProps \{id = band_volume_id
				rgba = [
					150
					150
					150
					255
				]}
			SetScreenElementProps \{id = guitar_volume_id
				rgba = [
					150
					150
					150
					255
				]}
		endif
	endswitch
endscript

script aom_spawn_ping \{time = 0.25}
	GetTags
	if NOT ($as_is_popup)
		switch ($audio_settings_editing)
			case Band
			pos = ($aom_menu_pos + (145.0, 96.0))
			case guitar
			pos = ($aom_menu_pos + (145.0, 266.0))
			case sfx
			pos = ($aom_menu_pos + (145.0, 436.0))
		endswitch
	else
		switch ($audio_settings_editing)
			case Band
			pos = (725.0, 295.0)
			case guitar
			pos = (825.0, 365.0)
			case sfx
			pos = (725.0, 440.0)
		endswitch
	endif
	<id> :DoMorph scale = 1 pos = <pos> alpha = 1
	<id> :DoMorph scale = 5 alpha = 0 time = <time>
	if NOT ($as_is_popup)
		<center_belly_pos> = (744.0, 146.0)
		<left_belly_pos> = (724.0, 146.0)
		<right_belly_pos> = (764.0, 146.0)
		<jiggle_time> = 0.05
		begin
		doScreenElementMorph id = aom_belly_strings pos = <left_belly_pos> time = <jiggle_time>
		Wait <jiggle_time> seconds
		doScreenElementMorph id = aom_belly_strings pos = <center_belly_pos> time = <jiggle_time>
		Wait <jiggle_time> seconds
		doScreenElementMorph id = aom_belly_strings pos = <right_belly_pos> time = <jiggle_time>
		Wait <jiggle_time> seconds
		doScreenElementMorph id = aom_belly_strings pos = <center_belly_pos> time = <jiggle_time>
		<left_belly_pos> = (<left_belly_pos> + (3.33, 0.0))
		<right_belly_pos> = (<right_belly_pos> + (-3.33, 0.0))
		repeat 6
	endif
endscript
