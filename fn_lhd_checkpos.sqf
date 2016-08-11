private _vehicle = vehicle player;

	private _CheckPos = (lhd modeltoworld _this);
	private _allObjects = (_CheckPos nearObjects ['Air',LHD_BayRadius]);
	private _allLand = (_CheckPos nearObjects ['Land',LHD_BayRadius]);
	_allObjects append _allLand;
	if (count _allObjects > 0) then {
		if (_vehicle in  _allObjects) then {
			[true,true];
		} else {
			[false,false];
		};
	} else {
		[true,false];
	};