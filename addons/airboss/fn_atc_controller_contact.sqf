//Get Variables
_vehicle = vehicle player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player is making initial contact with controller, assign callsign
			//Variable Reset
			LHD_Intention = 0; //Reset intentions, god knows what happened to the last vehicle player was in
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
			} foreach ATC_Callsigns;

				_callsignArray = ATC_Callsigns select _callsignNo;

				if (_vehicle in (_callsignArray select 2)) then {
					//Vehicle is already assigned a callsign
					ATC_callsign = _callsignArray select 0;
					_callsignPos = (_callsignArray find _vehicle) + 1;
				} else {
					//Assign vehicle a new callsign
					ATC_callsign = _callsignArray select 0;
					_callsignVehicles = _callsignArray select 2;
					_callsignPos = (count _callsignVehicles);
					ATC_callsignNo = _callsignPos + 1;
					_callsignVehicles pushback _vehicle;
					_callsignArrayNew = [(_callsignArray select 0),(_callsignArray select 1),_callsignVehicles];
					ATC_Callsigns set [_callsignNo,_callsignArrayNew];
					publicVariable "ATC_Callsigns";
				};

			LHD_Controlled = true; //Vehicle is now controlled

			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
			_vehicle vehicleRadio "homer_msg_greeting_2";sleep 0.1;
			_vehicle vehicleRadio "homer_msg_callsignassign_1";sleep 0.1;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;

			_isOnDeck = getPosWorld _vehicle in LHD_Deck;

			//if player on deck, transfer to FLYCO
			if (!_isOnDeck) then {
				_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
				_vehicle vehicleRadio "homer_word_over";sleep 0.1;
				LHD_RadioInUse = false;
				_cursor = 0;
				{
					if (_cursor > 0) then {
						call compile format ["ATC_Intention_Orders%1 = player addAction ['HOMER > Intention: %2', airboss_fnc_atc_controller_newintentions, [nil,%1], 20, false, true, '', 'true', -1];",_cursor,(_x select 0)];
					};
					_cursor = _cursor + 1;
				} foreach ATC_Intentions;
			} else {
				_vehicle vehicleRadio "homer_msg_greeting_3";sleep 0.1;
				_vehicle vehicleRadio "homer_callsign_homer";sleep 0.1;
				_vehicle vehicleRadio "homer_word_out";sleep 0.1;
				LHD_RadioInUse = false;

				call airboss_fnc_atc_baseActionsHomer;
			};

			//spawn controller monitor
			call airboss_fnc_system_atccontroller;