FLAG_IMPROV_TOGGLE = 10

script improvmode_startup 
	change \{game_mode = improv}
	begin
	WaitForEvent \{type = hit_notesp1}
	if (<pattern> && 65536)
		soundevent \{event = Improv_Lead_Bend1}
		printf \{'L2'}
	endif
	if (<pattern> && 4096)
		soundevent \{event = Lead_Sliding_Lick}
		printf \{'L1'}
	endif
	if (<pattern> && 256)
		soundevent \{event = Lead_Real_Short3}
		printf \{'R1'}
	endif
	if (<pattern> && 16)
		soundevent \{event = Lead_Real_Short4}
		printf \{'R2'}
	endif
	if (<pattern> && 1)
		soundevent \{event = Lead_Real_Short5}
		printf \{'X'}
	endif
	Wait \{1
		frame}
	repeat
endscript

script improv_test_script 
	printf \{'Firing improv test script!!!!!'}
endscript
