loading_screen_tips = [
	"Gibt es Probleme? ... Wirf einen Blick auf die Tutorials im Trainings-Menü."
	"Gibt es Probleme? ... Wirf einen Blick auf die Tutorials im Trainings-Menü."
	"Durchstöbere den Laden nach neuen Songs, coolen Outfits und Styles."
	"Durchstöbere den Laden nach neuen Songs, coolen Outfits und Styles."
	"Willst du mit einem Freund abrocken? Gründet eine neue Band in der Koop-Karriere."
	"Willst du mit einem Freund abrocken? Gründet eine neue Band in der Koop-Karriere."
	"Der Übungsmodus kann dir beim Bewältigen dieser schwierigen Solos helfen."
	"Der Übungsmodus kann dir beim Bewältigen dieser schwierigen Solos helfen."
	"Wenn ihr noch nie auf einem Vierspurrekorder aufgenommen habt, seid ihr keine richtige Band."
	"Überzeuge dich vor dem Stagediven davon, dass die Zuschauer auch bereit sind, dich aufzufangen."
	"Der Gebrauch von selbstgemachten Feuerwerkskörpern ist UNTERSAGT."
	"30 Minuten zu spät zur Probe zu kommen gehört dazu."
	"Ist es vielleicht möglich, dass die Monitore etwas weniger abkacken?"
	"Glaubt ja nicht, dass ihr die erste Band seid, die auf der Bühne nur schwarz trägt."
	"Ja, die Bühnenmonitore sind wirklich zum Crowdsurfen da."
	"Lass den Sänger niemals ans Mischpult."
	"Es geht immer noch lauter."
	"Wir sind zwar eine echt wütende Band, aber das heißt nicht, dass wir nicht an Frieden glauben."
	"20-minütige, ausschweifende Jazz-Improvisationen sind nicht OK."
	"Niemand will Geld dafür bezahlen, dich improvisieren zu hören."
	"Auszusehen, als sei man gerade erst aufgewacht, ist viel Arbeit."
	"Achte darauf, dass irgendwer in der Band weiß, wie man Reifen wechselt."
	"Dreh den Verstärker auf. Meine Ohren bluten ja kaum."
	"Früher bin ich immer ausgeflippt, wenn mein Verstärker Feuer fing, aber heute mag ich den Klang irgendwie."
	"Gitarren klingen zerschlagen einfach besser als intakt."
	"Du bist nur so gut wie dein letzter Auftritt ... und der war grottig."
	"Du hast großartig gespielt. Ich bin mir sicher, sie haben euch nur wegen euren Outfits ausgepfiffen."
	"Vielleicht taucht ja rechtzeitig zur Probe noch ein Drumcomputer auf."
	"Du scheinst ein Problem mit deinem Bass-Verstärker zu haben. Ich kann es hören!"
	"Geh da raus, rock ordentlich ab und verkaufe einen Haufen T-Shirts, damit wir was zu essen haben."
	"Beginnen wir doch mit unserer letzten Single.  Auf diese Weise räumen wir dieses Stück *&?#@! zeitig aus dem Weg!"
	"Ich bin der Schlagzeuger.  Ich werde nicht bezahlt, um etwas davon zu verstehen!"
	"Ich schwöre es, Wachtmeister, der Fernseher in der Umkleidekabine hat sich selbst von der Wand gelöst und aus dem Fenster gestürzt!"
	"Wird dir das alleine Spielen langsam langweilig? Dann geh online und miss dich an LIVE-Gegnern!"
	"Brauchst du neue Songs? Schau im Online-Menü nach, ob neue Inhalte zur Verfügung stehen!"
	"Du willst im Koop-Modus spielen, hast aber keinen Freund? Spiel online, um Leute kennenzulernen und abzujammen!"
	"Wer ist ein Gitarrengott? Sieh in den Bestenlisten im Online-Menߠnach."
	"Probleme, die richtigen Noten zu treffen? Versuche es mit dem Tool Sound-Latenz kalibrieren im Optionsmenü."
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
		split_text_into_array_elements \{text = "LÄDT"
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
