//Get Variables
_vehicle = objectParent player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Service Aircraft
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_1";sleep 0.3;
			LHD_RadioInUse = false;

			//Wait
			_rnd = floor(random 5) + 15;
			sleep _rnd;

			//ok
			_vehicle call airboss_fnc_VehicleService;
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_2";sleep 0.5;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHD_RadioInUse = false;
