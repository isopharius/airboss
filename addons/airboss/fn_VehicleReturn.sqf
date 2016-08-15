disableSerialization;
		private["_display","_vehicle","_control"];
		//Run when player selects returning of a vehicle
		private _vehicle = LHD_ActiveObject;
		private _display = (findDisplay 50001);
		private _control = (_display displayCtrl 1006);

		deleteVehicle _vehicle;

		private _display = (findDisplay 50001);
		(_display displayCtrl (1200 + LHD_SelectedBay)) ctrlSetTextColor [0.60,0.84,0.47,0.7];
		(_display displayCtrl (1100 + LHD_SelectedBay)) ctrlSetTextColor [0.60,0.84,0.47,0.7];
		LHD_BayStatus set [(LHD_SelectedBay - 1),true];

		//Update listbox
		[_control] call airboss_fnc_ui_UpdateListBox;
