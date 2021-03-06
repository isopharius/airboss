//Get Variables
_vehicle = vehicle player;

	_array = _this select 3;
	_type = _array select 0;

//Add Actions
	player removeaction LHD_Action_Takeoff;
	player removeaction LHD_Action_Takeoff_Priority;
	LHD_Action_Takeoff_Cancel = player addAction ["FLYCO > Cancel Takeoff", airboss_fnc_atc_takeoff_cancel,[],10,false,true, "", "true", -1];

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = 60;

//Defines
	_alt = 0;
	_alt1 = 0;
	_alt2 = 0;
	_cursor = 0;
	_array = [];
	_pattern = "alpha";
	_disCall = 0;
	_distance = 0;
	_prevdistance = 0;
	_finals = markerpos "LHD_finals";
	_landingPattern_array = LHD_PL select 0;
	_landingPattern = _landingPattern_array select 0;
	_Position = 0;
	_PrevPosition = 0;
	_clearDelay = 20;

//Load in pattern Information
	_numPatterns = count LHD_PL;
	_inPattern = count LHDPattern;
	_maxVehicles = 0;
	{_maxVehicles = _maxVehicles + (_x select 1)} foreach LHD_PL;

//Check pattern
	_array = LHDPattern;
	if (_type isEqualTo 0) then {
		//Standard Takeoff, go to end of que
		{
			_cursor =  _cursor + (_x select 1);
			if (((_inPattern) < _cursor) && {(_pattern isEqualTo "alpha")}) then {_pattern = _x select 0};
		} foreach LHD_PL;
		LHDPattern set [_inPattern,_vehicle];
	} else {
		//Priority
		if ((count LHDPattern) > 0) then {
			_PatternCurrent = LHDPattern select 0;
			[_PatternCurrent] pushback _vehicle;
			_NewLHDPattern = [_PatternCurrent];
			if ((count LHDPattern) > 1) then {
				LHDPattern deleteAt 0;
				_NewLHDPattern append LHDPattern;
			};
			LHDPattern = _NewLHDPattern;
		} else {
			LHDPattern = [_vehicle];
		};
		LHD_EC = [ATC_CS,ATC_CN];
		publicVariable "LHD_EC";
		_clearDelay = 0;
	};

	//Broadcast Request
	publicVariable "LHDPattern";
	LHD_TR = true;
	_Position = LHDPattern find _vehicle;

	if (_Position > 1) then {
		//Wait for clearance, will be a while
		waitUntil{!LHD_RU};LHD_RU = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.8;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 0.3;
		_vehicle vehicleRadio "flyco_msg_takeoff_que_1";sleep 0.3;
		_vehicle vehicleRadio format["flyco_digit_%1",(_Position + 1)];sleep _digitDelay;
		_vehicle vehicleRadio "flyco_msg_takeoff_que_2";sleep 1;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.8;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.8;
		LHD_RU = false;
	};

	call airboss_fnc_atc_alivetakeoff;
	call airboss_fnc_atc_distancetakeoff;

	if (LHD_TO) then {
		waitUntil{!LHD_RU};LHD_RU = true;
		_vehicle vehicleRadio "flyco_msg_takeoff_safe";sleep 0.4;
		_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.8;
		_vehicle vehicleRadio "flyco_word_out";sleep 0.8;
		LHD_RU = false;
	};

	//Make sure vehicle not in landing pattern
	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";

	//Takeoff Reset Variables
	LHD_TR =  false;
	LHD_TS = false;
	LHD_TO = false;

	call airboss_fnc_atc_removePilotActions;
	call airboss_fnc_atc_baseActionsFlyco;