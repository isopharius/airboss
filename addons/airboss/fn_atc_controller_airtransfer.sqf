//Get Variables
_vehicle = vehicle player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player requested transfer to FLYCO
			//Remove Actions
			player removeaction ATC_TransferToFlyco;
			player removeaction ATC_ChangeIntentions;
			call airboss_fnc_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_CS];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_CN];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_over";sleep 0.5;
			LHD_RU = false;

			call airboss_fnc_atc_baseActionsFlyco;