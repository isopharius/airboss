disableSerialization;
		//Run when player moves mouse over or off a bay
		params ["_ctrl"];
		private _pic = _ctrl - 100;

		if (LHD_SelectedBay != (_ctrl - 1200)) then {
			private _isOver = _this select 1;
			private _display = (findDisplay 50001);
			private _control = (_display displayCtrl _ctrl);
			private _picture = (_display displayCtrl _pic);
			private _status = (LHD_BayStatus select ((_ctrl - 1200) - 1));

			private _r = 1;
			private _g = 0;
			private _b = 0;

			if (_status) then {
				_r = 0.60;
				_g = 0.84;
				_b = 0.47;
			};

			if (_isOver) then {
				//Mouse is over control
				_control ctrlSetTextColor [_r,_g,_b,1.0];
				_picture ctrlSetTextColor [_r,_g,_b,1.0];
			} else {
				_control ctrlSetTextColor [_r,_g,_b,0.7];
				_picture ctrlSetTextColor [_r,_g,_b,0.7];
			};
		};
