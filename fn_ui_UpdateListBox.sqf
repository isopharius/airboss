disableSerialization;
		//Run when we need up update the listbox
		private _index = 0;
		private _listBox = _this select 0;
		lbClear _listBox;

		//Add stuff to list
		private _list = LHD_SpawnableVehicles;
		{
			private _vehName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
			_listBox lbAdd _vehName;
			_listBox lbSetData [_index, _x];
			_listBox lbSetValue [_index,0];		//NO ID FOR THIS!
			private _index = _index + 1;
		} foreach _list;