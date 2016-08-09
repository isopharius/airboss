		if (LHD_TakeoffRequest and (alive _vehicle)) then {
			_Position = LHDPattern find _vehicle;
			if ((_Position == 1) and !LHD_TakeoffStandby) then {
			//Aircraft is next vehicle, get them to prepare
				LHD_TakeoffStandby = true;
				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				_vehicle vehicleRadio "flyco_msg_takeoff_standby";sleep 0.3;
				_vehicle vehicleRadio "flyco_word_over";sleep 0.8;
				LHD_RadioInUse = false;
			};
			if (_Position == 0) then {
				//Direct departure, no traffic

				if (_vehicle iskindof "Plane") then { // This section checks if the main bays are free, it will wait until they are before proceeding
					_sirenVM = [0] call airboss_fnc_lhdsiren;
					waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
					_vehicle vehicleRadio "flyco_msg_takeoff_standby_plane";
					LHD_RadioInUse = false;

					sleep 3;
					_notsafe = true;
					_counter = 0;
					_deckClearFail = false;
					_deckClearMsg = false;

					_saferequest = {
						if ((LHD_TakeoffRequest) and (_notsafe)) then {
							_baylist = [(LHD_BayPositions select 0),(LHD_BayPositions select 3),(LHD_BayPositions select 4),(LHD_BayPositions select 5),(LHD_BayPositions select 6),(LHD_BayPositions select 8)];
							_bay1 = (_baylist select 0) call fnc_LHD_checkpos;
							_bay4 = (_baylist select 1) call fnc_LHD_checkpos;
							_bay5 = (_baylist select 2) call fnc_LHD_checkpos;
							_bay6 = (_baylist select 3) call fnc_LHD_checkpos;
							_bay7 = (_baylist select 4) call fnc_LHD_checkpos;
							_bay9 = (_baylist select 5) call fnc_LHD_checkpos;

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
									_isSafe = _arraySelect select 0;
									_isVeh = _arraySelect select 1;
									if (_isVeh) then {_stopDel = true;};
									if (!_stopDel) then {_x call fnc_LHD_deletepos};
									_cursor = _cursor + 1;
								} foreach _baylist;
								_deckClearFail = true;
								sleep 2;
							};

							_counter = _counter + 1;
							sleep 1;
							call _saferequest;
						};
					};
					call _saferequest;

				} else {
					_sirenVM = [1] call airboss_fnc_lhdsiren;
				};

				//Set New Heading
				_hdg = getdir lhd;

				_wD1 = floor(_hdg / 100);
				_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
				_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

				if (LHD_TakeoffRequest) then {
					waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
					_vehicle vehicleRadio format["flyco_callsign_%1",ATC_callsign];
					_vehicle vehicleRadio format["flyco_digit_%1",ATC_callsignNo];sleep 0.3;
					_vehicle vehicleRadio "flyco_msg_takeoff_depart_1";sleep _sentenceDelay;
					_vehicle vehicleRadio "flyco_word_vector";sleep 0.4;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep _digitDelay;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep _digitDelay;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep _digitDelay;
					sleep _sentenceDelay;
					_vehicle vehicleRadio "flyco_word_altitude";sleep 0.4;
					_vehicle vehicleRadio format["flyco_digit_%1",LHDAlt];sleep _digitDelay;
					_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
					sleep _sentenceDelay;
					_vehicle vehicleRadio "flyco_msg_takeoff_depart_2";sleep _sentenceDelay;
					_vehicle vehicleRadio "flyco_word_over";sleep 0.8;
					LHD_RadioInUse = false;
					LHD_TakeoffRequest = false;
					LHD_Takeoff = true;
				};
			};
			sleep 0.5;
			call airboss_fnc_atc_alivetakeoff;
		};