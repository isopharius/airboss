//Get Variables
_vehicle = vehicle player;

//Add Actions
	player removeaction LHD_Action_Takeoff_Cancel;

	//Radio Completed
		waitUntil{!LHD_RU};LHD_RU = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.1;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 1;
		_vehicle vehicleRadio "flyco_msg_cancelled";sleep 0.8;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
		LHD_RU = false;

	//Reset LHD Vehicle Variables
	LHD_TR =  false;
	LHD_TS = false;
	LHD_TO = false;

	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";

	call airboss_fnc_atc_removePilotActions;
	call airboss_fnc_atc_baseActionsFlyco;