params ["_lp"];	//lhd position
_ld = getdir lhd;	//lhd dir

//Set Control Room marker
	_pc = lhd modeltoworld [-6.91016,15.4805,16];	//position control
	LHD_Location = createLocation ["NameLocal", _pc, 5, 9.5];
	LHD_Location setDirection _ld;
	LHD_Location setRectangular true;
	LHD_Location setText "USX Syed";
    ["controlarea", _pc, "RECTANGLE", [5,9.5], "COLOR:", "ColorWhite", "BRUSH:", "Border"] call CBA_fnc_createMarker;
    "controlarea" setMarkerAlpha 0.5;

//Create deck location (used to check when landed)
	LHD_Deck = createLocation ["NameLocal", _lp, 30, 125];
	LHD_Deck setRectangular true;
	LHD_Deck setDirection _ld;
    ["deckarea", _lp, "RECTANGLE", [30,125], "COLOR:", "ColorBlue", "BRUSH:", "Border"] call CBA_fnc_createMarker;
    "deckarea" setMarkerAlpha 0.3;

//Set FlyCo Control Area
	LHD_ControlArea = createLocation ["NameLocal", _lp, (LHD_CR select 0), (LHD_CR select 1)];
	LHD_ControlArea setDirection _ld;
	LHD_ControlArea setRectangular false;
    ["flycoarea", _lp, "ELLIPSE", [(LHD_CR select 0), (LHD_CR select 1)], "COLOR:", "ColorGreen", "BRUSH:", "Border"] call CBA_fnc_createMarker;
    "flycoarea" setMarkerAlpha 0.2;

//Set Homer Restricted Area
	LHD_RestrictedArea = createLocation ["NameLocal", _lp, (LHD_RR select 0), (LHD_RR select 1)];
	LHD_RestrictedArea setDirection _ld;
	LHD_RestrictedArea setRectangular false;
    ["homerarea", _lp, "ELLIPSE", [(LHD_RR select 0), (LHD_RR select 1)], "COLOR:", "ColorRed", "BRUSH:", "Border"] call CBA_fnc_createMarker;
    "homerarea" setMarkerAlpha 0.2;

//Place markers for each pattern
{
	_c = 0;	//cursor
	_pa = _x;	//pattern array
	_p = _pa select 0;	//pattern
	_xR = _pa select 2;	//x radius
	_yR = _pa select 3;	//y radius
	_pr = [	//processor
		(lhd modeltoworld [-(_xR), (_yR)]),
		(lhd modeltoworld [-(_xR), -(_yR)]),
		(lhd modeltoworld [(_xR), -(_yR)]),
		(lhd modeltoworld [(_xR), (_yR)])
	];
	{
		_c = _c + 1;

		_n = format ["LHD_%1_%2", _p, _c];	//marker name
		_mp = [(_x select 0),(_x select 1)];	//marker position
		_m = createMarkerLocal[_n, _mp];	//marker
		_m setMarkerShape "ICON";
		_m setMarkerType "EMPTY";
	} foreach _pr;
} forEach LHD_PL;

//Create the Finals marker
	_cp = LHD_PL select 0;	//closest pattern
	_xc = _cp select 2;	//x closest
	_mp = (lhd modeltoworld [(_xc),0]);
	_m = createMarkerLocal["LHD_finals",_mp];
	_m setMarkerShape "ICON";
	_m setMarkerType "EMPTY";
