script songunloadfsbifdownloaded 
	getcontentfolderindexfromfile ($song_fsb_name)
	if NOT ($song_fsb_id = -1)
		if (<device> = content)
			unloadfsb \{fsb_index = $song_fsb_id}
			spawnscriptnow downloads_closecontentfolder params = {content_index = <content_index>}
			change \{song_fsb_id = -1}
			change \{song_fsb_name = 'none'}
		endif
	endif
endscript
