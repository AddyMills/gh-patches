loading_screen_tips = [
	"Des difficultés ? Va voir les didacticiels dans le menu Entraînement."
	"Des difficultés ? Va voir les didacticiels dans le menu Entraînement."
	"Va voir dans le Magasin les nouvelles chansons et tenues et styles vraiment cool."
	"Va voir dans le Magasin les nouvelles chansons et tenues et styles vraiment cool."
	"Tu veux faire la star avec un ami ?  Forme ton groupe en mode Coop."
	"Tu veux faire la star avec un ami ?  Forme ton groupe en mode Coop."
	"Un peu d'entraînement devrait t'aider à maîtriser ces solos pas faciles."
	"Un peu d'entraînement devrait t'aider à maîtriser ces solos pas faciles."
	"Si tu n'as jamais enregistré sur un 4 pistes, ton groupe est bidon."
	"Assure-toi que le public va te rattraper avant de sauter dans la fosse."
	"Les feux d'artifice faits maison sont INTERDITS."
	"Arriver en retard aux répètes, c'est une tradition."
	"On peut avoir un meilleur retour son ?"
	"Plein d'autres groupes s'habillaient déjà tout en noir avant ta naissance."
	"Oui, oui, les enceintes sur scène servent en fait de plongeoirs."
	"Ne jamais, JAMAIS, laisser le chanteur s'occuper du mixage."
	"Tu peux toujours jouer plus fort."
	"Ce n'est pas parce qu'on est agressifs qu'on n'aime pas la paix."
	"20 minutes d'impro de free jazz, très peu pour moi."
	"Personne n'a envie de payer pour t'entendre jouer."
	"Faut pas croire, un look négligé, ça se travaille."
	"Un groupe sans un bon mécano, c'est la cata assurée."
	"Augmente le volume de l'ampli. C'est à peine si mes oreilles entendent quelque chose."
	"Avant, je m'affolais quand mon ampli prenait feu. Maintenant ça ne me fait plus rien."
	"Il semblerait que les guitares fracassées aient une meilleure acoustique que leurs consoeurs intactes."
	"Tu es aussi bon que ton dernier concert... qui craignait un max."
	"Tu as super bien joué. Je suis sûr que les sifflets, c'était juste pour tes fringues."
	"Une boîte à rythmes se pointerait peut-être à l'heure aux répètes."
	"On dirait que t'as un problème avec l'ampli de ta basse. Je l'entends !"
	"Va jouer sur scène et vends quelques t-shirts pour qu'on puisse manger ce soir."
	"Allez, on commence avec le dernier single.  Comme ça on en aura fini avec cette *&?#@ !"
	"Je ne suis que le batteur. On ne me paie pas pour connaître ces trucs !"
	"Je le jure, m'sieur l'agent, la télé de la loge s'est débranchée toute seule et elle s'est jetée par la fenêtre !"
	"Marre de jouer en solo ? Connecte-toi et affronte la compétition en live !"
	"Besoin de nouvelles\\nchansons ? Jette un oeil sur le menu en ligne pour voir si du nouveau contenu est disponible !"
	"Tu veux jouer en mode Coop mais tu n'as pas d'amis ? Va en ligne te trouver un partenaire de rock !"
	"Qui sont les dieux de la guitare ? Consulte le classement dans le menu en ligne."
	"Pas moyen d'appuyer sur les notes ? Essaye l'outil Calibrer le décalage dans le menu des options."
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
		KillSpawnedScript \{name = jiggle_text_array_elements}
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
		split_text_into_array_elements \{text = "CHARGEMENT"
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
			params = {
				id = $g_loading_screen_split_container_id
				time = 1.0
				wait_time = 3000
				explode = 0
			}}
	else
		KillSpawnedScript \{name = destroy_loading_screen_spawned}
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
	KillSpawnedScript \{name = jiggle_text_array_elements}
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
	if IsWinPort
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
