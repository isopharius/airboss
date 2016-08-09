	if (!isnil "Land_CurrentPosition") then {
		player removeAction Land_CurrentPosition;
		player removeAction Land_RequestAirPickup;
		player removeAction Land_RequestCAS;
		Land_CurrentPosition = nil;
		Land_RequestAirPickup = nil;
		Land_RequestCAS = nil;
		//player removeaction Land_RequestAirPickup_Cancel;
	};