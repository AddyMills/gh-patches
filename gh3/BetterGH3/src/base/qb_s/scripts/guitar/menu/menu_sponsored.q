sponsored_menu_font = text_a4
sponsor_info = {
	tier1 = {
		logo_texture = Sponsor_Logo_AT
		product_texture = sponsor_photo_AT
		sponsorship_desc = "¡Audio Technica quedó impresionado con tu actuación! ¡Es hora de pasar al siguiente nivel! Te ofrecen un patrocinio y te regalan sus micrófonos legendarios."
		sponsorship_value = 1440
	}
	tier2 = {
		logo_texture = Sponsor_Logo_Line6
		product_texture = sponsor_photo_line6
		sponsorship_desc = "Line 6 Amps piensa que te luciste en la última actuación, ¡es hora de darle caña!  Te han ofrecido un patrocinio y un amplificador Line 6 para que arrases."
		sponsorship_value = 1440
	}
	tier3 = {
		logo_texture = Sponsor_Logo_ErnieBall
		product_texture = sponsor_photo_ernieBall
		sponsorship_desc = "Ernie Ball cree que estás rozando el éxito. ¡Quieren ayudarte a conseguirlo! Te ofrecen patrocinarte y además todas las cuerdas que puedas romper, ¡así que más te vale hacerlo bien!"
		sponsorship_value = 1440
	}
	tier4 = {
		logo_texture = Sponsor_Logo_Mackie
		product_texture = sponsor_photo_mackie
		sponsorship_desc = "Mackie cree que eres el próximo exitazo. ¡No permitas que la fama se te suba a la cabeza! Has conseguido unos monitores cañeros para que te escuches por encima del batería."
		sponsorship_value = 1440
	}
	tier5 = {
		logo_texture = Sponsor_Logo_Zildjian
		product_texture = sponsor_photo_zildjian
		sponsorship_desc = "Los peces gordos de Zildjian creen que tienes madera de estrella, ¡así que mejor que sepas cómo 'hacer ruido'! Te ofrecen un patrocinio y su línea de platillos. ¡Demuéstrales lo ruidoso que eres!"
		sponsorship_value = 1440
	}
	tier6 = {
		logo_texture = Sponsor_Logo_Crate
		product_texture = sponsor_photo_crate
		sponsorship_desc = "En Crate Amps están convencidos de que tienes potencial. ¡Es hora de demostrarlo! Tus tímpanos van a doler pero tu cartera te lo agradecerá. ¡Te patrocinan ofreciéndote todos los amplis que quieras!"
		sponsorship_value = 1440
	}
	tier7 = {
		logo_texture = Sponsor_Logo_Krank
		product_texture = sponsor_photo_krank
		sponsorship_desc = "¡Krank Amplification quedó boquiabierto con tus solos! Dicen que tocar con los amplis de Krank engancha. ¡Qué bien que son gratis! Mola un huevo ser patrocinado, ¿o no?"
		be
		sponsorship_value = 1440
	}
}

script create_sponsored_menu 
	menu_get_sponsor_sound
	if ($player1_status.bot_play = 1)
		exclusive_device = ($primary_controller)
	else
		if ($game_mode = p2_career ||
				$game_mode = p2_faceoff ||
				$game_mode = p2_pro_faceoff ||
				$game_mode = p2_battle)
			exclusive_mp_controllers = [0 , 0]
			SetArrayElement ArrayName = exclusive_mp_controllers index = 0 newvalue = ($player1_status.controller)
			SetArrayElement ArrayName = exclusive_mp_controllers index = 1 newvalue = ($player2_status.controller)
			exclusive_device = <exclusive_mp_controllers>
		else
			exclusive_device = ($primary_controller)
		endif
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		pos = (0.0, 0.0)
		id = sponsored_container
		exclusive_device = <exclusive_device>
	}
	get_tier_from_song \{song = $current_song}
	FormatText checksumname = tier 'tier%d' d = <tier_number>
	sponsor = ($sponsor_info.<tier>)
	sponsorship_value = (<sponsor>.sponsorship_value)
	get_current_band_info
	GetGlobalTags <band_info>
	<Cash> = (<Cash> + <sponsorship_value>)
	SetGlobalTags <band_info> params = {Cash = <Cash>}
	GetGlobalTags \{achievement_info}
	total_cash_in_career_mode = (<total_cash_in_career_mode> + <sponsorship_value>)
	SetGlobalTags achievement_info params = {total_cash_in_career_mode = <total_cash_in_career_mode>}
	sponsorship_value = (<sponsorship_value> + $player1_status.new_cash)
	change \{structurename = player1_status
		new_cash = 0}
	displaySprite {
		parent = sponsored_container
		pos = (640.0, 360.0)
		just = [left center]
		tex = (<sponsor>.product_texture)
		dims = (640.0, 640.0)
		z = -1
	}
	displaySprite \{parent = sponsored_container
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		tex = sponsor_papermag
		dims = (1280.0, 720.0)
		z = 1}
	create_menu_backdrop \{texture = sponsor_bg}
	rot = -6
	bluish = [64 32 128 255]
	displaySprite parent = sponsored_container tex = (<sponsor>.logo_texture) pos = (460.0, 160.0) just = [center center] scale = 1 rot_angle = <rot>
	CreateScreenElement {
		type = TextElement
		parent = sponsored_container
		text = "¡Te han patrocinado!"
		scale = 1.0
		pos = (465.0, 240.0)
		rot_angle = <rot>
		just = [center top]
		rgba = [120 0 0 255]
		font = ($sponsored_menu_font)
	}
	fit_text_in_rectangle id = <id> dims = (400.0, 0.0) only_if_larger_x = 1 keep_ar = 1
	CreateScreenElement {
		type = TextBlockElement
		parent = sponsored_container
		text = (<sponsor>.sponsorship_desc)
		scale = 0.55
		pos = (490.0, 305.0)
		rot_angle = <rot>
		dims = (800.0, 400.0)
		just = [center top]
		internal_just = [left top]
		font = ($sponsored_menu_font)
		rgba = [0 0 0 255]
	}
	CreateScreenElement {
		type = TextElement
		parent = sponsored_container
		text = "EXPRIMES A TU PATROCINADOR POR:"
		scale = 0.6
		pos = (500.0, 470.0)
		rot_angle = (<rot> - 1)
		just = [center top]
		font = ($sponsored_menu_font)
		rgba = <bluish>
	}
	fit_text_in_rectangle id = <id> dims = (250.0, 0.0) only_if_larger_x = 1 keep_ar = 1
	SoundEvent \{event = Cash_Sound}
	FormatText TextName = value_text "$%v" v = <sponsorship_value>
	CreateScreenElement {
		type = TextElement
		parent = sponsored_container
		text = <value_text>
		scale = (1.5, 1.3499999)
		pos = (500.0, 505.0)
		rot_angle = (<rot> - 1)
		just = [center top]
		font = ($sponsored_menu_font)
		rgba = <bluish>
	}
	button_font = buttonsxenon
	CreateScreenElement {
		type = TextElement
		parent = sponsored_container
		id = continue_button
		scale = 0.65000004
		pos = (440.0, 610.0)
		text = "\\m0"
		rot_angle = <rot>
		font = <button_font>
		rgba = [255 255 255 255]
		just = [left top]
	}
	CreateScreenElement {
		type = TextElement
		parent = continue_button
		id = continue_text
		scale = 0.9
		pos = (40.0, 22.0)
		text = "CONTINÚA"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action params = {action = continue}}
		]
	}
	displaySprite \{parent = continue_button
		tex = Sponsored_Pill
		pos = (-25.0, -37.0)
		scale = 2.1
		rgba = [
			0
			0
			0
			255
		]}
	LaunchEvent \{type = focus
		target = continue_text}
endscript

script destroy_sponsored_menu 
	destroy_menu \{menu_id = sponsored_container}
	destroy_menu_backdrop
endscript
