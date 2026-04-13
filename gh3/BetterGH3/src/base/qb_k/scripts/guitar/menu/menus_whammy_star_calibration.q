g_spc_check_pow_bool = 1
g_spc_whammy_is_popup = 0
g_spc_sp_is_popup = 0
SHOULD_WE_PLAY_WHAMMY_SOUND = 1

script create_whammy_bar_calibration_menu \{controller = 0
		popup = 0}
	if iswinport
		if (<popup> = 1)
			kill_start_key_binding
		endif
	else
		kill_start_key_binding
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = wbc_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	if (<popup>)
		change \{g_spc_whammy_is_popup = 1}
		controller = ($last_start_pressed_device)
		<z> = 100
	else
		change \{g_spc_whammy_is_popup = 0}
		<z> = 2
	endif
	if NOT (<popup>)
		create_menu_backdrop \{texture = Venue_BG}
		CreateScreenElement \{type = SpriteElement
			parent = wbc_container
			id = wbc_light_overlay
			texture = venue_overlay
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			z_priority = 99}
	endif
	displaySprite {
		id = wbc_poster_1
		parent = wbc_container
		tex = Options_Whammy_Poster_1
		pos = (286.0, 15.0)
		dims = (896.0, 896.0)
		rot_angle = -2
		z = <z>
	}
	displaySprite {
		id = wbc_poster_2
		parent = wbc_container
		tex = Options_Whammy_Poster_2
		pos = (286.0, 15.0)
		dims = (896.0, 896.0)
		rot_angle = -2
		z = (<z> - 1)
	}
	if NOT (<popup>)
		displaySprite {
			parent = wbc_container
			tex = Toprockers_Tape_1
			pos = (1010.0, 450.0)
			dims = (192.0, 92.0)
			z = (<z> + 1)
			flip_v
			rot_angle = 90
		}
		displaySprite {
			parent = wbc_container
			tex = toprockers_tape_2
			pos = (350.0, 200.0)
			z = (<z> + 1)
			rot_angle = 90
			dims = (192.0, 92.0)
			flip_v
			flip_h
		}
	endif
	text_block_scale = 0.65000004
	text_block_type_scale = 0.8
	text_block_1_pos = (630.0, 70.0)
	text_block_1_dims = (910.0, 200.0)
	text_block_2_pos = (650.0, 140.0)
	text_block_2_dims = (840.0, 100.0)
	text_block_3_pos = (750.0, 195.0)
	text_block_3_dims = (525.0, 300.0)
	<text_1> = "와미 바를 완전히 누른 뒤 서서히 기본 위치로 돌려 놓으십시오."
	button_color = "녹색"
	GetEnterButtonAssignment
	if (<assignment> = circle)
		button_color = "빨간색"
	endif
	FormatText textname = text_2 "이 위치로 조정하려면 %a 단추를 누르십시오." a = <button_color>
	<text_3> = "와미 바를 기본 위치로 돌려 놓을 때 마다 \\c1''기본 위치 조정됨'' \\c0이라는 메세지가 나올 때까지 작업을 반복하십시오."
	CreateScreenElement {
		type = TextBlockElement
		font = text_a3
		pos = <text_block_1_pos>
		parent = wbc_container
		text = <text_1>
		rgba = [0 0 0 255]
		z_priority = (<z> + 1)
		dims = <text_block_1_dims>
		just = [center top]
		internal_just = [left top]
		scale = <text_block_scale>
		internal_scale = <text_block_type_scale>
		rot_angle = -2
		line_spacing = 0.8
	}
	CreateScreenElement {
		type = TextBlockElement
		font = text_a3
		pos = <text_block_2_pos>
		parent = wbc_container
		text = <text_2>
		rgba = [220 220 220 255]
		z_priority = (<z> + 1)
		dims = <text_block_2_dims>
		just = [center top]
		internal_just = [left top]
		scale = <text_block_scale>
		internal_scale = <text_block_type_scale>
		rot_angle = -3
		line_spacing = 0.8
	}
	CreateScreenElement {
		type = TextBlockElement
		font = text_a3
		pos = <text_block_3_pos>
		parent = wbc_container
		text = <text_3>
		rgba = [0 0 0 255]
		z_priority = (<z> + 1)
		dims = <text_block_3_dims>
		just = [center top]
		internal_just = [left top]
		scale = <text_block_scale>
		internal_scale = <text_block_type_scale>
		rot_angle = -2
		line_spacing = 0.8
	}
	CreateScreenElement {
		type = TextElement
		font = text_a5
		pos = (760.0, 315.0)
		parent = wbc_container
		text = "조정"
		rgba = [220 220 220 255]
		z_priority = (<z> + 1)
		just = [center top]
		scale = 1.6
		rot_angle = -4
	}
	CreateScreenElement {
		type = TextElement
		font = text_a5
		pos = (800.0, 365.0)
		parent = wbc_container
		text = "와미"
		rgba = [220 220 220 255]
		z_priority = (<z> + 1)
		just = [center top]
		scale = 1.6
		rot_angle = -4
	}
	CreateScreenElement {
		type = TextBlockElement
		font = text_a3
		rgba = [140 235 170 255]
		pos = (810.0, 408.0)
		text = "기본 위치 조정됨"
		just = [center top]
		internal_just = [center center]
		dims = (400.0, 200.0)
		scale = 0.6
		line_spacing = 0.8
		parent = wbc_container
		z_priority = (<z> + 2)
		rot_angle = -4
		id = resting_message
		font_spacing = 50
		space_spacing = 20
		shadow
		shadow_offs = (2.0, 2.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{pad_choose menu_whammy_bar_calibration_enter_sample}
			{pad_back ui_flow_manager_respond_to_action Params = {action = go_back}}
		]
		exclusive_device = <controller>
	}
	LaunchEvent \{type = focus
		target = resting_message}
	spawnscriptnow menu_whammy_bar_update_resting_message Params = {controller = <controller>}
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
	add_user_control_helper text = "선택" button = green z = (<z> + 100)
	add_user_control_helper text = "뒤로" button = red z = (<z> + 100)
endscript

script destroy_whammy_bar_calibration_menu 
	if iswinport
		if ($g_spc_whammy_is_popup = 1)
			restore_start_key_binding
		endif
	else
		restore_start_key_binding
	endif
	killspawnedscript \{name = menu_whammy_bar_update_resting_message}
	destroy_menu \{menu_id = wbc_container}
	clean_up_user_control_helpers
	if NOT ($g_spc_whammy_is_popup)
		destroy_menu_backdrop
	endif
endscript

script menu_whammy_bar_calibration_enter_sample 
	if guitargetanalogueinfo controller = <device_num>
		if (<rightx> = 0)
			<rightx> = 0.0001
		elseif (<rightx> = 1)
			<rightx> = 0.9998999
		endif
		switch (<device_num>)
			case 0
			SetGlobalTags user_options Params = {resting_whammy_position_device_0 = <rightx>}
			case 1
			SetGlobalTags user_options Params = {resting_whammy_position_device_1 = <rightx>}
			case 2
			SetGlobalTags user_options Params = {resting_whammy_position_device_2 = <rightx>}
			case 3
			SetGlobalTags user_options Params = {resting_whammy_position_device_3 = <rightx>}
			case 4
			SetGlobalTags user_options Params = {resting_whammy_position_device_4 = <rightx>}
			case 5
			SetGlobalTags user_options Params = {resting_whammy_position_device_5 = <rightx>}
			case 6
			SetGlobalTags user_options Params = {resting_whammy_position_device_6 = <rightx>}
		endswitch
		if (<device_num> = $player1_status.controller)
			get_resting_whammy_position controller = <device_num>
			change structurename = player1_status resting_whammy_position = <resting_whammy_position>
		else
			if (<device_num> = $player2_status.controller)
				get_resting_whammy_position controller = <device_num>
				change structurename = player2_status resting_whammy_position = <resting_whammy_position>
			endif
		endif
	endif
endscript

script menu_whammy_bar_update_resting_message 
	begin
	if is_whammy_resting controller = <controller>
		if ($SHOULD_WE_PLAY_WHAMMY_SOUND = 0)
			soundevent \{event = Whammy_Test_SFX}
			change \{SHOULD_WE_PLAY_WHAMMY_SOUND = 1}
		endif
		SetScreenElementProps \{id = resting_message
			unhide}
		SetScreenElementProps \{id = wbc_poster_1
			alpha = 1}
	else
		change \{SHOULD_WE_PLAY_WHAMMY_SOUND = 0}
		SetScreenElementProps \{id = resting_message
			hide}
		menu_whammy_bar_do_poster_morph controller = <controller>
	endif
	Wait \{1
		GameFrame}
	repeat
endscript

script menu_whammy_bar_do_poster_morph 
	if guitargetanalogueinfo controller = <controller>
		if (<rightx> >= 0)
			SetScreenElementProps id = wbc_poster_1 alpha = ((1 - <rightx>) * 0.5)
		else
			SetScreenElementProps id = wbc_poster_1 alpha = ((0.5 * (<rightx> * -1)) + 0.5)
		endif
	endif
endscript

script create_star_power_trigger_calibration_menu \{controller = 0
		popup = 0}
	kill_start_key_binding
	CreateScreenElement \{id = spc_container
		type = ContainerElement
		parent = root_window
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	if (<popup>)
		<z> = 100
		controller = ($last_start_pressed_device)
	else
		<z> = -4
	endif
	if NOT (<popup>)
		create_menu_backdrop \{texture = Options_Calibrate_Starpower_Posterwall}
	else
		displaySprite \{parent = spc_container
			tex = Options_Calibrate_Starpower_Posterwall
			pos = (0.0, 0.0)
			dims = (1280.0, 720.0)
			z = 107}
	endif
	displaySprite {
		parent = spc_container
		tex = Options_Calibrate_Starpower_BG
		pos = (326.0, 0.0)
		dims = (512.0, 512.0)
		rot_angle = -2
		z = <z>
	}
	displaySprite {
		id = spc_rotating_bg_lines
		parent = spc_container
		tex = Options_Calibrate_Starpower_BG2
		pos = (578.0, 156.0)
		dims = (640.0, 640.0)
		just = [center center]
		rot_angle = 25
		z = (<z> + 1)
	}
	displaySprite {
		id = spc_rotating_bg_planes
		parent = spc_container
		tex = Options_Calibrate_Starpower_BG3
		pos = (568.0, 114.0)
		dims = (512.0, 384.0)
		just = [center center]
		rot_angle = 20
		z = (<z> + 2)
	}
	if english
		starpower_pow_tex = Options_Calibrate_Starpower_Pow
	elseif french
		starpower_pow_tex = options_calibrate_starpower_pow_fr
	elseif Spanish
		starpower_pow_tex = options_calibrate_starpower_pow_sp
	elseif German
		starpower_pow_tex = options_calibrate_starpower_pow_de
	elseif italian
		starpower_pow_tex = options_calibrate_starpower_pow_fr
	elseif Korean
		starpower_pow_tex = Options_Calibrate_Starpower_Pow
	endif
	displaySprite {
		id = spc_pow
		parent = spc_container
		tex = <starpower_pow_tex>
		pos = (0.0, 0.0)
		scale = 1.0
		relative_scale
		z = (<z> + 3)
	}
	SetScreenElementProps id = <id> hide
	button_color = "녹색"
	GetEnterButtonAssignment
	if (<assignment> = circle)
		button_color = "빨간색"
	endif
	FormatText textname = element_text "스타의 힘이 작동하길 원하시는 부분까지 기타를 들어 올리시고 %a 단추를 눌러 값을 지정하십시오." a = <button_color>
	CreateScreenElement {
		type = TextBlockElement
		id = star_calibration_text
		parent = spc_container
		font = text_a6
		pos = (608.0, 520.0)
		just = [center top]
		internal_just = [left top]
		line_spacing = 0.85
		dims = (940.0, 300.0)
		scale = (0.5, 0.65000004)
		rgba = [225 200 120 255]
		text = <element_text>
		event_handlers = [
			{pad_choose menu_star_power_trigger_enter_position Params = {controller = <controller>}}
			{pad_back ui_flow_manager_respond_to_action Params = {action = go_back}}
		]
		z_priority = (<z> + 6.1)
		rot_angle = -2
	}
	LaunchEvent \{type = focus
		target = star_calibration_text}
	spawnscriptnow menu_star_power_trigger_pow_check Params = {controller = <controller>}
	add_user_control_helper \{text = "선택"
		button = green
		z = 110}
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 110}
endscript

script destroy_star_power_trigger_calibration_menu 
	restore_start_key_binding
	destroy_menu \{menu_id = spc_container}
	clean_up_user_control_helpers
	killspawnedscript \{name = menu_star_power_trigger_pow_check}
	destroy_menu_backdrop
endscript

script menu_star_power_trigger_pow_check 
	begin
	if guitargetanalogueinfo controller = <controller>
		<spc_v_dist> = <RightY>
		if (<spc_v_dist> > 0)
			<spc_v_dist> = 0
		endif
		GetGlobalTags \{user_options}
		if (<controller> = $player1_status.controller)
			if (<lefty_flip_p1> = 1)
				<line_rot> = (25.0 -30.0 * ((<spc_v_dist>) * -1))
			else
				<line_rot> = (25.0 -30.0 * <spc_v_dist>)
			endif
		else
			if (<lefty_flip_p2> = 1)
				<line_rot> = (25.0 -30.0 * ((<spc_v_dist>) * -1))
			else
				<line_rot> = (25.0 -30.0 * <spc_v_dist>)
			endif
		endif
		SetScreenElementProps id = spc_rotating_bg_lines rot_angle = <line_rot>
		SetScreenElementProps id = spc_rotating_bg_planes rot_angle = (<line_rot> - 5.0)
		get_star_power_position controller = <controller>
		<spc_pos_dev> = <star_power_position>
		Wait \{0.05
			seconds}
		if (<spc_v_dist> <= <spc_pos_dev>)
			if ($g_spc_check_pow_bool = 1)
				soundevent \{event = POW_SFX}
				<spc_pow_rand_x> = 0
				<spc_pow_rand_y> = 0
				<spc_pow_rand_scale> = 0
				<spc_pow_rand_rot> = 0
				GetRandomValue \{name = spc_pow_rand_x
					Integer
					a = 380
					b = 470}
				GetRandomValue \{name = spc_pow_rand_y
					Integer
					a = 50
					b = 80}
				GetRandomValue \{name = spc_pow_rand_scale
					a = 0.6
					b = 1.0}
				GetRandomValue \{name = spc_pow_rand_rot
					a = -3.0
					b = 3.0}
				SetScreenElementProps {
					id = spc_pow
					unhide
					pos = (((1.0, 0.0) * <spc_pow_rand_x>) + ((0.0, 1.0) * <spc_pow_rand_y>))
					rot_angle = <spc_pow_rand_rot>
					scale = <spc_pow_rand_scale>
					relative_scale
				}
				change \{g_spc_check_pow_bool = 0}
			endif
		else
			SetScreenElementProps \{id = spc_pow
				hide}
			change \{g_spc_check_pow_bool = 1}
		endif
	else
		Wait \{0.05
			seconds}
	endif
	repeat
endscript

script menu_star_power_trigger_enter_position 
	if guitargetanalogueinfo controller = <device_num>
		if (<RightY> > 0)
			<RightY> = 0
		endif
		switch (<device_num>)
			case 0
			SetGlobalTags user_options Params = {star_power_position_device_0 = <RightY>}
			soundevent \{event = POW_SFX}
			case 1
			SetGlobalTags user_options Params = {star_power_position_device_1 = <RightY>}
			soundevent \{event = POW_SFX}
			case 2
			SetGlobalTags user_options Params = {star_power_position_device_2 = <RightY>}
			soundevent \{event = POW_SFX}
			case 3
			SetGlobalTags user_options Params = {star_power_position_device_3 = <RightY>}
			soundevent \{event = POW_SFX}
		endswitch
		if (<device_num> = $player1_status.controller)
			get_star_power_position controller = <device_num>
			change structurename = player1_status star_tilt_threshold = <star_power_position>
		else
			if (<device_num> = $player2_status.controller)
				get_star_power_position controller = <device_num>
				change structurename = player2_status star_tilt_threshold = <star_power_position>
			endif
		endif
	endif
endscript

script create_guitar_diagnostic_menu 
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = gd_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = SpriteElement
		parent = gd_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		dims = (1280.0, 1024.0)
		rgba = [
			80
			80
			80
			255
		]
		z_priority = -1}
	font = text_a4
	text_params = {type = TextElement parent = gd_container font = <font> just = [left top]}
	CreateScreenElement {
		<text_params>
		id = title_text
		text = "기타 정보"
		pos = (540.0, 100.0)
	}
	CreateScreenElement {
		<text_params>
		id = leftx
		text = "왼쪽 X"
		pos = (580.0, 200.0)
	}
	CreateScreenElement {
		<text_params>
		id = rightx
		text = "오른쪽 X"
		pos = (580.0, 240.0)
	}
	CreateScreenElement {
		<text_params>
		id = lefty
		text = "왼쪽 Y"
		pos = (580.0, 280.0)
	}
	CreateScreenElement {
		<text_params>
		id = RightY
		text = "오른쪽 Y"
		pos = (580.0, 320.0)
	}
	CreateScreenElement {
		<text_params>
		id = leftlength
		text = "왼쪽 길이"
		pos = (580.0, 360.0)
	}
	CreateScreenElement {
		<text_params>
		id = rightlength
		text = "오른쪽 길이"
		pos = (580.0, 400.0)
	}
	CreateScreenElement {
		<text_params>
		id = lefttrigger
		text = "왼쪽 트리거"
		pos = (580.0, 440.0)
	}
	CreateScreenElement {
		<text_params>
		id = righttrigger
		text = "오른쪽 트리거"
		pos = (580.0, 480.0)
	}
	CreateScreenElement {
		<text_params>
		id = VerticalDist
		text = "수직 거리"
		pos = (580.0, 520.0)
	}
	spawnscriptnow \{update_guitar_diagnostic_menu}
endscript

script destroy_guitar_diagnostic_menu 
	killspawnedscript \{name = update_guitar_diagnostic_menu}
	destroy_menu \{menu_id = gd_container}
endscript

script update_guitar_diagnostic_menu 
	begin
	if guitargetanalogueinfo \{controller = 0}
		FormatText textname = leftxtext "왼쪽 X - %v" v = <leftx>
		FormatText textname = rightxtext "와미 위치 - %v" v = <rightx>
		FormatText textname = leftytext "왼쪽 Y - %v" v = <lefty>
		FormatText textname = rightytext "오른쪽 Y - %v" v = <RightY>
		FormatText textname = leftlengthtext "왼쪽 길이 - %v" v = <leftlength>
		FormatText textname = rightlengthtext "오른쪽 길이 - %v" v = <rightlength>
		FormatText textname = lefttriggertext "왼쪽 트리거 - %v" v = <lefttrigger>
		FormatText textname = righttriggertext "오른쪽 트리거 - %v" v = <righttrigger>
		FormatText textname = verticaldisttext "수직 방향 - %v" v = <VerticalDist>
		SetScreenElementProps id = leftx text = <leftxtext>
		SetScreenElementProps id = rightx text = <rightxtext>
		SetScreenElementProps id = lefty text = <leftytext>
		SetScreenElementProps id = RightY text = <rightytext>
		SetScreenElementProps id = leftlength text = <leftlengthtext>
		SetScreenElementProps id = rightlength text = <rightlengthtext>
		SetScreenElementProps id = lefttrigger text = <lefttriggertext>
		SetScreenElementProps id = righttrigger text = <righttriggertext>
		SetScreenElementProps id = VerticalDist text = <verticaldisttext>
	endif
	Wait \{1
		GameFrame}
	repeat
endscript
