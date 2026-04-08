sponsored_menu_font = text_a4
sponsor_info = {
	tier1 = {
		logo_texture = Sponsor_Logo_AT
		product_texture = sponsor_photo_AT
		sponsorship_desc = "오디오 테크니카는 당신의 공연에 감동받았습니다! 한층 수준을 올릴 시간이군요! 스폰서 계약과 함께 전설의 마이크를 맞춰준다 합니다."
		sponsorship_value = 1440
	}
	tier2 = {
		logo_texture = Sponsor_Logo_Line6
		product_texture = sponsor_photo_line6
		sponsorship_desc = "라인 6는 당신이 지난 공연을 아주 끝내주게 해냈다고 생각합니다. 이제 소리를 더 높일 시간이군요! 라인 6에서 스폰서 계약과 함께 당신의 음향을 보조할 멋진 장비들을 제공하겠다고 합니다."
		sponsorship_value = 1440
	}
	tier3 = {
		logo_texture = Sponsor_Logo_ErnieBall
		product_texture = sponsor_photo_ernieBall
		sponsorship_desc = "어니 볼은 당신이 잘 성장하고 있다고 봅니다. 저들은 당신의 성장을 돕고 싶어합니다! 스폰서 계약과 함께 지겹도록 끊어버릴 수 있을 양의 기타줄을 증정한다 합니다. 열심히 하세요!"
		sponsorship_value = 1440
	}
	tier4 = {
		logo_texture = Sponsor_Logo_Mackie
		product_texture = sponsor_photo_mackie
		sponsorship_desc = "맥키는 당신이 미래의 스타가 될 재목이라 생각합니다. 너무 자만하진 마세요! 당신이 드럼 너머로 자신을 들을 수 있게 모니터를 증정한다 합니다."
		sponsorship_value = 1440
	}
	tier5 = {
		logo_texture = Sponsor_Logo_Zildjian
		product_texture = sponsor_photo_zildjian
		sponsorship_desc = "질지안의 대표는 당신이 정상을 향해 달려가고 있다고 생각합니다. 스폰서 계약과 함께 심벌즈를 증정한다 합니다. 맘껏 즐기세요!"
		sponsorship_value = 1440
	}
	tier6 = {
		logo_texture = Sponsor_Logo_Crate
		product_texture = sponsor_photo_crate
		sponsorship_desc = "크래잇 앰프는 당신의 매력에 확신을 가졌습니다. 후끈 달아 오르게 할 시간이군요! 당신의 고막은 아프겠지만 지갑은 두둑하겠네요. 평생 써먹을 수 있을 만큼 많은 앰프를 증정한다고 합니다!"
		sponsorship_value = 1440
	}
	tier7 = {
		logo_texture = Sponsor_Logo_Krank
		product_texture = sponsor_photo_krank
		sponsorship_desc = "크랭크 앰플리피케이션은 당신의 독주가 굉장했다고 봅니다! 당신이 크랭크와 같이 공연한다면 대단할거라 생각한답니다. 공짜 부품이 있는게 다행이네요! '스폰서가 좋아요'라고 말씀하실래요?"
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
	SetGlobalTags <band_info> Params = {Cash = <Cash>}
	GetGlobalTags \{achievement_info}
	total_cash_in_career_mode = (<total_cash_in_career_mode> + <sponsorship_value>)
	SetGlobalTags achievement_info Params = {total_cash_in_career_mode = <total_cash_in_career_mode>}
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
		text = "스폰서가 생겼습니다!"
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
		text = "스폰서에게서 다음의 금액을 받았습니다."
		scale = 0.6
		pos = (500.0, 470.0)
		rot_angle = (<rot> - 1)
		just = [center top]
		font = ($sponsored_menu_font)
		rgba = <bluish>
	}
	fit_text_in_rectangle id = <id> dims = (250.0, 0.0) only_if_larger_x = 1 keep_ar = 1
	soundevent \{event = Cash_Sound}
	FormatText textname = value_text "$%v" v = <sponsorship_value>
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
		text = "계속"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action Params = {action = continue}}
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
