	ATC_TransferToHomer = player addAction ["FLYCO > Transfer to HOMER", airboss_fnc_atc_controller_lhdtransfer, nil, 20, false, true, "", "true", -1];
	ATC_TransferToWatchdog = player addAction ["FLYCO > Transfer to WATCHDOG", airboss_fnc_land_controller_transfer, nil, 19, false, true, "", "true", -1];
	LHD_Action_Weather = player addAction ["FLYCO > Request Weather Report", airboss_fnc_atc_weather, nil, 18, false, true, "", "true", -1];
	ATC_Flyco_TrafficSitrep = player addAction ["FLYCO > Request Traffic Report", airboss_fnc_atc_controller_traffic, nil, 17, false, true, "", "true", -1];

	_isOnDeck = (getPosWorld player) in LHD_Deck;

	if (_isOnDeck) then {
		LHD_Action_Takeoff = player addAction ["FLYCO > Request Takeoff Clearance", airboss_fnc_atc_takeoff, [0], 15 ,false, true, "", "true", -1];
		LHD_Action_Takeoff_Priority = player addAction ["FLYCO > Request Emergency Takeoff Clearance", airboss_fnc_atc_takeoff, [1], 14, false, true, "", "true", -1];
		LHD_Action_Service = player addAction ["FLYCO > Request Aircraft Service", airboss_fnc_atc_controller_service, nil, 14, false, true, "", "true", -1];
	} else {
		LHD_Action_VectorShip = player addAction ["FLYCO > Request Vector to Ship", airboss_fnc_atc_position_ship, nil, 15, false, true, "", "true", -1];
		LHD_Action_Landing = player addAction ["FLYCO > Request Landing Clearance", airboss_fnc_atc_landing, [0], 14, false, true, "", "true", -1];
		LHD_Action_Landing_Priority = player addAction ["FLYCO > Request Emergency Landing Clearance", airboss_fnc_atc_landing, [1], 13, false, true, "", "true", -1];
	};
