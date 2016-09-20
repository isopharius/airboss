//Get Variables
_vehicle = vehicle player;

//Remove Actions
	player removeaction LHD_Action_Landing_Cancel;
	call airboss_fnc_atc_removePilotActions;

	//Radio Completed
		waitUntil{!LHD_RU};LHD_RU = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.1;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 1;
		_vehicle vehicleRadio "flyco_msg_landingcancelled";sleep 0.8;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
		LHD_RU = false;

		LHD_CL = true;

	//Reset LHD Vehicle Variables
		LHD_PW = false;
		Land_APproach = false;
		LHD_RU = false;
		LHD_CFA = 0; //This is the current ATC defined flying altitude
		LHD_CP = "alpha";
		LHD_OF = false;
		LHD_IL = false; //Set to True when turned on base
		LHD_HL = false; //Set to True when aircraft has landed
		LHD_MAP = false;

	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";

	call airboss_fnc_atc_baseActionsFlyco;