//Get Variables
_vehicle = vehicle player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Pilot requesting transfer to WATCHDOG

//Remove Actions
			call fnc_usec_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio format ["watchdog_callsign_%1",ATC_CS];
			_vehicle vehicleRadio format ["watchdog_digit_%1",ATC_CN];sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "watchdog_callsign_watchdog";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "watchdog_word_over";sleep 0.5;
			LHD_RU = false;

			call fnc_usec_atc_baseActionsWatchdog;