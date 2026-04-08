loading_screen_tips = [
	"¿Algún problema? Consulta los tutoriales del menú de ensayo."
	"¿Algún problema? Consulta los tutoriales del menú de ensayo."
	"Echa un vistazo a las canciones nuevas y a los vestuarios y estilos que más molan."
	"Echa un vistazo a las canciones nuevas y a los vestuarios y estilos que más molan."
	"¿Quieres dar caña con un amigo?  Inicia un grupo nuevo en Carrera cooperativa."
	"¿Quieres dar caña con un amigo?  Inicia un grupo nuevo en Carrera cooperativa."
	"Practicar te puede ayudar a clavar esos solos difíciles."
	"Practicar te puede ayudar a clavar esos solos difíciles."
	"Si no habéis grabado en un 4 pistas, no sois un grupo de verdad."
	"Asegúrate de que la peña quiere cogerte antes de tirarte desde el escenario."
	"NO utilices pirotecnia casera."
	"Llegar media hora tarde al ensayo forma parte de la tradición."
	"¿Puedo sacar algo más de partido de los monitores?"
	"¿Acaso os pensábais que erais el primer grupo que subía al escenario vestido completamente de negro?"
	"Sí, los monitores de escenario en realidad son trampolines."
	"Nunca más dejes al cantante encargado de la mezcla."
	"Nunca suena demasiado potente."
	"Somos un grupo muy duro, pero eso no significa que no creamos en la paz."
	"Los conciertos de jazz improvisados que duran 20 minutos no molan."
	"La gente pasa tres kilos de pagar dinero por escucharte improvisar."
	"¡Cuántas molestias para tener la misma pinta que todos traemos al despertarnos!"
	"Procura que alguien del grupo sepa cómo cambiar una rueda pinchada."
	"Sube el volumen de ese ampli, que aún no me he quedado sordo."
	"Siempre me ponía a temblar cuando mi ampli se quemaba.  Ahora ya me da igual."
	"Parece que las guitarras espachurradas suenan mejor que sus hermanas no espachurradas."
	"Eres exactamente como tu último concierto... Un fracaso."
	"Lo hiciste muy bien.  Seguro que están abucheándote por tu vestuario."
	"A lo mejor un batería llega a tiempo al ensayo."
	"Parece que tienes problemas con el ampli de tu bajo. ¡Puedo oírlo!"
	"Sal ahí fuera, mete caña y vende muchas camisetas. Así tendremos algo que comer."
	"Empecemos con nuestro último single.  ¡Así podemos sacarnos a ese *&?#@! del medio enseguida!"
	"Yo soy el batería,  ¡a mí no me pagan para entender nada de esto!"
	"¡Se lo juro, agente, el televisor del camerino se ha descolgado solo y se ha tirado por la ventana!"
	" ¿El solo se está convirtiendo en algo del pasado? ¡Entra online y compite en directo!"
	"¿Te hacen falta canciones nuevas? ¡Consulta el menú en línea para ver si hay canciones nuevas disponibles!"
	"¿Quieres jugar en modo Cooperativo pero no tienes ningún amigo a mano? ¡Juega en línea e improvisa!"
	" ¿Quién es un dios de la guitarra? Mira los récords en el menú online."
	"¿Tienes problemas para acertar con las notas?  Prueba con la opción Calibrar retardo en el menú Opciones."
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
		split_text_into_array_elements \{text = "CARGANDO"
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
