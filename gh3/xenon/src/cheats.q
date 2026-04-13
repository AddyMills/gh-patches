script toggle_hyperspeed 
	GetGlobalTags \{user_options}
	if ($<cheat> >= 0)
		if ($<cheat> = 5)
			new_value = 0
			change GlobalName = <cheat> newvalue = <new_value>
			SetGlobalTags user_options Params = {Cheat_HyperSpeed = <new_value>}
			FormatText textname = text "%c : OFF" c = ($guitar_hero_cheats [<index>].name_text)
			SetScreenElementProps id = <id> text = <text>
		else
			new_value = ($<cheat> + 1)
			change GlobalName = <cheat> newvalue = ($<cheat> + 1)
			SetGlobalTags user_options Params = {Cheat_HyperSpeed = <new_value>}
			FormatText textname = text "%c : ON" c = ($guitar_hero_cheats [<index>].name_text)
			FormatText textname = text "%c, %d" c = <text> d = (<new_value>)
			SetScreenElementProps id = <id> text = <text>
		endif
	endif
endscript