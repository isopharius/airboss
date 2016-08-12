		_position = (lhd modeltoworld (LHD_BayPositions select (LHD_SelectedBay - 1)));
		_hdg = (markerdir "controlroom");

		[_position, _hdg] call airboss_fnc_object_create;