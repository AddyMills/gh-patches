
script create_wuss_out_menu 
	change \{boss_wuss_out = 0}
	if iswinport
		player_device = ($primary_controller)
	else
		player_device = ($last_start_pressed_device)
	endif
	if ($current_song = bosstom)
		warning_text = "와, 톰 모렐로가 당신을 완전히 제압하고 있네요. 괜찮나요? 톰을 그냥 건너뛰고 싶으세요? 그가 당신을 이겼다는 것을 잊어버리진 못하겠지만 언제든지 다시 돌아올 수 있어요. 그도 기다리고 있을거에요."
	elseif ($current_song = bossslash)
		warning_text = "이런, 슬래쉬가 당신의 약점을 공격했나요? 포옹이라도 해 드릴까요? 그저 베이스를 연주하는 것으로 만족해야 할 지도 모르겠네요. 그를 그냥 건너뛰고 싶으신가요? 좀 더 기다려야 진정한 기타의 영웅들과 어깨를 나란히 맞추겠네요."
	endif
	kill_start_key_binding
	create_popup_warning_menu {
		title = "도망가기?"
		textblock = {
			text = <warning_text>
			dims = (880.0, 600.0)
			pos = (640.0, 387.0)
			scale = 0.55
		}
		player_device = <player_device>
		no_background
		menu_pos = (640.0, 470.0)
		dialog_dims = (600.0, 80.0)
		options = [
			{
				func = wuss_out_menu_continue
				text = "계속"
			}
			{
				func = wuss_out_menu_wuss_out
				text = "도망가기"
			}
		]
	}
endscript

script destroy_wuss_out_menu 
	restore_start_key_binding
	destroy_popup_warning_menu
endscript

script wuss_out_menu_continue 
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script wuss_out_menu_wuss_out 
	ui_flow_manager_respond_to_action \{action = wuss_out}
endscript
