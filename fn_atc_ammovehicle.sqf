					if ((alive _vehicle) and (someammo _vehicle) and (!ATC_CancelTask)) then {
						private _cursor = _cursor + 1;
						if (_cursor isEqualTo 30) then {
							private _cursor = 0;
							createvehicle ["SmokeShellRed", _pickup, [], 0, "NONE"];
							createvehicle ["SmokeShellRed", _delivery, [], 0, "NONE"];
						};
						call airboss_fnc_atc_ammovehicle;
					};