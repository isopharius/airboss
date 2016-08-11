					if ((alive _vehicle) and (vehicle player isEqualTo _vehicle)) then {
						// Player is in a vehicle, check if the vehicle is in a restricted area and not controlled
						_isOnDeck = getPosWorld _vehicle in LHD_Deck;
						_isInRestricted = getPosWorld _vehicle in LHD_RestrictedArea;

						if ((_isInRestricted) and (!LHD_Controlled) and (!_isOnDeck) and (LHD_radio)) then {
							if (LHD_ControlWarning < LHD_MaxWarnings) then {
								//Vehicle has entered the LHD restricted area, and is not currently controlled
								waitUntil{!LHD_RadioInUse};
								LHD_RadioInUse = true;
								_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
								_vehicle vehicleRadio "homer_msg_restrictedarea_1";sleep 0.1;
								_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
								_vehicle vehicleRadio "homer_word_over";sleep 0.1;
								LHD_RadioInUse = false;
								LHD_ControlWarning = LHD_ControlWarning + 1;
								sleep 20;
							} else {
								waitUntil{!LHD_RadioInUse};
								LHD_RadioInUse = true;
								_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
								_vehicle vehicleRadio "homer_msg_restrictedarea_2";sleep 0.3;
								_vehicle vehicleRadio "homer_word_over";sleep 0.1;
								LHD_RadioInUse = false;
								LHD_ControlWarning = LHD_ControlWarning + 1;
								sleep 30;
							};
						};

						if ((!LHD_Controlled) and (!ATC_ControllerActionAdded)) then {
							ATC_ControllerActionAdded = true;
							if (!acemod) then {
								//Add option to contact controller
								LHD_Action_ContactControl = player addAction ["Contact Controller", airboss_fnc_atc_controller, [0], 7, false, true, "", "(LHD_radio)", -1];
							};
						};

						sleep 1;
						call airboss_fnc_system_vehiclealive;
					};