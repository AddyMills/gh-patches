
script create_wuss_out_menu 
	change \{boss_wuss_out = 0}
	if IsWinPort
		player_device = ($primary_controller)
	else
		player_device = ($last_start_pressed_device)
	endif
	if ($current_song = bosstom)
		warning_text = "Eh ben, Tom Morello est en train de te botter les fesses. Tu tiens le coup ? Tu comptes rester à la traîne ? Tu sais qu'il aura toujours le dessus sur toi, mais t'en fais pas. Tu peux toujours revenir. Il t'attendra."
	elseif ($current_song = bossslash)
		warning_text = "Attends, Slash ne prendrait pas l'avantage ? T'as besoin de réconfort ? Tu devrais te contenter de la basse. Tu veux l'éviter ? Un jour tu auras peut-être ce qu'il faut pour te mesurer à un vrai guitar hero."
	endif
	kill_start_key_binding
	create_popup_warning_menu {
		title = "T'AS PEUR ?"
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
				text = "CONTINUER"
			}
			{
				func = wuss_out_menu_wuss_out
				text = "PEUREUX"
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
