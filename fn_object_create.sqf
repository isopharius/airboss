disableSerialization;
	_position = _this select 0;
	_hdg = _this select 1;
	_display = (findDisplay 50001);
	_control = (_display displayCtrl 1006);
	_index = lbCurSel _control;
	_type = _control lbData _index;

	if (LHD_SelectedBay == 1) then {_position = "fd_cargo_pos_19"};
	if (LHD_SelectedBay == 2) then {_position = "fd_cargo_pos_18"};
	if (LHD_SelectedBay == 3) then {_position = "fd_cargo_pos_14"};
	if (LHD_SelectedBay == 4) then {_position = "fd_cargo_pos_15"};
	if (LHD_SelectedBay == 5) then {_position = "fd_cargo_pos_10"};
	if (LHD_SelectedBay == 6) then {_position = "fd_cargo_pos_9"};
	if (LHD_SelectedBay == 7) then {_position = "fd_cargo_pos_8"};
	if (LHD_SelectedBay == 8) then {_position = "fd_cargo_pos_5"};
	if (LHD_SelectedBay == 9) then {_position = "fd_cargo_pos_7"};

	[lhd, _type, _position] call CUP_fnc_spawnVehicleCargo;

/*
	_vehicle = createVehicle [_type, _position, [], 0, "can_collide"];
	_vehicle setposASL [(_position select 0), (_position select 1), 17];
	_vehicle setdir _hdg;

	player reveal _vehicle;
	_vehicle allowdamage true;
*/