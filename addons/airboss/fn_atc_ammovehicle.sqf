					if ((alive _vehicle) and (someammo _vehicle) and (!ATC_CancelTask)) then {
						_cursor = _this + 1;
						if (_cursor isEqualTo 30) then {
							_cursor = 0;
							createvehicle ["SmokeShellRed", _pickup, [], 0, "NONE"];
							createvehicle ["SmokeShellRed", _delivery, [], 0, "NONE"];
						};
						_cursor call airboss_fnc_atc_ammovehicle;
					};