load_warning_menu_font = fontgrid_title_gh3

script create_network_prompt_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "순위표에서 다른 플레이어와 비교한 자신의 순위를 확인하려면 온라인 계정이 필요합니다."
			dims = (800.0, 400.0)
			scale = 0.5
		}
		TextElement = {
			text = "온라인에 접속하시겠습니까?"
			pos = (640.0, 465.0)
			scale = 0.6
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (600.0, 80.0)
		options = [
			{
				func = startup_go_online
				text = "YES"
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
			text = "Guitar Hero III를 실행할 때마다 자동으로 로그인이 되도록 하시겠습니까? 차후에 옵션 메뉴에서 설정을 변경할 수도 있습니다."
			dims = (800.0, 400.0)
			scale = 0.5
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (340.0, 80.0)
		options = [
			{
				func = set_autologin_yes_result
				text = "YES"
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
	netsessionfunc \{func = setautologinsetting
		Params = {
			autologinsetting = autologinon
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script set_autologin_no_result 
	netsessionfunc \{func = setautologinsetting
		Params = {
			autologinsetting = autoLoginOff
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script set_autologin_prompt_result 
	netsessionfunc \{func = setautologinsetting
		Params = {
			autologinsetting = autologinprompt
		}}
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script create_signin_warning_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "온라인에 접속하기 전까지는 순위표에서 성적을 확인할 수 없습니다."
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = signin_warning_select_continue
				text = "계속"
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
		Params = {
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
			text = "본 게임은 특정 시점에서 자동으로 데이터를 저장합니다. HDD 액세스 표시등이 깜박일 때 본체의 전원을 끄지 마십시오."
			pos = (640.0, 380.0)
			scale = 0.6
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (384.0, 64.0)
		options = [
			{
				func = signin_complete_menu_select_ok
				text = "확인"
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
	if isxenon
		<text> = "로그인해야 합니다."
	else
		<text> = "PLAYSTATION®Network 기능을 사용하려면 로그인해야 합니다."
	endif
	create_popup_warning_menu {
		textblock = {
			text = <text>
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = {ui_flow_manager_respond_to_action Params = {action = continue}}
				text = "계속"
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
	if isps3
		memcard_sequence_quit
	else
		if ($memcardsavingorloading = saving)
			desc_text = "저장 장치가 선택되지 않았거나 설치되어 있지 않습니다. 사용할 수 있는 저장 장치가 없으면 진행 상황을 저장할 수 없습니다."
			continue_text = "저장하지 않고 계속"
			continue_func = memcard_disable_saves_and_quit
		else
			desc_text = "저장 장치가 선택되지 않았거나 설치되어있지 않습니다."
			continue_text = "계속"
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
					func = {memcard_sequence_retry Params = {StorageSelectorForce = 1}}
					text = "저장 장치 선택"
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
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "확인 중..."
			textblock = {
				text = "HDD를 확인 중입니다. 본체의 전원을 끄지 마십시오."
			}}
		case xenon
		create_popup_warning_menu \{title = "확인 중..."
			textblock = {
				text = "저장 장치 확인 중..."
			}}
	endswitch
endscript

script create_confirm_overwrite_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		text = "저장된 게임에 덮어쓰시겠습니까? 이 저장된 게임에 포함된 모든 진행 상황이 사라지게 됩니다."
		case xenon
		text = "이 콘텐츠를 덮어쓰시겠습니까? 이 저장 콘텐츠에 포함된 모든 진행 상황이 사라지게 됩니다."
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
				func = {memcard_save_file Params = {overwriteconfirmed = 1}}
				text = "덮어쓰기"
			}
			{
				func = {memcard_sequence_quit}
				text = "취소"
			}
		]
	}
endscript

script create_confirm_load_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		text = "이 저장된 게임을 불러오시겠습니까? 저장되지 않은 진행 상황은 모두 사라지게 됩니다."
		case xenon
		text = "이 콘텐츠를 불러오시겠습니까? 저장되지 않은 진행 상황은 모두 사라지게 됩니다."
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
				func = {memcard_load_file Params = {loadconfirmed = 1}}
				text = "불러오기"
			}
			{
				func = {memcard_sequence_quit}
				text = "취소"
			}
		]
	}
endscript

script create_no_save_found_menu 
	memcard_cleanup_messages
	create_popup_warning_menu \{textblock = {
			text = "Guitar Hero III 저장 데이터가 없습니다."
		}
		menu_pos = (640.0, 480.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = memcard_sequence_quit
				text = "계속"
				scale = (1.0, 1.0)
			}
		]}
endscript

script create_corrupted_data_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		text = "저장된 게임이 손상되었거나 사용할 수 없습니다. 이 저장된 게임을 삭제하시겠습니까? 이 저장된 게임에 포함된 모든 진행 상황이 사라집니다."
		case xenon
		text = "게임 콘텐츠가 손상되었거나 사용할 수 없습니다. 이 콘텐츠를 삭제하시겠습니까? 이 저장된 콘텐츠에 포함된 모든 진행 상황이 사라집니다."
	endswitch
	if ($memcardsavingorloading = saving)
		options = [
			{
				func = memcard_delete_file
				text = "삭제"
				scale = 1
			}
			{
				func = memcard_disable_saves_and_quit
				text = "저장하지 않고 계속"
				scale = 1
			}
		]
	else
		options = [
			{
				func = memcard_delete_file
				text = "삭제"
				scale = 1
			}
			{
				func = memcard_sequence_quit
				text = "취소"
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
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "삭제 중..."
			textblock = {
				text = "저장 데이터를 삭제 중입니다. 본체의 전원을 끄지 마십시오."
			}}
		case xenon
		create_popup_warning_menu \{title = "삭제 중..."
			textblock = {
				text = "콘텐츠 삭제 중."
			}}
	endswitch
endscript

script create_delete_success_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "삭제에 성공했습니다."
			}}
		case xenon
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "삭제에 성공했습니다."
			}}
	endswitch
endscript

script create_load_success_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "불러오기에 성공했습니다."
			}}
		case xenon
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "불러오기에 성공했습니다."
			}}
	endswitch
endscript

script create_save_success_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "저장에 성공했습니다."
			}}
		case xenon
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "저장에 성공했습니다."
			}}
	endswitch
endscript

script create_overwrite_success_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "덮어쓰기에 성공했습니다."
			}}
		case xenon
		create_popup_warning_menu \{title = "성공"
			textblock = {
				text = "덮어쓰기에 성공했습니다."
			}}
	endswitch
endscript

script create_delete_failed_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "삭제 실패!"
			textblock = {
				text = "삭제에 실패했습니다! 게임을 종료하고 이 게임 데이터를 삭제하십시오."
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
		case xenon
		create_popup_warning_menu \{title = "삭제 실패!"
			textblock = {
				text = "삭제할 수 없습니다."
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
	endswitch
endscript

script create_load_failed_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "불러오기에 실패했습니다. 저장 데이터가 손상된 것 같습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "불러오기에 실패했습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
	endswitch
endscript

script create_save_failed_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "저장에 실패했습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "저장에 실패했습니다.\\n저장 장치가 선택되지 않았거나 선택한 저장 장치를 사용할 수 없습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
	endswitch
endscript

script create_overwrite_failed_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "덮어쓰기에 실패했습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "덮어쓰기에 실패했습니다.\\n저장 장치가 선택되지 않았거나 선택한 저장 장치를 사용할 수 없습니다."
				pos = (640.0, 380.0)
			}
			menu_pos = (640.0, 465.0)
			dialog_dims = (275.0, 64.0)
			options = [
				{
					func = memcard_sequence_retry
					text = "다시 시도"
				}
				{
					func = memcard_sequence_quit
					text = "계속"
				}
			]}
	endswitch
endscript

script create_out_of_space_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		MC_SpaceForNewFolder \{desc = guitarcontent}
		FormatText textname = message "게임을 저장할 HDD 공간이 부족합니다. Guitar Hero 3는 단일 게임 저장마다 %dKB의 HDD 공간이 필요합니다. 계속 진행하시면 게임의 진행 상황을 저장할 수 없습니다." d = <SpaceRequired>
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
					text = "파일 삭제"
				}
				{
					func = memcard_disable_saves_and_quit
					text = "저장하지 않고 계속"
				}
			]
		}
		case xenon
		if ($memcardsavingorloading = saving)
			create_popup_warning_menu \{textblock = {
					text = [
						"저장할 공간 없음"
						"\\n"
						"기존 데이터를 삭제해주십시오."
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
						text = "저장하지 않고 계속"
					}
				]}
		else
			create_load_failed_menu
		endif
	endswitch
endscript

script create_load_file_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "불러오는 중..."
			textblock = {
				text = "데이터를 불러오고 있습니다. 전원을 끄지 말아주십시오."
			}}
		case xenon
		create_popup_warning_menu \{title = "불러오는 중..."
			textblock = {
				text = "콘텐츠를 불러오는 중."
			}}
	endswitch
endscript

script create_overwrite_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "덮어쓰는 중..."
			textblock = {
				text = "기존의 저장 데이터에 덮어쓰는 중입니다. 본체의 전원을 끄지 마십시오."
			}}
		case xenon
		default
		create_popup_warning_menu \{title = "저장하는 중..."
			textblock = {
				text = "콘텐츠 저장 중."
			}}
	endswitch
endscript

script create_save_menu 
	memcard_cleanup_messages
	getplatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{title = "저장하는 중..."
			textblock = {
				text = "HDD에 저장하는 중입니다. 본체의 전원을 끄지 마십시오."
			}}
		case xenon
		create_popup_warning_menu \{title = "저장하는 중..."
			textblock = {
				text = "콘텐츠 저장 중."
			}}
	endswitch
endscript
