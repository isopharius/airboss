_vehicle = vehicle player;

	_CheckPos = (lhd modeltoworld _this);
	_allObjects = (_CheckPos nearObjects ['Air',LHD_BayRadius]);
	_allLand = (_CheckPos nearObjects ['Land',LHD_BayRadius]);
	_allObjects append _allLand;
	if ((count _allObjects > 0) and !(_vehicle in _allObjects)) then {
		//hint format ["%1",_allObjects];
		{deletevehicle _x} foreach _allObjects;
	};