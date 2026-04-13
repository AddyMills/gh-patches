
script create_practice_warning_menu 
	disable_pause
	player_device = ($player1_status.controller)
	get_song_struct song = ($current_song)
	if structurecontains structure = <song_struct> boss
		warning_text = "지금 훈련을 종료하면 이 노래의 진행 상황을 잃게됩니다. 종료합니까?"
		goto_text = "훈련"
	else
		warning_text = "지금 연습을 종료하면 이 노래의 진행 상황을 잃게됩니다. 종료합니까?"
		goto_text = "연습"
	endif
	kill_start_key_binding
	create_popup_warning_menu {
		textblock = {
			text = <warning_text>
			dims = (600.0, 400.0)
			scale = 0.6
		}
		player_device = <player_device>
		no_background
		menu_pos = (640.0, 480.0)
		dialog_dims = (600.0, 80.0)
		options = [
			{
				func = practice_warning_menu_select_cancel
				text = "취소"
			}
			{
				func = practice_warning_menu_select_practice
				text = <goto_text>
			}
		]
	}
endscript

script destroy_practice_warning_menu 
	destroy_popup_warning_menu
endscript

script practice_warning_menu_select_cancel 
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script practice_warning_menu_select_practice 
	get_song_struct song = ($current_song)
	if structurecontains structure = <song_struct> boss
		player_device = ($primary_controller)
		if isguitarcontroller controller = <player_device>
			ui_flow_manager_respond_to_action \{action = continue_tutorial}
		endif
	else
		ui_flow_manager_respond_to_action \{action = continue}
	endif
endscript
