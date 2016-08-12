/*
	File: PosToGrid.sqf
	Author: Karel Moricky

	Description:
	Converts array position to map grid position.

	Parameter(s):
	_this: Object, Array in format position or String with marker name

	Returns:
	Array in format ["X","Y"]
*/
private["_xgrid","_ygrid","_xcoord","_ycoord","_result"];
_xgrid = _this select 0;
_ygrid = _this select 1;
_xcoord =
	if (_xgrid >= 100) then {
		str _xgrid;
	} else {
		if (_xgrid >= 10) then {
			"0" + str _xgrid;
		} else {
			"00" + str _xgrid;
		};
	};

_ycoord =
	if (_ygrid >= 100) then {
		str _ygrid;
	} else {
		if (_ygrid >= 10) then {
			"0" + str _ygrid;
		} else {
			"00" + str _ygrid;
		};
	};
_result = _xcoord + " " + _ycoord;
_result;