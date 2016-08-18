//Get Variables
_vehicle = objectParent player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//transfer to HOMER
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "homer_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_baseActionsHomer;
