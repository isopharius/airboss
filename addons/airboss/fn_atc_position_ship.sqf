//Get Variables
	_loon1 = getPosWorld lhd;
	_loon2 = getPosWorld player;
	_vehicle = vehicle player;

	_dir = direction _vehicle;

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;

//calc heading to ship
	_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
	_hdg = (_hdg + 360) mod 360;

//Calc relative position
	_clock = (_hdg) - (_dir);
	_clock = (_clock + 360) mod 360;
	_clock = round(_clock / 30);
	if (_clock isEqualTo 0) then {_clock = 12};
	_wD1 = floor(_hdg / 100);
	_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
	_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

//Calc Distance
	_distance = round((_loon1 distance _loon2) / 100) * 100;
//	hintsilent format ["Ship is %1 o'clock, %2 meters",_clock,[_km,(_loon1 distance _loon2)]];

//Say it
	waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
	_vehicle vehicleRadio "flyco_word_roger";sleep 0.4;
	_vehicle vehicleRadio "flyco_word_shipis";sleep 0.4;
	_vehicle vehicleRadio format["flyco_digit_%1",_clock];sleep _digitDelay;
	_vehicle vehicleRadio "flyco_word_oclock";sleep 0.4;
	_vehicle vehicleRadio "flyco_word_bearing";sleep 0.4;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep _digitDelay;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep _digitDelay;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep _sentenceDelay;

	if (_distance < (ATC_maxDigit * 1000)) then {
		if (_distance < 1000) then {
		//Under a kilometer, report in meters
			_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
			_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
		} else {
		//Over a kilometer
			_distance = floor(_distance / 1000);
			_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
			if (_distance isEqualTo 1) then {
				_vehicle vehicleRadio "flyco_word_kilometer";sleep 0.3;
			} else {
				_vehicle vehicleRadio "flyco_word_kilometers";sleep 0.3;
			};
		};
	};
	_vehicle vehicleRadio "flyco_word_fromyourposition";sleep 1.1;

//End Transmission
	_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
	_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
	LHD_RadioInUse = false;