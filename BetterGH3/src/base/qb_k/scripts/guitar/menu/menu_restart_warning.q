
script create_restart_warning_menu \{player = 1}
	disable_pause
	player_device = ($last_start_pressed_device)
	create_popup_warning_menu {
		textblock = {
			text = "다시 시작하면 저장되지 않은 진행 상황을 잃어버리게 됩니다. 이 노래를 다시 시작하시겠습니까?"
			dims = (600.0, 400.0)
			scale = 0.6
		}
		player_device = <player_device>
		no_background
		menu_pos = (640.0, 480.0)
		dialog_dims = (600.0, 80.0)
		options = [
			{
				func = menu_flow_go_back
				text = "취소"
			}
			{
				func = restart_warning_select_restart
				text = "다시 시작"
			}
		]
	}
endscript

script destroy_restart_warning_menu 
	destroy_popup_warning_menu
endscript

script restart_warning_select_restart \{player = 1}
	GH3_SFX_fail_song_stop_sounds
	ui_flow_manager_respond_to_action action = continue create_params = {player = <player>}
endscript
