fake_training_script = [
	{
		call = print_random_carp
	}
	{
		time = 5000
		call = print_random_carp
	}
	{
		rel_time = 2000
		call = training_waste_time_test
	}
	{
		call = print_random_carp
	}
	{
		rel_time = 2000
		call = print_random_carp
	}
]

script training_waste_time_test 
	printf \{"From waste time test"}
	print_random_carp
	Wait \{10
		seconds}
endscript

script print_random_carp 
	printf "I'm a random carp and the training system time is %t ms" t = ($current_training_time)
endscript
current_training_script = fake_training_script
current_training_step = 0
current_training_time = 0
last_training_call_time = 0

script set_training_script 
	change current_training_script = <name>
endscript

script run_training_script 
	if NOT GotParam \{name}
		name = ($current_training_script)
	endif
	change current_training_script = <name>
	change \{current_training_time = 0}
	change \{last_training_call_time = 0}
	training_script = ($current_training_script)
	call_script = ((<training_script> [0]).call)
	<call_script>
	change \{current_training_step = 1}
	if GotParam \{Restart_Lesson}
		create_training_pause_handler
		search_step = 1
		begin
		GetArraySize (<training_script>)
		if (<search_step> = <array_size>)
			change \{training_last_lesson = 1}
			break
		endif
		training_struct = (<training_script> [<search_step>])
		if StructureContains Structure = (<training_struct>) lesson
			if ((<training_struct>.lesson) = $training_last_lesson)
				change current_training_step = <search_step>
				break
			endif
		endif
		search_step = (<search_step> + 1)
		repeat
	else
		change \{training_last_lesson = 1}
	endif
	SpawnScriptLater \{training_script_update}
endscript

script training_script_update 
	begin
	training_script = ($current_training_script)
	GetArraySize (<training_script>)
	if (($current_training_step) = <array_size>)
		spawnscriptnow \{kill_training_script_system}
	endif
	GetDeltaTime
	ms_elapsed = (<delta_time> * 1000)
	change current_training_time = (($current_training_time) + <ms_elapsed>)
	training_struct = (<training_script> [($current_training_step)])
	if StructureContains Structure = (<training_struct>) time
		time_to_fire = (<training_struct>.time)
		if (($current_training_time) > <time_to_fire>)
			call_script = (<training_struct>.call)
			spawnscriptnow <call_script> id = training_spawned_script
			change current_training_step = (($current_training_step) + 1)
			change last_training_call_time = ($current_training_time)
		endif
	elseif StructureContains Structure = (<training_struct>) rel_time
		time_gap = ($current_training_time - $last_training_call_time)
		time_to_fire = (<training_struct>.rel_time)
		if (<time_gap> > <time_to_fire>)
			call_script = (<training_struct>.call)
			spawnscriptnow <call_script> id = training_spawned_script
			change current_training_step = (($current_training_step) + 1)
			change last_training_call_time = ($current_training_time)
		endif
	else
		old_training_struct = (<training_script> [($current_training_step - 1)])
		old_script = (<old_training_struct>.call)
		if NOT ScriptIsRunning <old_script>
			if StructureContains Structure = (<training_struct>) lesson
				change training_last_lesson = (<training_struct>.lesson)
			endif
			call_script = (<training_struct>.call)
			spawnscriptnow <call_script> id = training_spawned_script
			change current_training_step = (($current_training_step) + 1)
			change last_training_call_time = ($current_training_time)
		endif
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script kill_training_script_system 
	KillSpawnedScript \{name = training_script_update}
	KillSpawnedScript \{id = training_spawned_script}
endscript

script debugstruct 
	printf "%d" d = <n>
	printstruct <...>
endscript
