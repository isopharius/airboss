					if ((alive _vehicle) and (!_IsThere) and (!ATC_CancelTask)) then {
						//Player is in transit to location
						_distanceR = (_vehicle distance _delivery);
						//hintSilent format ["%1m",_distanceR];
						if (_distanceR < 100) then {_IsThere = true;};
						//sleep 1;
						call airboss_fnc_atc_taskalive;
					};