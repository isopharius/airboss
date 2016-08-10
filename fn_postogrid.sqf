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
private ["_x","_y","_xgrid","_ygrid","_xcoord","_ycoord","_result"];

_x = -1;
_y = -1;

switch (typename _this) do
{
	//--- Coordinates
	case "ARRAY": {
		_x = _this select 0;
		_y = _this select 1;
	};
	//--- Unit
	case "OBJECT": {
		_x = getPosWorld _this select 0;
		_y = getPosWorld _this select 1;
	};
	//--- Marker
	case "STRING": {
		_x = markerpos _this select 0;
		_y = markerpos _this select 1;
	};
	default {
		if (true) exitwith {hintc format ["Bad input in ""PosToGrid.sqf"" - %1.",typename _this]};
	};
};

_xgrid = floor (_x / 100);
_ygrid = floor (/*(MapY - _y)*/ _y / 100); //15360

_xcoord = _xgrid;
_ycoord = _ygrid;

_result = [_xcoord,_ycoord];
_result;

//99.747604,-71.310097,5020.0483