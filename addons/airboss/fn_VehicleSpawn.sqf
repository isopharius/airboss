disableSerialization;
	private["_position","_type","_display","_control","_index"];
	_display = (findDisplay 50001);
	_control = (_display displayCtrl 1006);
	_index = lbCurSel _control;
	_type = _control lbData _index;

	if (LHD_SelectedBay isEqualTo 1) then {_position = "fd_cargo_pos_19"};
	if (LHD_SelectedBay isEqualTo 2) then {_position = "fd_cargo_pos_18"};
	if (LHD_SelectedBay isEqualTo 3) then {_position = "fd_cargo_pos_14"};
	if (LHD_SelectedBay isEqualTo 4) then {_position = "fd_cargo_pos_15"};
	if (LHD_SelectedBay isEqualTo 5) then {_position = "fd_cargo_pos_10"};
	if (LHD_SelectedBay isEqualTo 6) then {_position = "fd_cargo_pos_9"};
	if (LHD_SelectedBay isEqualTo 7) then {_position = "fd_cargo_pos_8"};
	if (LHD_SelectedBay isEqualTo 8) then {_position = "fd_cargo_pos_5"};
	if (LHD_SelectedBay isEqualTo 9) then {_position = "fd_cargo_pos_7"};

	[lhd, _type, _position] call CUP_fnc_spawnVehicleCargo;