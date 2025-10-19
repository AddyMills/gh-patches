GH3_Download_Songs = {
	prefix = 'download'
	num_tiers = 1
	tier1 = {
		title = "Downloaded songs"
		songs = [
			DLC3
			DLC4
			dlc5
			dlc6
			dlc7
			dlc8
			dlc1
			dlc2
			DLC17
			DLC14
			DLC15
			DLC16
			DLC19
			DLC26
			DLC18
			dlc9
			DLC11
			DLC12
			DLC13
			DLC36
			DLC10
			DLC24
			DLC25
			DLC37
			DLC29
			DLC30
			DLC31
			DLC27
			DLC28
			DLC32
			DLC38
			DLC39
			DLC40
			DLC49
			DLC50
			DLC51
			DLC33
			DLC34
			DLC35
			DLC45
			DLC46
			DLC47
			DLC61
			DLC68
			DLC69
			DLC70
			DLC71
			DLC72
			DLC73
			DLC75
			DLC74
			DLC62
			DLC63
			DLC66
			DLC80
			DLC81
			DLC82
			dlc85
			dlc89
			dlc87
			dlc86
			dlc84
			DLC91
			DLC90
			dlc88
			DLC92
			DLC93
			DLC83
		]
		unlockall
		level = load_z_artdeco
	}
}

script downloads_opencontentfolder 
	unpausespawnedscript \{downloads_closecontentfolder}
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
	wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 1}
	if NOT opencontentfolder content_index = <content_index>
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	getcontentfolderstate
	if (<contentfolderstate> = failed)
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	if (<contentfolderstate> = opened)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
	change downloadcontentfolder_index = <content_index>
	mark_safe_for_shutdown
	return \{true}
endscript

script downloads_closecontentfolder \{force = 0}
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
	if NOT closecontentfolder content_index = <content_index>
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	getcontentfolderstate
	if (<contentfolderstate> = free)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 0}
	mark_safe_for_shutdown
	return \{true}
endscript

script downloadcontentlost 
	change \{is_changing_levels = 0}
	change \{practice_songpreview_changing = 0}
	printscriptinfo \{"DownloadContentLost"}
	spawnscriptnow \{noqbid
		downloadcontentlost_spawned}
	killspawnedscript \{name = setlist_choose_song}
	killspawnedscript \{name = downloadcontentlost}
endscript
