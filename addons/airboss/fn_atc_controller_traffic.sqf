//Get Variables
_vehicle = vehicle player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player has requested a traffic pattern report
			//Load in pattern Information
			_numPatterns = count LHD_PL;
			_inPattern = count LHDPattern;
			_remainPattern = _inPattern;
			_maxVehicles = 0;
			{_maxVehicles = _maxVehicles + (_x select 1)} foreach LHD_PL;
			_cursor = _inPattern;
			_patternMaxNo = 0;
			_patternName = "alpha";
			_pos = 0;

			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio "flyco_msg_trafficsitrep_1";sleep 2;
			if (_inPattern > 0) then {
				{
					_patternName = _x select 0;
					_patternMaxNo = _x select 1;
					_remainPattern = _remainPattern - _patternMaxNo;
					_cursor = _patternMaxNo;
					if (_remainPattern < 0) then {
						_cursor = _cursor + _remainPattern;
						_remainPattern = 0;
					};

					_vehicle vehicleRadio format ["flyco_digit_%1",_cursor];
					_vehicle vehicleRadio "flyco_vehicle_aircraft"; sleep 0.5;
					_vehicle vehicleRadio format ["flyco_ph_%1",_patternName];sleep 1;
				} foreach LHD_PL;

				if (_vehicle in LHDPattern) then {
					_pos = (LHDPattern find _vehicle) + 1;
					_vehicle vehicleRadio "flyco_msg_trafficsitrep_2";sleep 0.3;
					_vehicle vehicleRadio format ["flyco_digit_%1",_pos];
					_vehicle vehicleRadio "flyco_word_outof";sleep 0.3;
					_vehicle vehicleRadio format ["flyco_digit_%1",_inPattern];
					_vehicle vehicleRadio "flyco_msg_trafficsitrep_3";sleep 2;
				};
			} else {
				_vehicle vehicleRadio "flyco_msg_trafficsitrep_4";sleep 1;
			};
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.1;
			LHD_RU = false;