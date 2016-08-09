	private["_vehicle"];
	_vehicle = _this;
	LHD_Action_Landing_Cancel = player addAction ["FLYCO > Cancel Landing", airboss_fnc_atc_landing_cancel,[],10,false];