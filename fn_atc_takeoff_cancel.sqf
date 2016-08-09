//Get Variables
	_vehicle = objectParent player;
	if (_vehicle == objNull) then {
		_vehicle = player;
	};

//Add Actions
	player removeaction LHD_Action_Takeoff_Cancel;

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = 60;

	//Radio Completed
		waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.1;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_callsign];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_callsignNo];sleep 1;
		_vehicle vehicleRadio "flyco_msg_cancelled";sleep 0.8;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
		LHD_RadioInUse = false;

	//Reset LHD Vehicle Variables
	LHD_TakeoffRequest =  false;
	LHD_TakeoffStandby = false;
	LHD_Takeoff = false;

	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";

	call airboss_fnc_atc_removePilotActions;
	call airboss_fnc_atc_baseActionsFlyco;