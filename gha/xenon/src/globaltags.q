// Save hyperspeed
script restore_options_from_global_tags 
	GetGlobalTags \{user_options}
	if (<lefty_flip_p1>)
		change \{pad_event_up_inversion = true}
	else
		change \{pad_event_up_inversion = false}
	endif
	change GlobalName = Cheat_HyperSpeed newvalue = <Cheat_HyperSpeed>
endscript