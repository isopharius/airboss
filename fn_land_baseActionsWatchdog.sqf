
Land_CurrentPosition = player addAction ["WATCHDOG > Request Current Position", airboss_fnc_land_controller, [2], 20, false, true];
	if (!Land_AwaitingDelivery) then {
		Land_RequestAirPickup = player addAction ["WATCHDOG > Request Air Transport", airboss_fnc_land_transport_air, [0], 19, false, true];
	};
	if (!Land_AwaitingCASRun) then {
		Land_RequestCAS = player addAction ["WATCHDOG > Request Close Air Support", airboss_fnc_land_closeairsupport, [0], 19, false, true];
	};