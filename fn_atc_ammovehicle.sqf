					if ((alive _vehicle) and (someammo _vehicle) and (!ATC_CancelTask)) then {
						_cursor = _cursor + 1;
						if (_cursor == 30) then {
							_cursor = 0;
							_smoke1 = "SmokeShellRed" createvehicle _pickup;
							_smoke2 = "SmokeShellRed" createvehicle _delivery;
						};
						call airboss_fnc_atc_ammovehicle;
					};