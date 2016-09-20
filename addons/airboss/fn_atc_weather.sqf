//Script Settings
#define DIGITDELAY 0.3
#define	SENTENCEDELAY 0.7
#define	ATCMAXDIGIT 60

//Input Variables
	_windDirection = ((((wind select 0) atan2 (wind select 1)) + 360) mod 360);
	_windSpeed = sqrt ( ( (wind select 0)*(wind select 0) ) + ( (wind select 1)*(wind select 1) ) + ( (wind select 2)*(wind select 2) ) ) * 1.94384449;
	_vehicle = vehicle player;

//Split
	_wS = round(_windSpeed);

	_wD1 = floor(_windDirection / 100);
	_wD2 = floor((_windDirection - (_wD1 * 100)) / 10);
	_wD3 = floor(_windDirection - (_wD2 * 10) - (_wD1 * 100));

	_t1 = floor(daytime);
	_t2 = floor((daytime - _t1) * 60);

//Initial Message
	waitUntil{!LHD_RU};LHD_RU = true;
	_vehicle vehicleRadio "flyco_msg_weather_1";sleep 1;

//Say Time
	//hintsilent format ["%1,%2,%3,%3 (%5) - %6",_t1,_t2,_t3,_t4,daytime,( _t2 + (_t1 * 10))];
	_vehicle vehicleRadio "flyco_word_thetimeis";sleep 0.7;
	_vehicle vehicleRadio format["flyco_digit_%1",_t1];sleep 0.1;

	if (_t2 < 10) then {
		_vehicle vehicleRadio "flyco_digit_0";sleep 0.1;
		_vehicle vehicleRadio format["flyco_digit_%1",_t2];sleep 0.1;
	} else {
		_vehicle vehicleRadio format["flyco_digit_%1",_t2];sleep 0.1;
	};
	_vehicle vehicleRadio "flyco_word_hours";sleep 0.7;
	sleep SENTENCEDELAY;

//Say WindSpeed Result
	if(_wS > ATCMAXDIGIT) then {_wS = ATCMAXDIGIT};
	_vehicle vehicleRadio "flyco_word_windSpeed";sleep 1;
	_vehicle vehicleRadio format["flyco_digit_%1",_wS];sleep DIGITDELAY;
	_vehicle vehicleRadio "flyco_word_knots";sleep SENTENCEDELAY;

//Say windDirection Result
	_vehicle vehicleRadio "flyco_word_windDirection";sleep 1;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
	_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep DIGITDELAY;
	sleep SENTENCEDELAY;

//Sky Condition
	_condition = overcast;
	_forecast = overcastForecast;

	_vehicle vehicleRadio "flyco_word_skyconditions";sleep DIGITDELAY;

	if(_condition > 0.1) then {
		if(_condition > 0.5) then {
			if(_condition > 0.9) then {
				_vehicle vehicleRadio "flyco_cloud_4";
			} else {
				_vehicle vehicleRadio "flyco_cloud_3";
			};
		} else {
			_vehicle vehicleRadio "flyco_cloud_2";
		};
	} else {
		_vehicle vehicleRadio "flyco_cloud_1";
	};
	sleep SENTENCEDELAY;

	_vehicle vehicleRadio "flyco_word_forecast";sleep DIGITDELAY;

	if(_forecast > 0.1) then {
		if(_forecast > 0.5) then {
			if(_forecast > 0.9) then {
				_vehicle vehicleRadio "flyco_cloud_4";
			} else {
				_vehicle vehicleRadio "flyco_cloud_3";
			};
		} else {
			_vehicle vehicleRadio "flyco_cloud_2";
		};
	} else {
		_vehicle vehicleRadio "flyco_cloud_1";
	};
	sleep SENTENCEDELAY;

//Visibility
	_condition = fog;
	_forecast = fogForecast;

	_vehicle vehicleRadio "flyco_word_visibility";sleep 1.2;

	if(_condition > 0.1) then {
		if(_condition > 0.5) then {
			if(_condition > 0.9) then {
				_vehicle vehicleRadio "flyco_cloud_4";
			} else {
				_vehicle vehicleRadio "flyco_word_obscured";
			};
		} else {
			_vehicle vehicleRadio "flyco_word_limited";
		};
	} else {
		_vehicle vehicleRadio "flyco_word_fine";
	};
	sleep SENTENCEDELAY;

	_vehicle vehicleRadio "flyco_word_forecast";sleep 1.2;

	if(_forecast > 0.1) then {
		if(_forecast > 0.5) then {
			if(_forecast > 0.9) then {
				_vehicle vehicleRadio "flyco_word_obscured";
			} else {
				_vehicle vehicleRadio "flyco_word_poor";
			};
		} else {
			_vehicle vehicleRadio "flyco_word_limited";
		};
	} else {
		_vehicle vehicleRadio "flyco_word_fine";
	};
	sleep SENTENCEDELAY;

//End Transmission
	_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
	_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
	LHD_RU = false;