loginTextColor = [
	255
	200
	0
	255
]
gPrivateMatchId = 0

script create_winport_connection_status_screen 
	printf \{"--- create_winport_connection_status_screen"}
	create_menu_backdrop \{texture = online_background}
	z = 110
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = connectionStatusContainer
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = connectionStatusContainer
		just = [
			center
			top
		]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1}
	menu_id = <id>
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound Params = {up}}
			{pad_down generic_menu_up_or_down_sound Params = {down}}
			{pad_back cancel_winport_connection_status_screen}
		]
	}
	vmenu_id = <id>
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
	create_pause_menu_frame \{parent = connectionStatusContainer
		z = 5}
	displaySprite \{parent = connectionStatusContainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = connectionStatusContainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = TextElement
		parent = connectionStatusContainer
		font = fontgrid_title_gh3
		scale = 1.2
		rgba = [
			223
			223
			223
			250
		]
		text = "온라인"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 182.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = connectionStatusContainer
		id = statusmessage
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = <z>
		pos = (640.0, 310.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	if NOT (netsessionfunc func = IsConnected)
		add_user_control_helper \{text = "취소"
			button = red
			z = 100}
		LaunchEvent type = focus target = <vmenu_id>
		netsessionfunc \{func = onlinesignin}
		begin
		netsessionfunc \{func = getnetworkstatus}
		switch (<currentnetworktask>)
			case "START_NETWORK"
			switch (<currentnetworkstatus>)
				case "PENDING"
				statustext = "온라인 서비스 초기화 중"
				case "DONE"
				statustext = "온라인 서비스 준비 완료"
				case "FAILED"
				statustext = "온라인 서비스를 초기화할 수 없습니다."
				success = false
				default
				statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
				success = false
			endswitch
			case "CHECK_DNS"
			switch (<currentnetworkstatus>)
				case "PENDING"
				statustext = "게임 서버 찾는 중"
				case "DONE"
				statustext = "게임 서버 찾기 성공"
				success = true
				case "FAILED"
				statustext = "게임 서버를 찾을 수 없습니다."
				success = false
				default
				statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
				success = false
			endswitch
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		SetScreenElementProps id = statusmessage text = <statustext>
		fit_text_into_menu_item \{id = statusmessage
			max_width = 480}
		if GotParam \{success}
			clean_up_user_control_helpers
			if (<success> = false)
				add_user_control_helper \{text = "뒤로"
					button = red
					z = 100}
				return
			endif
			break
		endif
		Wait \{1
			frame}
		if NOT (ScreenElementExists id = connectionStatusContainer)
			return
		endif
		repeat
	endif
	if NOT (netsessionfunc func = hasexistinglogin)
		SetScreenElementProps \{id = statusmessage
			text = "로그인 정보를 찾을 수 없습니다.\\n새 계정을 생성하거나 기존의 계정을 사용하시겠습니까?"}
		fit_text_into_menu_item \{id = statusmessage
			max_width = 480}
		displaySprite \{parent = connectionStatusContainer
			id = options_bg_1
			tex = dialog_bg
			pos = (640.0, 500.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				botom
			]}
		displaySprite \{parent = connectionStatusContainer
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
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (100.0, 50.0)
			event_handlers = [
				{focus net_warning_focus}
				{unfocus net_warning_unfocus}
				{pad_choose start_winport_account_create_screen}
				{pad_back cancel_winport_connection_status_screen}
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
			text = "새 계정 만들기"
			just = [center top]
			z_priority = (<z> + 0.1)
		}
		fit_text_into_menu_item id = <id> max_width = 200
		GetScreenElementDims id = <id>
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_left
			texture = dialog_highlight
			alpha = 0.0
			just = [right center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_right
			texture = dialog_highlight
			alpha = 0.0
			just = [left center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
		}
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (100.0, 50.0)
			event_handlers = [
				{focus net_warning_focus}
				{unfocus net_warning_unfocus}
				{pad_choose start_winport_account_login_screen}
				{pad_back cancel_winport_connection_status_screen}
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
			text = "기존 계정"
			just = [center top]
			z_priority = (<z> + 0.1)
		}
		fit_text_into_menu_item id = <id> max_width = 200
		GetScreenElementDims id = <id>
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_left
			texture = dialog_highlight
			alpha = 0.0
			just = [right center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_right
			texture = dialog_highlight
			alpha = 0.0
			just = [left center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
		}
		add_user_control_helper \{text = "선택"
			button = green
			z = 100}
		add_user_control_helper \{text = "뒤로"
			button = red
			z = 100}
		add_user_control_helper \{text = "위/아래"
			button = strumbar
			z = 100}
		LaunchEvent type = focus target = <vmenu_id>
		return
	endif
	if NOT (netsessionfunc func = IsLoggedIn)
		ui_flow_manager_respond_to_action \{action = account_login}
	endif
	ui_flow_manager_respond_to_action \{action = goto_online_menu}
endscript

script destroy_winport_connection_status_screen 
	DestroyScreenElement \{id = connectionStatusContainer}
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script cancel_winport_connection_status_screen 
	netsessionfunc \{func = ResetNetwork}
	ui_flow_manager_respond_to_action \{action = back}
endscript

script create_winport_account_create_screen 
	create_winport_account_management_screen \{mode = createAccount
		title = "계정 생성"
		container = accountCreateContainer}
endscript

script destroy_winport_account_create_screen 
	destroy_winport_account_management_screen \{container = accountCreateContainer}
endscript

script start_winport_account_create_screen 
	ui_flow_manager_respond_to_action \{action = account_create}
endscript

script create_winport_account_login_screen 
	netsessionfunc \{func = getautologinsetting}
	if (<autologinsetting> = autologinon && netsessionfunc func = hasexistinglogin)
		netsessionfunc \{func = InitializeLoginFields
			Params = {
				loginMode = loginAccount
			}}
		ui_flow_manager_respond_to_action \{action = executeLogin}
	else
		create_winport_account_management_screen \{mode = loginAccount
			title = "계정 로그인"
			container = accountLoginContainer
			yellowButtonText = "비밀번호 변경"
			yellowButtonAction = start_winport_account_change_screen
			blueButtonText = "새 계정 만들기"
			blueButtonAction = start_winport_account_create_screen}
	endif
endscript

script destroy_winport_account_login_screen 
	destroy_winport_account_management_screen \{container = accountLoginContainer}
endscript

script start_winport_account_login_screen 
	ui_flow_manager_respond_to_action \{action = account_login}
endscript

script create_winport_account_change_screen 
	create_winport_account_management_screen \{mode = changeAccount
		title = "비밀번호 변경"
		container = accountChangeContainer
		yellowButtonText = "비밀번호 초기화"
		yellowButtonAction = start_winport_account_reset_screen}
endscript

script destroy_winport_account_change_screen 
	destroy_winport_account_management_screen \{container = accountChangeContainer}
endscript

script start_winport_account_change_screen 
	ui_flow_manager_respond_to_action \{action = account_change}
endscript

script create_winport_account_reset_screen 
	create_winport_account_management_screen \{mode = resetAccount
		title = "비밀번호 초기화"
		container = accountResetContainer
		yellowButtonText = "계정 삭제"
		yellowButtonAction = start_winport_account_delete_screen}
endscript

script destroy_winport_account_reset_screen 
	destroy_winport_account_management_screen \{container = accountResetContainer}
endscript

script start_winport_account_reset_screen 
	ui_flow_manager_respond_to_action \{action = account_reset}
endscript

script create_winport_account_delete_screen 
	create_winport_account_management_screen \{mode = deleteAccount
		title = "계정 삭제"
		container = accountDeleteContainer}
endscript

script destroy_winport_account_delete_screen 
	destroy_winport_account_management_screen \{container = accountDeleteContainer}
endscript

script start_winport_account_delete_screen 
	ui_flow_manager_respond_to_action \{action = account_delete}
endscript

script create_change_password_submenu 
	create_winport_account_management_screen \{mode = changeAccount
		title = "비밀번호 변경"
		container = accountChangeContainer
		yellowButtonAction = winport_null_action}
endscript

script destroy_change_password_submenu 
	destroy_winport_account_management_screen \{container = accountChangeContainer}
endscript

script create_account_delete_submenu 
	create_winport_account_management_screen \{mode = deleteAccount
		title = "계정 삭제"
		container = accountDeleteSubmenuContainer
		yellowButtonAction = winport_null_action}
endscript

script destroy_account_delete_submenu 
	destroy_winport_account_management_screen \{container = accountDeleteSubmenuContainer}
endscript

script winport_null_action 
endscript

script create_winport_account_management_screen 
	printf \{"--- create_winport_account_management_screen"}
	z = 110
	create_menu_backdrop \{texture = online_background}
	if ((GotParam yellowButtonAction) && (GotParam blueButtonAction))
		Handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = executeLogin}}
			{pad_option2 <yellowButtonAction>}
			{pad_option <blueButtonAction>}
			{pad_back cancel_winport_account_management_screen Params = {mode = <mode>}}
		]
	elseif (GotParam yellowButtonAction)
		Handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = executeLogin}}
			{pad_option2 <yellowButtonAction>}
			{pad_back cancel_winport_account_management_screen Params = {mode = <mode>}}
		]
	elseif (GotParam blueButtonAction)
		Handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = executeLogin}}
			{pad_option <blueButtonAction>}
			{pad_back cancel_winport_account_management_screen Params = {mode = <mode>}}
		]
	else
		Handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = executeLogin}}
			{pad_back cancel_winport_account_management_screen Params = {mode = <mode>}}
		]
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = <container>
		pos = (0.0, 0.0)
		event_handlers = <Handlers>
	}
	netsessionfunc func = InitializeLoginFields Params = {loginMode = <mode>}
	displaySprite parent = <container> tex = dialog_title_bg dims = (300.0, 230.0) z = 9 pos = (640.0, 40.0) just = [right top] flip_v
	displaySprite parent = <container> tex = dialog_title_bg dims = (300.0, 230.0) z = 9 pos = (640.0, 40.0) just = [left top]
	CreateScreenElement {
		type = TextElement
		parent = <container>
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = [223 223 223 250]
		text = <title>
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 125.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	fit_text_in_rectangle id = <id> dims = (400.0, 75.0) pos = (640.0, 125.0) only_if_larger_x = 1 only_if_larger_y = 1 just = center
	CreateScreenElement {
		type = TextElement
		parent = <container>
		id = capsLockField
		font = text_a4
		scale = 0.6
		rgba = [255 0 0 255]
		text = "(Caps Lock이 켜져있음)"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 530.0)
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = <container>
		font = text_a4
		scale = 0.6
		rgba = [180 180 180 255]
		text = "온라인으로 플레이할 때는 게임 내용이 달라질 수 있습니다."
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 560.0)
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = <container>
		font = text_a4
		scale = 1.0
		rgba = [180 180 180 255]
		text = "*계정 정보를 입력할 때에는 키보드를 사용해주십시오.*"
		just = [center top]
		z_priority = 10.0
		pos = (640.0, 595.0)
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [0 0 0 255]
	}
	fit_text_in_rectangle id = <id> dims = (600.0, 25.0) pos = (640.0, 595.0) only_if_larger_x = 1 only_if_larger_y = 1 just = center keep_ar = 1
	<pos> = (375.0, 290.0)
	create_winport_login_field container = <container> pos = <pos> label = "사용자 이름:" labelId = usernameLabelId prefixId = usernamePrefixId cursorId = usernameCursorId suffixId = usernameSuffixId ang = -2.0
	GetScreenElementDims \{id = usernameLabelId}
	lineHeight = (<height> + 8)
	if (<mode> = loginAccount || <mode> = deleteAccount || <mode> = changeAccount)
		pos = (<pos> + ((0.0, 1.0) * <lineHeight>))
		create_winport_login_field container = <container> pos = <pos> label = "비밀번호:" labelId = passwordLabelId prefixId = passwordPrefixId cursorId = passwordCursorId suffixId = passwordSuffixId ang = 0.2
	endif
	if (<mode> = createAccount || <mode> = changeAccount || <mode> = resetAccount)
		pos = (<pos> + ((0.0, 1.0) * <lineHeight>))
		create_winport_login_field container = <container> pos = <pos> label = "새 비밀번호:" labelId = newPassword1LabelId prefixId = newPassword1PrefixId cursorId = newPassword1CursorId suffixId = newPassword1SuffixId ang = -0.6
		pos = (<pos> + ((0.0, 1.0) * <lineHeight>))
		create_winport_login_field container = <container> pos = <pos> label = "새 비밀번호 확인:" labelId = newPassword2LabelId prefixId = newPassword2PrefixId cursorId = newPassword2CursorId suffixId = newPassword2SuffixId ang = 0.5
	endif
	if (<mode> = createAccount || <mode> = resetAccount)
		pos = (<pos> + ((0.0, 1.0) * <lineHeight>))
		create_winport_login_field container = <container> pos = <pos> label = "라이선스:" labelId = licenseLabelId prefixId = licensePrefixId cursorId = licenseCursorId suffixId = licenseSuffixId ang = 1.5
	endif
	add_user_control_helper \{text = "승인"
		button = green
		z = 100}
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	if GotParam \{yellowButtonText}
		add_user_control_helper text = <yellowButtonText> button = Yellow z = 100
	endif
	if GotParam \{blueButtonText}
		add_user_control_helper text = <blueButtonText> button = blue z = 100
	endif
	LaunchEvent type = focus target = <container>
	begin
	if (IsCapsLockOn)
		SetScreenElementProps \{id = capsLockField
			alpha = 1.0}
	else
		SetScreenElementProps \{id = capsLockField
			alpha = 0.0}
	endif
	update_winport_login_field \{field = UserName
		labelId = usernameLabelId
		prefixId = usernamePrefixId
		cursorId = usernameCursorId
		suffixId = usernameSuffixId}
	update_winport_login_field \{field = password
		labelId = passwordLabelId
		prefixId = passwordPrefixId
		cursorId = passwordCursorId
		suffixId = passwordSuffixId}
	update_winport_login_field \{field = newPassword1
		labelId = newPassword1LabelId
		prefixId = newPassword1PrefixId
		cursorId = newPassword1CursorId
		suffixId = newPassword1SuffixId}
	update_winport_login_field \{field = newPassword2
		labelId = newPassword2LabelId
		prefixId = newPassword2PrefixId
		cursorId = newPassword2CursorId
		suffixId = newPassword2SuffixId}
	update_winport_login_field \{field = license
		labelId = licenseLabelId
		prefixId = licensePrefixId
		cursorId = licenseCursorId
		suffixId = licenseSuffixId}
	Wait \{1
		frame}
	if NOT (ScreenElementExists id = <container>)
		return
	endif
	netsessionfunc \{func = GetLoginEntry}
	if (<loginEntry> = loginAccepted)
		break
	endif
	if (<loginEntry> = loginAborted)
		break
	endif
	if ((GotParam yellowButtonAction) && (<loginEntry> = loginOption1))
		printf \{"Got yellowButtonAction button"}
		break
	endif
	if ((GotParam blueButtonAction) && (<loginEntry> = loginOption2))
		printf \{"Got blueButtonAction button"}
		break
	endif
	repeat
	switch <loginEntry>
		case loginAccepted
		ui_flow_manager_respond_to_action \{action = executeLogin}
		case loginOption1
		printf \{"Executing option 1"}
		ui_flow_manager_respond_to_action \{action = executeOption1}
		case loginOption2
		printf \{"Executing option 2"}
		ui_flow_manager_respond_to_action \{action = executeOption2}
		case loginAborted
		cancel_winport_account_management_screen mode = <mode>
	endswitch
endscript

script destroy_winport_account_management_screen 
	netsessionfunc \{func = DestroyLoginFields}
	if (ScreenElementExists id = <container>)
		DestroyScreenElement id = <container>
	endif
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script cancel_winport_account_management_screen 
	if (<mode> = loginAccount)
		if (netsessionfunc func = hasexistinglogin)
			ui_flow_manager_respond_to_action \{action = back_to_main}
		else
			ui_flow_manager_respond_to_action \{action = back_to_connection_status}
		endif
	else
		ui_flow_manager_respond_to_action \{action = back}
	endif
endscript

script create_winport_login_field 
	CreateScreenElement {
		type = ContainerElement
		parent = <container>
		rot_angle = <ang>
	}
	rotContainer = <id>
	CreateScreenElement {
		type = TextElement
		parent = <rotContainer>
		id = <labelId>
		font = fontgrid_title_gh3
		scale = 0.8
		rgba = $loginTextColor
		text = <label>
		just = [left top]
		z_priority = 10.0
		pos = <pos>
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = <rotContainer>
		id = <prefixId>
		font = fontgrid_title_gh3
		scale = 0.8
		rgba = $loginTextColor
		text = ""
		just = [left top]
		z_priority = 10.0
		pos = (300.0, 300.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = <rotContainer>
		id = <cursorId>
		font = fontgrid_title_gh3
		scale = (0.5, 0.8)
		rgba = $loginTextColor
		text = "I"
		just = [left top]
		z_priority = 10.0
		pos = (400.0, 300.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = <rotContainer>
		id = <suffixId>
		font = fontgrid_title_gh3
		scale = 0.8
		rgba = $loginTextColor
		text = ""
		just = [left top]
		z_priority = 10.0
		pos = (500.0, 300.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}
	RunScriptOnScreenElement id = <cursorId> winport_cursor_blinker Params = {blinkId = <cursorId>}
endscript

script update_winport_login_field 
	if NOT (ScreenElementExists id = <labelId>)
		return
	endif
	netsessionfunc func = GetLoginField Params = {field = <field>}
	if (<active> = 1)
		SetScreenElementProps id = <prefixId> text = <prefix>
		SetScreenElementProps id = <cursorId> text = "I"
		SetScreenElementProps id = <suffixId> text = <suffix>
	else
		SetScreenElementProps id = <prefixId> text = <prefix>
		SetScreenElementProps id = <cursorId> text = ""
		SetScreenElementProps id = <suffixId> text = ""
	endif
	GetScreenElementDims id = <labelId>
	getscreenelementposition id = <labelId>
	pos = (<screenelementpos> + ((1.0, 0.0) * <width>))
	SetScreenElementProps id = <prefixId> pos = <pos>
	getscreenelementposition id = <prefixId>
	GetScreenElementDims id = <prefixId>
	pos = (<screenelementpos> + ((1.0, 0.0) * <width>))
	SetScreenElementProps id = <cursorId> pos = <pos>
	getscreenelementposition id = <cursorId>
	GetScreenElementDims id = <cursorId>
	pos = (<screenelementpos> + ((1.0, 0.0) * <width>))
	SetScreenElementProps id = <suffixId> pos = <pos>
endscript

script winport_cursor_blinker 
	begin
	if NOT (ScreenElementExists id = <blinkId>)
		return
	endif
	doScreenElementMorph id = <blinkId> alpha = 0 time = 0.5
	Wait \{0.5
		seconds}
	if NOT (ScreenElementExists id = <blinkId>)
		return
	endif
	doScreenElementMorph id = <blinkId> alpha = 1.0 time = 0.5
	Wait \{0.5
		seconds}
	repeat
endscript

script create_winport_account_create_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_winport_account_create_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_winport_account_login_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_winport_account_login_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_winport_account_change_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_winport_account_change_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_winport_account_reset_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_winport_account_reset_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_winport_account_delete_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_winport_account_delete_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_account_change_submenu_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_account_change_submenu_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_account_delete_submenu_status_screen 
	create_winport_account_management_status_screen
endscript

script destroy_account_delete_submenu_status_screen 
	destroy_winport_account_management_status_screen
endscript

script create_winport_account_management_status_screen 
	printf \{"--- create_winport_account_management_status_screen"}
	create_menu_backdrop \{texture = online_background}
	z = 110
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = accountstatuscontainer
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = accountstatuscontainer
		just = [
			center
			top
		]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1}
	menu_id = <id>
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound Params = {up}}
			{pad_down generic_menu_up_or_down_sound Params = {down}}
		]
	}
	vmenu_id = <id>
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
	create_pause_menu_frame \{parent = accountstatuscontainer
		z = 5}
	displaySprite \{parent = accountstatuscontainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = accountstatuscontainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = TextElement
		parent = accountstatuscontainer
		font = fontgrid_title_gh3
		scale = 1.2
		rgba = [
			223
			223
			223
			250
		]
		text = "온라인"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 182.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = accountstatuscontainer
		id = statusmessage
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = <z>
		pos = (640.0, 310.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	LaunchEvent type = focus target = <vmenu_id>
	netsessionfunc \{func = executelogintask}
	begin
	netsessionfunc \{func = getnetworkstatus}
	switch (<currentnetworktask>)
		case "CREATE_ACCOUNT"
		switch (<currentnetworkstatus>)
			case "PENDING"
			statustext = "계정 생성 요청 중"
			case "DONE"
			statustext = "계정 생성 완료"
			success = true
			case "FAILED"
			statustext = "계정을 생성할 수 없습니다."
			success = false
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		case "LOGIN_ACCOUNT"
		switch (<currentnetworkstatus>)
			case "PENDING"
			statustext = "계정 인증 중"
			case "DONE"
			statustext = "계정 인증 성공"
			success = true
			case "FAILED"
			statustext = "계정을 인증할 수 없습니다."
			success = false
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		case "CHANGE_ACCOUNT"
		switch (<currentnetworkstatus>)
			case "PENDING"
			statustext = "비밀번호 변경 요청 중"
			case "DONE"
			statustext = "비밀번호 변경 완료"
			success = true
			case "FAILED"
			statustext = "비밀번호를 변경할 수 없습니다."
			success = false
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		case "RESET_ACCOUNT"
		switch (<currentnetworkstatus>)
			case "PENDING"
			statustext = "계정 초기화 요청 중"
			case "DONE"
			statustext = "계정 비밀번호 초기화"
			success = true
			case "FAILED"
			statustext = "계정을 초기화할 수 없습니다."
			success = false
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		case "DELETE_ACCOUNT"
		switch (<currentnetworkstatus>)
			case "PENDING"
			statustext = "계정 삭제 요청 중"
			case "DONE"
			statustext = "계정 삭제 완료"
			success = true
			case "FAILED"
			statustext = "계정을 삭제할 수 없습니다."
			success = false
			default
			statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
			success = false
		endswitch
		default
		printf "Unexpected state = %s" s = <currentnetworktask>
		statustext = "내부 오류: 네트워크 상태가 잘못되었습니다!"
		success = false
	endswitch
	SetScreenElementProps id = statusmessage text = <statustext>
	fit_text_into_menu_item \{id = statusmessage
		max_width = 480}
	if GotParam \{success}
		break
	endif
	Wait \{1
		frame}
	if NOT (ScreenElementExists id = accountstatuscontainer)
		return
	endif
	repeat
	if (<success> = false)
		netsessionfunc \{func = getautologinsetting}
		if (<autologinsetting> = autologinon && netsessionfunc func = hasexistinglogin)
			netsessionfunc \{func = setautologinsetting
				Params = {
					autologinsetting = autologinprompt
				}}
		endif
		netsessionfunc \{func = getfailurecode}
		switch <failurecode>
			case 666
			statustext = "새 비밀번호 확인 항목이 일치하지 않습니다."
			case 667
			statustext = "인증 서비스 실패"
			case 668
			statustext = "사용자 이름은 6글자에서 16글자 사이여야 합니다."
			case 669
			statustext = "비밀번호는 6글자에서 16글자 사이여야 합니다."
			case 700
			statustext = "과제 완수"
			case 701
			statustext = "잘못된 인증 요청"
			case 702
			statustext = "서버 설정 오류"
			case 703
			statustext = "잘못된 게임 타이틀 Id"
			case 704
			statustext = "잘못된 계정 정보"
			case 705
			statustext = "잘못된 인증 요청"
			case 706
			statustext = "잘못된 라이선스 코드"
			case 707
			statustext = "이미 존재하는 사용자 이름입니다."
			case 708
			statustext = "잘못된 사용자 이름 형식"
			case 709
			statustext = "사용할 수 없는 사용자 이름입니다."
			case 710
			statustext = "라이선스 코드에 너무 많은 계정이 연결되어 있습니다."
			case 711
			statustext = "계정 마이그레이션은 지원하지 않습니다."
			case 712
			statustext = "타이틀을 사용할 수 없습니다"
			case 713
			statustext = "계정이 만료되었습니다."
			case 714
			statustext = "계정이 잠겨있음"
			case 715
			statustext = "인증 오류: Guitar Hero III를 종료하고 다시 실행하기 전까지는 온라인 기능을 사용할 수 없습니다."
			case 716
			statustext = "잘못된 비밀번호"
		endswitch
		SetScreenElementProps id = statusmessage text = <statustext>
		fit_text_into_menu_item \{id = statusmessage
			max_width = 480}
		displaySprite \{parent = accountstatuscontainer
			id = options_bg_1
			tex = dialog_bg
			pos = (640.0, 500.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				botom
			]}
		displaySprite \{parent = accountstatuscontainer
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
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (100.0, 50.0)
			event_handlers = [
				{focus net_warning_focus}
				{unfocus net_warning_unfocus}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = erroraction}}
				{pad_back ui_flow_manager_respond_to_action Params = {action = erroraction}}
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
			text = "다시 시도"
			just = [center top]
			z_priority = (<z> + 0.1)
		}
		fit_text_into_menu_item id = <id> max_width = 480
		GetScreenElementDims id = <id>
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_left
			texture = dialog_highlight
			alpha = 0.0
			just = [right center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_right
			texture = dialog_highlight
			alpha = 0.0
			just = [left center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
		}
		clean_up_user_control_helpers
		add_user_control_helper \{text = "선택"
			button = green
			z = 100}
		add_user_control_helper \{text = "뒤로"
			button = red
			z = 100}
		LaunchEvent type = focus target = <vmenu_id>
		return
	endif
	Wait \{3
		seconds}
	ui_flow_manager_respond_to_action \{action = successaction}
	netsessionfunc \{func = stats_init}
endscript

script destroy_winport_account_management_status_screen 
	if (ScreenElementExists id = accountstatuscontainer)
		DestroyScreenElement \{id = accountstatuscontainer}
	endif
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script create_join_private_menu 
	printf \{"--- create_join_private_menu"}
	z = 110
	create_menu_backdrop \{texture = online_background}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = private_menu_container
		pos = (0.0, 0.0)
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
				executeJoinAttempt
			}
			{
				pad_back
				ui_flow_manager_respond_to_action
				Params = {
					action = back
				}
			}
		]}
	netsessionfunc \{func = InitializeLoginFields
		Params = {
			loginMode = matchUsername
		}}
	displaySprite \{parent = private_menu_container
		tex = dialog_title_bg
		dims = (300.0, 250.0)
		z = 9
		pos = (640.0, 50.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = private_menu_container
		tex = dialog_title_bg
		dims = (300.0, 250.0)
		z = 9
		pos = (640.0, 50.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = TextElement
		parent = private_menu_container
		font = fontgrid_title_gh3
		scale = 1.0
		rgba = [
			223
			223
			223
			250
		]
		text = "1:1 매치 참가"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 145.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	fit_text_in_rectangle id = <id> dims = (400.0, 75.0) pos = (640.0, 145.0) only_if_larger_x = 1 only_if_larger_y = 1 just = center
	CreateScreenElement \{type = TextElement
		parent = private_menu_container
		font = text_a4
		scale = 1.0
		rgba = [
			180
			180
			180
			255
		]
		text = "*매치 참가를 위해 키보드로 사용자 이름을 입력해주십시오.*"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 590.0)
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	fit_text_in_rectangle id = <id> dims = (600.0, 25.0) pos = (640.0, 590.0) only_if_larger_x = 1 only_if_larger_y = 1 just = center keep_ar = 1
	<pos> = (375.0, 320.0)
	create_winport_login_field container = private_menu_container pos = <pos> label = "매치 사용자 이름:" labelId = usernameLabelId prefixId = usernamePrefixId cursorId = usernameCursorId suffixId = usernameSuffixId ang = -2.0
	add_user_control_helper \{text = "승인"
		button = green
		z = 100}
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	LaunchEvent \{type = focus
		target = private_menu_container}
	begin
	update_winport_login_field \{field = matchUsername
		labelId = usernameLabelId
		prefixId = usernamePrefixId
		cursorId = usernameCursorId
		suffixId = usernameSuffixId}
	Wait \{1
		frame}
	if NOT (ScreenElementExists id = private_menu_container)
		return
	endif
	netsessionfunc \{func = GetLoginEntry}
	if ((<loginEntry> = loginAccepted) || (<loginEntry> = loginAborted))
		break
	endif
	repeat
	switch <loginEntry>
		case loginAccepted
		executeJoinAttempt
		case loginAborted
		ui_flow_manager_respond_to_action \{action = back}
	endswitch
endscript

script executeJoinAttempt 
	netsessionfunc \{func = GeneratePrivateMatchId}
	change gPrivateMatchId = <privateMatchId>
	ui_flow_manager_respond_to_action \{action = attempt_join}
endscript

script destroy_join_private_menu 
	netsessionfunc \{func = DestroyLoginFields}
	DestroyScreenElement \{id = private_menu_container}
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script create_logout_submenu 
	printf \{"--- create_logout_submenu"}
	create_menu_backdrop \{texture = online_background}
	z = 110
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = logoutContainer
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = logoutContainer
		just = [
			center
			top
		]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1}
	menu_id = <id>
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound Params = {up}}
			{pad_down generic_menu_up_or_down_sound Params = {down}}
			{pad_back ui_flow_manager_respond_to_action Params = {action = back}}
		]
	}
	vmenu_id = <id>
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
	create_pause_menu_frame \{parent = logoutContainer
		z = 5}
	displaySprite \{parent = logoutContainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = logoutContainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = TextElement
		parent = logoutContainer
		font = fontgrid_title_gh3
		scale = 1.2
		rgba = [
			223
			223
			223
			250
		]
		text = "로그아웃"
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 182.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = logoutContainer
		id = statusmessage
		text = "로그아웃하면 현재 온라인 세션이 종료됩니다. 다시 로그인하기 전까지는 점수가 순위표에 반영되지 않을 것입니다."
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = <z>
		pos = (640.0, 300.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	fit_text_into_menu_item \{id = statusmessage
		max_width = 470}
	displaySprite \{parent = logoutContainer
		id = options_bg_1
		tex = dialog_bg
		pos = (640.0, 500.0)
		dims = (320.0, 64.0)
		z = 9
		just = [
			center
			botom
		]}
	displaySprite \{parent = logoutContainer
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
	CreateScreenElement {
		type = ContainerElement
		parent = <vmenu_id>
		dims = (100.0, 50.0)
		event_handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose executeLogout}
			{pad_back ui_flow_manager_respond_to_action Params = {action = back}}
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
		text = "로그아웃"
		just = [center top]
		z_priority = (<z> + 0.1)
	}
	fit_text_into_menu_item id = <id> max_width = 200
	GetScreenElementDims id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_left
		texture = dialog_highlight
		alpha = 0.0
		just = [right center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
		z_priority = (<z> + 0.1)
		scale = (1.0, 1.0)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_right
		texture = dialog_highlight
		alpha = 0.0
		just = [left center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
		z_priority = (<z> + 0.1)
		scale = (1.0, 1.0)
	}
	CreateScreenElement {
		type = ContainerElement
		parent = <vmenu_id>
		dims = (100.0, 50.0)
		event_handlers = [
			{focus net_warning_focus}
			{unfocus net_warning_unfocus}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = back}}
			{pad_back ui_flow_manager_respond_to_action Params = {action = back}}
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
		text = "온라인 상태 유지"
		just = [center top]
		z_priority = (<z> + 0.1)
	}
	fit_text_into_menu_item id = <id> max_width = 200
	GetScreenElementDims id = <id>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_left
		texture = dialog_highlight
		alpha = 0.0
		just = [right center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
		z_priority = (<z> + 0.1)
		scale = (1.0, 1.0)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = bookend_right
		texture = dialog_highlight
		alpha = 0.0
		just = [left center]
		pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
		z_priority = (<z> + 0.1)
		scale = (1.0, 1.0)
	}
	add_user_control_helper \{text = "선택"
		button = green
		z = 100}
	add_user_control_helper \{text = "뒤로"
		button = red
		z = 100}
	add_user_control_helper \{text = "위/아래"
		button = strumbar
		z = 100}
	LaunchEvent type = focus target = <vmenu_id>
endscript

script destroy_logout_submenu 
	DestroyScreenElement \{id = logoutContainer}
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script executeLogout 
	netsessionfunc \{func = ResetNetwork}
	Wait \{1.0
		second}
	destroy_logout_submenu
	start_flow_manager \{flow_state = main_menu_fs}
endscript

script create_account_submenu \{menu_title = "계정 관리"
		menu_id = online_account_menu
		vmenu_id = online_account_vmenu}
	change \{online_main_menu_pos = (640.0, 110.0)}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = account_submenu_anchor
		pos = (0.0, 0.0)}
	CreateScreenElement {
		type = VScrollingMenu
		parent = account_submenu_anchor
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
			{pad_back ui_flow_manager_respond_to_action Params = {action = back}}
			{pad_back generic_menu_pad_back}
			{pad_up generic_menu_up_or_down_sound Params = {up}}
			{pad_down generic_menu_up_or_down_sound Params = {down}}
		]
	}
	CreateScreenElement \{type = ContainerElement
		parent = account_submenu_anchor
		id = online_account_submenu_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = online_account_submenu_container
		id = online_account_submenu_text_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = account_submenu_anchor
		id = online_info_pane_container
		pos = (0.0, 0.0)}
	create_menu_backdrop \{texture = online_background}
	displaySprite id = online_frame parent = online_account_submenu_container tex = Online_Frame_Large pos = ($online_main_menu_pos) dims = (660.0, 480.0) just = [center top] z = 2
	displaySprite id = online_frame_crown parent = online_account_submenu_container tex = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -62.0)) dims = (256.0, 105.0) just = [center top] z = 3
	CreateScreenElement {
		type = TextElement
		parent = online_account_submenu_text_container
		id = online_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_dark_purple)
		pos = (($online_main_menu_pos) + (0.0, 35.0))
		text = <menu_title>
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
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "로그아웃"
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = execute_logout}
		line_spacing = 50
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "비밀번호 변경"
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = execute_change_password}
		line_spacing = 50
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "계정 삭제"
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = execute_delete_account}
		line_spacing = 50
	}
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	create_online_main_menu_helper_buttons
	LaunchEvent type = focus target = <vmenu_id>
endscript

script destroy_account_submenu 
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{id = account_submenu_anchor}
		DestroyScreenElement \{id = account_submenu_anchor}
	endif
endscript
