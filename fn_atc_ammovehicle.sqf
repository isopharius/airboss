					if ((alive _vehicle) and (someammo _vehicle) and (!ATC_CancelTask)) then {
						_cursor = _cursor + 1;
						if (_cursor isEqualTo 30) then {
							_cursor = 0;
							_smoke1 = createvehicle ["SmokeShellRed", _pickup, [], 0, "NONE"];
							_smoke2 = createvehicle ["SmokeShellRed", _delivery, [], 0, "NONE"];
						};
						call airboss_fnc_atc_ammovehicle;
					};