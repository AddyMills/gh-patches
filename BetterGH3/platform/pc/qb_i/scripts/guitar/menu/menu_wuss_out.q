
script create_wuss_out_menu 
	change \{boss_wuss_out = 0}
	if IsWinPort
		player_device = ($primary_controller)
	else
		player_device = ($last_start_pressed_device)
	endif
	if ($current_song = bosstom)
		warning_text = "Wow, Tom Morello ti sta facendo a pezzi. Tutto a posto? Forse vuoi evitarlo e basta? Vivrai con la consapevolezza che ti ha stracciato, ma non importa. Puoi sempre tornare ad affrontarlo. Lui sarà lì ad aspettarti."
	elseif ($current_song = bossslash)
		warning_text = "Ehi, Slash ti sta facendo a pezzettini? Hai bisogno di coccole? Forse faresti meglio a continuare a suonare il basso. Lo vuoi evitare a pie' pari?  Magari più tardi sarai in grado di competere con un vero Guitar Hero."
	endif
	kill_start_key_binding
	create_popup_warning_menu {
		title = "TE LA SVIGNI?"
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
				text = "CONTINUA"
			}
			{
				func = wuss_out_menu_wuss_out
				text = "SVIGNATELA"
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
