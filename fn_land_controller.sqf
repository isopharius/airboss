//Get Variables
_vehicle = vehicle player;


	_initArray = _this select 3;
	_id = _this select 2;
	_type = _initArray select 0; //0 = Inital Contact

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;

		if (_type == 0) exitwith {//Player is making initial contact with controller, assign callsign

				player removeaction Action_ContactControl;
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
						_callsignVehicles pushback [_vehicle];
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
		};
		if (_type == 1) exitwith {//Player has transferred to this controller in an AIRCRAFT
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["watchdog_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["watchdog_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "watchdog_callsign_watchdog";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_removePilotActions;
			call airboss_fnc_atc_baseActionsWatchdog;
		};
		if (_type == 2) exitwith {//Land base player is requesting a fix on their current location

				call airboss_fnc_land_RemoveActionsWatchdog;

				_mapGrid = (position player) call airboss_fnc_PosToGrid;
				_posStr = _mapGrid call airboss_fnc_GridToStr;
				_mapGridX = _mapGrid select 0;
				_mapGridY = _mapGrid select 1;

				_x1 = floor(_mapGridX / 100);
				_x2 = floor((_mapGridX - (_x1 * 100)) / 10);
				_x3 = floor(_mapGridX - (_x2 * 10) - (_x1 * 100));

				_y1 = floor(_mapGridY / 100);
				_y2 = floor((_mapGridY - (_y1 * 100)) / 10);
				_y3 = floor(_mapGridY - (_y2 * 10) - (_y1 * 100));

				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: This is WATCHDOG, I have your current position as grid figures %1. Over",_posStr];
				playsound "watchdog_word_thisis";sleep 0.4;
				playsound "watchdog_callsign_watchdog";sleep 0.8;
				playsound "watchdog_msg_currentposition_1";sleep 1.6;
				playsound "watchdog_word_gridfigures";sleep 0.6;
				playsound format ["watchdog_digit_%1",_x1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x3];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y3];sleep 0.5;
				playsound"watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				call airboss_fnc_land_baseActionsWatchdog;
		};