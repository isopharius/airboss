_vehicle = vehicle player;

	_CheckPos = (lhd modeltoworld _this);
	_allObjects = (_CheckPos nearObjects ['Air',LHD_BayRadius]);
	_allLand = (_CheckPos nearObjects ['Land',LHD_BayRadius]);
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