	call airboss_fnc_system_playeralive;

	//Player has died!
		ControllerActionAdded = false;

	//Cleanup Air Transport Pickup markers (for soldiers)
		if (!isnil "Land_AirPickup_marker1") then {
			deletemarkerlocal Land_AirPickup_marker1;
		};
		if (!isnil "Land_AirPickup_marker2") then {
			deletemarkerlocal Land_AirPickup_marker2;
		};

	//Cleanup Task markers (For Pilots on tasks)
		if (!isnil "Air_TaskMarker1") then {
			deletemarkerlocal Air_TaskMarker1;
		};
		if (!isnil "Air_TaskMarker2") then {
			deletemarkerlocal Air_TaskMarker2;
		};

	sleep 1;
	call airboss_fnc_system_controlroom;