	private["_vehicle"];
	_vehicle = _this;
	LHD_Action_Takeoff_Cancel = player addAction ["FLYCO > Cancel Takeoff", airboss_fnc_atc_takeoff_cancel,[],10,false];