// "Quickplay Songs" cheat unlocks PullMeUnder

script IsSongAvailable \{for_bonus = 0}
	GameMode_GetType
	check_allowed_in_quickplay = 0
	if (($is_network_game = 1) || (<type> = quickplay) || (<type> = training))
		check_allowed_in_quickplay = 1
	endif
	if (($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff) || ($game_mode = p2_battle))
		check_allowed_in_quickplay = 1
	endif
	if (<check_allowed_in_quickplay> = 1)
		get_song_allowed_in_quickplay song = <song>
		if (<allowed_in_quickplay> = 0)
			return \{false}
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) never_show_in_setlist
		return \{false}
	endif
	if ($is_network_game = 1)
		if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_vocals
			GameMode_GetNumPlayers
			<player_idx> = 1
			begin
			GetPlayerInfo <player_idx> part
			if (<part> = Vocals)
				return \{false}
			endif
			<player_idx> = (<player_idx> + 1)
			repeat <num_players>
		endif
		if NOT is_song_downloaded song_checksum = <song>
			return \{false}
		endif
		if GlobalTagExists <song> noassert = 1
			GetGlobalTags <song>
			if ($net_match_dlc_sync_finished = 1)
				if (<available_on_other_client> = 0)
					return \{false}
				endif
			elseif (<download> = 1)
				return \{false}
			endif
		endif
		if ($is_multiplayer_beta = 0)
			get_song_saved_in_globaltags song = <song>
			if (<saved_in_globaltags> = 1)
				return \{true}
			endif
		else
			GetArraySize \{$OnlineBetaSongs}
			if (<array_size> > 0)
				index = 0
				begin
				if (<song> = ($OnlineBetaSongs [<index>]))
					return \{true}
				endif
				<index> = (<index> + 1)
				repeat <array_size>
			endif
		endif
	else
		if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_vocals
			GameMode_GetNumPlayers
			GameMode_GetProperty \{prop = cooperative}
			if (<cooperative> = false)
				GameMode_GetProperty \{prop = faceoff}
				<should_disallow_vocals> = false
				if (<num_players> = 2 && <faceoff> = true)
					<should_disallow_vocals> = true
				elseif (<num_players> = 1)
					<should_disallow_vocals> = true
				endif
				if (<should_disallow_vocals> = true)
					<player_idx> = 1
					begin
					GetPlayerInfo <player_idx> controller
					if NOT IsGuitarController controller = <controller>
						if NOT IsDrumController controller = <controller>
							return \{false}
						endif
					endif
					<player_idx> = (<player_idx> + 1)
					repeat <num_players>
				endif
			endif
		endif
		if NOT is_song_downloaded song_checksum = <song>
			return \{false}
		endif
		if (<download> = 1)
			return \{true}
		endif
		if StructureContains Structure = ($gh_songlist_props.<song>) always_unlocked
			return \{true}
		endif
		get_song_saved_in_globaltags song = <song>
		if (<saved_in_globaltags> = 1)
			GetGlobalTags <song> param = unlocked
			if (<unlocked> = 1)
				return \{true}
			endif
			GetGlobalTags \{user_options}
			if (<cheat_index13> = 1)
				//if (<song> != PullMeUnder)
					return \{true}
				//endif
			endif
		endif
	endif
	return \{false}
endscript