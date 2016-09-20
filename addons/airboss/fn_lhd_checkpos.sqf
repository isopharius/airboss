	_CheckPos = (lhd modeltoworld _this);
	_allObjects = (_CheckPos nearObjects ['Air',LHD_BR]);
	_allLand = (_CheckPos nearObjects ['Land',LHD_BR]);
	_allObjects append _allLand;
	if (count _allObjects > 0) then {
		if ((objectParent player) in _allObjects) then {
			[true,true];
		} else {
			[false,false];
		};
	} else {
		[true,false];
	};
