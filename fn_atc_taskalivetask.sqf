					if ((alive _vehicle) and (!_IsThere) and (!ATC_CancelTask)) then {
						//Player is in transit to location
						private _distanceR = (_vehicle distance _delivery);
						//hintSilent format ["%1m",_distanceR];
						if (_distanceR < _WithinRange) then {_IsThere = true;};
						sleep 1;
						call airboss_fnc_atc_taskalivetask;
					};