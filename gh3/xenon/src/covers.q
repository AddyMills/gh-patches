// addy did this

song_covers_wavegroup = {
	slowride
	blacksunshine
	cliffsofdover
	holidayincambodia
	storyofmylife
	shebangsadrum
}
song_covers_steve = {
	barracuda
	citiesonflame
	hitmewithyourbestshot
	mississippiqueen
	rockulikeahurricane
	schoolsout
	talkdirtytome
}
song_covers_line6 = {
	blackmagicwoman
	lagrange
	paranoid
	pridenjoy
	rocknrollallnite
	theseeker
	sunshineofyourlove
}

script get_song_covered_by \{song = invalid}
	if structurecontains structure = $gh3_songlist_props <song>
		if structurecontains structure = ($gh3_songlist_props.<song>) covered_by
			return covered_by = ($gh3_songlist_props.<song>.covered_by) true
		elseif structurecontains structure = $song_covers_wavegroup ($gh3_songlist_props.<song>.checksum)
			return covered_by = "WaveGroup" true
		elseif structurecontains structure = $song_covers_steve ($gh3_songlist_props.<song>.checksum)
			return covered_by = "Steve Ouimette" true
		elseif structurecontains structure = $song_covers_line6 ($gh3_songlist_props.<song>.checksum)
			return covered_by = "Line 6" true
		else
			return \{false}
		endif
	endif
	printstruct <...>
	scriptassert \{"Song not found"}
endscript

script destroy_intro 
	killspawnedscript \{id = intro_scripts}
	killspawnedscript \{name = Song_Intro_Kick_SFX_Waiting}
	killspawnedscript \{name = Song_Intro_Highway_Up_SFX_Waiting}
	killspawnedscript \{name = move_highway_2d}
	killspawnedscript \{name = intro_buttonup_ripple}
	killspawnedscript \{name = intro_hud_move}
	doScreenElementMorph \{id = intro_song_info_text
		alpha = 0}
	doScreenElementMorph \{id = intro_artist_info_text
		alpha = 0}
	doScreenElementMorph \{id = intro_performed_by_text
		alpha = 0}
	if ScreenElementExists \{id = intro_covered_by}
		DestroyScreenElement \{id = intro_covered_by}
	endif
	if ScreenElementExists \{id = intro_covered_by_text}
		DestroyScreenElement \{id = intro_covered_by_text}
	endif
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	EnableInput controller = ($<player_status>.controller)
	player = (<player> + 1)
	repeat $current_num_players
endscript

script intro_song_info 
	begin
	GetSongTimeMs
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	Wait \{1
		GameFrame}
	repeat
	if ($current_intro.song_title_on_time = 0)
		return
	endif
	get_song_title song = ($current_song)
	GetUpperCaseString <song_title>
	intro_song_info_text :SetProps text = <uppercasestring>
	intro_song_info_text :domorph pos = ($current_intro.song_title_pos)
	get_song_artist song = ($current_song)
	GetUpperCaseString <song_artist>
	intro_artist_info_text :SetProps text = <uppercasestring>
	intro_artist_info_text :domorph pos = ($current_intro.song_artist_pos)
	get_song_artist_text song = ($current_song)
	GetUpperCaseString <song_artist_text>
	intro_performed_by_text :SetProps text = <uppercasestring>
	intro_performed_by_text :domorph pos = ($current_intro.performed_by_pos)
	get_song_covered_by song = ($current_song)
	if GotParam \{covered_by}
		GetUpperCaseString <covered_by>
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = intro_covered_by_text
			font = text_a10
			just = [
				left
				top
			]
			scale = (1.0, 0.5)
			rgba = [
				230
				205
				160
				255
			]
			text = "COVERED BY"
			z_priority = 5.0
			alpha = 0
			shadow
			shadow_offs = (1.0, 1.0)}
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = intro_covered_by
			font = text_a10
			just = [
				left
				top
			]
			scale = 1.0
			rgba = [
				255
				190
				70
				255
			]
			text = "Coverer"
			z_priority = 5.0
			alpha = 0
			shadow
			shadow_offs = (1.0, 1.0)}
		intro_covered_by_text :domorph pos = ((255.0, 200.0))
		intro_covered_by :SetProps text = <uppercasestring>
		intro_covered_by :domorph pos = ((255.0, 215.0))
	endif
	intro_song_info_text :SetProps \{z_priority = 5.0}
	intro_artist_info_text :SetProps \{z_priority = 5.0}
	intro_performed_by_text :SetProps \{z_priority = 5.0}
	doScreenElementMorph id = intro_song_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	doScreenElementMorph id = intro_performed_by_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	doScreenElementMorph id = intro_artist_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	if GotParam \{covered_by}
		doScreenElementMorph id = intro_covered_by_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_covered_by alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	endif
	Wait ($current_intro.song_title_on_time / 1000.0) seconds
	doScreenElementMorph id = intro_song_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	doScreenElementMorph id = intro_artist_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	doScreenElementMorph id = intro_performed_by_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	if GotParam \{covered_by}
		doScreenElementMorph id = intro_covered_by_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_covered_by alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		Wait ($current_intro.song_title_fade_time / 1000.0) seconds
		DestroyScreenElement \{id = intro_covered_by_text}
		DestroyScreenElement \{id = intro_covered_by}
	endif
endscript
