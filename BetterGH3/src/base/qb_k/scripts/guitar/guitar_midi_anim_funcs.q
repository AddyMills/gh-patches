
script Band_PlaysimpleAnim \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if NOT GotParam \{Anim}
		return
	endif
	<name> :Obj_KillSpawnedScript name = play_simple_anim
	<name> :Obj_SpawnScriptNow play_simple_anim Params = {<...>}
endscript

script Band_PlayAnim \{name = Guitarist
		Anim = idle}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if bassist_should_use_guitarist_commands
		if (<name> = Guitarist)
			if CompositeObjectExists \{name = bassist}
				LaunchEvent type = play_anim target = bassist data = {<...>}
			endif
		elseif (<name> = bassist)
			return
		endif
	endif
	LaunchEvent type = play_anim target = <name> data = {<...>}
endscript

script band_playidle \{name = Guitarist}
	Band_PlayAnim name = <name> Anim = idle Cycle
endscript

script Band_PlayFacialAnim \{name = Guitarist}
	if CompositeObjectExists name = <name>
		<name> :Obj_KillSpawnedScript name = play_special_facial_anim
		<name> :Obj_SpawnScriptNow play_special_facial_anim Params = {Anim = <Anim>}
	endif
endscript

script Band_SetStrumStyle \{name = Guitarist
		style = Long}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> strum = <style>
endscript

script Band_ChangeStance \{name = Guitarist
		stance = stance_a}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if bassist_should_use_guitarist_commands
		if (<name> = Guitarist)
			if CompositeObjectExists \{name = bassist}
				LaunchEvent type = change_stance target = bassist data = {<...>}
			endif
		elseif (<name> = bassist)
			return
		endif
	endif
	LaunchEvent type = change_stance target = <name> data = {<...>}
endscript

script Band_StopStrumming \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> strum = none
endscript

script Band_EnableArms \{name = Guitarist
		blend_time = 0.25}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if (<name> = Guitarist || <name> = bassist)
		<name> :hero_toggle_arms num_arms = 2 pre_num_arms = 0 blend_time = <blend_time>
	else
		<name> :hero_enable_arms blend_time = <blend_time>
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> arms_disabled = 0
	change structurename = <info_struct> disable_arms = 0
endscript

script Band_DisableArms \{name = Guitarist
		blend_time = 0.25}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if (<name> = Guitarist || <name> = bassist)
		<name> :hero_toggle_arms num_arms = 0 pre_num_arms = 2 blend_time = <blend_time>
	else
		<name> :hero_disable_arms blend_time = <blend_time>
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> arms_disabled = 2
	change structurename = <info_struct> disable_arms = 2
endscript

script Band_SetPosition 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	char_name = <name>
	if GotParam \{index}
		get_waypoint_id index = <index>
		GetWaypointPos name = <waypoint_id>
		change structurename = <info_struct> target_node = <waypoint_id>
	elseif GotParam \{node}
		GetWaypointPos name = <node>
		change structurename = <info_struct> target_node = <node>
	endif
	<char_name> :Obj_SetPosition position = <pos>
endscript

script Band_DisableMovement 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> allow_movement = false
endscript

script Band_EnableMovement 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> allow_movement = true
endscript

script Band_WalkToNode \{name = Guitarist
		faceAudience = true}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($current_num_players = 2)
		return
	endif
	GetPakManCurrent \{map = Zones}
	GetPakManCurrentName \{map = Zones}
	FormatText \{textname = suffix
		'_TRG_Waypoint_Guitarist_Walk01'}
	AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
	waypoint_id = <appended_id>
	if NOT DoesWayPointExist name = <waypoint_id>
		return
	endif
	if ChecksumEquals a = <name> b = Guitarist
		if LocalizedStringEquals a = <node> b = "guitarist_start"
			SpawnScriptLater \{LightShow_WaitAndEnableSpotlights
				Params = {
					enable = false
					time = 4.0
				}}
		else
			SpawnScriptLater \{LightShow_WaitAndEnableSpotlights
				Params = {
					enable = true
					time = 1.5
				}}
		endif
	endif
	LaunchEvent type = walk target = <name> data = {<...> anim_set = $normal_walk_data}
endscript

script Band_TurnToFace \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_RotateToFaceNode \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_FaceNode \{name = Guitarist
		node = 1}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	get_waypoint_id index = <node>
	GetWaypointPos name = <waypoint_id>
	<name> :turn_to_face pos = <pos>
endscript

script Band_FaceAudience \{name = Guitarist}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :face_audience
endscript

script Band_PlayAttackAnim 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	attack_type = ($battlemode_powerups [<type>].name)
	if (($player1_status.band_Member) = <name>)
		battle_anims = player1_battlemode_anims
	elseif (($player2_status.band_Member) = <name>)
		battle_anims = player2_battlemode_anims
	else
		return
	endif
	if NOT structurecontains structure = $<battle_anims> name = <attack_type>
		return
	endif
	Anim = ($<battle_anims>.<attack_type>.attack_anim)
	if NOT (<Anim> = none)
		LaunchEvent type = play_battle_anim target = <name> data = {<...> no_wait}
	endif
endscript

script Band_PlayResponseAnim 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	attack_type = ($battlemode_powerups [<type>].name)
	if (($player1_status.band_Member) = <name>)
		battle_anims = player1_battlemode_anims
	elseif (($player2_status.band_Member) = <name>)
		battle_anims = player2_battlemode_anims
	else
		return
	endif
	if NOT structurecontains structure = $<battle_anims> name = <attack_type>
		return
	endif
	Anim = ($<battle_anims>.<attack_type>.response_anim)
	if NOT (<Anim> = none)
		LaunchEvent type = play_battle_anim target = <name> data = {<...>}
	endif
endscript

script bassist_should_use_guitarist_commands 
	if (($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff) || ($game_mode = p2_battle))
		if ($boss_battle = 0)
			return \{true}
		endif
	endif
	return \{false}
endscript
