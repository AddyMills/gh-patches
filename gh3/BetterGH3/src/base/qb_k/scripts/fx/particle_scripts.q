Force_Particle_Update_Time = 1.0

script CreateFlexibleParticleSystem \{groupID = 0}
	if GotParam \{PERM}
		PERM = 1
	else
		PERM = 0
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if NOT GotParam \{params_Script}
		if NOT GlobalExists name = <params_Script> type = structure
			printf "Global particle %s could not be found." s = <params_Script>
			return
		endif
	endif
	if NOT GotParam \{ObjID}
		obj_getid
	endif
	MangleChecksums a = <name> b = <ObjID>
	if NOT ObjectExists id = <mangled_ID>
		if CutsceneDestroyListActive
			AddToCutsceneDestroyList {
				destroy_func = DestroyFlexibleParticleSystem
				ignore_duplicates
				name = <mangled_ID>
				destroy_params = {name = <name> ObjID = <ObjID>}
			}
		endif
		alloc_flexible_particle params_Script = (<params_Script>) name = <mangled_ID> ObjID = <ObjID> Bone = <Bone> attachNode = <attachNode> Bone = <Bone> groupID = <groupID> PERM = <PERM>
	endif
endscript

script CreateFlexibleParticleSystem_Editor 
	killspawnedscript \{name = CreateFlexibleParticleSystem_Editor_Spawned}
	spawnscriptnow CreateFlexibleParticleSystem_Editor_Spawned Params = <...>
endscript

script CreateFlexibleParticleSystem_Editor_Spawned \{groupID = 0}
	if GotParam \{PERM}
		PERM = 1
	else
		PERM = 0
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if NOT GotParam \{ObjID}
		obj_getid
	endif
	if GotParam \{attachObjID}
		<ObjID> = <attachObjID>
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{ObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if (IsCreated <name>)
		<name> :Die
		Wait \{1
			frame}
	endif
	if (IsCreated <mangled_ID>)
		<mangled_ID> :Die
		Wait \{1
			frame}
	endif
	if NOT IsCreated <mangled_ID>
		if (GotParam attach)
			alloc_flexible_particle params_Script = (<params_Script>) name = <mangled_ID> ObjID = <attachObjID> attachNode = <attachNode> Bone = <Bone> groupID = <groupID> PERM = <PERM>
		else
			alloc_flexible_particle params_Script = (<params_Script>) name = <mangled_ID> groupID = <groupID> PERM = <PERM>
		endif
	endif
endscript

script GetFlexibleParticleSystem 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{ObjID}
		obj_getid
	endif
	MangleChecksums a = <name> b = <ObjID>
	if ObjectExists id = <mangled_ID>
		return systemID = <mangled_ID>
	endif
endscript

script DestroyFlexibleParticleSystem 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{ObjID}
		obj_getid
	endif
	MangleChecksums a = <name> b = <ObjID>
	if ObjectExists id = <mangled_ID>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <mangled_ID>
		endif
		<mangled_ID> :DestroyParticles
	endif
endscript

script DestroyFlexibleParticleSystem_Editor 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{ObjID}
		obj_getid
	endif
	MangleChecksums a = <name> b = <ObjID>
	if ObjectExists id = <name>
		<name> :DestroyParticles
	endif
	if ObjectExists id = <mangled_ID>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <mangled_ID>
		endif
		<mangled_ID> :DestroyParticles
	endif
endscript
LockableFlexibleParticleComponents = [
	{
		Component = lockobj
	}
	{
		Component = flexibleparticle
	}
]

script alloc_flexible_particle \{groupID = 0}
	if NOT CheckFlexibleParticleStructure <params_Script>
		printf \{"Invalid particle structure"}
		return
	endif
	if GotParam \{PERM}
		if (<PERM> = 1)
			priority = COIM_Priority_Permanent
			heap = GameObj
		else
			priority = COIM_Priority_Effects
			heap = particle
		endif
	else
		priority = COIM_Priority_Effects
		heap = particle
	endif
	CreateGameObject priority = <priority> heap = <heap> Components = $LockableFlexibleParticleComponents Params = {
		name = <name>
		<params_Script>
		IgnoreLockDie
		id = <ObjID>
		parent_object = <ObjID>
		Bone = <Bone>
		groupID = <groupID>
		attachNode = <attachNode>
		object_type = particle
	}
endscript
SuspendibleFlexibleParticleComponents = [
	{
		Component = flexibleparticle
	}
]
FlexibleParticleComponents = [
	{
		Component = flexibleparticle
	}
]

script CreateGlobalFlexParticlesystem \{groupID = 0}
	if NOT CheckFlexibleParticleStructure <params_Script>
		printf \{"Invalid particle structure"}
		return
	endif
	if GotParam \{PERM}
		priority = COIM_Priority_Permanent
		heap = GameObj
	else
		priority = COIM_Priority_Effects
		heap = particle
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if NOT GotParam \{params_Script}
		if NOT GlobalExists name = <params_Script> type = structure
			printf "Global particle %s could not be found." s = <params_Script>
			return
		endif
	endif
	if NOT ObjectExists id = <name>
		if CutsceneDestroyListActive
			AddToCutsceneDestroyList {
				destroy_func = DestroyGlobalFlexParticleSystem
				ignore_duplicates
				name = <name>
				destroy_params = {name = <name>}
			}
		endif
		if structurecontains \{structure = params_Script
				SuspendDistance}
			CreateGameObject priority = <priority> heap = <heap> Components = $SuspendibleFlexibleParticleComponents Params = {
				name = <name>
				<params_Script>
				groupID = <groupID>
				pos = <pos>
				object_type = particle
			}
		else
			CreateGameObject priority = <priority> heap = <heap> Components = $FlexibleParticleComponents Params = {
				name = <name>
				<params_Script>
				groupID = <groupID>
				pos = <pos>
				object_type = particle
			}
		endif
	endif
endscript

script DestroyGlobalFlexParticleSystem 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if ObjectExists id = <name>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <name>
		endif
		<name> :DestroyParticles
	endif
endscript

script CreateFastParticleSystem \{groupID = 0}
	CreateSplineParticleSystem Params = <...>
endscript

script CreateSplineParticleSystem \{groupID = 0}
	if GotParam \{PERM}
		PERM = 1
	else
		PERM = 0
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if NOT GotParam \{params_Script}
		if NOT GlobalExists name = <params_Script> type = structure
			printf "Global particle %s could not be found." s = <params_Script>
			return
		endif
	endif
	if GotParam \{attachObjID}
		<ObjID> = <attachObjID>
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{ObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if NOT IsCreated <mangled_ID>
		if CutsceneDestroyListActive
			AddToCutsceneDestroyList {
				destroy_func = DestroyFastParticleSystem
				ignore_duplicates
				name = <mangled_ID>
				destroy_params = {name = <name> attachObjID = <attachObjID>}
			}
		endif
		alloc_spline_particle {params_Script = <params_Script> name = <mangled_ID> attachObjID = <ObjID> ObjID = <ObjID> Bone = <Bone> groupID = <groupID>
			attachNode = <attachNode> emit_script = <emit_script> emit_params = <emit_params> PERM = <PERM> creation_node = <creation_node>}
	endif
	if ((IsCreated <mangled_ID>) && (GotParam ObjID) && (structurecontains structure = params_Script ApplyEnvBrightness))
		<mangled_ID> :ApplyEnvBrightness from = <ObjID>
	endif
	if IsCreated <mangled_ID>
		return systemID = <mangled_ID>
	endif
endscript

script CreateSplineParticleSystem_Editor 
	killspawnedscript \{name = CreateSplineParticleSystem_Editor_Spawned}
	spawnscriptnow CreateSplineParticleSystem_Editor_Spawned Params = <...>
endscript

script CreateSplineParticleSystem_Editor_Spawned \{groupID = 0}
	if GotParam \{PERM}
		PERM = 1
	else
		PERM = 0
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if GotParam \{attachObjID}
		<ObjID> = <attachObjID>
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{ObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if (IsCreated <name>)
		<name> :Die
		Wait \{1
			frame}
	endif
	if (IsCreated <mangled_ID>)
		<mangled_ID> :Die
		Wait \{1
			frame}
	endif
	if (IsCreated <mangled_ID>)
		<mangled_ID> :UpdateParams {params_Script = <params_Script>}
		if GotParam \{attach}
			<mangled_ID> :Obj_LockToObject objectname = <ObjID>
		else
			<mangled_ID> :Obj_LockToObject off objectname = <ObjID>
		endif
	else
		alloc_spline_particle {params_Script = <params_Script> name = <mangled_ID> attachObjID = <ObjID> ObjID = <ObjID> Bone = <Bone> groupID = <groupID>
			attachNode = <attachNode> emit_script = <emit_script> emit_params = <emit_params> PERM = <PERM> creation_node = <creation_node>}
	endif
endscript
SuspendibleFastParticleComponents = [
	{
		Component = particle
	}
]
FastParticleComponents = [
	{
		Component = particle
	}
]

script CreateGlobalFastParticleSystem \{groupID = 0}
	if NOT CheckSplineParticleStructure <params_Script>
		printf \{"Invalid particle structure"}
		return
	endif
	if GotParam \{PERM}
		priority = COIM_Priority_Permanent
		heap = GameObj
	else
		priority = COIM_Priority_Effects
		heap = particle
	endif
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if NOT GotParam \{params_Script}
		script_assert \{"No <params_script> parameter"}
	endif
	if NOT GotParam \{params_Script}
		if NOT GlobalExists name = <params_Script> type = structure
			printf "Global particle %s could not be found." s = <params_Script>
			return
		endif
	endif
	if NOT IsCreated <name>
		if CutsceneDestroyListActive
			AddToCutsceneDestroyList {
				destroy_func = DestroyGlobalFastParticleSystem
				ignore_duplicates
				name = <name>
				destroy_params = {name = <name>}
			}
		endif
		if structurecontains \{structure = params_Script
				SuspendDistance}
			CreateGameObject priority = <priority> heap = <heap> Components = SuspendibleFastParticleComponents Params = {
				name = <name>
				parent_object = <ObjID>
				groupID = <groupID>
				<params_Script>
				pos = <pos>
				object_type = particle
			}
		else
			CreateGameObject priority = <priority> heap = <heap> Components = $FastParticleComponents Params = {
				name = <name>
				parent_object = <ObjID>
				groupID = <groupID>
				<params_Script>
				pos = <pos>
				object_type = particle
			}
		endif
	endif
	if IsCreated <name>
		if GotParam \{emit_script}
			<name> :Obj_SpawnScriptLater <emit_script> Params = <emit_params>
		endif
	endif
endscript

script DestroyGlobalFastParticleSystem 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if ObjectExists id = <name>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <name>
		endif
		<name> :Die
	endif
endscript

script DestroyFastParticleSystem 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{attachObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if ObjectExists id = <mangled_ID>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <mangled_ID>
		endif
		<mangled_ID> :Die
	endif
endscript

script DestroyParticleSystem_Editor 
	killspawnedscript \{name = DestroyParticleSystem_Editor_Spawn}
	spawnscriptnow DestroyParticleSystem_Editor_Spawn Params = <...>
endscript

script DestroyParticleSystem_Editor_Spawn 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{attachObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if ObjectExists id = <mangled_ID>
		<mangled_ID> :Die
	endif
	if ObjectExists id = <name>
		<name> :Die
	endif
endscript

script DestroySplineParticleSystem_Editor 
	if NOT GotParam \{name}
		script_assert \{"No <name> parameter"}
	endif
	if GotParam \{ObjID}
		attachObjID = <ObjID>
	endif
	if GotParam \{attachObjID}
		MangleChecksums a = <name> b = <attachObjID>
	else
		<mangled_ID> = <name>
	endif
	if ObjectExists id = <mangled_ID>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <mangled_ID>
		endif
		<mangled_ID> :Die
	endif
	if ObjectExists id = <name>
		if CutsceneDestroyListActive
			RemoveFromCutsceneDestroyList name = <name>
		endif
		<name> :Die
	endif
endscript

script EmitFastParticles 
	if GotParam \{wait_frames}
		Wait <wait_frames> frames
	else
		Wait <wait_seconds> seconds
	endif
	SetEmitRate \{0}
	begin
	if NOT IsEmitting
		break
	endif
	Wait \{1
		frame}
	repeat
	Die
endscript
LockableSplineParticleComponents = [
	{
		Component = lockobj
	}
	{
		Component = particle
	}
]

script alloc_spline_particle \{groupID = 0}
	if NOT CheckSplineParticleStructure <params_Script>
		printf \{"Invalid particle structure"}
		return
	endif
	if GotParam \{PERM}
		if (<PERM> = 1)
			priority = COIM_Priority_Permanent
			heap = GameObj
		else
			priority = COIM_Priority_Effects
			heap = particle
		endif
	else
		priority = COIM_Priority_Effects
		heap = particle
	endif
	if NOT ObjectExists id = <name>
		if GotParam \{attachObjID}
			CreateGameObject priority = <priority> heap = <heap> Components = $LockableSplineParticleComponents Params = {
				name = <name>
				<params_Script>
				id = <attachObjID>
				IgnoreLockDie
				parent_object = <attachObjID>
				Bone = <Bone>
				groupID = <groupID>
				LocalSpace
				creation_node = <creation_node>
				object_type = particle
			}
		else
			CreateGameObject priority = <priority> heap = <heap> {
				Components = [
					{
						Component = particle
						name = <name>
						Bone = <Bone>
						groupID = <groupID>
						<params_Script>
					}
				]
				Params = {
					name = <name>
					Bone = <Bone>
					creation_node = <creation_node>
					object_type = particle
				}
			}
			if structurecontains \{structure = params_Script
					LocalSpace}
				if NOT structurecontains \{structure = params_Script
						boxPositions}
					printstruct <params_Script>
					script_assert \{"No <boxPositions> parameter...  system should not have been defined in LocalSpace"}
				endif
				if ObjectExists id = <name>
					<name> :SetStartPos (<params_Script>.boxPositions [1])
				endif
			endif
		endif
	endif
	if ObjectExists id = <name>
		if GotParam \{emit_script}
			<name> :Obj_SpawnScriptLater <emit_script> Params = <emit_params>
		endif
	endif
endscript

script alloc_fast_particle \{groupID = 0}
	if NOT GotParam \{params_Script}
		if NOT GlobalExists name = <params_Script> type = structure
			printf "Global particle %s could not be found." s = <params_Script>
			return
		endif
	endif
	if GotParam \{PERM}
		if (<PERM> = 1)
			priority = COIM_Priority_Permanent
			heap = GameObj
		else
			priority = COIM_Priority_Effects
			heap = particle
		endif
	else
		priority = COIM_Priority_Effects
		heap = particle
	endif
	if NOT ObjectExists id = <name>
		if GotParam \{attachObjID}
			CreateGameObject priority = <priority> heap = <heap> {
				Components = [
					{
						Component = lockobj
						id = <attachObjID>
						<params_Script>
						IgnoreLockDie
					}
					{
						Component = particle
						name = <name>
						groupID = <groupID>
						parent_object = <attachObjID>
						Bone = <Bone>
						<params_Script>
						systemLifetime = (<params_Script>.EmitDuration)
						systemLifetime = <systemLifetime>
					}
				]
				Params = {
					name = <name>
					Bone = <Bone>
					LocalSpace
					creation_node = <creation_node>
					object_type = particle
				}
			}
		else
			CreateGameObject priority = <priority> heap = <heap> {
				Components = [
					{
						Component = particle
						name = <name>
						Bone = <Bone>
						groupID = <groupID>
						<params_Script>
					}
				]
				Params = {
					name = <name>
					Bone = <Bone>
					creation_node = <creation_node>
					object_type = particle
				}
			}
			if structurecontains \{structure = params_Script
					LocalSpace}
				if NOT structurecontains \{structure = params_Script
						boxPositions}
					printstruct <params_Script>
					script_assert \{"No <boxPositions> parameter...  system should not have been defined in LocalSpace"}
				endif
				if ObjectExists id = <name>
					<name> :SetStartPos (<params_Script>.boxPositions [1])
				endif
			endif
		endif
	endif
	if ObjectExists id = <name>
		if GotParam \{emit_script}
			<name> :Obj_SpawnScriptLater <emit_script> Params = <emit_params>
		endif
	endif
endscript

script CreateGameObject 
	if IsCompositeObjectManagerEnabled
		CreateCompositeObject <...>
	else
		CreateCompositeObjectInstance <...>
	endif
endscript

script JOW_RGBAToVector \{rgba = [
			0
			0
			0
			0
		]}
	return rgb = (<rgba> [0] * (1.0, 0.0, 0.0) + <rgba> [1] * (0.0, 1.0, 0.0) + <rgba> [2] * (0.0, 0.0, 1.0)) a = (<rgba> [3])
endscript

script JOW_VectorToRGBA \{rgb = (0.0, 0.0, 0.0)
		a = 0}
	rgba = [0 0 0 0]
	val = (<rgb>.(1.0, 0.0, 0.0))
	casttointeger \{val}
	SetArrayElement ArrayName = rgba index = 0 newvalue = <val>
	val = (<rgb>.(0.0, 1.0, 0.0))
	casttointeger \{val}
	SetArrayElement ArrayName = rgba index = 1 newvalue = <val>
	val = (<rgb>.(0.0, 0.0, 1.0))
	casttointeger \{val}
	SetArrayElement ArrayName = rgba index = 2 newvalue = <val>
	casttointeger \{a}
	SetArrayElement ArrayName = rgba index = 3 newvalue = <a>
	return rgba = <rgba>
endscript

script Hero_ContinuousTerrainParticles_Off 
	ClearEventHandlerGroup
	SetEventHandler \{event = NewTerrainType
		Scr = Hero_ContinuousTerrainParticles_On
		response = switch_script}
	OnExceptionRun
	Block
endscript

script Hero_ContinuousTerrainParticles_On 
	GetTerrainTypeParam param = treadActions terrain_id = <TerrainType>
	if NOT structurecontains \{structure = treadActions
			HeroContinuousParticleParams}
		goto \{Hero_ContinuousTerrainParticles_Off}
	endif
	GetUniqueCompositeObjectID \{PreferredId = Hero_ContinuousTerrainParticles}
	ClearEventHandlerGroup
	SetEventHandler event = NewTerrainType Scr = Hero_ContinuousTerrainParticles_Switch response = switch_script Params = {ParticleId = <UniqueId>}
	OnExceptionRun
	begin
	if NOT CompositeObjectExists <UniqueId>
		CreateGameObject priority = COIM_Priority_Effects heap = particle OldHeap = COM Components = [
			{Component = flexibleparticle}
		] Params = {
			name = <UniqueId>
			(<treadActions>.HeroContinuousParticleParams)
			NoVisibilityTest
			object_type = particle
		}
	endif
	Obj_GetVelocity
	NormalizeVector <vel>
	Obj_GetPosition
	if CompositeObjectExists <UniqueId>
		<UniqueId> :Obj_SetPosition position = (((1.0, 0.0, 1.0) && <pos>) + (0.0, 1.0, 0.0) * <TerrainParticleHeight> + (((1.0, 0.0, 1.0) && <norm>) * 0.1 * <length>))
	endif
	Wait \{1
		GameFrame}
	repeat
endscript

script Hero_ContinuousTerrainParticles_Switch 
	if CompositeObjectExists <ParticleId>
		<ParticleId> :EmitRate rate = 0
		<ParticleId> :destroy ifEmpty = 1
	endif
	goto Hero_ContinuousTerrainParticles_On Params = <...>
endscript

script GetParticleType \{params_Script}
	type = FLEXIBLE
	if CheckFlexibleParticleStructure <params_Script>
		if GlobalExists name = <params_Script> type = structure
			if structurecontains structure = (<params_Script>) ParticleType
				switch (<params_Script>.ParticleType)
					case FlexParticle
					type = FLEXIBLE
					case SplineParticle
					type = Fast
				endswitch
			else
				if structurecontains structure = (<params_Script>) Class
					if ((<params_Script>.Class) = ParticleObject)
						type = Fast
					endif
				endif
			endif
		endif
	endif
	if CheckSplineParticleStructure <params_Script>
		if GlobalExists name = <params_Script> type = structure
			if structurecontains structure = (<params_Script>) ParticleType
				switch (<params_Script>.ParticleType)
					case FlexParticle
					type = FLEXIBLE
					case SplineParticle
					type = Fast
				endswitch
			else
				if structurecontains structure = (<params_Script>) Class
					if ((<params_Script>.Class) = ParticleObject)
						type = Fast
					endif
				endif
			endif
		endif
	endif
	return type = <type>
endscript

script WaterRippleGenerated 
endscript
