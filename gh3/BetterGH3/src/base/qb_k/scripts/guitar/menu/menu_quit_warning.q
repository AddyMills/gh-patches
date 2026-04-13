
script create_quit_warning_menu \{player = 1
		option1_text = "취소"
		option2_text = "종료"}
	disable_pause
	player_device = ($last_start_pressed_device)
	create_popup_warning_menu {
		textblock = {
			text = "종료하면 저장되지 않은 진행 상황을 잃어버리게 됩니다. 이 노래를 종료하시겠습니까?"
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
				text = <option1_text>
			}
			{
				func = quit_warning_select_quit
				text = <option2_text>
			}
		]
	}
endscript

script destroy_quit_warning_menu 
	destroy_popup_warning_menu
endscript

script quit_warning_select_quit \{player = 1}
	GH3_SFX_fail_song_stop_sounds
	ui_flow_manager_respond_to_action action = continue create_params = {player = <player>}
endscript
