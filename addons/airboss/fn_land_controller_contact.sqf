//Get Variables
_vehicle = vehicle player;

//Player is making initial contact with controller, assign callsign

				if (!acemod) then {
					player removeaction Action_ContactControl;
				} else {
					ACEActionAdded = false;
				};

				_cursor = 0;
				_typeOf = TypeOf _vehicle;
				_callsignNo = 0;

				{
					_arrayCallsign = _x select 0;
					_arrayKindOf = _x select 1;
					if (_vehicle isKindOf _arrayKindOf) then {
						//Vehicle qualifies for Callsign
						_callsignNo = _cursor;
					};
					_cursor =  _cursor + 1;
				} foreach Callsigns;

					_callsignArray = Callsigns select _callsignNo;

					if (_vehicle in (_callsignArray select 2)) then {
						//Vehicle is already assigned a callsign
						callsign = _callsignArray select 0;
						_callsignPos = (_callsignArray find _vehicle) + 1;
					} else {
						//Assign vehicle a new callsign
						callsign = _callsignArray select 0;
						_callsignVehicles = _callsignArray select 2;
						_callsignPos = (count _callsignVehicles);
						callsignNo = _callsignPos + 1;
						_callsignVehicles pushback _vehicle;
						_callsignArrayNew = [(_callsignArray select 0),(_callsignArray select 1),_callsignVehicles];
						Callsigns set [_callsignNo,_callsignArrayNew];
						publicVariable "Callsigns";
					};

				Controlled = true; //Vehicle is now controlled

				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: This is WATCHDOG, you have been assigned callsign %1 %2. Standing By. Over",toUpper(callsign),callsignNo];
				playsound "watchdog_word_thisis";sleep 0.4;
				playsound "watchdog_callsign_watchdog";sleep 0.8;
				playsound "watchdog_msg_callsignassign_1";sleep 1.75;
				playsound format ["watchdog_callsign_%1",callsign];sleep 0.7;
				playsound format ["watchdog_digit_%1",callsignNo];sleep 0.5;
				playsound "watchdog_word_standingby";sleep 0.95;
				playsound "watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				call airboss_fnc_land_baseActionsWatchdog;