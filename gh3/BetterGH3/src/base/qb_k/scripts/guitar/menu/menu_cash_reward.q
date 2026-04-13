cash_deduction_types = [
	{
		desc = "화염에 휩싸인 자동차"
		val = 2500
	}
	{
		desc = "도난당한 벽화"
		val = 80
	}
	{
		desc = "난장판이 된 녹색 방"
		val = 210
	}
	{
		desc = "납부한 고성방가 벌금 고지서"
		val = 550
	}
	{
		desc = "어질러진 호텔 방"
		val = 330
	}
	{
		desc = "섭취한 음료수"
		val = 300
	}
]
review_string_3star = "별 3개의 평균적인 평가를 받음. 여기 당신의 몫입니다."
review_string_4star = "별 4개의 좋은 평가를 받음. 여기 당신의 몫입니다."
review_string_5star = "별 5개의 환상적인 평가를 받음. 여기 당신의 몫입니다."
base_deduction_index_array = [
	0
	1
	2
	3
	4
	5
]

script create_cash_reward_menu 
	if ($player1_status.bot_play = 1)
		exclusive_device = ($primary_controller)
	else
		if ($game_mode = p2_career ||
				$game_mode = p2_faceoff ||
				$game_mode = p2_pro_faceoff ||
				$game_mode = p2_battle)
			exclusive_mp_controllers = [0 , 0]
			SetArrayElement ArrayName = exclusive_mp_controllers index = 0 newvalue = ($player1_device)
			SetArrayElement ArrayName = exclusive_mp_controllers index = 1 newvalue = ($player2_device)
			exclusive_device = <exclusive_mp_controllers>
		else
			exclusive_device = ($primary_controller)
		endif
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = cash_reward_container
		pos = (-90.0, 0.0)
		rot_angle = 6
		exclusive_device = <exclusive_device>
	}
	stars = ($player1_status.stars)
	song_cash = ($player1_status.new_cash)
	change \{structurename = player1_status
		new_cash = 0}
	venue_name = (($LevelZones.($current_level)).title)
	GetUpperCaseString <venue_name>
	CreateScreenElement \{type = SpriteElement
		parent = cash_reward_container
		texture = Newspaper_BG_2P
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = -100}
	create_menu_backdrop \{texture = Cash_reward_bg}
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = (1.1, 0.9)
		pos = (660.0, 0.0)
		text = <uppercasestring>
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [center top]
		z_priority = 3
	}
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = (1.8, 1.3)
		pos = (660.0, 40.0)
		text = "공연 수입"
		font = ($cash_reward_font)
		rgba = [150 60 35 255]
		just = [center top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	if (<width> > 600)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((600.0, 0.0) + <height> * (0.0, 1.0))
	endif
	FormatText checksumname = review_text 'review_string_%vstar' v = <stars>
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = 0.7
		pos = (355.0, 110.0)
		text = (<review_text>)
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	fit_text_in_rectangle id = <id> dims = ((530.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = 0.7 start_y_scale = 0.7
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = 0.7
		pos = (355.0, 140.0)
		text = "뭔가 멋진 것을 구입해보십시오."
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	fit_text_in_rectangle id = <id> dims = ((530.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = 0.7 start_y_scale = 0.7
	create_deductions_list pos = (340.0, 195.0) dims = (550.0, 500.0) scale = (0.9, 0.7) received = <song_cash>
	create_you_get_text pos = (890.0, 400.0) scale = (2.0, 1.5) value = <song_cash>
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = 0.8
		pos = (880.0, 460.0)
		text = "힘들게 얻은 것을 소비하십시오"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [right top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	if (<width> > 510)
		fit_text_in_rectangle id = <id> dims = ((510.0, 0.0) + ((0.0, 1.0) * <height>)) start_x_scale = 0.8 start_y_scale = 0.8
	endif
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = 0.8
		pos = (880.0, 495.0)
		text = "상점에서 사용할 수 있는 현금."
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [right top]
		z_priority = 3
	}
	button_font = buttonsxenon
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		scale = 0.6
		pos = (410.0, 560.0)
		text = "\\m0"
		font = <button_font>
		rgba = [255 255 255 255]
		just = [left top]
		z_priority = 3
	}
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		id = continue_button
		scale = 0.7
		pos = (435.0, 572.0)
		text = "계속"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		z_priority = 3
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action Params = {action = continue}}
		]
	}
	displaySprite \{parent = cash_reward_container
		tex = Sponsored_Pill
		pos = (390.0, 580.0)
		rgba = [
			0
			0
			0
			255
		]
		just = [
			left
			center
		]}
	GetScreenElementDims \{id = continue_button}
	SetScreenElementProps id = <id> dims = (<width> * (1.0, 0.0) + (64.0, 96.0))
	LaunchEvent \{type = focus
		target = continue_button}
endscript

script destroy_cash_reward_menu 
	destroy_menu \{menu_id = cash_reward_container}
	destroy_menu_backdrop
endscript
cash_reward_font = text_a4

script create_deductions_list \{pos = (200.0, 200.0)
		scale = 1
		dims = (400.0, 400.0)
		received = 1200}
	dl_width = ((1.0, 0.0).<dims>)
	dl_height = ((0.0, 1.0).<dims>)
	CreateScreenElement {
		type = ContainerElement
		parent = cash_reward_container
		id = deductions_container
		pos = <pos>
	}
	pay = <received>
	deduction_count = 4
	PermuteArray array = ($base_deduction_index_array) NewArrayName = perm_deduction_array
	index = 0
	begin
	perm_index = (<perm_deduction_array> [<index>])
	<pay> = (<pay> + $cash_deduction_types [<perm_index>].val)
	<index> = (<index> + 1)
	repeat <deduction_count>
	FormatText textname = gross_pay_text "$%d" d = <pay>
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		pos = ((1.0, 0.0) * <dl_width>)
		scale = <scale>
		text = <gross_pay_text>
		font = ($cash_reward_font)
		rgba = [15 70 0 255]
		just = [right top]
		z_priority = 3
	}
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		id = cd_pay_text
		pos = (15.0, 0.0)
		scale = <scale>
		text = "페이"
		font = ($cash_reward_font)
		rgba = [15 70 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims \{id = cd_pay_text}
	separation_height = (<height> * 0.9)
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		pos = (((0.0, 1.0) * <separation_height>) + (15.0, 0.0))
		scale = (<scale> * 0.95)
		text = "마이너스 공제"
		font_spacing = 4
		font = ($cash_reward_font)
		rgba = [150 60 35 255]
		just = [left top]
		z_priority = 3
	}
	index = 0
	begin
	perm_index = (<perm_deduction_array> [<index>])
	deduction_string = ($cash_deduction_types [<perm_index>].desc)
	FormatText textname = deduction_value "-$%v" v = ($cash_deduction_types [<perm_index>].val)
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		pos = (((0.0, 1.0) * (<separation_height> * (<index> + 2))) + (15.0, 0.0))
		scale = (<scale> * 0.95)
		text = <deduction_string>
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	if (<width> > 400)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		pos = ((1.0, 0.0) * <dl_width> + (0.0, 1.0) * (<separation_height> * (<index> + 2)))
		scale = (<scale> * 0.95)
		text = <deduction_value>
		font = ($cash_reward_font)
		rgba = [150 60 35 255]
		just = [right top]
		z_priority = 3
	}
	<index> = (<index> + 1)
	repeat <deduction_count>
endscript

script create_you_get_text \{value = 1200
		scale = 1
		pos = (630.0, 320.0)}
	FormatText textname = payment_text "$%v" v = <value>
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		id = payment_text_id
		scale = <scale>
		text = <payment_text>
		font = ($cash_reward_font)
		pos = (<pos> - (0.0, 15.0))
		rgba = [15 70 0 255]
		just = [right top]
		z_priority = 3
	}
	CreateScreenElement {
		type = TextElement
		parent = cash_reward_container
		id = you_get_id
		scale = (<scale> * 0.65000004)
		text = "획득:"
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [right top]
		z_priority = 3
	}
	soundevent \{event = Cash_Sound}
	GetScreenElementDims \{id = payment_text_id}
	you_get_pos = (<pos> - (1.0, 0.0) * (<width> * 1.1))
	SetScreenElementProps id = you_get_id pos = <you_get_pos>
endscript
