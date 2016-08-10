disableSerialization;
	_bay = 1;

	//Update Bay Status
	{
		_CheckPos = (lhd modeltoworld _x);
		_bayStatus = LHD_BayStatus select (_bay - 1);
		_allObjects = (_CheckPos nearObjects ["Air",_radius]);
		_NearObjectsLand = ( nearestObjects [ _CheckPos, ["Land","WeaponHolder","ReammoBox_F","Cargo_base_F","StaticWeapon"],_radius]);
		_NearObjectsSea = (_CheckPos nearObjects ["Ship",_radius]);
		_allObjects append _NearObjectsLand;
		_allObjects append _NearObjectsSea;
		_pic = 1100 + _bay;
		_picture = (_display displayCtrl _pic);

		if (count _allObjects > 0) then {
			if (_bayStatus) then {
				[_bay,false] call airboss_fnc_ui_BayStatusUpdate;
			};
			if (LHD_SelectedBay isEqualTo _bay) then {
				LHD_ActiveObject = _allObjects select 0;
			};
			_icon = getText (configfile >> "CfgVehicles" >> (TypeOf (_allObjects select 0)) >> "Picture");
			_picture ctrlSetText format ["%1",_icon];
		} else {
			_picture ctrlSetText "";
			LHD_BayStatus set [(_bay - 1),true];
		};
		_bay = _bay + 1;
	} foreach LHD_BayPositions;

	if(LHD_SelectedBay > 0) then {
		//Update Active Bay details
		if(LHD_ActiveObject != Player) then {
			//Update Details
			_TypeOfV = TypeOf LHD_ActiveObject;
			_vehName = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "displayName");

			_VehID = LHD_ActiveObject getVariable["VehID",''];
			if (_VehID != '') then {
				_vehName = format["%1 (%2)",_vehName,_VehID];
			};

			_TextVehicle ctrlSetText format ["%1",_vehName];
			_icon = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "Picture");
			_IconVehicle ctrlSetText format ["%1",_icon];
			if (format ["%1",driver LHD_ActiveObject] != "<NULL-object>") then {_TextDriver ctrlSetText format ["%1",driver LHD_ActiveObject];} else {_TextDriver ctrlSetText "None";	};
		} else {
			_IconVehicle ctrlSetText "";
			_TextVehicle ctrlSetText "None";
			_TextDriver ctrlSetText "None";
		};

		//Check if Issuing button should be shown

		_baySelected = (LHD_SelectedBay > 0);
		_bayStatus = LHD_BayStatus select (LHD_SelectedBay - 1);

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