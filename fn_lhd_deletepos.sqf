private _vehicle = vehicle player;

	private _CheckPos = (lhd modeltoworld _this);
	private _allObjects = (_CheckPos nearObjects ['Air',LHD_BayRadius]);
	private _allLand = (_CheckPos nearObjects ['Land',LHD_BayRadius]);
	private _allObjects append _allLand;
	if ((count _allObjects > 0) and !(_vehicle in _allObjects)) then {
		//hint format ["%1",_allObjects];
		{deletevehicle _x} foreach _allObjects;
	};