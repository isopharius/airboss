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
private ["_x", "_y"];
_x = -1;
_y = -1;
_type = typename _this;

call {
	//--- Coordinates
	if (_type isEqualTo "ARRAY") exitWith {
		_x = _this select 0;
		_y = _this select 1;
	};
	//--- Unit
	if (_type isEqualTo "OBJECT") exitWith {
		_x = getPosWorld _this select 0;
		_y = getPosWorld _this select 1;
	};
	//--- Marker
	if (_type isEqualTo "STRING") then {
		_x = markerpos _this select 0;
		_y = markerpos _this select 1;
	} else {
		hintc format["Bad input in ""PosToGrid.sqf"" - %1.",typename _this];
	};
};

private _xgrid = floor (_x / 100);
private _ygrid = floor (/*(MapY - _y)*/ _y / 100); //15360

private _xcoord = _xgrid;
private _ycoord = _ygrid;

private _result = [_xcoord,_ycoord];
_result;

//99.747604,-71.310097,5020.0483
