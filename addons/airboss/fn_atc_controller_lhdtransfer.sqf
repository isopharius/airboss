//Get Variables
_vehicle = objectParent player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//transfer to HOMER
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_CS];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_CN];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "homer_word_over";sleep 0.5;
			LHD_RU = false;

			call airboss_fnc_atc_baseActionsHomer;
