script transition_startrendering 
	printf \{"Transition_StartRendering"}
	startrendering
	enable_pause
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		gh3_start_pressed
	endif
	if ($current_song = dlc19)
		crowd_create_lighters
		crowd_startlighters
	endif
endscript
