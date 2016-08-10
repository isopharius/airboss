//Set Control Room marker
	_PosControl = lhd modeltoworld [-6.91016,15.4805,16];
	LHD_Location = createLocation ["NameLocal", _PosControl, 5, 9.5];
	LHD_Location setDirection _lhddir;
	LHD_Location setRectangular true;
	LHD_Location setText "USX Syed";
    ["controlarea", _PosControl, "RECTANGLE", [5,9.5], "COLOR:", "ColorWhite", "BRUSH:", "Border"] call CBA_fnc_createMarker;

//Create deck location (used to check when landed)
	LHD_Deck = createLocation ["NameLocal", _lhdpos, 30, 125];
	LHD_Deck setRectangular true;
	LHD_Deck setDirection _lhddir;
    ["deckarea", _lhdpos, "RECTANGLE", [30,125], "COLOR:", "ColorBlue", "BRUSH:", "Border"] call CBA_fnc_createMarker;

//Set FlyCo Control Area
	LHD_ControlArea = createLocation ["NameLocal", _lhdpos, (LHD_ControlRadius select 0), (LHD_ControlRadius select 1)];
	LHD_ControlArea setDirection _lhddir;
	LHD_ControlArea setRectangular false;
    ["flycoarea", _lhdpos, "ELLIPSE", [(LHD_ControlRadius select 0), (LHD_ControlRadius select 1)], "COLOR:", "ColorGreen", "BRUSH:", "Border"] call CBA_fnc_createMarker;

//Set Homer Restricted Area
	LHD_RestrictedArea = createLocation ["NameLocal", _lhdpos, (LHD_RestrictedRadius select 0), (LHD_RestrictedRadius select 1)];
	LHD_RestrictedArea setDirection _lhddir;
	LHD_RestrictedArea setRectangular false;
    ["homerarea", _lhdpos, "ELLIPSE", [(LHD_RestrictedRadius select 0), (LHD_RestrictedRadius select 1)], "COLOR:", "ColorRed", "BRUSH:", "Border"] call CBA_fnc_createMarker;

//Place markers for each pattern
{
	_cursor = 0;
	_patternArray = _x;
	_pattern = _patternArray select 0;
	_xRadius = _patternArray select 2; _yRadius = _patternArray select 3;
	_Processor = [
		(lhd modeltoworld [-(_xRadius),(_yRadius)]),
		(lhd modeltoworld [-(_xRadius),-(_yRadius)]),
		(lhd modeltoworld [(_xRadius),-(_yRadius)]),
		(lhd modeltoworld [(_xRadius),(_yRadius)])
	];
	{
		_cursor = _cursor + 1;

		_markerName = format ["LHD_%1_%2",_pattern,_cursor];
		_position = [(_x select 0),(_x select 1)];
		_marker = createMarkerLocal[_markerName,_position];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "EMPTY";
	} foreach _Processor;
} forEach LHDPatternLayout;

//Create the Finals marker
	_closestPattern = LHDPatternLayout select 0;
	_xClosest = _closestPattern select 2;
	_position = (lhd modeltoworld [(_xClosest),0]);
	_marker = createMarkerLocal["LHD_finals",_position];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "EMPTY";