						if ((LHD_TakeoffRequest) and (_notsafe)) then {
							_counter = _this;
							_baylist = [(LHD_BayPositions select 0),(LHD_BayPositions select 3),(LHD_BayPositions select 4),(LHD_BayPositions select 5),(LHD_BayPositions select 6),(LHD_BayPositions select 8)];
							_bay1 = (_baylist select 0) call seven_fnc_lhd_checkpos;
							_bay4 = (_baylist select 1) call seven_fnc_lhd_checkpos;
							_bay5 = (_baylist select 2) call seven_fnc_lhd_checkpos;
							_bay6 = (_baylist select 3) call seven_fnc_lhd_checkpos;
							_bay7 = (_baylist select 4) call seven_fnc_lhd_checkpos;
							_bay9 = (_baylist select 5) call seven_fnc_lhd_checkpos;

							_array = [_bay1,_bay4,_bay5,_bay6,_bay7,_bay9];

							_notsafeC = false;
							_pastveh = false;
							{
								_isSafe = _x select 0;
								_isVeh = _x select 1;
								if (!_pastveh) then {
									if (_isVeh) then {_pastveh = true;} else {
										if (!_isSafe) then {_notsafeC = true};
									};
								};
							} foreach _array;

							//hint format ["%1",_array];

							if (!_notsafeC) then {
								_notsafe = false;
							};

							if ((_deckClearFail) and (!_deckClearMsg) and (_notsafe)) then {
								waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
								_vehicle vehicleRadio "flyco_msg_takeoff_standby_plane_3";
								LHD_RadioInUse = false;
								_deckClearMsg = true;
							};

							if ((_counter > _clearDelay) and !_deckClearFail) then {
								//After this amount of time, computer will try automated clearance.
								waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
								_vehicle vehicleRadio "flyco_msg_takeoff_standby_plane_2";
								LHD_RadioInUse = false;
								sleep 3;
								_cursor = 0;
								_stopDel = false;
								{
									_arraySelect = (_array select _cursor);
									_isVeh = _arraySelect select 1;
									if (_isVeh) then {_stopDel = true;};
									if (!_stopDel) then {_x call seven_fnc_lhd_deletepos};
									_cursor = _cursor + 1;
								} foreach _baylist;
								_deckClearFail = true;
								sleep 2;
							};

							_counter = _counter + 1;
							sleep 1;
							_counter call seven_fnc_atc_safetakeoff;
						};