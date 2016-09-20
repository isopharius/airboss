disableSerialization;
		//Run when we need up update the listbox
		private _index = 0;
		params ["_listBox"];
		lbClear _listBox;

		//Add stuff to list
		private _list = LHD_SV;
		{
			private _vehName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
			_listBox lbAdd _vehName;
			_listBox lbSetData [_index, _x];
			_listBox lbSetValue [_index,0];		//NO ID FOR THIS!
			_index = _index + 1;
		} foreach _list;
