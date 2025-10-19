guitar_select_available_guitar_array = [
]
guitar_select_available_bass_array = [
]
guitar_select_guitar_indeces = [
]
guitar_select_bass_indeces = [
]
g_old_selected_guitar_index_p1 = 0
g_old_selected_guitar_index_p2 = 0
guitar_select_old_guitar_p1 = 0
guitar_select_old_guitar_p2 = 0
guitar_select_highlighted_guitar_p1 = 0
guitar_select_highlighted_guitar_p2 = 0
guitar_select_total_num_guitars = 0
gs_selected_brand_p1 = 0
gs_old_selected_brand_p1 = 0
gs_selected_brand_p2 = 0
gs_old_selected_brand_p2 = 0
gs_made_first_selection_bool_p1 = 0
gs_made_first_selection_bool_p2 = 0
gs_guitar_brand_ID_p1 = null
gs_guitar_finish_ID_p1 = null
gs_guitar_brand_ID_p2 = null
gs_guitar_finish_ID_p2 = null
gh_net_finish_id = 0
online_guitar_highlighted_id_p1 = Instrument_ES335_Red
online_guitar_highlighted_id_p2 = Instrument_ES335_Red
online_old_guitar_id_p1 = Instrument_ES335_Red
online_old_guitar_id_p2 = Instrument_ES335_Red
gs_instrument_blurb_text = "DEFAULT INSTRUMENT BLURB"
gs_select_text = "SELECT GUITAR"
gs_element_offsets = [
	(0.0, 125.0)
	(-4.0, 185.0)
	(-4.0, 200.0)
	(-4.0, 268.0)
	(-100.0, 304.0)
	(0.0, 612.0)
]

script create_select_bass_menu 
	create_select_guitar_menu player = <player> instrument_type = Bass
endscript

script create_select_guitar_menu \{player = 1
		instrument_type = guitar}
	if (<player> = 1)
		change \{gs_made_first_selection_bool_p1 = 0}
	else
		change \{gs_made_first_selection_bool_p2 = 0}
	endif
	build_gs_available_guitar_array <...>
	FormatText checksumname = player_status 'player%i_status' i = <player>
	if find_profile_by_id id = ($<player_status>.character_id)
		get_musician_profile_struct index = <index>
		FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player>
		if GetGlobalTags <default_characterguitartag> noassert = 1
			if ((<instrument_type> = Bass))
				if (<current_instrument> = guitar)
					change structurename = <player_status> instrument_id = <current_selected_bass>
					SetGlobalTags <default_characterguitartag> params = {current_instrument = Bass}
					FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
					change globalname = <change_flag> newvalue = 1
				endif
			elseif ((<instrument_type> = guitar))
				if (<current_instrument> = Bass)
					change structurename = <player_status> instrument_id = <current_selected_guitar>
					SetGlobalTags <default_characterguitartag> params = {current_instrument = guitar}
					FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
					change globalname = <change_flag> newvalue = 1
				endif
			endif
		endif
	endif
	if (<instrument_type> = guitar)
		FormatText \{checksumname = guitar_select_available_instruments
			'guitar_select_available_guitar_array'}
	else
		FormatText \{checksumname = guitar_select_available_instruments
			'guitar_select_available_bass_array'}
	endif
	select_guitar_build_brand_array instrument_type = guitar gs_available_instruments = <guitar_select_available_instruments> player = <player>
	exclusive_dev = $player1_device
	if (($is_network_game) = 1)
		<exclusive_dev> = $primary_controller
	else
		if (<player> = 2)
			<exclusive_dev> = $player2_device
		endif
	endif
	event_handlers = [
		{pad_up gs_scroll_up_or_down params = {
				player = <player>
				dir = up
				gs_available_instruments = <guitar_select_available_instruments>
				gs_available_brands = <gs_available_brands>
				instrument_type = <instrument_type>
			}
		}
		{pad_down gs_scroll_up_or_down params = {
				player = <player>
				dir = down
				gs_available_instruments = <guitar_select_available_instruments>
				gs_available_brands = <gs_available_brands>
				instrument_type = <instrument_type>
			}
		}
		{pad_back select_guitar_go_back params = {
				player = <player>
				gs_available_instruments = <guitar_select_available_instruments>
				instrument_type = <instrument_type>
			}
		}
		{pad_choose select_guitar_choose params = {
				guitar_index = $guitar_select_highlighted_guitar_p1
				player = <player>
				gs_available_instruments = <guitar_select_available_instruments>
				gs_available_brands = <gs_available_brands>
				instrument_type = <instrument_type>
			}
		}
	]
	if (<player> = 1)
		if ($current_num_players = 1)
			new_menu {
				scrollid = scrolling_select_guitar_p1
				vmenuid = vmenu_select_guitar_p1
				menu_pos = (120.0, 190.0)
				use_backdrop = 0
				event_handlers = <event_handlers>
				no_focus = 1
			}
			vparent = vmenu_select_guitar_p1
		else
			new_menu {
				scrollid = scrolling_select_guitar_p1
				vmenuid = vmenu_select_guitar_p1
				menu_pos = (120.0, 190.0)
				use_backdrop = 0
				event_handlers = <event_handlers>
				exclusive_device = <exclusive_dev>
				no_focus = 1
			}
			vparent = vmenu_select_guitar_p1
		endif
	else
		new_menu {
			scrollid = scrolling_select_guitar_p2
			vmenuid = vmenu_select_guitar_p2
			menu_pos = (700.0, 120.0)
			use_backdrop = 0
			event_handlers = <event_handlers>
			exclusive_device = <exclusive_dev>
			no_focus = 1
		}
		if ($is_network_game = 1)
			vmenu_select_guitar_p2 :SetProps \{disable_pad_handling}
			LaunchEvent \{type = unfocus
				target = vmenu_select_guitar_p2}
		endif
		vparent = vmenu_select_guitar_p2
	endif
	if ($current_num_players = 1)
		FormatText checksumname = player_status 'player%i_status' i = <player>
		their_instrument_id = ($<player_status>.instrument_id)
		get_instrument_name_and_index id = <their_instrument_id>
		select_guitar_get_available_index_from_total_index index = <instrument_index> gs_available_instruments = <guitar_select_available_instruments>
		change guitar_select_highlighted_guitar_p1 = <index>
		change guitar_select_old_guitar_p1 = <index>
		get_musician_instrument_struct index = <instrument_index>
		change gs_instrument_blurb_text = (<info_struct>.blurb)
		CreateScreenElement \{type = ContainerElement
			id = select_guitar_container
			parent = root_window
			pos = (386.0, 0.0)}
		<brown_window_color> = [120 60 10 255]
		<window_fill_color> = [0 0 0 200]
		<cs_menu_starting_pos> = (0.0, 110.0)
		displaySprite {
			parent = select_guitar_container
			tex = window_frame_cap
			pos = <cs_menu_starting_pos>
			dims = (256.0, 64.0)
			just = [center center]
			rgba = <brown_window_color>
			z = 0
		}
		displaySprite {
			parent = select_guitar_container
			tex = window_fill_cap
			pos = <cs_menu_starting_pos>
			dims = (256.0, 64.0)
			just = [center center]
			rgba = <window_fill_color>
			z = 0
		}
		displaySprite {
			parent = select_guitar_container
			tex = window_header_01
			pos = (<cs_menu_starting_pos> + (0.0, -40.0))
			dims = (256.0, 64.0)
			just = [center center]
			rgba = [200 200 200 255]
			z = 1
		}
		displaySprite {
			parent = select_guitar_container
			tex = window_frame_body_tall
			pos = (<cs_menu_starting_pos> + (0.0, 32.0))
			dims = (256.0, 434.0)
			just = [center top]
			rgba = <brown_window_color>
			z = 0
		}
		displaySprite {
			parent = select_guitar_container
			tex = window_fill_body_large
			pos = (<cs_menu_starting_pos> + (0.0, 32.0))
			dims = (256.0, 498.0)
			just = [center top]
			rgba = <window_fill_color>
			z = 0
		}
		CreateScreenElement {
			type = SpriteElement
			parent = select_guitar_container
			pos = (<cs_menu_starting_pos> + (-2.0, 430.0))
			dims = (242.0, 128.0)
			just = [center top]
			texture = store_frame_bottom_bg
			z_priority = 1
			rgba = <brown_window_color>
			flip_h
			flip_v
		}
		displayText {
			parent = select_guitar_container
			text = "SELECT GUITAR"
			pos = ($gs_element_offsets [0])
			scale = (0.6, 0.55)
			font = fontgrid_title_gh3
			just = [center center]
			rgba = [185 100 60 255]
			z = 1
		}
		displaySprite {
			id = gs_brand_background
			parent = select_guitar_container
			tex = Char_Select_Frame_BG
			pos = ($gs_element_offsets [2])
			dims = (266.0, 128.0)
			just = [center center]
			rgba = [250 250 200 255]
			z = 1
		}
		get_instrument_brand_and_finish id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p1])
		displayText {
			parent = select_guitar_container
			text = <instrument_brand>
			pos = (($gs_element_offsets [2]) + (-2.0, 8.0))
			scale = 1
			font = fontgrid_title_gh3
			just = [center center]
			rgba = [160 80 30 255]
			z = 2
		}
		change gs_guitar_brand_ID_p1 = <id>
		GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
		if (<width> > 260)
			SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
				scale = 1}
			fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + (<Height> * (0.0, 1.0))) pos = (($gs_element_offsets [2]) + (-2.0, 8.0))
		endif
		CreateScreenElement {
			type = TextBlockElement
			parent = select_guitar_container
			text = <instrument_name2>
			pos = ($gs_element_offsets [3])
			scale = (0.55, 0.55)
			dims = (440.0, 300.0)
			font = text_a4
			just = [center center]
			rgba = [255 255 200 255]
			z = 2
		}
		change gs_guitar_finish_ID_p1 = <id>
		get_instrument_logo id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p1])
		displayText {
			id = gs_guitar_logo_ID_p1
			parent = select_guitar_container
			text = <instrument_logo>
			pos = ($gs_element_offsets [5])
			scale = 0.8
			font = fontgrid_title_gh3
			just = [center center]
			rgba = [250 250 200 255]
			z = 2
		}
		CreateScreenElement {
			type = WindowElement
			parent = select_guitar_container
			id = gs_instrument_info_scroll_window
			pos = ($gs_element_offsets [4])
			dims = (388.0, 250.0)
		}
		spawnscriptnow {
			select_guitar_scroll_instrument_info
			params = {
				parent = gs_instrument_info_scroll_window
				pos = (($gs_element_offsets [4]) + (0.0, -10.0))
			}
		}
	else
		if (<instrument_type> = guitar)
			change \{gs_select_text = "SELECT GUITAR"}
		elseif (<instrument_type> = Bass)
			change \{gs_select_text = "SELECT BASS"}
		endif
		if (<player> = 1)
			FormatText checksumname = player_status 'player%i_status' i = <player>
			if find_profile_by_id id = ($<player_status>.character_id)
				get_musician_profile_struct index = <index>
				FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player> AddToStringLookup = true
				if GetGlobalTags <default_characterguitartag> noassert = 1
					if (<instrument_type> = guitar)
						<their_instrument_id> = <current_selected_guitar>
					else
						<their_instrument_id> = <current_selected_bass>
					endif
					get_instrument_name_and_index id = <their_instrument_id>
					select_guitar_get_available_index_from_total_index index = <instrument_index> gs_available_instruments = <guitar_select_available_instruments>
					change guitar_select_highlighted_guitar_p1 = <index>
					change guitar_select_old_guitar_p1 = <index>
					if NOT (<their_instrument_id> = $<player_status>.instrument_id)
						KillSpawnedScript \{name = Store_Update_Player_Status}
						spawnscriptnow Store_Update_Player_Status params = {player = <player> instrument_id = <their_instrument_id>}
					endif
				endif
			endif
			CreateScreenElement \{type = ContainerElement
				id = select_guitar_container
				parent = root_window
				pos = (460.0, 500.0)}
			displaySprite \{parent = select_guitar_container
				tex = guitar_select_2p_frame
				just = [
					center
					center
				]
				dims = (256.0, 432.0)
				pos = (0.0, 40.0)
				z = 0}
			displaySprite \{parent = select_guitar_container
				tex = guitar_select_2p_wing
				just = [
					center
					center
				]
				pos = (140.0, -24.0)
				z = 0}
			displaySprite \{parent = select_guitar_container
				tex = guitar_select_2p_wing
				just = [
					center
					center
				]
				pos = (-140.0, -24.0)
				z = 0
				flip_v}
			displayText \{id = gs_select_guitar_text_p1
				parent = select_guitar_container
				text = $gs_select_text
				pos = (0.0, -30.0)
				scale = (0.5, 0.43)
				font = fontgrid_title_gh3
				just = [
					center
					center
				]
				rgba = [
					175
					105
					40
					255
				]
				z = 1}
			displaySprite \{id = gs_brand_background_p1
				parent = select_guitar_container
				tex = Char_Select_Frame_BG
				pos = (0.0, 30.0)
				dims = (266.0, 128.0)
				just = [
					center
					center
				]
				rgba = [
					250
					250
					200
					255
				]
				z = 1}
			displaySprite \{id = gs_finish_background_p1
				parent = select_guitar_container
				tex = white
				pos = (0.0, 88.0)
				dims = (266.0, 32.0)
				just = [
					center
					center
				]
				rgba = [
					120
					0
					0
					255
				]
				z = 1}
			get_instrument_brand_and_finish id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p1])
			displayText {
				parent = select_guitar_container
				text = <instrument_brand>
				pos = (0.0, 10.0)
				scale = 1
				font = text_a4
				just = [center center]
				rgba = [80 0 10 255]
				z = 2
				noshadow
			}
			change gs_guitar_brand_ID_p1 = <id>
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			get_instrument_logo id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p1])
			displayText {
				id = gs_guitar_logo_ID_p1
				parent = select_guitar_container
				text = <instrument_logo>
				pos = (0.0, 40.0)
				scale = 0.6
				font = text_a4
				just = [center center]
				rgba = [0 0 0 255]
				z = 2
				noshadow
			}
			displayText {
				parent = select_guitar_container
				text = <instrument_name2>
				pos = (0.0, 83.0)
				scale = (0.75, 0.5)
				font = text_a4
				just = [center center]
				rgba = [250 250 200 255]
				z = 2
				noshadow
			}
			change gs_guitar_finish_ID_p1 = <id>
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 83.0)
			endif
		else
			FormatText checksumname = player_status 'player%i_status' i = <player>
			if find_profile_by_id id = ($<player_status>.character_id)
				get_musician_profile_struct index = <index>
				FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player> AddToStringLookup = true
				if GetGlobalTags <default_characterguitartag> noassert = 1
					if (<instrument_type> = guitar)
						<their_instrument_id> = <current_selected_guitar>
					else
						<their_instrument_id> = <current_selected_bass>
					endif
					get_instrument_name_and_index id = <their_instrument_id>
					select_guitar_get_available_index_from_total_index index = <instrument_index> gs_available_instruments = <guitar_select_available_instruments>
					change guitar_select_highlighted_guitar_p2 = <index>
					change guitar_select_old_guitar_p2 = <index>
					if NOT (<their_instrument_id> = $<player_status>.instrument_id)
						KillSpawnedScript \{name = Store_Update_Player_Status}
						spawnscriptnow Store_Update_Player_Status params = {player = <player> instrument_id = <their_instrument_id>}
					endif
				endif
			endif
			CreateScreenElement \{type = ContainerElement
				id = select_guitar_container_p2
				parent = root_window
				pos = (810.0, 500.0)}
			displaySprite \{parent = select_guitar_container_p2
				tex = guitar_select_2p_frame
				just = [
					center
					center
				]
				dims = (256.0, 432.0)
				pos = (0.0, 40.0)
				z = 0}
			displaySprite \{parent = select_guitar_container_p2
				tex = guitar_select_2p_wing
				just = [
					center
					center
				]
				pos = (140.0, -24.0)
				z = 0}
			displaySprite \{parent = select_guitar_container_p2
				tex = guitar_select_2p_wing
				just = [
					center
					center
				]
				pos = (-140.0, -24.0)
				z = 0
				flip_v}
			displayText \{id = gs_select_guitar_text_p2
				parent = select_guitar_container_p2
				text = $gs_select_text
				pos = (0.0, -30.0)
				scale = (0.5, 0.43)
				font = fontgrid_title_gh3
				just = [
					center
					center
				]
				rgba = [
					140
					110
					150
					255
				]
				z = 1}
			displaySprite \{id = gs_brand_background_p2
				parent = select_guitar_container_p2
				tex = Char_Select_Frame_BG
				pos = (0.0, 30.0)
				dims = (266.0, 128.0)
				just = [
					center
					center
				]
				rgba = [
					240
					210
					250
					255
				]
				z = 1}
			displaySprite \{id = gs_finish_background_p2
				parent = select_guitar_container_p2
				tex = white
				pos = (0.0, 88.0)
				dims = (266.0, 32.0)
				just = [
					center
					center
				]
				rgba = [
					110
					0
					90
					255
				]
				z = 1}
			get_instrument_brand_and_finish id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p2])
			displayText {
				parent = select_guitar_container_p2
				text = <instrument_brand>
				pos = (0.0, 10.0)
				scale = 1
				font = text_a4
				just = [center center]
				rgba = [70 0 50 255]
				z = 2
				noshadow
			}
			change gs_guitar_brand_ID_p2 = <id>
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			get_instrument_logo id = ($<guitar_select_available_instruments> [$guitar_select_highlighted_guitar_p2])
			displayText {
				id = gs_guitar_logo_ID_p2
				parent = select_guitar_container_p2
				text = <instrument_logo>
				pos = (0.0, 40.0)
				scale = 0.6
				font = text_a4
				just = [center center]
				rgba = [0 0 0 255]
				z = 2
				noshadow
			}
			displayText {
				parent = select_guitar_container_p2
				text = <instrument_name2>
				pos = (0.0, 83.0)
				scale = (0.75, 0.5)
				font = text_a4
				just = [center center]
				rgba = [240 210 250 255]
				z = 2
				noshadow
			}
			change gs_guitar_finish_ID_p2 = <id>
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 83.0)
			endif
		endif
	endif
	if (<player> = 1)
		get_instrument_name_and_index id = ($player1_status.instrument_id)
		change g_old_selected_guitar_index_p1 = <instrument_index>
	else
		get_instrument_name_and_index id = ($player2_status.instrument_id)
		change g_old_selected_guitar_index_p2 = <instrument_index>
	endif
	FormatText checksumname = player_status 'player%i_status' i = <player>
	if ($current_num_players = 1)
		change \{using_guitar_select_camera = 1}
		change \{lock_guitar_select_camera = 1}
		char_name = ($<player_status>.band_member)
		LaunchEvent type = unfocus target = <vparent>
		if CompositeObjectExists name = <char_name>
			<char_name> :ragdoll_markforreset
			<char_name> :handle_change_stance stance = stance_frontend_guitar Speed = 2.0 no_wait
		endif
		PlayIGCCam \{id = gs_view_cam_id
			name = gs_view_cam
			viewport = bg_viewport
			controlscript = guitar_select_camera_morph
			LockTo = world
			pos = (10.0, 5.0, 1.580106)
			Quat = (0.028251, -0.9906429, 0.13347001)
			FOV = 72.0
			Play_hold = 1
			interrupt_current
			time = 0.5}
		begin
		if ($lock_guitar_select_camera = 0)
			break
		else
			Wait \{1
				gameframe}
		endif
		repeat
	endif
	LaunchEvent type = focus target = <vparent>
endscript
using_guitar_select_camera = 0
lock_guitar_select_camera = 0

script guitar_select_camera_morph 
	change \{lock_guitar_select_camera = 1}
	CCam_DoMorph \{LockTo = world
		pos = (2.503113, 1.0385579, 2.869411)
		Quat = (0.028074998, -0.999026, 0.020287)
		FOV = 78.0}
	CCam_WaitMorph
	CCam_DoMorph \{LockTo = Guitarist
		LockToBone = bone_guitar_neck
		pos = (0.05, 0.6, -0.4)
		Quat = (0.48735002, 0.463712, -0.514474)
		FOV = 120.0
		time = 0.5
		motion = smooth}
	ScreenFX_AddFXInstance \{viewport = bg_viewport
		name = GSdof
		scefName = dof
		time = 0.5
		type = dof
		on = 1
		BackDist = 0.003
		strength = 0.6
		BlurRadius = 6
		BlurResolution = half}
	ScreenFX_AddFXInstance \{viewport = bg_viewport
		name = GSdof2
		scefName = DoF2
		time = 0.5
		type = dof
		on = 1
		BackDist = 0.01
		strength = 1.0
		BlurRadius = 6
		BlurResolution = half}
	CCam_WaitMorph
	CCam_Freeze
	change \{lock_guitar_select_camera = 0}
endscript

script select_guitar_build_brand_array \{instrument_type = guitar
		player = 1}
	GetArraySize <gs_available_instruments> GlobalArray
	<our_array_size> = <array_size>
	get_musician_instrument_size
	<their_array_size> = <array_size>
	gs_available_brands = []
	<i> = 0
	begin
	<j> = 0
	begin
	get_musician_instrument_struct index = <j>
	if (($<gs_available_instruments> [<i>]) = (<info_struct>.desc_id))
		<k> = 0
		<found_brand> = 0
		GetArraySize (<gs_available_brands>)
		if (<array_size> > 0)
			begin
			if ((<gs_available_brands> [<k>]) = (<info_struct>.name))
				<found_brand> = 1
				FormatText checksumname = player_status 'player%i_status' i = <player>
				if (($<player_status>.instrument_id) = (<info_struct>.desc_id))
					if (<player> = 1)
						change gs_selected_brand_p1 = <k>
					else
						change gs_selected_brand_p2 = <k>
					endif
				endif
				break
			endif
			<k> = (<k> + 1)
			repeat <array_size>
		endif
		if (<found_brand> = 0)
			AddArrayElement array = (<gs_available_brands>) element = (<info_struct>.name)
			<gs_available_brands> = (<array>)
			FormatText checksumname = player_status 'player%i_status' i = <player>
			if (($<player_status>.instrument_id) = (<info_struct>.desc_id))
				if (<player> = 1)
					change gs_selected_brand_p1 = <array_size>
				else
					change gs_selected_brand_p2 = <array_size>
				endif
			endif
		endif
	endif
	<j> = (<j> + 1)
	repeat <their_array_size>
	<i> = (<i> + 1)
	repeat <our_array_size>
	return gs_available_brands = <gs_available_brands>
endscript

script select_guitar_build_finish_array \{instrument_type = guitar}
	GetArraySize <gs_available_instruments> GlobalArray
	<our_array_size> = <array_size>
	get_musician_instrument_size
	<their_array_size> = <array_size>
	gs_available_finishes = []
	<i> = 0
	begin
	<j> = 0
	begin
	get_musician_instrument_struct index = <j>
	if (($<gs_available_instruments> [<i>]) = (<info_struct>.desc_id))
		get_instrument_brand_and_finish id = (<info_struct>.desc_id)
		if (<instrument_brand> = <brand>)
			AddArrayElement array = (<gs_available_finishes>) element = (<info_struct>.desc_id)
			<gs_available_finishes> = (<array>)
		endif
	endif
	<j> = (<j> + 1)
	repeat <their_array_size>
	<i> = (<i> + 1)
	repeat <our_array_size>
	return gs_available_finishes = <gs_available_finishes>
endscript

script destroy_select_guitar_menu \{player = 1}
	if (<player> = 1)
		destroy_menu \{menu_id = scrolling_select_guitar_p1}
		destroy_menu \{menu_id = scrolling_guitar_finish_menu_p1}
		if ($current_num_players = 1)
			KillSpawnedScript \{name = select_guitar_scroll_instrument_info}
		endif
		destroy_menu \{menu_id = gs_instrument_info_scroll_window}
		destroy_menu \{menu_id = select_guitar_container}
		destroy_menu \{menu_id = select_finish_container}
	else
		destroy_menu \{menu_id = scrolling_select_guitar_p2}
		destroy_menu \{menu_id = scrolling_guitar_finish_menu_p2}
		destroy_menu \{menu_id = select_guitar_container_p2}
		destroy_menu \{menu_id = select_finish_container_p2}
	endif
	FormatText checksumname = player_status 'player%i_status' i = <player>
	<band_member> = ($<player_status>.band_member)
	if CompositeObjectExists name = <band_member>
		if <band_member> :Anim_AnimNodeExists id = BodyTimer
			<band_member> :Anim_Command target = BodyTimer command = Timer_SetSpeed params = {Speed = 1.0}
		endif
	endif
	if ($current_num_players = 1)
		KillCamAnim \{name = gs_view_cam}
	endif
endscript
guitar_select_camera_changing = 0

script guitar_select_exit_camera_morph 
	change \{guitar_select_camera_changing = 1}
	CCam_DoMorph \{LockTo = Guitarist
		LockToBone = bone_guitar_neck
		pos = (0.05, 0.618989, -0.4)
		Quat = (0.48735002, 0.463712, -0.514474)
		FOV = 120.0
		motion = smooth}
	CCam_WaitMorph
	CCam_DoMorph \{LockTo = world
		pos = (2.503113, 1.0385579, 2.869411)
		Quat = (0.028074998, -0.999026, 0.020287)
		FOV = 78.0
		time = 0.5
		motion = smooth}
	ScreenFX_UpdateFXInstanceParams \{viewport = bg_viewport
		name = GSdof
		time = 0.5
		type = dof
		on = 1
		BackDist = 0.003
		strength = 0
		BlurRadius = 6
		BlurResolution = half}
	ScreenFX_UpdateFXInstanceParams \{viewport = bg_viewport
		name = GSdof2
		time = 0.5
		type = dof
		on = 1
		BackDist = 0.01
		strength = 0
		BlurRadius = 6
		BlurResolution = half}
	CCam_WaitMorph
	ScreenFX_RemoveFXInstance \{viewport = bg_viewport
		name = GSdof}
	ScreenFX_RemoveFXInstance \{viewport = bg_viewport
		name = GSdof2
		time = 2}
	change \{guitar_select_camera_changing = 0}
endscript

script wait_for_guitar_select_exit_camera 
	Wait \{5
		gameframes}
	begin
	if ($guitar_select_camera_changing = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script gs_wait_to_load_guitar_p1 
	Wait \{0.2
		second}
	change \{globalname = generic_select_monitor_p1_changed
		newvalue = 1}
endscript

script gs_wait_to_load_guitar_p2 
	Wait \{0.2
		second}
	change \{globalname = generic_select_monitor_p2_changed
		newvalue = 1}
endscript

script gs_scroll_up_or_down \{player = 1
		dir = down}
	generic_menu_up_or_down_sound params = {<dir>}
	if (<player> = 1)
		if ($gs_made_first_selection_bool_p1 = 0)
			GetArraySize (gs_available_brands)
			<avail_size> = <array_size>
			if (<dir> = down)
				change gs_selected_brand_p1 = ($gs_selected_brand_p1 + 1)
				if ($gs_selected_brand_p1 = <avail_size>)
					change \{gs_selected_brand_p1 = 0}
				endif
			endif
			if (<dir> = up)
				change gs_selected_brand_p1 = ($gs_selected_brand_p1 - 1)
				if ($gs_selected_brand_p1 = -1)
					change gs_selected_brand_p1 = (<avail_size> - 1)
				endif
			endif
			<inst_ID> = 0
			select_guitar_get_first_guitar_brand_in_list {
				brand = (<gs_available_brands> [$gs_selected_brand_p1])
				instrument_type = <instrument_type>
				gs_available_instruments = <gs_available_instruments>
			}
			<inst_ID> = <instrument_id>
			change guitar_select_highlighted_guitar_p1 = <instrument_index>
			FormatText checksumname = player_status 'player%i_status' i = <player>
			if NOT (<inst_ID> = $<player_status>.instrument_id)
				KillSpawnedScript \{name = Store_Update_Player_Status}
				spawnscriptnow Store_Update_Player_Status params = {player = <player> instrument_id = <inst_ID>}
				if ($current_num_players = 1)
					select_guitar_change_blurb_text inst_ID = <inst_ID>
				endif
			endif
			if (($is_network_game) = 1)
				change online_guitar_highlighted_id_p1 = ($<player_status>.instrument_id)
				if (<dir> = up)
					dir_value = 0
				else
					dir_value = 1
				endif
				network_player_lobby_message {
					type = guitar_select
					action = update
					checksum = <instrument_type>
					value1 = <dir_value>
				}
			endif
			get_instrument_brand_and_finish id = <inst_ID>
			SetScreenElementProps id = $gs_guitar_brand_ID_p1 text = <instrument_brand>
			SetScreenElementProps id = $gs_guitar_finish_ID_p1 text = <instrument_name2>
			if ($current_num_players = 1)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
					scale = 1}
				GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
				if (<width> > 260)
					fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + (<Height> * (0.0, 1.0))) pos = (($gs_element_offsets [2]) + (-2.0, 8.0))
				endif
			else
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
					scale = 1}
				GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
				if (<width> > 260)
					fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
				endif
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
					scale = 1}
				GetScreenElementDims \{id = $gs_guitar_finish_ID_p1}
				if (<width> > 260)
					fit_text_in_rectangle id = $gs_guitar_finish_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 0.5))) pos = (0.0, 83.0)
				else
					SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
						scale = (0.75, 0.5)}
				endif
			endif
			get_instrument_logo id = <inst_ID>
			SetScreenElementProps id = gs_guitar_logo_ID_p1 text = <instrument_logo>
		endif
	else
		if ($gs_made_first_selection_bool_p2 = 0)
			GetArraySize (gs_available_brands)
			<avail_size> = <array_size>
			if (<dir> = down)
				change gs_selected_brand_p2 = ($gs_selected_brand_p2 + 1)
				if ($gs_selected_brand_p2 = <avail_size>)
					change \{gs_selected_brand_p2 = 0}
				endif
			endif
			if (<dir> = up)
				change gs_selected_brand_p2 = ($gs_selected_brand_p2 - 1)
				if ($gs_selected_brand_p2 = -1)
					change gs_selected_brand_p2 = (<avail_size> - 1)
				endif
			endif
			<inst_ID> = 0
			select_guitar_get_first_guitar_brand_in_list {
				brand = (<gs_available_brands> [$gs_selected_brand_p2])
				instrument_type = <instrument_type>
				gs_available_instruments = <gs_available_instruments>
			}
			change guitar_select_highlighted_guitar_p2 = <instrument_index>
			<inst_ID> = <instrument_id>
			FormatText checksumname = player_status 'player%i_status' i = <player>
			if NOT (<inst_ID> = $<player_status>.instrument_id)
				KillSpawnedScript \{name = Store_Update_Player_Status}
				spawnscriptnow Store_Update_Player_Status params = {player = <player> instrument_id = <inst_ID>}
			endif
			get_instrument_brand_and_finish id = <inst_ID>
			SetScreenElementProps id = $gs_guitar_brand_ID_p2 text = <instrument_brand>
			SetScreenElementProps id = $gs_guitar_finish_ID_p2 text = <instrument_name2>
			SetScreenElementProps \{id = $gs_guitar_brand_ID_p2
				scale = 1}
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p2}
			if (<width> > 260)
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
				scale = 1}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p2}
			if (<width> > 260)
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 0.5))) pos = (0.0, 83.0)
			else
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
					scale = (0.75, 0.5)}
			endif
			get_instrument_logo id = <inst_ID>
			SetScreenElementProps id = gs_guitar_logo_ID_p2 text = <instrument_logo>
		endif
	endif
endscript

script select_guitar_go_back \{player = 1
		instrument_type = guitar}
	if (<player> = 1)
		instrument_id = ($<gs_available_instruments> [($guitar_select_old_guitar_p1)])
		change \{guitar_select_highlighted_guitar_p1 = $guitar_select_old_guitar_p1}
		change \{gs_selected_brand_p1 = $gs_old_selected_brand_p1}
		if ($is_network_game = 1)
			get_musician_instrument_type desc_id = <instrument_id>
			if (<instrument_type> = guitar)
				change player1_selected_guitar = <instrument_id>
			else
				change player1_selected_bass = <instrument_id>
			endif
		endif
	else
		instrument_id = ($<gs_available_instruments> [($guitar_select_old_guitar_p2)])
		change \{guitar_select_highlighted_guitar_p2 = $guitar_select_old_guitar_p2}
		change \{gs_selected_brand_p2 = $gs_old_selected_brand_p2}
	endif
	FormatText checksumname = player_status 'player%i_status' i = <player>
	if NOT (<instrument_id> = $<player_status>.instrument_id)
		change structurename = <player_status> instrument_id = <instrument_id>
		if NOT ($is_network_game)
			if find_profile_by_id id = ($<player_status>.character_id)
				get_musician_profile_struct index = <index>
				FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player>
				if (<instrument_type> = guitar)
					SetGlobalTags <default_characterguitartag> params = {current_instrument = guitar current_selected_guitar = <instrument_id>}
				else
					SetGlobalTags <default_characterguitartag> params = {current_instrument = Bass current_selected_bass = <instrument_id>}
				endif
			endif
		endif
		FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
		change globalname = <change_flag> newvalue = 1
		if ($current_num_players = 1)
			select_guitar_change_blurb_text inst_ID = <instrument_id>
		endif
		generic_select_monitor_wait
	endif
	if NOT ($is_network_game)
		if find_profile_by_id id = ($<player_status>.character_id)
			get_musician_profile_struct index = <index>
			FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player> AddToStringLookup = true
			SetGlobalTags <default_characterguitartag> params = {current_instrument = <instrument_type>}
		endif
	endif
	ui_flow_manager_respond_to_action action = go_back player = <player>
endscript

script select_guitar_menu_lose_focus 
	GetTags
	SetScreenElementProps id = <id> rgba = [180 100 60 255]
endscript

script select_guitar_choose \{player = 1
		needs_net_message = 1
		includes_finish = 0}
	SoundEvent \{event = ui_sfx_select}
	if ($current_num_players = 1)
		begin
		if ($generic_select_monitor_p1_changed = 0)
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
	if (<player> = 1)
		<inst_ID> = ($<gs_available_instruments> [($guitar_select_highlighted_guitar_p1)])
		change structurename = player1_status instrument_id = <inst_ID>
		if find_profile_by_id id = ($player1_status.character_id)
			get_musician_profile_struct index = <index>
			FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player>
			if (<instrument_type> = guitar)
				SetGlobalTags <default_characterguitartag> params = {current_instrument = guitar current_selected_guitar = <inst_ID>}
				change player1_selected_guitar = <inst_ID>
			else
				SetGlobalTags <default_characterguitartag> params = {current_instrument = Bass current_selected_bass = <inst_ID>}
				change player1_selected_bass = <inst_ID>
			endif
		endif
		change \{guitar_select_old_guitar_p1 = $guitar_select_highlighted_guitar_p1}
		change \{gs_old_selected_brand_p1 = $gs_selected_brand_p1}
		if ($gs_made_first_selection_bool_p1 = 0)
			select_guitar_create_finish_menu gs_available_instruments = <gs_available_instruments> player = <player> instrument_type = <instrument_type>
			change \{gs_made_first_selection_bool_p1 = 1}
		else
			ui_flow_manager_respond_to_action action = select_character_hub player = <player> create_params = {player = <player>} destroy_params = {player = <player>}
		endif
	else
		<inst_ID> = ($<gs_available_instruments> [($guitar_select_highlighted_guitar_p2)])
		change structurename = player2_status instrument_id = <inst_ID>
		if NOT ($is_network_game)
			if find_profile_by_id id = ($player2_status.character_id)
				get_musician_profile_struct index = <index>
				FormatText checksumname = default_characterguitartag 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name) p = <player>
				if (<instrument_type> = guitar)
					SetGlobalTags <default_characterguitartag> params = {current_instrument = guitar current_selected_guitar = <inst_ID>}
				else
					SetGlobalTags <default_characterguitartag> params = {current_instrument = Bass current_selected_bass = <inst_ID>}
				endif
			endif
		endif
		change \{guitar_select_old_guitar_p2 = $guitar_select_highlighted_guitar_p2}
		change \{gs_old_selected_brand_p2 = $gs_selected_brand_p2}
		if ($gs_made_first_selection_bool_p2 = 0)
			select_guitar_create_finish_menu gs_available_instruments = <gs_available_instruments> player = <player> instrument_type = <instrument_type>
			change \{gs_made_first_selection_bool_p2 = 1}
		else
			ui_flow_manager_respond_to_action action = select_character_hub player = <player> create_params = {player = <player>} destroy_params = {player = <player>}
		endif
	endif
endscript

script get_instrument_name_and_index 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<id> = (<info_struct>.desc_id))
		return instrument_name = (<info_struct>.name) instrument_index = <index>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	get_instrument_name_and_index \{id = Instrument_Explorer_White}
	return instrument_name = (<info_struct>.name) instrument_index = <index> false
endscript

script get_player_instrument_desc_name \{player = 1}
	if (<player> = 1)
		instrument_id = ($player1_status.instrument_id)
	else
		instrument_id = ($player2_status.instrument_id)
	endif
	if find_instrument_index desc_id = (<instrument_id>)
		get_musician_instrument_struct index = <index>
		return true instrument_name = (<info_struct>.desc_name)
	else
		return \{false
			instrument_name = "Instrument not found"}
	endif
endscript

script get_instrument_brand_and_finish 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<id> = (<info_struct>.desc_id))
		<ins_fin> = (<info_struct>.finish)
		if GotParam \{ins_fin}
			GetUpperCaseString <ins_fin>
			gitaf_instrument_finish = <UpperCaseString>
		else
			gitaf_instrument_finish = "Something Bad Happened..."
		endif
		<ins_name2> = (<info_struct>.name2)
		if GotParam \{ins_name2}
			GetUpperCaseString <ins_name2>
			gitaf_instrument_name2 = <UpperCaseString>
		else
			gitaf_instrument_name2 = "Something Bad Happened..."
		endif
		<ins_brand> = (<info_struct>.name)
		if GotParam \{ins_fin}
			GetUpperCaseString <ins_brand>
			gitaf_instrument_brand = <UpperCaseString>
		else
			gitaf_instrument_brand = "Something Bad Happened..."
		endif
		return instrument_brand = <gitaf_instrument_brand> instrument_finish = <gitaf_instrument_finish> instrument_name2 = <gitaf_instrument_name2>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	return \{instrument_brand = "Brand Not Found!!!"
		instrument_finish = "Finish Not Found!!!"}
endscript

script get_instrument_logo 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<id> = (<info_struct>.desc_id))
		<ins_logo> = (<info_struct>.logo)
		if GotParam \{ins_logo}
			GetUpperCaseString <ins_logo>
			gitaf_instrument_logo = <UpperCaseString>
		else
			gitaf_instrument_logo = "Something Bad Happened..."
		endif
		return instrument_logo = <gitaf_instrument_logo>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	return \{instrument_logo = "Logo Not Found!!!"}
endscript

script select_guitar_change_blurb_text \{lines_in_window = 8}
	if GotParam \{inst_ID}
		get_instrument_name_and_index id = <inst_ID>
		get_musician_instrument_struct index = <instrument_index>
		change gs_instrument_blurb_text = (<info_struct>.blurb)
	else
		change gs_instrument_blurb_text = <text>
	endif
	KillSpawnedScript \{name = select_guitar_scroll_instrument_info}
	destroy_menu \{menu_id = gs_instrument_info_scroll_window}
	CreateScreenElement {
		type = WindowElement
		parent = select_guitar_container
		id = gs_instrument_info_scroll_window
		pos = ($gs_element_offsets [4])
		dims = (388.0, 250.0)
	}
	my_pos = (($gs_element_offsets [4]) + (0.0, -10.0))
	my_x_dims = 362
	if GotParam \{dims}
		gs_instrument_info_scroll_window :SetProps dims = <dims>
	endif
	if GotParam \{x_dims}
		<my_x_dims> = <x_dims>
	endif
	if GotParam \{pos}
		<my_pos> = <pos>
		gs_instrument_info_scroll_window :SetProps pos = <my_pos>
	endif
	my_z = 2
	if GotParam \{z}
		<my_z> = <z>
	endif
	spawnscriptnow {
		select_guitar_scroll_instrument_info
		params = {
			parent = gs_instrument_info_scroll_window
			x_dims = <my_x_dims>
			z = <my_z>
			pos = <my_pos>
			lines_in_window = <lines_in_window>
		}
	}
endscript

script select_guitar_scroll_instrument_info \{z = 2
		x_dims = 362}
	CreateScreenElement {
		type = TextBlockElement
		parent = <parent>
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.58, 0.6)
		text = $gs_instrument_blurb_text
		font = text_a4
		rgba = [235 145 80 255]
		z_priority = <z>
		dims = (<x_dims> * (1.0, 0.0))
		allow_expansion
		line_spacing = 1.25
	}
	<text_id> = <id>
	SetScreenElementLock id = <text_id> on
	<text_id> :GetParentID
	GetScreenElementDims id = <parent_id>
	<parent_height> = <Height>
	GetScreenElementDims id = <text_id>
	GetScreenElementChildren id = <text_id>
	GetArraySize (<children>)
	<line_nums> = (<array_size> + 0.01)
	<pixels_per_line> = (<Height> / <line_nums>)
	<fade_time> = 1.5
	<idle_time> = 3.5
	<black_time> = 0.2
	begin
	<text_id> :DoMorph alpha = 0 pos = (0.0, 0.0)
	<text_id> :DoMorph alpha = 1 time = <fade_time>
	if (<Height> <= <parent_height>)
		break
	endif
	Wait <idle_time> seconds
	<diff> = (<Height> - <parent_height> + 2.1)
	<lines_to_scroll> = (<diff> / <pixels_per_line>)
	<rate> = 1.0
	<text_id> :DoMorph pos = (<diff> * (0.0, -1.0)) time = (<rate> * <lines_to_scroll>)
	Wait <idle_time> seconds
	<text_id> :DoMorph alpha = 0 time = <fade_time>
	Wait <black_time> seconds
	repeat
endscript

script select_guitar_get_first_guitar_brand_in_list \{brand = explorer}
	<i> = 0
	GetArraySize <gs_available_instruments> GlobalArray
	total_size = <array_size>
	begin
	if (<instrument_type> = guitar)
		get_musician_instrument_struct index = ($guitar_select_guitar_indeces [<i>])
	else
		get_musician_instrument_struct index = ($guitar_select_bass_indeces [<i>])
	endif
	if ((<info_struct>.name) = <brand>)
		return instrument_id = (<info_struct>.desc_id) instrument_index = <i>
	endif
	<i> = (<i> + 1)
	repeat <total_size>
endscript

script select_guitar_get_available_index_from_total_index \{index = 0}
	<i> = 0
	GetArraySize <gs_available_instruments> GlobalArray
	<avail_size> = <array_size>
	begin
	get_musician_instrument_struct index = <index>
	if (($<gs_available_instruments> [<i>]) = (<info_struct>.desc_id))
		return index = <i>
	endif
	<i> = (<i> + 1)
	repeat <avail_size>
endscript

script select_guitar_create_finish_menu \{player = 1}
	exclusive_dev = $player1_device
	if (($is_network_game) = 1)
		<exclusive_dev> = $primary_controller
	else
		if (<player> = 2)
			<exclusive_dev> = $player2_device
		endif
	endif
	event_handlers = [
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
		{pad_back select_guitar_go_back_from_finish_menu params = {gs_available_instruments = <gs_available_instruments> player = <player> instrument_type = <instrument_type>}}
	]
	<p1_menu_pos> = (566.0, 480.0)
	<p2_menu_pos> = (786.0, 490.0)
	<menu_offset> = (-270.0, -160.0)
	if (<player> = 1)
		if ($current_num_players = 2)
			new_menu {
				scrollid = scrolling_guitar_finish_menu_p1
				vmenuid = vmenu_guitar_finish_menu_p1
				use_backdrop = 0
				event_handlers = <event_handlers>
				menu_pos = (<p1_menu_pos> + (-178.0, -210.0))
				exclusive_device = <exclusive_dev>
				internal_just = [center top]
			}
		else
			new_menu {
				scrollid = scrolling_guitar_finish_menu_p1
				vmenuid = vmenu_guitar_finish_menu_p1
				use_backdrop = 0
				event_handlers = <event_handlers>
				menu_pos = (<p1_menu_pos> + <menu_offset>)
				internal_just = [center top]
				text_left
			}
			KillSpawnedScript \{name = select_guitar_scroll_instrument_info}
			destroy_menu \{menu_id = gs_instrument_info_scroll_window}
		endif
		vparent = vmenu_guitar_finish_menu_p1
	else
		new_menu {
			scrollid = scrolling_guitar_finish_menu_p2
			vmenuid = vmenu_guitar_finish_menu_p2
			use_backdrop = 0
			event_handlers = <event_handlers>
			menu_pos = <p2_menu_pos>
			exclusive_device = <exclusive_dev>
			internal_just = [center top]
		}
		if ($is_network_game = 1)
			vmenu_guitar_finish_menu_p2 :SetProps \{disable_pad_handling}
			LaunchEvent \{type = unfocus
				target = vmenu_guitar_finish_menu_p2}
		endif
		vparent = vmenu_guitar_finish_menu_p2
	endif
	if (<player> = 1)
		LaunchEvent \{type = unfocus
			target = scrolling_select_guitar_p1}
	else
		if NOT ($is_network_game)
			LaunchEvent \{type = unfocus
				target = scrolling_select_guitar_p2}
		endif
	endif
	if ($current_num_players = 1)
		CreateScreenElement {
			type = ContainerElement
			id = select_finish_container
			parent = root_window
			pos = (<p1_menu_pos> + <menu_offset>)
			internal_just = [center top]
		}
		<brown_window_color> = [120 60 10 255]
		SetScreenElementProps {
			id = gs_brand_background
			texture = store_frame_bottom_bg
			dims = (242.0, 128.0)
			rgba = <brown_window_color>
		}
		SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
			rgba = [
				250
				250
				200
				255
			]
			scale = 0.8}
		GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
		if (<width> > 260)
			SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
				scale = 1}
			fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((215.0, 0.0) + (<Height> * (0.0, 1.0))) pos = (($gs_element_offsets [2]) + (-2.0, 8.0))
		endif
		displaySprite \{id = gs_bookend1_ID
			parent = select_finish_container
			tex = character_hub_hilite_bookend
			dims = (24.0, 24.0)
			just = [
				left
				top
			]
			rgba = [
				255
				255
				205
				255
			]
			pos = (-64.0, 11.0)
			z = 4}
		displaySprite \{id = gs_bookend2_ID
			parent = select_finish_container
			tex = character_hub_hilite_bookend
			dims = (24.0, 24.0)
			just = [
				right
				top
			]
			rgba = [
				255
				255
				205
				255
			]
			pos = (238.0, 11.0)
			z = 4}
		displaySprite \{id = gs_whiteTexHighlight_ID
			parent = select_finish_container
			tex = white
			just = [
				left
				top
			]
			rgba = [
				255
				255
				205
				255
			]
			dims = (264.0, 32.0)
			pos = (-47.0, 8.0)
			z = 2}
		set_focus_color \{rgba = [
				130
				40
				40
				250
			]}
		set_unfocus_color \{rgba = [
				180
				100
				60
				250
			]}
		get_instrument_brand_and_finish id = ($<gs_available_instruments> [$guitar_select_highlighted_guitar_p1])
		select_guitar_build_finish_array {
			brand = <instrument_brand>
			gs_available_instruments = <gs_available_instruments>
		}
		GetArraySize <gs_available_finishes>
		<i> = 0
		begin
		get_instrument_brand_and_finish id = (<gs_available_finishes> [<i>])
		FormatText checksumname = gs_finish_menu_item_id 'gs_finish_menu_item_%n' n = <i>
		CreateScreenElement {
			id = <gs_finish_menu_item_id>
			type = TextElement
			parent = <vparent>
			font = text_a4
			scale = (0.7, 0.7)
			rgba = ($menu_unfocus_color)
			just = [center top]
			text = <instrument_finish>
			event_handlers = [
				{focus retail_menu_focus}
				{focus select_guitar_finish_highlight params = {player = <player>
						id = (<gs_available_finishes> [<i>])
						index = <i>
					}
				}
				{unfocus retail_menu_unfocus}
				{pad_choose select_guitar_finish_choose params = {id = (<gs_available_finishes> [<i>])
						player = <player>
						gs_available_instruments = <gs_available_instruments>
						instrument_type = <instrument_type>
					}
				}
			]
		}
		GetScreenElementDims id = <id>
		if (<width> > 180)
			SetScreenElementProps id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((180.0, 34.0))
		endif
		<i> = (<i> + 1)
		repeat <array_size>
		if (<array_size> = 1)
			change \{gs_made_first_selection_bool_p1 = 1}
			select_guitar_finish_highlight {
				player = <player>
				id = (<gs_available_finishes> [0])
			}
			select_guitar_finish_choose {
				id = (<gs_available_finishes> [0])
				player = <player>
				gs_available_instruments = <gs_available_instruments>
				instrument_type = <instrument_type>
			}
		endif
	else
		if (<player> = 1)
			LaunchEvent \{type = unfocus
				target = scrolling_select_guitar_p1}
			LaunchEvent type = focus target = <vparent>
			SetScreenElementProps \{id = gs_select_guitar_text_p1
				text = "SELECT FINISH"}
			get_instrument_brand_and_finish id = ($<gs_available_instruments> [$guitar_select_highlighted_guitar_p1])
			select_guitar_build_finish_array {
				brand = <instrument_brand>
				gs_available_instruments = <gs_available_instruments>
			}
			get_instrument_brand_and_finish id = (<gs_available_finishes> [0])
			SetScreenElementProps \{id = gs_brand_background_p1
				pos = (0.0, 58.0)}
			SetScreenElementProps \{id = gs_finish_background_p1
				pos = (0.0, 0.0)}
			SetScreenElementProps \{id = gs_guitar_logo_ID_p1
				hide}
			SetScreenElementProps {
				id = $gs_guitar_brand_ID_p1
				text = <instrument_brand>
				scale = (0.75, 0.5)
				pos = (0.0, -6.0)
				rgba = [250 250 200 255]
			}
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p1
				text = <instrument_finish>
				scale = (1.0, 0.8)
				pos = (0.0, 52.0)
				rgba = [80 0 10 255]
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 52.0)
			endif
			GetArraySize <gs_available_finishes>
			<i> = 0
			begin
			get_instrument_brand_and_finish id = (<gs_available_finishes> [<i>])
			CreateScreenElement {
				type = TextElement
				parent = <vparent>
				font = text_a4
				scale = (0.7, 0.7)
				rgba = ($menu_unfocus_color)
				just = [center top]
				text = <instrument_finish>
				event_handlers = [
					{focus retail_menu_focus}
					{focus select_guitar_finish_highlight params = {player = <player>
							id = (<gs_available_finishes> [<i>])
						}
					}
					{unfocus retail_menu_unfocus}
					{pad_choose select_guitar_finish_choose params = {id = (<gs_available_finishes> [<i>])
							player = <player>
							gs_available_instruments = <gs_available_instruments>
							instrument_type = <instrument_type>
							finish_index = <i>
						}
					}
				]
				exclusive_device = <exclusive_dev>
				hide
			}
			GetScreenElementDims id = <id>
			if (<width> > 180)
				fit_text_in_rectangle id = <id> dims = (0.7 * ((160.0, 0.0) + (<Height> * (0.0, 1.0)))) pos = (<p1_menu_pos> + <menu_offset>)
			endif
			<i> = (<i> + 1)
			repeat <array_size>
			if (<array_size> = 1)
				change \{gs_made_first_selection_bool_p1 = 1}
				select_guitar_finish_highlight {
					player = <player>
					id = (<gs_available_finishes> [0])
				}
				select_guitar_finish_choose {
					id = (<gs_available_finishes> [0])
					player = <player>
					gs_available_instruments = <gs_available_instruments>
					instrument_type = <instrument_type>
					needs_net_message = 0
				}
			endif
		else
			if ($is_network_game = 0)
				LaunchEvent \{type = unfocus
					target = scrolling_select_guitar_p2}
				LaunchEvent type = focus target = <vparent>
			endif
			SetScreenElementProps \{id = gs_select_guitar_text_p2
				text = "SELECT FINISH"}
			get_instrument_brand_and_finish id = ($<gs_available_instruments> [$guitar_select_highlighted_guitar_p2])
			select_guitar_build_finish_array {
				brand = <instrument_brand>
				gs_available_instruments = <gs_available_instruments>
			}
			get_instrument_brand_and_finish id = (<gs_available_finishes> [0])
			SetScreenElementProps \{id = gs_brand_background_p2
				pos = (0.0, 58.0)}
			SetScreenElementProps \{id = gs_finish_background_p2
				pos = (0.0, 0.0)}
			SetScreenElementProps \{id = gs_guitar_logo_ID_p2
				hide}
			SetScreenElementProps {
				id = $gs_guitar_brand_ID_p2
				text = <instrument_brand>
				scale = (0.75, 0.5)
				pos = (0.0, -6.0)
				rgba = [240 210 250 255]
			}
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p2
				text = <instrument_finish>
				scale = (1.0, 0.8)
				pos = (0.0, 52.0)
				rgba = [70 0 50 255]
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 52.0)
			endif
			GetArraySize <gs_available_finishes>
			get_instrument_brand_and_finish id = ($<gs_available_instruments> [$guitar_select_highlighted_guitar_p2])
			select_guitar_build_finish_array {
				brand = <instrument_brand>
				gs_available_instruments = <gs_available_instruments>
			}
			GetArraySize <gs_available_finishes>
			<i> = 0
			begin
			get_instrument_brand_and_finish id = (<gs_available_finishes> [<i>])
			CreateScreenElement {
				type = TextElement
				parent = <vparent>
				font = text_a4
				scale = (0.7, 0.7)
				rgba = ($menu_unfocus_color)
				just = [center top]
				text = <instrument_finish>
				event_handlers = [
					{focus retail_menu_focus}
					{focus select_guitar_finish_highlight params = {player = <player>
							id = (<gs_available_finishes> [<i>])
						}
					}
					{unfocus retail_menu_unfocus}
					{pad_choose select_guitar_finish_choose params = {id = (<gs_available_finishes> [<i>])
							player = <player>
							gs_available_instruments = <gs_available_instruments>
							instrument_type = <instrument_type>
						}
					}
				]
				exclusive_device = <exclusive_dev>
				hide
			}
			GetScreenElementDims id = <id>
			if (<width> > 180)
				fit_text_in_rectangle id = <id> dims = (0.7 * ((160.0, 0.0) + (<Height> * (0.0, 1.0)))) pos = (<p1_menu_pos> + <menu_offset>)
			endif
			<i> = (<i> + 1)
			repeat <array_size>
			if (<array_size> = 1)
				change \{gs_made_first_selection_bool_p2 = 1}
				select_guitar_finish_highlight {
					player = <player>
					id = (<gs_available_finishes> [0])
				}
				select_guitar_finish_choose {
					id = (<gs_available_finishes> [0])
					player = <player>
					gs_available_instruments = <gs_available_instruments>
					instrument_type = <instrument_type>
					needs_net_message = 0
				}
			endif
		endif
	endif
endscript

script select_guitar_go_back_from_finish_menu \{player = 1
		instrument_type = guitar}
	SoundEvent \{event = Generic_Menu_Back_SFX}
	if ($current_num_players = 1)
		LaunchEvent \{type = focus
			target = scrolling_select_guitar_p1}
		LaunchEvent \{type = unfocus
			target = scrolling_guitar_finish_menu_p1}
		destroy_menu \{menu_id = scrolling_guitar_finish_menu_p1}
		change \{gs_made_first_selection_bool_p1 = 0}
		destroy_menu \{menu_id = select_finish_container}
		instrument_id = ($<gs_available_instruments> [($guitar_select_old_guitar_p1)])
		change \{guitar_select_highlighted_guitar_p1 = $guitar_select_old_guitar_p1}
		change \{gs_selected_brand_p1 = $gs_old_selected_brand_p1}
		if NOT (<instrument_id> = ($player1_status.instrument_id))
			change structurename = player1_status instrument_id = <instrument_id>
			FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
			change globalname = <change_flag> newvalue = 1
		endif
		SetScreenElementProps \{id = gs_brand_background
			texture = Char_Select_Frame_BG
			dims = (266.0, 128.0)
			rgba = [
				250
				250
				200
				255
			]}
		SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
			rgba = [
				160
				80
				30
				255
			]}
		get_instrument_brand_and_finish id = <instrument_id>
		SetScreenElementProps id = $gs_guitar_brand_ID_p1 text = <instrument_brand>
		SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
			scale = 1}
		GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
		if (<width> > 260)
			SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
				scale = 1}
			fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + (<Height> * (0.0, 1.0))) pos = (($gs_element_offsets [2]) + (-2.0, 8.0))
		endif
		SetScreenElementProps id = $gs_guitar_finish_ID_p1 text = <instrument_name2>
		get_instrument_logo id = <instrument_id>
		SetScreenElementProps id = gs_guitar_logo_ID_p1 text = <instrument_logo>
		select_guitar_change_blurb_text inst_ID = <instrument_id>
	else
		if (<instrument_type> = guitar)
			change \{gs_select_text = "SELECT GUITAR"}
		elseif (<instrument_type> = Bass)
			change \{gs_select_text = "SELECT BASS"}
		endif
		if (<player> = 1)
			SetScreenElementProps \{id = gs_select_guitar_text_p1
				text = $gs_select_text}
			LaunchEvent \{type = focus
				target = scrolling_select_guitar_p1}
			LaunchEvent \{type = unfocus
				target = scrolling_guitar_finish_menu_p1}
			destroy_menu \{menu_id = scrolling_guitar_finish_menu_p1}
			change \{gs_made_first_selection_bool_p1 = 0}
			if ($is_network_game = 1)
				network_player_lobby_message {
					type = skin_select
					action = deselect
					checksum = <instrument_type>
				}
			endif
			instrument_id = ($<gs_available_instruments> [($guitar_select_old_guitar_p1)])
			change \{guitar_select_highlighted_guitar_p1 = $guitar_select_old_guitar_p1}
			change \{gs_selected_brand_p1 = $gs_old_selected_brand_p1}
			if NOT (<instrument_id> = ($player1_status.instrument_id))
				change structurename = player1_status instrument_id = <instrument_id>
				FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
				change globalname = <change_flag> newvalue = 1
			endif
			get_instrument_brand_and_finish id = <instrument_id>
			SetScreenElementProps \{id = gs_brand_background_p1
				pos = (0.0, 30.0)}
			SetScreenElementProps \{id = gs_finish_background_p1
				pos = (0.0, 88.0)}
			SetScreenElementProps {
				id = $gs_guitar_brand_ID_p1
				text = <instrument_brand>
				scale = 1
				pos = (0.0, 10.0)
				rgba = [80 0 10 255]
			}
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p1
				text = <instrument_name2>
				scale = (0.75, 0.5)
				pos = (0.0, 83.0)
				rgba = [250 250 200 255]
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 83.0)
			endif
			get_instrument_logo id = <instrument_id>
			SetScreenElementProps id = gs_guitar_logo_ID_p1 text = <instrument_logo>
			SetScreenElementProps \{id = gs_guitar_logo_ID_p1
				unhide}
		else
			SetScreenElementProps \{id = gs_select_guitar_text_p2
				text = $gs_select_text}
			LaunchEvent \{type = focus
				target = scrolling_select_guitar_p2}
			LaunchEvent \{type = unfocus
				target = scrolling_guitar_finish_menu_p2}
			destroy_menu \{menu_id = scrolling_guitar_finish_menu_p2}
			change \{gs_made_first_selection_bool_p2 = 0}
			instrument_id = ($<gs_available_instruments> [($guitar_select_old_guitar_p2)])
			change \{guitar_select_highlighted_guitar_p2 = $guitar_select_old_guitar_p2}
			change \{gs_selected_brand_p2 = $gs_old_selected_brand_p2}
			if NOT (<instrument_id> = ($player2_status.instrument_id))
				change structurename = player2_status instrument_id = <instrument_id>
				FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
				change globalname = <change_flag> newvalue = 1
			endif
			get_instrument_brand_and_finish id = <instrument_id>
			SetScreenElementProps \{id = gs_brand_background_p2
				pos = (0.0, 30.0)}
			SetScreenElementProps \{id = gs_finish_background_p2
				pos = (0.0, 88.0)}
			SetScreenElementProps {
				id = $gs_guitar_brand_ID_p2
				text = <instrument_brand>
				scale = 1
				pos = (0.0, 10.0)
				rgba = [70 0 50 255]
			}
			GetScreenElementDims \{id = $gs_guitar_brand_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_brand_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_brand_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 10.0)
			endif
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p2
				text = <instrument_name2>
				scale = (0.75, 0.5)
				pos = (0.0, 83.0)
				rgba = [240 251 250 255]
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 83.0)
			endif
			get_instrument_logo id = <instrument_id>
			SetScreenElementProps id = gs_guitar_logo_ID_p2 text = <instrument_logo>
			SetScreenElementProps \{id = gs_guitar_logo_ID_p2
				unhide}
		endif
		if (<player> = 1)
			destroy_menu \{menu_id = select_finish_container}
		else
			destroy_menu \{menu_id = select_finish_container_p2}
		endif
	endif
endscript

script select_guitar_finish_highlight \{player = 1
		index = 0}
	FormatText checksumname = player_status 'player%i_status' i = <player>
	if NOT (<id> = $<player_status>.instrument_id)
		change structurename = <player_status> instrument_id = <id>
		FormatText checksumname = change_flag 'generic_select_monitor_p%i_changed' i = <player>
		change globalname = <change_flag> newvalue = 1
	endif
	get_instrument_brand_and_finish id = <id>
	if ($current_num_players = 1)
		SetScreenElementProps id = $gs_guitar_brand_ID_p1 text = <instrument_brand>
		SetScreenElementProps id = $gs_guitar_finish_ID_p1 text = <instrument_name2>
		get_instrument_logo id = <id>
		SetScreenElementProps id = gs_guitar_logo_ID_p1 text = <instrument_logo>
		<offset> = (<index> * (0.0, 33.5))
		<l_pos> = ((-64.0, 11.0) + <offset>)
		<r_pos> = ((238.0, 11.0) + <offset>)
		<hl_pos> = ((-47.0, 8.0) + <offset>)
		SetScreenElementProps id = gs_bookend1_ID pos = <l_pos>
		SetScreenElementProps id = gs_bookend2_ID pos = <r_pos>
		SetScreenElementProps id = gs_whiteTexHighlight_ID pos = <hl_pos>
	else
		if (<player> = 1)
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p1
				text = <instrument_finish>
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p1}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p1
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p1 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 52.0)
			endif
		else
			SetScreenElementProps {
				id = $gs_guitar_finish_ID_p2
				text = <instrument_finish>
			}
			GetScreenElementDims \{id = $gs_guitar_finish_ID_p2}
			if (<width> > 260)
				SetScreenElementProps \{id = $gs_guitar_finish_ID_p2
					scale = 1}
				fit_text_in_rectangle id = $gs_guitar_finish_ID_p2 dims = ((255.0, 0.0) + ((<Height>) * (0.0, 1.0))) pos = (0.0, 52.0)
			endif
		endif
	endif
endscript

script select_guitar_finish_choose \{player = 1
		needs_net_message = 1}
	if (<player> = 1)
		get_instrument_name_and_index id = <id>
		select_guitar_get_available_index_from_total_index {
			gs_available_instruments = <gs_available_instruments>
			index = <instrument_index>
		}
		change guitar_select_highlighted_guitar_p1 = <index>
		if GotParam \{finish_index}
			change gh_net_finish_id = <finish_index>
		endif
		select_guitar_choose {
			player = <player>
			gs_available_instruments = <gs_available_instruments>
			instrument_type = <instrument_type>
			needs_net_message = <needs_net_message>
			includes_finish = 1
		}
	else
		get_instrument_name_and_index id = <id>
		select_guitar_get_available_index_from_total_index {
			gs_available_instruments = <gs_available_instruments>
			index = <instrument_index>
		}
		change guitar_select_highlighted_guitar_p2 = <index>
		select_guitar_choose {
			player = <player>
			gs_available_instruments = <gs_available_instruments>
			instrument_type = <instrument_type>
		}
	endif
	if (<player> = 1)
		destroy_menu \{menu_id = select_finish_container}
		destroy_menu \{menu_id = scrolling_guitar_finish_menu_p1}
	else
		destroy_menu \{menu_id = select_finish_container_p2}
		destroy_menu \{menu_id = scrolling_guitar_finish_menu_p2}
	endif
endscript

script build_gs_available_guitar_array 
	if (<instrument_type> = guitar)
		FormatText \{checksumname = guitar_select_available_instruments
			'guitar_select_available_guitar_array'}
		change \{globalname = guitar_select_guitar_indeces
			newvalue = [
			]}
		change globalname = <guitar_select_available_instruments> newvalue = ($Free_Guitars)
		<secret_instrument_array> = ($Secret_Guitars)
		<download_instrument_array> = Download_Guitars
		num_downloads_on_other_client = ($download_guitars_on_other_client)
		<bonus_guitar_array> = ($Bonus_Guitars)
		<bonus_guitar_finishes_array> = ($Bonus_Guitar_Finishes)
	else
		FormatText \{checksumname = guitar_select_available_instruments
			'guitar_select_available_bass_array'}
		change \{globalname = guitar_select_bass_indeces
			newvalue = [
			]}
		change globalname = <guitar_select_available_instruments> newvalue = ($Free_Basses)
		<secret_instrument_array> = ($Secret_Basses)
		<download_instrument_array> = Download_Basses
		num_downloads_on_other_client = ($download_basses_on_other_client)
		<bonus_guitar_array> = ($Bonus_Basses)
		<bonus_guitar_finishes_array> = ($Bonus_Bass_Finishes)
	endif
	num_downloads = 0
	if GlobalExists name = <download_instrument_array>
		GetArraySize ($<download_instrument_array>)
		<download_array_size> = <array_size>
		<i> = 0
		begin
		find_instrument_index desc_id = ($<download_instrument_array> [<i>])
		if is_musician_instrument_downloaded index = <index>
			AddArrayElement array = $<guitar_select_available_instruments> element = ($<download_instrument_array> [<i>])
			change globalname = <guitar_select_available_instruments> newvalue = (<array>)
			num_downloads = (<num_downloads> + 1)
		endif
		<i> = (<i> + 1)
		repeat <download_array_size>
	endif
	if ($is_network_game = 1 && <player> = 2 && (($download_guitars_on_other_client - <num_downloads>) > 0))
		begin
		AddArrayElement array = $<guitar_select_available_instruments> element = (<guitar_select_available_instruments> [0])
		change globalname = <guitar_select_available_instruments> newvalue = (<array>)
		repeat ($download_guitars_on_other_client - <num_downloads>)
	endif
	GetArraySize (<secret_instrument_array>)
	<secret_array_size> = <array_size>
	<i> = 0
	begin
	GetGlobalTags (<secret_instrument_array> [<i>].id) param = unlocked
	if (<unlocked>)
		AddArrayElement array = $<guitar_select_available_instruments> element = (<secret_instrument_array> [<i>].id)
		change globalname = <guitar_select_available_instruments> newvalue = (<array>)
	endif
	<i> = (<i> + 1)
	repeat <secret_array_size>
	GetArraySize (<bonus_guitar_array>)
	<bonus_guitar_array_size> = <array_size>
	<j> = 0
	begin
	GetGlobalTags (<bonus_guitar_array> [<j>].id) param = unlocked
	if (<unlocked>)
		AddArrayElement array = $<guitar_select_available_instruments> element = (<bonus_guitar_array> [<j>].id)
		change globalname = <guitar_select_available_instruments> newvalue = (<array>)
	endif
	<j> = (<j> + 1)
	repeat <bonus_guitar_array_size>
	GetArraySize (<bonus_guitar_finishes_array>)
	<bonus_guitar_finishes_array_size> = <array_size>
	<k> = 0
	begin
	GetGlobalTags (<bonus_guitar_finishes_array> [<k>].id) param = unlocked
	if (<unlocked>)
		AddArrayElement array = $<guitar_select_available_instruments> element = (<bonus_guitar_finishes_array> [<k>].id)
		change globalname = <guitar_select_available_instruments> newvalue = (<array>)
	endif
	<k> = (<k> + 1)
	repeat <bonus_guitar_finishes_array_size>
	GetArraySize <guitar_select_available_instruments> GlobalArray
	change guitar_select_total_num_guitars = <array_size>
	<i> = 0
	GetArraySize <guitar_select_available_instruments> GlobalArray
	total_size = <array_size>
	begin
	<j> = 0
	get_musician_instrument_size
	begin
	get_musician_instrument_struct index = <j>
	if (($<guitar_select_available_instruments> [<i>]) = (<info_struct>.desc_id))
		if (<instrument_type> = guitar)
			AddArrayElement array = $guitar_select_guitar_indeces element = <j>
			change globalname = guitar_select_guitar_indeces newvalue = (<array>)
		else
			AddArrayElement array = $guitar_select_bass_indeces element = <j>
			change globalname = guitar_select_bass_indeces newvalue = (<array>)
		endif
		break
	endif
	<j> = (<j> + 1)
	repeat <array_size>
	<i> = (<i> + 1)
	repeat <total_size>
endscript
