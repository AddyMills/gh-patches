battle_explanation_color_white = [
	245
	220
	200
	255
]
battle_explanation_color_yellow = [
	237
	169
	0
	255
]
battle_explanation_bullet_materials = [
	sys_BattleGEM_Green01_sys_BattleGEM_Green01
	sys_BattleGEM_RED01_sys_BattleGEM_RED01
	sys_BattleGEM_Yellow01_sys_BattleGEM_Yellow01
	sys_BattleGEM_Blue01_sys_BattleGEM_Blue01
	sys_BattleGEM_Orange01_sys_BattleGEM_Orange01
]
battle_explanation_text = {
	bossslash = {
		image = battle_help_boss_bg_slash
		title = "슬래시가 배틀 신청!"
		bullets = [
			{
				text = "스타의 힘 대신에 배틀 파워를 얻었습니다"
			}
			{
				text = "배틀 보석을 연주해 파워업을 획득하십시오"
			}
			{
				text = "기타를 위로 기울여 슬래시를 공격해 실수하도록 만드십시오"
			}
			{
				text = "노래가 끝나기 전에 상대를 실패하게 만들면 승리합니다"
			}
			{
				text = "반격해올 수도 있으니 주의하십시오"
			}
		]
		prompt = "준비되셨습니까?"
	}
	bosstom = {
		image = battle_help_boss_bg_morello
		title = "모렐로의 도전 신청!"
		bullets = [
			{
				text = "스타의 힘 대신에 배틀 파워를 얻었습니다"
			}
			{
				text = "배틀 보석을 연주해 파워업을 획득하십시오"
			}
			{
				text = "기타를 위로 기울여 톰을 공격해 실수하도록 만드십시오"
			}
			{
				text = "노래가 끝나기 전에 상대를 실패하게 만들면 승리합니다"
			}
			{
				text = "반격해올 수도 있으니 주의하십시오"
			}
		]
		prompt = "준비되셨습니까?"
	}
	bossdevil = {
		image = battle_help_boss_bg_satan
		title = "드디어 때가 왔습니다!"
		bullets = [
			{
				text = "스타의 힘 대신에 배틀 파워를 얻었습니다"
			}
			{
				text = "배틀 보석을 연주해 파워업을 획득하십시오"
			}
			{
				text = "기타를 위로 기울여 라우를 공격해 실수하도록 만드십시오"
			}
			{
				text = "노래가 끝나기 전에 상대를 실패하게 만들면 승리합니다"
			}
			{
				text = "반격해올 수도 있으니 주의하십시오"
			}
		]
		prompt = "준비되셨습니까?"
	}
	generic = {
		title = "배틀 모드!"
		bullets = [
			{
				text = "스타의 힘 대신에 배틀 파워를 얻었습니다"
			}
			{
				text = "배틀 보석을 연주해 파워업을 획득하십시오"
			}
			{
				text = "기타를 위로 기울여 다른 플레이어를 공격해 실수하도록 만드십시오"
			}
			{
				text = "노래가 끝나기 전에 상대방이 실패하도록 만들지 못하면 서든 데스에 들어가게 됩니다"
			}
			{
				text = "서든 데스에서는 모든 파워업이 무시무시한 죽음의 흡수로 변경됩니다"
			}
		]
		prompt = "준비되셨습니까?"
	}
}

script create_battle_helper_menu \{device_num = 0
		popup = 0}
	if GameIsPaused
		unpausegame
	endif
	if GotParam \{boss}
		if ($game_mode = p2_battle)
			<boss_structure> = ($battle_explanation_text.generic)
		else
			<boss_structure> = ($battle_explanation_text.<boss>)
		endif
	else
		GetGlobalTags \{Progression}
		<boss_structure> = ($battle_explanation_text.<boss_song>)
	endif
	menu_z = 10
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = battle_explanation_container}
	CreateScreenElement \{type = SpriteElement
		parent = battle_explanation_container
		id = battle_explanation_screen
		pos = (640.0, 360.0)
		texture = battle_help_bg
		rgba = [
			223
			223
			223
			255
		]
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = 0}
	CreateScreenElement \{parent = battle_explanation_container
		type = VMenu
		id = bullet_spacer
		pos = (545.0, 205.0)
		just = [
			left
			top
		]
		internal_just = [
			left
			top
		]}
	GetArraySize \{$battle_explanation_bullet_materials}
	<num_materials> = <array_size>
	GetArraySize (<boss_structure>.bullets)
	<num_bullets> = <array_size>
	<i> = 0
	begin
	CreateScreenElement \{parent = bullet_spacer
		type = ContainerElement
		dims = (100.0, 100.0)
		just = [
			left
			top
		]}
	<container_id> = <id>
	CreateScreenElement {
		parent = <container_id>
		type = TextBlockElement
		text = (<boss_structure>.bullets [<i>].text)
		local_id = text
		dims = (480.0, 0.0)
		pos = (0.0, 0.0)
		allow_expansion
		rgba = $battle_explanation_color_white
		z_priority = 50
		line_spacing = 0.9
		font = text_a4
		just = [left top]
		internal_just = [left top]
		internal_scale = 0.625
		shadow
		shadow_rgba = [0 0 0 255]
		shadow_offs = (3.0, 3.0)
		alpha = 0
	}
	GetScreenElementDims id = <id>
	<container_id> :SetProps dims = ((1.0, 0.0) * <width> + (0.0, 1.0) * <height> + (0.0, 20.0))
	Mod a = <i> b = <num_materials>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		rgba = [255 255 255 255]
		just = [right top]
		z_priority = 40
		local_id = gem
		pos = (12.0, 7.0)
		scale = 0.5
		material = ($battle_explanation_bullet_materials [<Mod>])
		alpha = 0
		MaterialProps = [
			{
				name = m_startFade
				Property = 1.0
			}
			{
				name = m_endFade
				Property = 1.0
			}
			{
				name = m_playerIndex
				Property = 1.0
			}
		]
	}
	RunScriptOnScreenElement id = <container_id> battle_fly_in_anim Params = {idx = <i> container_id = <container_id>}
	<i> = (<i> + 1)
	repeat <num_bullets>
	if isps3
		change \{gHighwayStartFade = 1.0}
		change \{gHighwayEndFade = 1.0}
	endif
	if iswinport
		change \{gHighwayStartFade = 1.0}
		change \{gHighwayEndFade = 1.0}
	endif
	if structurecontains \{structure = boss_structure
			image}
		CreateScreenElement {
			type = SpriteElement
			id = who_wants_to_battle_image
			parent = battle_explanation_container
			rgba = [255 255 255 255]
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			texture = (<boss_structure>.image)
			just = [center center]
			z_priority = 5
			alpha = 1
		}
	endif
	<title_offset> = (-10.0, -20.0)
	displaySprite {
		parent = battle_explanation_container
		tex = battle_help_flourish
		pos = ((770.0, 165.0) + <title_offset>)
		dims = (384.0, 96.0)
		just = [center bottom]
		z = 50
	}
	<id> :domorph alpha = 0.5
	displaySprite {
		parent = battle_explanation_container
		tex = battle_help_flourish
		pos = ((770.0, 145.0) + <title_offset>)
		just = [center top]
		dims = (384.0, 96.0)
		z = 50
		flip_h
	}
	<id> :domorph alpha = 0.5
	CreateScreenElement {
		type = TextElement
		parent = battle_explanation_container
		id = who_wants_to_battle_text
		text = (<boss_structure>.title)
		font = text_a10
		scale = 1
		pos = ((770.0, 120.0) + <title_offset>)
		rgba = [237 169 0 255]
		just = [center top]
		z_priority = 51
		font_spacing = 5
		shadow
		shadow_rgba = [0 0 0 255]
		shadow_offs = (3.0, 3.0)
		event_handlers = [
			{pad_choose battle_helper_continue Params = {device_num = <device_num>}}
			{pad_back battle_helper_back}
		]
		exclusive_device = ($primary_controller)
	}
	displayText {
		parent = bullet_spacer
		text = (<boss_structure>.prompt)
		font = text_a4
		scale = 0.7
		pos = (575.0, 580.0)
		rgba = [237 169 0 255]
		just = [left top]
		z = 50
	}
	RunScriptOnScreenElement id = <id> wait_and_show_ready
	LaunchEvent \{type = focus
		target = who_wants_to_battle_text}
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = "배틀"
		button = green
		z = 100}
	add_user_control_helper \{text = "거부"
		button = red
		z = 100}
endscript

script battle_helper_continue 
	ui_flow_manager_respond_to_action action = continue device_num = <device_num>
endscript

script battle_helper_back 
	if ($game_mode = p1_career)
		WriteAchievements \{achievement = wuss_out}
	endif
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script destroy_battle_helper_menu 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = battle_explanation_container}
endscript

script battle_fly_in_anim 
	ResolveScreenElementId id = {<container_id> child = text}
	<text_id> = <resolved_id>
	ResolveScreenElementId id = {<container_id> child = gem}
	<gem_id> = <resolved_id>
	Wait \{0.15
		seconds}
	Wait (<idx> * 0.4) seconds
	<gem_id> :GetProps
	<gem_final_pos> = <pos>
	soundevent \{event = GH3_Star_FlyIn}
	<gem_id> :domorph pos = (<gem_final_pos> + (-600.0, 0.0)) alpha = 1
	<gem_id> :domorph pos = <gem_final_pos> time = 0.35000002 motion = ease_in
	<text_id> :domorph time = 0.2 motion = ease_in rgba = [255 255 255 255] alpha = 1
	<text_id> :domorph time = 0.1 motion = ease_out rgba = $battle_explanation_color_white
endscript

script wait_and_show_ready 
	domorph \{alpha = 0}
	Wait \{2.8
		seconds}
	domorph \{time = 0.2
		motion = ease_in
		rgba = [
			255
			255
			255
			255
		]
		alpha = 1}
	domorph \{time = 0.1
		motion = ease_in
		rgba = $battle_explanation_color_yellow}
endscript
