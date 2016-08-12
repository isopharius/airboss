//Get Variables
_vehicle = vehicle player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Pilot requesting transfer to WATCHDOG

//Remove Actions
			call fnc_usec_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["watchdog_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["watchdog_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "watchdog_callsign_watchdog";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call fnc_usec_atc_baseActionsWatchdog;