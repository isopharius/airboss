disableSerialization;

//Initate Debarkation Control
	Dialog_DKC = createDialog DebarkDialog;

	WaitUntil {Dialog_DKC};

	//Initialize Display Variables
	_display=(findDisplay DebarkDisplay);
	_listBox = (_display displayCtrl 1006);
	_TextVehicle = (_display displayCtrl 1004);
	_TextDriver = (_display displayCtrl 1005);
	_IconVehicle = (_display displayCtrl 1002);

	//Set Button states
	_ctrlSpawn = (_display displayCtrl 1007);
	_ctrlReturn = (_display displayCtrl 1008);
	_ctrlService = (_display displayCtrl 1009);
	_ctrlLoad = (_display displayCtrl 1010);
	_ctrlLoadPers = (_display displayCtrl 1011);
	_ctrlSpawn ctrlEnable false;
	_ctrlReturn ctrlEnable false;
	_ctrlService ctrlEnable false;
	_ctrlLoad ctrlEnable false;
	_ctrlLoadPers ctrlEnable false;

	[_listBox] call airboss_fnc_ui_UpdateListBox;
	_radius = LHD_BayRadius;

//BayWatch
call airboss_fnc_ui_baywatch;