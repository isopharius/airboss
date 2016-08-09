	if (!isnil "ATC_TransferToHomer") then {
		player removeaction ATC_TransferToHomer;
		ATC_TransferToHomer = nil;
	};
	if (!isnil "ATC_TransferToFlyco") then {
		player removeaction ATC_TransferToFlyco;
		ATC_TransferToFlyco = nil;
	};
	if (!isnil "ATC_TransferToWatchdog") then {
		player removeaction ATC_TransferToWatchdog;
		ATC_TransferToWatchdog = nil;
	};
	if (!isnil "ATC_ChangeIntentions") then {
		player removeaction ATC_ChangeIntentions;
		ATC_ChangeIntentions = nil;
		player removeaction ATC_Homer_AirSitrep;
		ATC_Homer_AirSitrep = nil;
	};
	if (!isnil "ATC_Flyco_TrafficSitrep") then {
		player removeaction ATC_Flyco_TrafficSitrep;
		ATC_Flyco_TrafficSitrep = nil;
		player removeaction LHD_Action_Weather;
		LHD_Action_Weather = nil;
	};
	if (!isnil "LHD_Action_ContactControl") then {
		player removeaction LHD_Action_ContactControl;
		LHD_Action_ContactControl = nil;
	};
	if (!isnil "LHD_Action_VectorShip") then {
		player removeaction LHD_Action_VectorShip;
		LHD_Action_VectorShip = nil;
	};
	if (!isnil "LHD_Action_Takeoff") then {
		player removeaction LHD_Action_Takeoff;
		LHD_Action_Takeoff = nil;
	};
	if (!isnil "LHD_Action_Takeoff_Priority") then {
		player removeaction LHD_Action_Takeoff_Priority;
		LHD_Action_Takeoff_Priority = nil;
	};
	if (!isnil "LHD_Action_Takeoff_Cancel") then {
		player removeaction LHD_Action_Takeoff_Cancel;
		LHD_Action_Takeoff_Cancel = nil;
	};
	if (!isnil "LHD_Action_Landing") then {
		player removeaction LHD_Action_Landing;
		LHD_Action_Landing = nil;
	};
	if (!isnil "LHD_Action_Landing_Priority") then {
		player removeaction LHD_Action_Landing_Priority;
		LHD_Action_Landing_Priority = nil;
	};
	if (!isnil "LHD_Action_Landing_Cancel") then {
		player removeaction LHD_Action_Landing_Cancel;
		LHD_Action_Landing_Cancel = nil;
	};
	if (!isnil "ATC_Action_VectorBase") then {
		{player removeaction _x} forEach ATC_Action_VectorBase;
		ATC_Action_VectorBase = nil;
	};
	if (!isnil "ATC_Homer_TrgGround") then {
		player removeaction ATC_Homer_TrgGround;
		ATC_Homer_TrgGround = nil;
	};
	if (!isnil "ATC_Homer_TrgAerial") then {
		player removeaction ATC_Homer_TrgAerial;
		ATC_Homer_TrgAerial = nil;
	};
	if (!isnil "ATC_Homer_TrgVector") then {
		player removeaction ATC_Homer_TrgVector;
		ATC_Homer_TrgVector = nil;
	};
	if (!isnil "ATC_Homer_TrgCancel") then {
		player removeaction ATC_Homer_TrgCancel;
		ATC_Homer_TrgCancel = nil;
	};
	if (!isnil "LHD_Action_Service") then {
		player removeaction LHD_Action_Service;
		LHD_Action_Service = nil;
	};
	//if (!isnil "LHD_Action_CargoLoad") then {
	//	player removeaction LHD_Action_CargoLoad;
	//	LHD_Action_CargoLoad = nil;
	//};