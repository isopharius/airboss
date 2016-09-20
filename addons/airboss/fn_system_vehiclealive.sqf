					if ((alive _vehicle) && {(objectParent player isEqualTo _vehicle)}) then {
						// Player is in a vehicle, check if the vehicle is in a restricted area and not controlled
						_isOnDeck = getPosWorld _vehicle in LHD_Deck;
						_isInRestricted = getPosWorld _vehicle in LHD_RestrictedArea;

						if ((_isInRestricted) && (!LHD_C) && (!_isOnDeck)) then {
							if (LHD_CW < LHD_MW) then {
								//Vehicle has entered the LHD restricted area, and is not currently controlled
								waitUntil{!LHD_RU};
								LHD_RU = true;
								_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
								_vehicle vehicleRadio "homer_msg_restrictedarea_1";sleep 0.1;
								_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
								_vehicle vehicleRadio "homer_word_over";sleep 0.1;
								LHD_RU = false;
								LHD_CW = LHD_CW + 1;
								sleep 20;
							} else {
								waitUntil{!LHD_RU};
								LHD_RU = true;
								_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
								_vehicle vehicleRadio "homer_msg_restrictedarea_2";sleep 0.3;
								_vehicle vehicleRadio "homer_word_over";sleep 0.1;
								LHD_RU = false;
								LHD_CW = LHD_CW + 1;
								sleep 30;
							};
						};

						if ((!LHD_C) && (!ATC_AA)) then {
							//Add option to contact controller
							ATC_AA = true;
							if (!am) then {
								LHD_Action_ContactControl = player addAction ["Contact Controller", airboss_fnc_atc_controller_contact, [0], 7, false, true, "", "true", -1];
							};
						};

						sleep 1;
						call airboss_fnc_system_vehiclealive;
					};
