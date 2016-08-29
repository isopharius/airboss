disableSerialization;
	//Run when a player selects a bay
		params ["_bay"];
		private _status = false;
		if (LHD_SelectedBay > 0) then {
			_status = (LHD_BayStatus select (LHD_SelectedBay - 1));
		};

		private _r = 1;
		private _g = 0;
		private _b = 0;

		if (_status) then {
			_r = 0.60;
			_g = 0.84;
			_b = 0.47;
		};

		//Set New Control White
		private _ctrl = 1200 + _bay;
		private _pic = 1100 + _bay;
		private _display = (findDisplay 50001);
		private _control = (_display displayCtrl _ctrl);
		private _ctrlSpawn = (_display displayCtrl 1007);
		private _ctrlReturn = (_display displayCtrl 1008);
		private _ctrlService = (_display displayCtrl 1009);
		private _ctrlLoad = (_display displayCtrl 1010);
		private _picture = (_display displayCtrl _pic);
		_control ctrlSetTextColor [1,1,1,1];
		_picture ctrlSetTextColor [1,1,1,1];

		//Set Old Control Normal
		private _ctrl = 1200 + LHD_SelectedBay;
		private _pic = 1100 + LHD_SelectedBay;
		private _control = (_display displayCtrl _ctrl);
		private _picture = (_display displayCtrl _pic);
		_control ctrlSetTextColor [_r,_g,_b,0.7];
		_picture ctrlSetTextColor [_r,_g,_b,0.7];

		//Set Bay Selected
		LHD_SelectedBay = _bay;
		private _baytext = (_display displayCtrl 1003);
		_baytext ctrlSetText format ["Bay #%1",_bay];
		private _TextVehicle = (_display displayCtrl 1004);
		private _TextDriver = (_display displayCtrl 1005);
		_TextVehicle ctrlSetText "None";
		_TextDriver ctrlSetText "None";
		LHD_ActiveObject = player;
