disableSerialization;
		private["_ctrl","_pic","_control","_display","_baySelected","_button","_r","_g","_b"];
		//Sets visual status of a bay on dialog
		params ["_bay", "_IsSafe"];
		_ctrl = 1200 + _bay;
		_pic = 1100 + _bay;
		_display = (findDisplay 50001);
		_control = (_display displayCtrl _ctrl);
		_picture = (_display displayCtrl _pic);
		_button = (_display displayCtrl 1007);
		_baySelected = LHD_SB > 0;

		if (_IsSafe) then {
			_r = 0.60;
			_g = 0.84;
			_b = 0.47;
		} else {
			_r = 1;
			_g = 0;
			_b = 0;
		};
		_control ctrlSetTextColor [_r,_g,_b,1.0];
		_picture ctrlSetTextColor [_r,_g,_b,1.0];
		LHD_BS set [(_bay - 1),_IsSafe];

		//Check if bay currently selected, if so, disable issuing
		if (_bay isEqualTo LHD_SB) then {
			if (_IsSafe) then {
				_control ctrlEnable true;
			} else {
				_control ctrlEnable false;
			};
		};