script setlist_songpreview_monitor 
	begin
	if NOT ($current_setlist_songpreview = $target_setlist_songpreview)
		change \{setlist_songpreview_changing = 1}
		song = ($target_setlist_songpreview)
		songunloadfsb
		wait \{0.5
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
			if NOT songloadfsb song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			formattext checksumname = song_preview '%s_preview' s = <song_prefix>
			get_song_struct song = <song>
			soundbussunlock \{music_setlist}
			if structurecontains structure = <song_struct> name = band_playback_volume
				setlistvol = ((<song_struct>.band_playback_volume))
				setsoundbussparams {music_setlist = {vol = <setlistvol>}}
			else
				setsoundbussparams \{music_setlist = {
						vol = 0.0
					}}
			endif
			soundbusslock \{music_setlist}
			playsound <song_preview> buss = music_setlist
			change current_setlist_songpreview = <song>
			change \{setlist_songpreview_changing = 0}
		endif
	elseif NOT ($current_setlist_songpreview = none)
		song = ($current_setlist_songpreview)
		get_song_prefix song = <song>
		formattext checksumname = song_preview '%s_preview' s = <song_prefix>
		if NOT issoundplaying <song_preview>
			change \{setlist_songpreview_changing = 1}
			if NOT songloadfsb song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			playsound <song_preview> buss = music_setlist
			change \{setlist_songpreview_changing = 0}
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript
