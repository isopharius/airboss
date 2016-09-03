//Get Closest Vector and direct to that
params ["_vehicle", "_vector1", "_vector2", "_vector3", "_vector4"];

	_d1 = _vehicle distance _vector1;
	_d2 = _vehicle distance _vector2;
	_d3 = _vehicle distance _vector3;
	_d4 = _vehicle distance _vector4;

	_curVectorNum = 1;

	if ((_d1 < _d2) && {(_d1 < _d3)} && {(_d1 < _d4)}) then {_curVectorNum= 1};
	if ((_d2 < _d1) && {(_d2 < _d3)} && {(_d2 < _d4)}) then {_curVectorNum= 2};
	if ((_d3 < _d2) && {(_d3 < _d1)} && {(_d3 < _d4)}) then {_curVectorNum= 3};
	if ((_d4 < _d2) && {(_d4 < _d3)} && {(_d4 < _d1)}) then {_curVectorNum= 4};
	_curVectorNum;