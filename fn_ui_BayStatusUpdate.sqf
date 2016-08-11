disableSerialization;
		//Sets visual status of a bay on dialog
		private _bay = _this select 0;
		private _IsSafe = _this select 1;
		private _ctrl = 1200 + _bay;
		private _pic = 1100 + _bay;
		private _display = (findDisplay 50001);
		private _control = (_display displayCtrl _ctrl);
		private _picture = (_display displayCtrl _pic);
		private _button = (_display displayCtrl 1007);
		private _baySelected = LHD_SelectedBay > 0;

		if (_IsSafe) then {
			private _r = 0.60;
			private _g = 0.84;
			private _b = 0.47;
		} else {
			private _r = 1;
			private _g = 0;
			private _b = 0;
		};
		_control ctrlSetTextColor [_r,_g,_b,1.0];
		_picture ctrlSetTextColor [_r,_g,_b,1.0];
		LHD_BayStatus set [(_bay - 1),_IsSafe];

		//Check if bay currently selected, if so, disable issuing
		if (_bay isEqualTo LHD_SelectedBay) then {
			if (_IsSafe) then {
				_control ctrlEnable true;
			} else {
				_control ctrlEnable false;
			};
		};