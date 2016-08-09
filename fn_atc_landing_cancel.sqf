//Get Variables
	_vehicle = objectParent player;
	if (_vehicle == objNull) then {
		_vehicle = player;
	};

//Add Actions
	player removeaction LHD_Action_Landing_Cancel;

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = 60;

	//Radio Completed
		waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.1;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_callsign];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_callsignNo];sleep 1;
		_vehicle vehicleRadio "flyco_msg_landingcancelled";sleep 0.8;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
		LHD_RadioInUse = false;

		LHD_CancelLanding = true;

	//Reset LHD Vehicle Variables
		LHD_PatternWaypointComp = false;
		LHD_Approach = false;
		LHD_RadioInUse = false;
		LHD_CurrentFlyAlt = 0; //This is the current ATC defined flying altitude
		LHD_CurrentPattern = "alpha";
		LHD_OnFinals = false;
		LHD_IsLanding = false; //Set to True when turned on base
		LHD_HasLanded = false; //Set to True when aircraft has landed
		LHD_AtMAP = false;

	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";

	call airboss_fnc_atc_removePilotActions;
	call airboss_fnc_atc_baseActionsFlyco;