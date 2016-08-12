//Get Variables
_vehicle = vehicle player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Service Aircraft
			waitUntil{!LHA_RadioInUse};LHA_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_1";sleep 0.3;
			LHA_RadioInUse = false;

			//Wait
			_rnd = floor(random 5) + 15;
			sleep _rnd;
			["ATC003",_vehID,"LHA"] spawn fnc_usec_recordEventClient;

			//ok
			_vehicle call fnc_usec_lha_VehicleServiceRadio;
			waitUntil{!LHA_RadioInUse};LHA_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_2";sleep 0.5;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHA_RadioInUse = false;