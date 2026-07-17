// Skip legal timer
script ui_boot_legal_wait 
	ui_event_wait \{event = menu_replace
		data = {
			state = UIstate_boot_movie_atvi
		}}
endscript