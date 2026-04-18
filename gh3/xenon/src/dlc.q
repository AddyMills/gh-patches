
script setlist_songpreview_monitor 
	begin
	if NOT ($current_setlist_songpreview = $target_setlist_songpreview)
		change \{setlist_songpreview_changing = 1}
		song = ($target_setlist_songpreview)
		SongUnLoadFSB
		Wait \{0.5
			second}
		if ($target_setlist_songpreview != <song> || $target_setlist_songpreview = none)
			change \{current_setlist_songpreview = none}
			change \{setlist_songpreview_changing = 0}
		else
			get_song_prefix song = <song>
			get_song_struct song = <song>
			if structurecontains structure = <song_struct> streamname
				song_prefix = (<song_struct>.streamname)
			endif
			if NOT SongLoadFSB song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			FormatText checksumname = song_preview '%s_preview' s = <song_prefix>
			get_song_struct song = <song>
			SoundBussUnlock \{Music_Setlist}
			if structurecontains structure = <song_struct> name = band_playback_volume
				setlistvol = ((<song_struct>.band_playback_volume))
				SetSoundBussParams {Music_Setlist = {vol = <setlistvol>}}
			else
				SetSoundBussParams \{Music_Setlist = {
						vol = 0.0
					}}
			endif
			SoundBussLock \{Music_Setlist}
			PlaySound <song_preview> buss = Music_Setlist
			change current_setlist_songpreview = <song>
			change \{setlist_songpreview_changing = 0}
		endif
	elseif NOT ($current_setlist_songpreview = none)
		song = ($current_setlist_songpreview)
		get_song_prefix song = <song>
		FormatText checksumname = song_preview '%s_preview' s = <song_prefix>
		if NOT issoundplaying <song_preview>
			change \{setlist_songpreview_changing = 1}
			if NOT SongLoadFSB song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			PlaySound <song_preview> buss = Music_Setlist
			change \{setlist_songpreview_changing = 0}
		endif
	endif
	Wait \{1
		GameFrame}
	repeat
endscript

script downloadcontentlost 
	change \{is_changing_levels = 0}
	change \{practice_songpreview_changing = 0}
	printscriptinfo \{"DownloadContentLost"}
	spawnscriptnow \{noqbid
		DownloadContentLost_Spawned}
	killspawnedscript \{name = setlist_choose_song}
	killspawnedscript \{name = downloadcontentlost}
endscript

script SongUnLoadFSBIfDownloaded 
	GetContentFolderIndexFromFile ($song_fsb_name)
	if NOT ($song_fsb_id = -1)
		if (<device> = content)
			UnLoadFSB \{fsb_index = $song_fsb_id}
			spawnscriptnow Downloads_CloseContentFolder Params = {content_index = <content_index>}
			change \{song_fsb_id = -1}
			change \{song_fsb_name = 'none'}
		endif
	endif
endscript

script Downloads_CloseContentFolder \{force = 0}
	mark_unsafe_for_shutdown
	if (<force> = 1)
		if ($downloadcontentfolder_index = -1)
			mark_safe_for_shutdown
			return
		endif
	endif
	if (<force> = 1)
		change \{downloadcontentfolder_count = 0}
	else
		change downloadcontentfolder_count = ($downloadcontentfolder_count - 1)
		if ($downloadcontentfolder_count > 0)
			mark_safe_for_shutdown
			return \{true}
		endif
	endif
	if (<force> = 1)
		content_index = ($downloadcontentfolder_index)
	else
		change \{downloadcontentfolder_index = -1}
	endif
	if NOT CloseContentFolder content_index = <content_index>
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = free)
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	change \{downloadcontentfolder_lock = 0}
	mark_safe_for_shutdown
	return \{true}
endscript

script Downloads_OpenContentFolder 
	unpausespawnedscript \{Downloads_CloseContentFolder}
	mark_unsafe_for_shutdown
	begin
	if ($downloadcontentfolder_lock = 0)
		break
	endif
	if ($downloadcontentfolder_index = <content_index>)
		change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
		mark_safe_for_shutdown
		return \{true}
	endif
	Wait \{1
		GameFrame}
	repeat
	change \{downloadcontentfolder_lock = 1}
	if NOT OpenContentFolder content_index = <content_index>
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = failed)
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	if (<contentfolderstate> = opened)
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
	change downloadcontentfolder_index = <content_index>
	mark_safe_for_shutdown
	return \{true}
endscript

script crowd_monitor_performance 
	lighters_on = false
	begin
	get_skill_level
	if ($current_song = DLC19)
		skill = good
	endif
	if (<skill> != Bad)
		if (<lighters_on> = false)
			Crowd_AllSetHand \{Hand = right
				type = lighter}
			Crowd_AllPlayAnim \{Anim = special}
			lighters_on = true
			Crowd_ToggleLighters \{on}
		endif
	else
		if (<lighters_on> = true)
			Crowd_AllSetHand \{Hand = right
				type = clap}
			Crowd_AllPlayAnim \{Anim = idle}
			lighters_on = false
			Crowd_ToggleLighters \{off}
		endif
	endif
	Wait \{1
		GameFrame}
	repeat
endscript

script Transition_StartRendering 
	printf \{"Transition_StartRendering"}
	startrendering
	enable_pause
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		gh3_start_pressed
	endif
	if ($current_song = DLC19)
		crowd_create_lighters
		Crowd_StartLighters
	endif
endscript

script first_gem_fx 
	ExtendCRC <gem_id> '_particle' out = fx_id
	if GotParam \{is_star}
		if ($game_mode = p2_battle || $boss_battle = 1)
			<pos> = (125.0, 170.0)
		else
			if ($player1_status.star_power_used = 1)
				<pos> = (95.0, 20.0)
			else
				<pos> = (255.0, 170.0)
			endif
		endif
	else
		<pos> = (66.0, 20.0)
	endif
	destroy2dparticlesystem id = <fx_id>
	create2dparticlesystem {
		id = <fx_id>
		pos = <pos>
		z_priority = 8.0
		material = sys_Particle_lnzflare02_sys_Particle_lnzflare02
		parent = <gem_id>
		start_color = [255 255 255 255]
		end_color = [255 255 255 0]
		start_scale = (1.0, 1.0)
		end_scale = (2.0, 2.0)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 0.0
		emit_rate = 0.3
		emit_dir = 0.0
		emit_spread = 160.0
		velocity = 0.01
		friction = (0.0, 0.0)
		time = 1.25
	}
	spawnscriptnow destroy_first_gem_fx Params = {gem_id = <gem_id> fx_id = <fx_id>}
	Wait \{0.8
		seconds}
	destroy2dparticlesystem id = <fx_id> kill_when_empty
endscript
