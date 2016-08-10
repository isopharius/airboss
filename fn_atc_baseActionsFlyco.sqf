	private["_vehicle","_isOnDeck"];
_vehicle = vehicle player;

	ATC_TransferToHomer = player addAction ["FLYCO > Transfer to HOMER", airboss_fnc_atc_controller, [3], 20, false, true];
	ATC_TransferToWatchdog = player addAction ["FLYCO > Transfer to WATCHDOG", airboss_fnc_land_controller, [1], 19, false, true];
	LHD_Action_Weather = player addAction ["FLYCO > Request Weather Report", airboss_fnc_atc_weather,[],18,false];
	ATC_Flyco_TrafficSitrep = player addAction ["FLYCO > Request Traffic Report", airboss_fnc_atc_controller, [6], 17, false, true];
	_isOnDeck = getPosWorld _vehicle in LHD_Deck;

	if (_isOnDeck) then {
		LHD_Action_Takeoff = player addAction ["FLYCO > Request Takeoff Clearance", airboss_fnc_atc_takeoff,[0],15,false];
		LHD_Action_Takeoff_Priority = player addAction ["FLYCO > Request Emergency Takeoff Clearance", airboss_fnc_atc_takeoff,[1],14,false];
		//LHD_Action_CargoLoad = player addAction ["FLYCO > Request Cargo Load", airboss_fnc_atc_controller,[8],14,false];
		LHD_Action_Service = player addAction ["FLYCO > Request Aircraft Service", airboss_fnc_atc_controller,[11],14,false];
	} else {
		LHD_Action_VectorShip = player addAction ["FLYCO > Request Vector to Ship", airboss_fnc_atc_position_ship,[],15,false];
		LHD_Action_Landing = player addAction ["FLYCO > Request Landing Clearance", airboss_fnc_atc_landing,[0],14,false];
		LHD_Action_Landing_Priority = player addAction ["FLYCO > Request Emergency Landing Clearance", airboss_fnc_atc_landing,[1],13,false];
	};