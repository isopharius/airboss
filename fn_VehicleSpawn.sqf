		_position = (lhd modeltoworld (LHD_BayPositions select (LHD_SelectedBay - 1)));
		_position call airboss_fnc_object_create;