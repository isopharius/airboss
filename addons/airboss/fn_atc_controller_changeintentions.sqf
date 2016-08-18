//Get Variables
_vehicle = objectParent player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player is changing their intentions
			LHD_Controlled = true; //Vehicle is now controlled (just in case!)
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
			_vehicle vehicleRadio "homer_word_over";sleep 0.1;
			LHD_RadioInUse = false;

			_cursor = 0;
			{
				if (_cursor > 0) then {
					call compile format ["ATC_Intention_Orders%1 = player addAction ['HOMER > Intention: %2', airboss_fnc_atc_controller_newintentions, [1, %1], 7, false, true, '', 'true', -1];",_cursor,(_x select 0)];
				};
				_cursor = _cursor + 1;
			} foreach ATC_Intentions;
