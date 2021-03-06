disableSerialization;
	_bay = 1;

	//Update Bay Status
	{
		_CheckPos = (lhd modeltoworld _x);
		_bayStatus = LHD_BS select (_bay - 1);
		_allObjects = (_CheckPos nearObjects ["Air", _radius]);
		_NearObjectsLand1 = (_CheckPos nearObjects ["Land", _radius]);
		_NearObjectsLand2 = (_CheckPos nearObjects ["WeaponHolder", _radius]);
		_NearObjectsLand3 = (_CheckPos nearObjects ["ReammoBox_F", _radius]);
		_NearObjectsLand4 = (_CheckPos nearObjects ["Cargo_base_F", _radius]);
		_NearObjectsLand5 = (_CheckPos nearObjects ["StaticWeapon", _radius]);
		_NearObjectsSea = (_CheckPos nearObjects ["Ship", _radius]);
		_allObjects append _NearObjectsLand1;
		_allObjects append _NearObjectsLand2;
		_allObjects append _NearObjectsLand3;
		_allObjects append _NearObjectsLand4;
		_allObjects append _NearObjectsLand5;
		_allObjects append _NearObjectsSea;
		_display = (findDisplay 50001);
		_pic = 1100 + _bay;
		_picture = (_display displayCtrl _pic);

		if (count _allObjects > 0) then {
			if (_bayStatus) then {
				[_bay,false] call airboss_fnc_ui_BayStatusUpdate;
			};
			if (LHD_SB isEqualTo _bay) then {
				LHD_AO = _allObjects select 0;
			};
			_icon = getText (configfile >> "CfgVehicles" >> (TypeOf (_allObjects select 0)) >> "Picture");
			_picture ctrlSetText format ["%1",_icon];
		} else {
			_picture ctrlSetText "";
			LHD_BS set [(_bay - 1),true];
		};
		_bay = _bay + 1;
	} foreach LHD_BP;

	if(LHD_SB > 0) then {
		//Update Active Bay details
		if(LHD_AO != Player) then {
			//Update Details
			_TypeOfV = TypeOf LHD_AO;
			_vehName = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "displayName");

			_TextVehicle ctrlSetText format ["%1",_vehName];
			_icon = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "Picture");
			_IconVehicle ctrlSetText format ["%1",_icon];
			if (format ["%1",driver LHD_AO] != "<NULL-object>") then {_TextDriver ctrlSetText format ["%1",driver LHD_AO];} else {_TextDriver ctrlSetText "None";	};
		} else {
			_IconVehicle ctrlSetText "";
			_TextVehicle ctrlSetText "None";
			_TextDriver ctrlSetText "None";
		};

		//Check if Issuing button should be shown

		_baySelected = (LHD_SB > 0);
		_bayStatus = LHD_BS select (LHD_SB - 1);

		_display = (findDisplay 50001);
		_vehList = (_display displayCtrl 1006);
		_type = lbCurSel _vehList;

		// ** CHECK SPAWN BUTTON STATUS
		if((_baySelected) and (_bayStatus) and (_type > -1)) then {
			_ctrlSpawn ctrlEnable true;
		} else {
			_ctrlSpawn ctrlEnable false; // Disable Issuing Button
		};

		// ** CHECK RETURN/SERVICE BUTTON STATUS
		if(!_bayStatus) then {
			_ctrlReturn ctrlEnable true;
			_ctrlService ctrlEnable true;
			_ctrlLoad ctrlEnable true;
			_ctrlLoadPers ctrlEnable true;
		} else {
			_ctrlReturn ctrlEnable false;
			_ctrlService ctrlEnable false;
			_ctrlLoad ctrlEnable false;
			_ctrlLoadPers ctrlEnable false;
		};
	};
	sleep 0.5;
	call airboss_fnc_ui_baywatch;