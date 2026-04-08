calibrate_lag_warning_menu_font = fontgrid_title_gh3

script create_calibrate_lag_warning_menu 
	disable_pause
	player_device = ($last_start_pressed_device)
	create_popup_warning_menu {
		textblock = {
			text = "랙을 조정하려면 노래를 다시 시작해야 합니다. 다시 시작한다면 저장되지 않은 진행 상황을 잃어버리게 됩니다. 계속하시겠습니까?"
			dims = (800.0, 400.0)
			scale = 0.55
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
				func = menu_calibrate_lag_warning_select_yes
				text = "조정"
			}
		]
	}
endscript

script destroy_calibrate_lag_warning_menu 
	destroy_popup_warning_menu
endscript

script menu_calibrate_lag_warning_select_yes 
	GH3_SFX_fail_song_stop_sounds
	ui_flow_manager_respond_to_action \{action = continue}
endscript
