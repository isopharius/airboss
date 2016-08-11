//Get Variables
_vehicle = vehicle player;

	_loon1 = getPosWorld lhd;
	_loon2 = getPosWorld _vehicle;
	_dir = direction _vehicle;
	_initArray = _this select 3;
	_type = _initArray select 0; //0 = Priority landing

//Add Actions
	player removeaction LHD_Action_Landing;
	player removeaction LHD_Action_Landing_Priority;
	player removeaction ATC_TransferToHomer;
	LHD_Action_Landing_Cancel = player addAction ["FLYCO > Cancel Landing", airboss_fnc_atc_landing_cancel,[],10,false,true, "", "(LHD_radio)", -1];

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;

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
	_landingPattern_array = LHDPatternLayout select 0;
	_landingPattern = _landingPattern_array select 0;
	LHD_CancelLanding = false;

//Load in pattern Information
	_numPatterns = count LHDPatternLayout;
	_inPattern = count LHDPattern;
	_maxVehicles = 0;
	{_maxVehicles = _maxVehicles + (_x select 1)} foreach LHDPatternLayout;

//### CHECK IF ROOM IN PATTERN ###
if ((_inPattern < _maxVehicles) or (_type isEqualTo 1)) then {
	_array = LHDPattern;
	if (_type isEqualTo 0) then {
		//Standard Pattern Entry
		{
			_cursor =  _cursor + (_x select 1);
			if (((_inPattern) < _cursor) and (_pattern isEqualTo "alpha")) then {_pattern = _x select 0};
		} foreach LHDPatternLayout;
		_alt = (_inPattern * LHDAlt) + LHDAlt; //this sets the next vehicles altitude
		_alt1 = floor(_alt / 100) * 100;
		_alt2 = (_alt - _alt1);
		LHD_CurrentFlyAlt = _alt;
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
			LHDPattern = [_vehicle]
		};
		_pattern = _landingPattern;
		_alt = (LHDAlt * 2); //this sets the next vehicles altitude
		_alt1 = floor(_alt / 100) * 100;
		_alt2 = (_alt - _alt1);
		LHD_CurrentFlyAlt = _alt;
		LHD_Emergency_Call = [ATC_callsign,ATC_callsignNo];
		publicVariable "LHD_Emergency_Call";
	};
		publicVariable "LHDPattern";
		LHD_Approach = true;

	//calc heading to ship
		_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
		_hdg = (_hdg + 360) mod 360;
		_LHDdir = markerdir "ship";
		//_approachdir = (_hdg) - (_LHDdir);
		_approachdir = (_hdg);
		_approachdir = (_approachdir + 360) mod 360;
		_approachdir = round(_approachdir / 30);
		_approach = "south";
		if (((_approachdir > 0) and (_approachdir <= 3)) OR ((_approachdir > 9) and (_approachdir <= 12))) then {_approach = "north";};
		if (((_approachdir > 7) and (_approachdir <= 9)) OR ((_approachdir > 4) and (_approachdir <= 6))) then {_approach = "south";};
		//hint format["%1",_approach];

	//calc distance
		_distance = (_loon1 distance _loon2);
		_speed = speed _vehicle;
		_timeA = _distance / _speed;
		if(_timeA > 60) then {_timeA = 0};  //if its going to take an hour, don't give a time!
		_curtime = daytime * 60;
		_timeF = _curtime + _timeA;
		_timeHours = floor(_timeF / 60);
		_timeMins = floor(_timeF - (_timeHours * 60));

	//Calc relative position
		_clock = (_hdg) - (_dir);
		_clock = (_clock + 360) mod 360;
		_clock = round(_clock / 30);
		if (_clock isEqualTo 0) then {_clock = 12};

	//Calc Distance
		_distance = round((_loon1 distance _loon2) / 100) * 100;
	//	hintsilent format ["Ship is %1 o'clock, %2 meters",_clock,[_km,(_loon1 distance _loon2)]];


	// ### VECTORING CODE ###

		//Init Variables
			_curVectorNum = 0;
			_vector1 = markerpos format ["LHD_%1_1",_pattern];
			_vector2 = markerpos format ["LHD_%1_2",_pattern];
			_vector3 = markerpos format ["LHD_%1_3",_pattern];
			_vector4 = markerpos format ["LHD_%1_4",_pattern];

		//Script Settings
			_nearDistance = 100; //How close before next vector
			_digitDelay = 0.4;
			_sentenceDelay = 1;

		//Get Nearest Vector
			_curVectorNum = [_vehicle,_vector1,_vector2,_vector3,_vector4] call airboss_fnc_atc_nearestVector;
			_curVector = markerpos format ["LHD_%1_%2",_pattern,_curVectorNum];

			_wp = group player addWaypoint [_curVector, _nearDistance];
			_wp setWaypointStatements ["(LHD_radio)", "LHD_PatternWaypointComp = true;"];

	//Clear for approach into Pattern
		waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
		_vehicle vehicleRadio "flyco_word_roger";sleep 0.1;
		_vehicle vehicleRadio format["flyco_callsign_%1",ATC_callsign];
		_vehicle vehicleRadio format["flyco_digit_%1",ATC_callsignNo];sleep 0.3;
		_vehicle vehicleRadio "flyco_word_enter";sleep 0.3;
		_vehicle vehicleRadio format["flyco_ph_%1",_pattern];sleep 0.1;
		_vehicle vehicleRadio "flyco_word_pattern";sleep 0.3;

		//calc heading to ship
			_loon1 = _curVector;
			_loon2 = getPosWorld player;
			_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
			_hdg = round((_hdg + 360) mod 360);

		//Set New Heading
		_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
		_hdg = round((_hdg + 360) mod 360);

		_wD1 = floor(_hdg / 100);
		_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
		_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

		_vehicle vehicleRadio "flyco_word_bearing";sleep 0.4;
		_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep _digitDelay;
		_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep _digitDelay;
		_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep _sentenceDelay;

	//Set Approach Direction
		_vehicle vehicleRadio format["flyco_cmp_%1",_approach];sleep 0.1;
		sleep _sentenceDelay;
		if (_timeA > 0) then {
			//only give an arrival if its not ages in the future
			_vehicle vehicleRadio "flyco_word_estimatedarrival";sleep 0.3;
			_vehicle vehicleRadio format["flyco_digit_%1",_timeHours];sleep 0.1;
			if (_timeMins < 10) then {
				_vehicle vehicleRadio "flyco_digit_0";sleep 0.1;
				_vehicle vehicleRadio format["flyco_digit_%1",_timeMins];sleep 0.1;
			} else {
				_vehicle vehicleRadio format["flyco_digit_%1",_timeMins];sleep 0.1;
			};
		_vehicle vehicleRadio "flyco_word_hours";sleep 0.7;
		sleep _sentenceDelay;
		};

	//Provide Altitude for Entry
		_vehicle vehicleRadio "flyco_word_maintainaltitude";sleep 0.3;
		if (_alt1 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt1];sleep 0.1;};
		if (_alt2 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt2];sleep 0.1;};
		_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;

		//End Transmission
		_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
		LHD_RadioInUse = false;
		sleep 10;

	// ### Wait for status to change ###
		call airboss_fnc_atc_aliveapproach;

		if (LHD_HasLanded) then {
		//Radio Completed
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_landingcompleted";sleep 0.8;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHD_RadioInUse = false;
		};

		//Perform post-landing actions to return to normal state
			LHDPattern = LHDPattern - [_vehicle];
			publicVariable "LHDPattern";
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

} else {
	//Pattern is closed
	waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
	_vehicle vehicleRadio "flyco_word_negative";sleep 0.8;
	_vehicle vehicleRadio "flyco_word_clearancedenied";sleep 0.8;
	_vehicle vehicleRadio "flyco_word_thepatternisfull";sleep 0.3;
	//End Transmission
	_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
	_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
	LHD_RadioInUse = false;
};
//Remove all old waypoints
	{
		_x setWPpos (getPosWorld player);
		sleep 1;
		deletewaypoint _x;
	} foreach waypoints (group player);
//Make sure vehicle not in landing pattern
	LHDPattern = LHDPattern - [_vehicle];
	publicVariable "LHDPattern";
//Remove Action
	call airboss_fnc_atc_removePilotActions;
	call airboss_fnc_atc_baseActionsFlyco;