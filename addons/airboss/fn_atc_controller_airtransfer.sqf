//Get Variables
_vehicle = vehicle player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player requested transfer to FLYCO
			//Remove Actions
			player removeaction ATC_TransferToFlyco;
			player removeaction ATC_ChangeIntentions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_removePilotActions;
			call airboss_fnc_atc_baseActionsFlyco;