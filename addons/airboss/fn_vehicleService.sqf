private["_vehicle","_type"];
_vehicle = _this;

if (local _vehicle or (assignedVehicle player) isEqualTo _vehicle) then {

	player reveal _vehicle;
	_vehicle setFuel 1;
	_vehicle setDamage 0;
	_vehicle setVehicleAmmo 1;

	_type = typeOf _vehicle;
	_turretcount = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

	if (_turretcount > 0) then {
		for "_i" from 0 to (_turretcount-1) do {

			_thisturret = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;

			_mags = getArray(_thisturret >> "magazines");
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_vehicle removeMagazinesTurret [_x,[_i]];
					_removed set [count _removed,_x];
				};
			} forEach _mags;
			// Now re-add the mags

			{
				_vehicle addMagazineTurret [_x,[_i]];
			} forEach _mags;
		};
	};
};