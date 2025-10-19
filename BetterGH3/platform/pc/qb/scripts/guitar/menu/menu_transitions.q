transitions_locked = 0

script destroy_menu_transition 
	if ScreenElementExists \{id = transition_container}
		root_window :SetProps \{just = [
				left
				top
			]}
		root_window :SetProps \{alpha = 1
			scale = (1.0, 1.0)
			pos = (0.0, 0.0)}
		DestroyScreenElement \{id = transition_container}
		change \{transitions_locked = 0}
	endif
endscript

script menu_transition_out_right \{transition_time = 0.125}
	destroy_menu_transition
	change \{transitions_locked = 1}
	CreateScreenElement \{id = transition_container
		type = ContainerElement
		parent = root_window
		pos = (0.0, 0.0)
		alpha = 0}
	CreateScreenElement \{type = SpriteElement
		parent = transition_container
		texture = white
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		rgba = [
			0
			0
			0
			255
		]
		dims = (1280.0, 720.0)
		z_priority = 5000}
	if IsWinPort
	else
		root_window :SetProps \{just = [
				right
				top
			]}
		RunScriptOnScreenElement id = root_window fade_element params = {pos = (1280.0, 0.0) alpha = 1 time = <transition_time> scale = (2.0, 1.0)}
		transition_container :DoMorph alpha = 1 time = <transition_time>
	endif
endscript

script menu_transition_in_right \{transition_time = 0.125}
	root_window :SetProps \{just = [
			left
			top
		]}
	root_window :SetProps \{alpha = 1
		scale = (2.0, 1.0)
		pos = (0.0, 0.0)}
	RunScriptOnScreenElement id = transition_container fade_element params = {pos = (0.0, 0.0) alpha = 0 time = <transition_time>}
	if IsWinPort
		root_window :DoMorph alpha = 1 scale = 1 pos = (0.0, 0.0) time = <transition_time>
	else
		root_window :DoMorph alpha = 1 scale = 1 time = <transition_time>
	endif
	change \{transitions_locked = 0}
	destroy_menu_transition
endscript

script menu_transition_out_left \{transition_time = 0.125}
	destroy_menu_transition
	change \{transitions_locked = 1}
	CreateScreenElement \{id = transition_container
		type = ContainerElement
		parent = root_window
		pos = (0.0, 0.0)
		alpha = 0}
	CreateScreenElement \{type = SpriteElement
		parent = transition_container
		texture = white
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		rgba = [
			0
			0
			0
			255
		]
		dims = (1280.0, 720.0)
		z_priority = 5000}
	root_window :SetProps \{just = [
			left
			top
		]}
	if IsWinPort
		RunScriptOnScreenElement id = root_window fade_element params = {pos = (0.0, 0.0) alpha = 1 time = <transition_time> scale = (2.0, 1.0)}
		transition_container :DoMorph pos = (0.0, 0.0) alpha = 1 time = <transition_time>
	else
		RunScriptOnScreenElement id = root_window fade_element params = {alpha = 1 time = <transition_time> scale = (2.0, 1.0)}
		transition_container :DoMorph alpha = 1 time = <transition_time>
	endif
endscript

script menu_transition_in_left \{transition_time = 0.125}
	if IsWinPort
	else
		root_window :SetProps \{just = [
				right
				top
			]}
		root_window :SetProps \{pos = (1280.0, 0.0)
			alpha = 1
			scale = (2.0, 1.0)}
		RunScriptOnScreenElement id = transition_container fade_element params = {pos = (0.0, 0.0) alpha = 0 time = <transition_time>}
		root_window :DoMorph alpha = 1 scale = 1 pos = (1280.0, 0.0) time = <transition_time>
	endif
	destroy_menu_transition
	change \{transitions_locked = 0}
endscript

script fade_element \{time = 0
		pos = (0.0, 0.0)
		alpha = 0
		scale = 1}
	DoMorph id = <id> alpha = <alpha> time = <time> pos = <pos> scale = <scale>
endscript
