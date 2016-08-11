disableSerialization;
		//Run when player moves mouse over or off a bay
		private _ctrl = _this select 0;
		private _pic = _ctrl - 100;

		if (LHD_SelectedBay != (_ctrl - 1200)) then {
			private _isOver = _this select 1;
			private _display = (findDisplay 50001);
			private _control = (_display displayCtrl _ctrl);
			private _picture = (_display displayCtrl _pic);
			private _status = (LHD_BayStatus select ((_ctrl - 1200) - 1));
			if (_status) then {
				private _r = 0.60;
				private _g = 0.84;
				private _b = 0.47;
			} else {
				private _r = 1;
				private _g = 0;
				private _b = 0;
			};
			if (_isOver) then {
				//Mouse is over control
				private _control ctrlSetTextColor [_r,_g,_b,1.0];
				private _picture ctrlSetTextColor [_r,_g,_b,1.0];
			} else {
				private _control ctrlSetTextColor [_r,_g,_b,0.7];
				private _picture ctrlSetTextColor [_r,_g,_b,0.7];
			};
		};