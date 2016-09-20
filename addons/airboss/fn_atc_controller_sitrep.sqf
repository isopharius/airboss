//Get Variables
_vehicle = vehicle player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player has requested an air situation report

			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio "homer_msg_airsitrep_1";sleep 2.5;
			_counter = 0;
			{
				//Go through each intention set
				_numAircraft = count (_x select 1);
				_type = _x select 2;
				if (_numAircraft > 0) then {
					_counter = _counter + 1;
					//declare status
					_vehicle vehicleRadio format ["homer_digit_%1",_numAircraft];
					_vehicle vehicleRadio "homer_vehicle_aircraft"; sleep 0.5;
					_vehicle vehicleRadio "homer_word_registeredfor"; sleep 0.5;
					_vehicle vehicleRadio format ["homer_status_%1",_type];sleep 2;
					_vehicle vehicleRadio "homer_word_duties"; sleep 0.5;
				};
			} foreach ATC_I;
			if (_counter isEqualTo 0) then {
				_vehicle vehicleRadio "homer_msg_airsitrep_2"; sleep 1;
			};
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_out";sleep 0.1;
			LHD_RU = false;