script quickplay_choose_random_venue 
	if NOT GotParam \{can_change_level}
		can_change_level = 1
	endif
	unlocked_levels = []
	GetArraySize \{$LevelZoneArray}
	level_zone_array_size = <array_size>
	index = 0
	begin
	get_LevelZoneArray_checksum index = <index>
	if NOT StructureContains Structure = ($LevelZones.<level_checksum>) debug_only
		if NOT StructureContains Structure = ($LevelZones.<level_checksum>) lnlwl_norandom
			FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.name)
			GetGlobalTags <venue_checksum> param = unlocked
			add_venue = 0
			if (<unlocked> = 1)
				add_venue = 1
			endif
			if ($Cheat_UnlockATTBallpark = 1)
				if (<level_checksum> = load_z_Ballpark)
					add_venue = 1
				endif
			endif
			if (<add_venue> = 1)
				AddArrayElement array = <unlocked_levels> element = <level_checksum>
				<unlocked_levels> = <array>
			endif
		endif
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	GetArraySize <unlocked_levels>
	if (<can_change_level> = 1)
		if (<array_size> != 0)
			GetRandomValue a = 0 b = (<array_size> - 1) Integer name = random_int
			change current_level = (<unlocked_levels> [<random_int>])
		else
			change \{current_level = load_z_bayou}
		endif
	endif
endscript


LevelZones = {
	$download_LevelZones
	load_z_soundcheck = {
		zone = z_soundcheck
		name = 'z_soundcheck'
		title = qs("\Lsoundcheck")
		debug_only
	}
	load_z_soundcheck_practice = {
		zone = z_soundcheck_practice
		name = 'z_soundcheck_practice'
		title = qs("\Lsoundcheck_practice")
		debug_only
	}
	load_z_credits = {
		zone = z_credits
		name = 'z_credits'
		title = qs("\LSunna's Chariot")
	}
	viewer = {
		zone = z_viewer
		name = 'z_viewer'
		title = qs("\Lviewer")
		debug_only
	}
	load_z_viewer = {
		zone = z_viewer
		name = 'z_viewer'
		title = qs("\Lviewer")
		debug_only
	}
	load_z_Template = {
		zone = z_template
		name = 'z_Template'
		title = qs("\LTemplate")
		debug_only
	}
	load_z_bayou = {
		zone = z_bayou
		name = 'z_Bayou'
		title = qs("\LSwamp Shack")
		bG = menu_venue_poster_bayou
	}
	load_z_castle = {
		zone = z_castle
		name = 'z_Castle'
		title = qs("\LWill Heilm's Keep")
		bG = menu_venue_poster_castle
	}
	load_z_fairgrounds = {
		zone = z_fairgrounds
		name = 'z_Fairgrounds'
		title = qs("\LStrutter's Farm")
		bG = menu_venue_poster_fairgrounds
	}
	load_z_Frathouse = {
		zone = z_frathouse
		name = 'z_Frathouse'
		title = qs("\LPhi Psi Kappa")
		bG = menu_venue_poster_frathouse
	}
	load_z_goth = {
		zone = z_goth
		name = 'z_Goth'
		title = qs("\LWilted Orchid")
		bG = menu_venue_poster_goth
	}
	load_z_newyork = {
		zone = z_newyork
		name = 'z_NewYork'
		title = qs("\LTimes Square")
		bG = menu_venue_poster_newyork
	}
	load_z_recordstore = {
		zone = z_recordstore
		name = 'z_Recordstore'
		title = qs("\LAmoeba Records")
		bG = menu_venue_poster_recordstore
	}
	load_z_metalfest = {
		zone = z_metalfest
		name = 'z_Metalfest'
		title = qs("\LOzzfest")
		bG = menu_venue_poster_metalfest
	}
	load_z_Ballpark = {
		zone = z_ballpark
		name = 'z_Ballpark'
		title = qs("\LAT&T Park")
	}
	load_z_military = {
		zone = z_military
		name = 'z_Military'
		title = qs("\LRock Brigade")
	}
	load_z_Hotel = {
		zone = z_hotel
		name = 'z_Hotel'
		title = qs("\LTed's Tiki Hut")
	}
	load_z_cathedral = {
		zone = z_cathedral
		name = 'z_Cathedral'
		title = qs("\LBone Church")
	}
	load_z_harbor = {
		zone = z_harbor
		name = 'z_Harbor'
		title = qs("\LPang Tang Bay")
	}
	load_z_hob = {
		zone = z_hob
		name = 'z_HoB'
		title = qs("\LHouse of Blues")
	}
	load_z_tool = {
		zone = z_tool
		name = 'z_Tool'
		title = qs("\LTool")
		lnlwl_norandom
	}
	load_z_board_room = {
		zone = z_board_room
		name = 'z_Board_Room'
		title = qs("\LBoard Room")
		debug_only
	}
	load_z_whitebox = {
		zone = z_Whitebox
		name = 'z_Whitebox'
		title = qs("\LWhite Box")
		debug_only
	}
	load_z_test01 = {
		zone = z_test01
		name = 'z_test01'
		title = qs("\LAndyM Test")
		debug_only
	}
	load_z_studio = {
		zone = z_studio
		name = 'z_Studio'
		title = qs("\LRecording Studio")
		debug_only
	}
	load_z_Studio2 = {
		zone = z_studio2
		name = 'z_Studio2'
		title = qs("\LRecording Studio")
	}
	load_z_Scifi = {
		zone = z_scifi
		name = 'z_Scifi'
		title = qs("\LTesla's Coil")
	}
}
