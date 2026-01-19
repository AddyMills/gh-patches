loading_screen_tips = [
	"In caso di difficoltà, accedi alle lezioni contenute nel menu Esercizi."
	"In caso di difficoltà, accedi alle lezioni contenute nel menu Esercizi."
	"Vai all'emporio per comprare nuove canzoni, vestiti eccezionali e stili straordinari."
	"Vai all'emporio per comprare nuove canzoni, vestiti eccezionali e stili straordinari."
	"Vuoi rockeggiare con un amico?  Crea un nuovo gruppo nella carriera cooperativa."
	"Vuoi rockeggiare con un amico?  Crea un nuovo gruppo nella carriera cooperativa."
	"Se ti eserciti un po' potrai dominare quegli assolo così complicati."
	"Se ti eserciti un po' potrai dominare quegli assolo così complicati."
	"Se non hai mai registrato un demo, non fai parte di un vero gruppo."
	"Assicurati che il pubblico sia pronto ad afferrarti prima di lanciarti dal palco!"
	"MAI utilizzare fuochi d'artificio fatti in casa."
	"Per tradizione, si arriva sempre in ritardo di 30 minuti alle prove."
	"Possiamo diminuire il riverbero delle casse spia?"
	"Non pensare che la tua band sia la prima a salire sul palco con tutti i componenti vestiti di nero."
	"Sì, le casse spia sul palco sono in effetti dei trampolini."
	"Non lasciare mai al cantante la responsabilità del mix."
	"Può essere sempre più forte."
	"Siamo un gruppo di gente arrabbiata, ma ciò non significa che non crediamo nella pace."
	"20 minuti di odissea nel free jazz non vanno bene."
	"La gente non è disposta a sborsare quattrini per sentirti improvvisare."
	"Ci vuole molto tempo prima di potersi minimamente paragonare a te."
	"Accertati che qualcuno nel gruppo sappia come sostituire una gomma bucata."
	"Alza quel volume! Le mie orecchie non stanno neanche sanguinando!"
	"Impazzivo di rabbia quando il mio amplificatore prendeva fuoco. Adesso invece devo dire che mi piace parecchio!"
	"Le chitarre distrutte sembrano suonare meglio delle loro sorelle intatte!"
	"Hai suonato esattamente come la volta scorsa... ossia una vera schifezza!"
	"Sei un fenomeno. Sono sicuro che i fischi erano solo per il tuo vestito!"
	"Al momento giusto forse comparirà una drum machine che ti consentirà di esercitarti un po'."
	"Secondo me, hai dei problemi con l'amplificazione del basso. Lo sento da qui!"
	"Vai là fuori, scatenati come sai e vendi un po' di magliette, così almeno possiamo mangiare."
	"Iniziamo con il nostro ultimo single.  Così ce lo leviamo subito dalle *&?#@!"
	"Sono il batterista.  Non vengo pagato per capire questa roba!"
	"Glielo giuro, agente, la TV del camerino si è svitata da sola dal muro ed è volata dalla finestra!"
	"Giocare da solo è noioso? Vai online e affronta avversari reali!"
	"Hai bisogno di nuove canzoni? Accedi al menu online per scoprire se sono disponibili dei nuovi brani!"
	"Ti serve un amico per suonare in modalità cooperativa? Vai online! Ci sono molte persone con cui fare amicizia e suonare assieme!"
	"Vuoi sapere chi sono i chitarristi al top? Consulta le classifiche nel menu online."
	"Difficoltà nel centrare le note? Prova a usare lo strumento Calibra latenza nel menu delle opzioni."
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
		split_text_into_array_elements \{text = "CARICAMENTO"
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
