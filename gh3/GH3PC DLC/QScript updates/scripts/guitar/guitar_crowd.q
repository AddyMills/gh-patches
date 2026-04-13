script crowd_monitor_performance 
	lighters_on = false
	begin
	get_skill_level
	if ($current_song = dlc19)
		skill = good
	endif
	if (<skill> != bad)
		if (<lighters_on> = false)
			crowd_allsethand \{hand = right
				type = lighter}
			crowd_allplayanim \{anim = special}
			lighters_on = true
			crowd_togglelighters \{on}
		endif
	else
		if (<lighters_on> = true)
			crowd_allsethand \{hand = right
				type = clap}
			crowd_allplayanim \{anim = idle}
			lighters_on = false
			crowd_togglelighters \{off}
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript
