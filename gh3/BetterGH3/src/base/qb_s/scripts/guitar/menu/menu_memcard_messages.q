load_warning_menu_font = fontgrid_title_gh3

script create_network_prompt_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "Para registrar tus progresos contra otros jugadores en la tabla de récords, necesitas una cuenta online."
			dims = (800.0, 400.0)
			scale = 0.5
		}
		TextElement = {
			text = "¿Quieres entrar online ahora?"
			pos = (640.0, 465.0)
			scale = 0.6
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (600.0, 80.0)
		options = [
			{
				func = startup_go_online
				text = "SÍ"
			}
			{
				func = startup_stay_offline
				text = "NO"
			}
		]}
endscript

script destroy_network_prompt_menu 
	destroy_popup_warning_menu
endscript

script startup_go_online 
	ui_flow_manager_respond_to_action \{action = select_startup_go_online}
endscript

script startup_stay_offline 
	ui_flow_manager_respond_to_action \{action = select_startup_stay_offline}
endscript

script create_autologin_prompt_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "¿Quieres acceder automáticamente cada vez que inicies Guitar Hero III? Podrás cambiar esta opción en el menú Opciones."
			dims = (800.0, 400.0)
			scale = 0.5
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (340.0, 80.0)
		options = [
			{
				func = set_autologin_yes_result
				text = "SÍ"
			}
			{
				func = set_autologin_no_result
				text = "NO"
			}
		]}
endscript

script destroy_autologin_prompt_menu 
	destroy_popup_warning_menu
endscript

script set_autologin_yes_result 
	NetSessionFunc \{func = SetAutoLoginSetting
		params = {
			autoLoginSetting = autoLoginOn
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script set_autologin_no_result 
	NetSessionFunc \{func = SetAutoLoginSetting
		params = {
			autoLoginSetting = autoLoginOff
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script set_autologin_prompt_result 
	NetSessionFunc \{func = SetAutoLoginSetting
		params = {
			autoLoginSetting = autoLoginPrompt
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script create_signin_warning_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "Hasta que no juegues online, no se registrarán tus progresos en la tabla de récords."
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = signin_warning_select_continue
				text = "CONTINÚA"
				scale = (1.0, 1.0)
			}
		]}
endscript

script destroy_signin_warning_menu 
	destroy_popup_warning_menu
endscript

script signin_warning_select_signin 
	ui_flow_manager_respond_to_action \{action = select_choose_storage_device}
endscript

script signin_warning_select_cws 
	start_checking_for_signin_change
	change \{enable_saving = 0}
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
	ui_flow_manager_respond_to_action \{action = select_continue_without_saving}
endscript

script signin_warning_select_continue 
	ui_flow_manager_respond_to_action \{action = select_continue_without_signing_in}
endscript

script create_signin_complete_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "El juego guarda los datos automáticamente en algunos puntos. No apagues el equipo mientras el indicador de acceso del disco duro parpadee."
			pos = (640.0, 380.0)
			scale = 0.6
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (384.0, 64.0)
		options = [
			{
				func = signin_complete_menu_select_ok
				text = "OK"
				scale = (1.0, 1.0)
			}
		]}
	change \{signin_complete_menu_select_ok_called = 0}
endscript
signin_complete_menu_select_ok_called = 0

script signin_complete_menu_select_ok 
	if ($signin_complete_menu_select_ok_called = 0)
		change \{signin_complete_menu_select_ok_called = 1}
		destroy_popup_warning_menu
		ui_flow_manager_respond_to_action \{action = continue}
	endif
endscript

script destroy_signin_complete_menu 
	destroy_popup_warning_menu
endscript

script create_online_signin_warning_menu 
	memcard_cleanup_messages
	if isXenon
		<text> = "Tienes que estar registrado."
	else
		<text> = "You must be signed in to access PLAYSTATION®Network features."
	endif
	create_popup_warning_menu {
		textblock = {
			text = <text>
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = {ui_flow_manager_respond_to_action params = {action = continue}}
				text = "CONTINÚA"
				scale = (1.0, 1.0)
			}
		]
	}
endscript

script destroy_online_signin_warning_menu 
	destroy_popup_warning_menu
endscript

script create_storagedevice_warning_menu 
	memcard_cleanup_messages
	if IsPs3
		memcard_sequence_quit
	else
		if ($MemcardSavingOrLoading = Saving)
			desc_text = "No se encontró ni se seleccionó ningún dispositivo de almacenamiento. Si no existe un dispositivo de almacenamiento, no se guardará el progreso."
			continue_text = "CONTINÚA SIN GUARDAR"
			continue_func = memcard_disable_saves_and_quit
		else
			desc_text = "No se ha seleccionado o encontrado ningún dispositivo de almacenamiento."
			continue_text = "CONTINÚA"
			continue_func = memcard_sequence_quit
		endif
		create_popup_warning_menu {
			textblock = {
				text = <desc_text>
				pos = (640.0, 380.0)
				dims = (700.0, 400.0)
				scale = 0.6
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (600.0, 80.0)
			dialog_pos = (640.0, 455.0)
			dialgo
			options = [
				{
					func = {memcard_sequence_retry params = {StorageSelectorForce = 1}}
					text = "DISPOSITIVO DE ALMACENAMIENTO"
				}
				{
					func = <continue_func>
					text = <continue_text>
				}
			]
		}
	endif
endscript

script create_checking_memory_card_screen 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "COMPROBANDO"
			textblock = {
				text = "Comprobando disco duro. No apagues el sistema."
			}}
		case xenon
		create_popup_warning_menu \{title = "COMPROBANDO"
			textblock = {
				text = "Comprobando dispositivo de almacenamiento..."
			}}
	endswitch
endscript

script create_confirm_overwrite_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		text = "¿Seguro que quieres sobrescribir estos datos? Todo el progreso de estos datos se perderá."
		case xenon
		text = "¿Estás seguro de que quieres sobrescribir este contenido? Todos los objetivos logrados en este contenido guardado se perderán."
	endswitch
	create_popup_warning_menu {
		textblock = {
			text = <text>
			pos = (640.0, 370.0)
		}
		menu_pos = (640.0, 465.0)
		dialog_dims = (350.0, 64.0)
		options = [
			{
				func = {memcard_save_file params = {OverwriteConfirmed = 1}}
				text = "SOBREESCRIBIR"
			}
			{
				func = {memcard_sequence_quit}
				text = "CANCELAR"
			}
		]
	}
endscript

script create_confirm_load_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		text = "¿Seguro que quieres cargar estos datos? Se perderá todo el progreso desde la última vez que guardaste."
		case xenon
		text = "¿Estás seguro que quieres cargar este contenido? Se perderá toda la progresión desde la última vez que guardaste la partida."
	endswitch
	create_popup_warning_menu {
		textblock = {
			text = <text>
			pos = (640.0, 370.0)
		}
		menu_pos = (640.0, 465.0)
		dialog_dims = (256.0, 64.0)
		options = [
			{
				func = {memcard_load_file params = {LoadConfirmed = 1}}
				text = "CARGAR"
			}
			{
				func = {memcard_sequence_quit}
				text = "CANCELAR"
			}
		]
	}
endscript

script create_no_save_found_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "No se han encontrado datos guardados de GUITAR HERO III."
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = memcard_sequence_quit
				text = "CONTINÚA"
				scale = (1.0, 1.0)
			}
		]}
endscript

script create_corrupted_data_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		text = "Los datos guardados están dañados y no pueden utilizarse. ¿Quieres borrar estos datos guardados? Todo el progreso de estos datos se perderá."
		case xenon
		text = "El contenido del juego está dañado y no puede utilizarse. ¿Quieres borrar este contenido? Todos los objetivos logrados en este contenido guardado se perderán."
	endswitch
	if ($MemcardSavingOrLoading = Saving)
		options = [
			{
				func = memcard_delete_file
				text = "BORRAR"
				scale = 1
			}
			{
				func = memcard_disable_saves_and_quit
				text = "CONTINÚA SIN GUARDAR"
				scale = 1
			}
		]
	else
		options = [
			{
				func = memcard_delete_file
				text = "BORRAR"
				scale = 1
			}
			{
				func = memcard_sequence_quit
				text = "CANCELAR"
				scale = 1
			}
		]
	endif
	create_popup_warning_menu {
		textblock = {
			text = <text>
			dims = (800.0, 500.0)
			pos = (640.0, 375.0)
			scale = 0.5
		}
		menu_pos = (640.0, 465.0)
		dialog_dims = (256.0, 64.0)
		options = <options>
	}
endscript

script create_delete_file_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "BORRANDO..."
			textblock = {
				text = "Eliminando los datos guardados. No apagues la consola."
			}}
		case xenon
		create_popup_warning_menu \{title = "BORRANDO..."
			textblock = {
				text = "Eliminando contenido."
			}}
	endswitch
endscript

script create_delete_success_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Se ha borrado correctamente."
			}}
		case xenon
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Se ha borrado correctamente."
			}}
	endswitch
endscript

script create_load_success_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Se ha cargado correctamente."
			}}
		case xenon
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Se ha cargado correctamente."
			}}
	endswitch
endscript

script create_save_success_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Éxito al guardar."
			}}
		case xenon
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Éxito al guardar."
			}}
	endswitch
endscript

script create_overwrite_success_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Éxito al actualizar."
			}}
		case xenon
		create_popup_warning_menu \{title = "CORRECTO"
			textblock = {
				text = "Éxito al actualizar."
			}}
	endswitch
endscript

script create_delete_failed_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "NO SE HA PODIDO BORRAR."
			textblock = {
				text = "No se ha podido borrar. Sal del juego y borra los datos de este juego."
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
		case xenon
		create_popup_warning_menu \{title = "NO SE HA PODIDO BORRAR."
			textblock = {
				text = "No se puede borrar."
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
	endswitch
endscript

script create_load_failed_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "Error al cargar. Los datos están dañados."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "No se ha podido cargar."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
	endswitch
endscript

script create_save_failed_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "No se ha podido guardar."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "Error al guardar.\\nNo se seleccionó ningún dispositivo de almacenamiento y el dispositivo de almacenamiento actualmente en uso no está disponible."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
	endswitch
endscript

script create_overwrite_failed_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "Intento fallido al sobrescribir."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "Error al sobrescribir.\\nNo se seleccionó ningún dispositivo de almacenamiento y el dispositivo de almacenamiento actualmente en uso no está disponible."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "REINTENT."
				}
				{
					func = memcard_sequence_quit
					text = "CONTINÚA"
				}
			]}
	endswitch
endscript

script create_out_of_space_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		MC_SpaceForNewFolder \{desc = GuitarContent}
		FormatText TextName = message "Insuficiente espacio en el disco duro para guardar partidas. Guitar Hero 3 necesita %d KB en el disco duro para guardar una partida. Si decides continuar no podrás guardar ningún progreso de tu partida." d = <SpaceRequired>
		create_popup_warning_menu {
			textblock = {
				text = <message>
				pos = (640.0, 390.0)
				dims = (900.0, 490.0)
				scale = 0.5
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (600.0, 80.0)
			options = [
				{
					func = memcard_delete_file
					text = "BORRAR ARCHIVOS"
				}
				{
					func = memcard_disable_saves_and_quit
					text = "CONTINÚA SIN GUARDAR"
				}
			]
		}
		case xenon
		if ($MemcardSavingOrLoading = Saving)
			create_popup_warning_menu \{textblock = {
					text = [
						"No se puede guard."
						"\\n"
						"Borra algunos datos."
					]
					pos = (640.0, 390.0)
					dims = (900.0, 490.0)
					scale = 0.5
				}
				menu_pos = (640.0, 465.0)
				dialog_dims = (600.0, 80.0)
				options = [
					{
						func = memcard_disable_saves_and_quit
						text = "CONTINÚA SIN GUARDAR"
					}
				]}
		else
			create_load_failed_menu
		endif
	endswitch
endscript

script create_load_file_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "CARGANDO..."
			textblock = {
				text = "Cargando datos. No reinicies ni apagues el sistema."
			}}
		case xenon
		create_popup_warning_menu \{title = "CARGANDO..."
			textblock = {
				text = "Cargando contenido."
			}}
	endswitch
endscript

script create_overwrite_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "GUARDANDO..."
			textblock = {
				text = "Se están sobrescribiendo los datos guardados. No apagues el sistema."
			}}
		case xenon
		default
		create_popup_warning_menu \{title = "GUARDANDO..."
			textblock = {
				text = "Guardando contenido."
			}}
	endswitch
endscript

script create_save_menu 
	memcard_cleanup_messages
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "GUARDANDO..."
			textblock = {
				text = "Guardando en el disco duro. No reinicies ni apagues el sistema."
			}}
		case xenon
		create_popup_warning_menu \{title = "GUARDANDO..."
			textblock = {
				text = "Guardando contenido."
			}}
	endswitch
endscript
