p2_scroll_time_factor = 1
p2_game_speed_factor = 1

script kill_object_later 
	if ScreenElementExists id = <gem_id>
		DestroyGem name = <gem_id>
	endif
endscript