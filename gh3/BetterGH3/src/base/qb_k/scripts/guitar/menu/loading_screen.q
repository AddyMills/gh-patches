loading_screen_tips = [
	"문제가 있으신가요? 훈련 메뉴를 확인해보십시오."
	"문제가 있으신가요? 훈련 메뉴를 확인해보십시오."
	"상점에서 새로운 노래와 멋진 옷, 스타일을 확인해보십시오."
	"상점에서 새로운 노래와 멋진 옷, 스타일을 확인해보십시오."
	"친구와 함께 락에 빠져보고 싶으십니까? 협동 경력 모드에서 새로운 밴드를 시작해보십시오."
	"친구와 함께 락에 빠져보고 싶으십니까? 협동 경력 모드에서 새로운 밴드를 시작해보십시오."
	"연습을 부지런히 하는 것은 어려운 독주 부분을 통과하는 열쇠가 될 수도 있습니다."
	"연습을 부지런히 하는 것은 어려운 독주 부분을 통과하는 열쇠가 될 수도 있습니다."
	"당신이 4트랙으로 녹음을 하지 않았다면 밴드라고 불릴 가치도 없습니다."
	"관중들에게 뛰어들기 전에 그들이 당신을 잡아줄 마음이 있는지를 꼭 확인하십시오."
	"집에서 만든 화약같은 것은 절대로 사용하지 마십시오."
	"연습에 30분 늦게 나타나는 것은 단순한 전통입니다."
	"모니터에 그만 좀 쳐박히면 안될까요?"
	"당신들이 무대에서 전부 검은색옷을 입은 최초의 밴드라고 생각하지 마십시오."
	"네, 무대 모니터는 사실 다이빙 보드입니다."
	"절대 무슨 일이 있어도 가수가 믹싱을 하게하면 안됩니다."
	"항상 예상보다 소리가 커지기 마련입니다."
	"우리는 매우 화가 나있는 밴드지만 그렇다고 평화를 믿지 않는 것은 아닙니다."
	"20분 동안 즉흥적인 재즈 연주를 하는 것은 전혀 좋은 생각이 아닙니다."
	"사람들은 엉망진창인 연주나 들으려고 돈을 내는 것이 아닙니다."
	"방금 일어난 상태에서 무대에서 보여지는 모습을 꾸미는데 상당한 시간이 소요됩니다."
	"밴드의 누군가는 반드시 펑크난 타이어 교체 방법을 숙지하도록 하십시오."
	"그 앰프 좀 켜보세요. 귀에서 피가 날 생각도 안 하잖아요."
	"전에는 앰프가 불에 휩싸였을 때 공포에 떨었지만 지금은 그 소리를 즐기죠."
	"부숴버린 기타가 부수지 않은 기타보다 더 좋은 소리를 내는 것 같습니다."
	"당신은 딱 전임자만큼의 실력밖에 안되네요... 실력이 거지같았거든요."
	"아주 잘 연주했습니다. 아마도 옷차림에만 야유를 보낸걸 겁니다."
	"어쩌면 드럼 기계가 박자를 맞춰줄 지도 모르겠네요."
	"베이스 앰프에 문제가 있는 것 같네요. 다 들린다구요!"
	"빨리 나가서 먹고 살 수 있도록 거칠게 락을 부르고 티셔츠를 팔아제끼십시오."
	"우리의 최신 싱글 곡으로 시작하죠. 그래야 그따위 *&?#@!를 일찌감치 치워버리죠!"
	"저는 드러머입니다. 이게 대체 뭐하는 짓인지 전혀 모르겠어요!"
	"장담하겠는데 탈의실 TV가 자기 발로 걸어서 창문으로 뛰어내릴리가 없잖아요!"
	"혼자 놀기는 좀 지겨우신가요? 온라인에 접속해 LIVE 대전을 즐겨보세요!"
	"새로운 노래가 필요하십니까? 온라인 메뉴에서 새로운 콘텐츠를 사용할 수 있는지 확인하십시오!"
	"협동 플레이를 하고싶은데 친구가 없으신가요? 온라인에서 누구 하나 낚아서 해보세요!"
	"기타의 신은 누구일까요? 온라인 메뉴에서 순위표를 확인해보십시오."
	"노트를 맞추기가 어려우십니까? 옵션 메뉴의 음향 랙 조절 도구를 사용해보십시오."
]
g_loading_screen_split_container_id = id

script create_loading_screen \{mode = play_song}
	kill_start_key_binding
	if ($is_changing_levels = 1)
		return
	endif
	change \{is_changing_levels = 1}
	GetArraySize ($loading_screen_tips)
	GetRandomValue name = rand_num a = 0 b = (<array_size> - 1) Integer
	rand_tip = ($loading_screen_tips [<rand_num>])
	if (<mode> = play_song || <mode> = play_encore || <mode> = play_boss || <mode> = restart_song)
		killspawnedscript \{name = jiggle_text_array_elements}
		if ScreenElementExists \{id = $g_loading_screen_split_container_id}
			DestroyScreenElement \{id = $g_loading_screen_split_container_id}
		endif
		movie = 'loading_flying'
		if NOT IsMovieInBuffer movie = <movie>
			buffer_slot = 0
			FreeMovieBuffer buffer_slot = <buffer_slot>
			if GotExtraMemory
				MemPushContext \{DebugHeap}
			endif
			AllocateMovieBuffer buffer_slot = <buffer_slot> movie = 'movies\\bik\\loading_flying.bik.xen'
			if GotExtraMemory
				MemPopContext
			endif
			LoadMovieIntoBuffer buffer_slot = <buffer_slot> movie = <movie>
		endif
		PlayMovieFromBuffer {
			buffer_slot = <buffer_slot>
			TextureSlot = 2
			no_hold
			wait_until_rendered
			TexturePri = 4999
		}
		CreateScreenElement {
			type = TextBlockElement
			parent = root_window
			id = loading_tip_text
			text = <rand_tip>
			font = text_a4
			scale = 0.9
			just = [center center]
			dims = (350.0, 480.0)
			pos = (860.0, 300.0)
			rgba = [255 255 255 255]
			z_priority = 5000
			shadow
			shadow_offs = (5.0, 5.0)
			shadow_rgba = [0 0 0 255]
		}
		split_text_into_array_elements \{text = "LOADING"
			text_pos = (400.0, 560.0)
			space_between = (40.0, 0.0)
			flags = {
				rgba = [
					255
					255
					255
					255
				]
				scale = 2.0
				z_priority = 6000
				font = text_a10
				just = [
					center
					center
				]
				alpha = 1
			}}
		change g_loading_screen_split_container_id = <container_id>
		spawnscriptnow \{jiggle_text_array_elements
			Params = {
				id = $g_loading_screen_split_container_id
				time = 1.0
				wait_time = 3000
				explode = 0
			}}
	else
		killspawnedscript \{name = destroy_loading_screen_spawned}
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = loading_screen_container
			pos = (0.0, 0.0)}
		CreateScreenElement \{type = SpriteElement
			parent = loading_screen_container
			texture = loading_flying_static
			pos = (640.0, 360.0)
			just = [
				center
				center
			]
			dims = (1280.0, 720.0)}
	endif
endscript

script destroy_loading_screen 
	destroy_menu \{menu_id = loading_tip_text}
	killspawnedscript \{name = jiggle_text_array_elements}
	if ScreenElementExists \{id = $g_loading_screen_split_container_id}
		DestroyScreenElement \{id = $g_loading_screen_split_container_id}
	endif
	if IsMoviePlaying \{TextureSlot = 2}
		KillMovie \{TextureSlot = 2}
	endif
	spawnscriptnow \{destroy_loading_screen_spawned}
	Hideloadingscreen
	if ($playing_song = 0)
		change \{is_changing_levels = 0}
	endif
endscript

script destroy_loading_screen_spawned \{time = 0.3}
	OnExitRun \{destroy_loading_screen_finish}
	if (<time> > 0)
		if ScreenElementExists \{id = menu_backdrop_container}
			doScreenElementMorph id = menu_backdrop_container alpha = 0 time = <time>
		endif
		if ScreenElementExists \{id = loading_screen_container}
			doScreenElementMorph id = loading_screen_container alpha = 0 time = <time>
		endif
		Wait <time> seconds
	endif
endscript

script destroy_loading_screen_finish 
	if iswinport
		if IsMoviePlaying \{TextureSlot = 2}
			KillMovie \{TextureSlot = 2}
		endif
	endif
	if ScreenElementExists \{id = loading_screen_container}
		DestroyScreenElement \{id = loading_screen_container}
	endif
	destroy_menu_backdrop
endscript

script refresh_screen 
	destroy_loading_screen
	create_loading_screen
endscript
