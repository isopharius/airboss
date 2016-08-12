	ATC_TransferToFlyco = player addAction ["HOMER > Transfer to FLYCO", airboss_fnc_atc_controller, [2], 20, false, true, "", "true", -1];
	ATC_TransferToWatchdog = player addAction ["HOMER > Transfer to WATCHDOG", airboss_fnc_land_controller, [1], 19, false, true, "", "true", -1];
	//if (!ATC_onTask) then {
		ATC_ChangeIntentions = player addAction ["HOMER > Change Intentions", airboss_fnc_atc_controller, [4], 18, false, true, "", "true", -1];
	//};
	ATC_Homer_AirSitrep = player addAction ["HOMER > Request Air Sitrep", airboss_fnc_atc_controller, [5], 17, false, true, "", "true", -1];

	/*
	if ((LHD_Intention isEqualTo 2) and (_targets isEqualTo 0)) then {
		ATC_Homer_TrgAerial = player addAction ["HOMER > Aerial Training Target", airboss_fnc_atc_controller, [7,"aerial"], 17, false, true, "", "true", -1];
		ATC_Homer_TrgGround = player addAction ["HOMER > Ground Training Target", airboss_fnc_atc_controller, [7,"ground"], 17, false, true, "", "true", -1];
	};
	if (_targets > 0) then {
		ATC_Homer_TrgVector = player addAction ["HOMER > Request Target Vector", airboss_fnc_atc_controller, [10], 17, false, true, "", "true", -1];
		ATC_Homer_TrgCancel = player addAction ["HOMER > Cancel Training Target", airboss_fnc_atc_controller, [9], 17, false, true, "", "true", -1];
	};
	_baseNo = 0;
	ATC_Action_VectorBase = [];
	{
		_baseName = BaseNames select _baseNo;
		_action = player addAction [format["HOMER > Request Vector to Base %1",_baseName], airboss_fnc_atc_position_base, [_baseNo], 15, false, true, "", "true", -1];
		_baseNo = _baseNo + 1;
		ATC_Action_VectorBase set [count ATC_Action_VectorBase,_action];
	} forEach Bases;
	*/