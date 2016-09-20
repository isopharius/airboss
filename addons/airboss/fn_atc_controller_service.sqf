//Get Variables
_vehicle = objectParent player;

	if (ATC_AA) then {
		ATC_AA = false;
		if (!am) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Service Aircraft
			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_1";sleep 0.3;
			LHD_RU = false;

			//Wait
			_rnd = floor(random 5) + 15;
			sleep _rnd;

			//ok
			_vehicle call airboss_fnc_VehicleService;
			waitUntil{!LHD_RU};LHD_RU = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_CS];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_CN];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_2";sleep 0.5;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHD_RU = false;
