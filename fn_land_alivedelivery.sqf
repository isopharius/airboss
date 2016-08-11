						if ((alive player) and (!_IsThere) and (Land_AwaitingDelivery)) then {
							//Player is in transit to location
							private _distanceR = (player distance _delivery);
							//hintSilent format ["%1m",_distanceR];
							if (_distanceR < 100) then {_IsThere = true;};
							sleep 1;
							call airboss_fnc_land_alivedelivery;
						};