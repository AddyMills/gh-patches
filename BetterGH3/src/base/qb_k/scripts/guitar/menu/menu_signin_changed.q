
script create_signin_changed_menu 
	destroy_popup_warning_menu
	create_popup_warning_menu \{title = "로그인 변경됨"
		title_props = {
			scale = 1.0
		}
		textblock = {
			text = "로그인한 사용자가 변경되어 저장된 게임과 도전 과제에 대한 소유권을 잃었습니다. 그로 인해 게임을 다시 시작해야 합니다."
			pos = (640.0, 380.0)
		}
		menu_pos = (640.0, 510.0)
		options = [
			{
				func = signing_change_confirm_reboot
				text = "계속"
				scale = (1.0, 1.0)
			}
		]}
endscript

script destroy_signin_changed_menu 
	destroy_popup_warning_menu
endscript

script recreate_signin_changed_menu 
	destroy_signin_changed_menu
	create_signin_changed_menu
endscript
