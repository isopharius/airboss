//Script Settings
#define DIGITDELAY 0.4
#define	SENTENCEDELAY 1
#define	ATCMAXDIGIT 60

			if (Land_APproach && {!LHD_HL} && {(alive _vehicle)} && {!LHD_CL}) then {

				// ### Check for New Altitude and Position in Que ###
				_Position = LHDPattern find _vehicle;
				_oldalt = _alt;
				_alt = ((_Position) * LHDAlt) + LHDAlt; //this sets the vehicles altitude

				// ### Check if at correct altitude ###
				_curalt = position _vehicle select 2;
				if ((((_curalt < (_alt - LHD_WA)) || {( _curalt > (_alt + LHD_WA))}) && {(!LHD_IL)}) && {(_alt isEqualTo LHD_CFA)}) then {
					//At wrong altitude, get angry
					waitUntil{!LHD_RU};LHD_RU = true;
					_vehicle vehicleRadio "flyco_word_watchyouraltitude";sleep 0.9;
					_vehicle vehicleRadio "flyco_word_maintain";sleep 0.3;
					if (_alt1 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt1];sleep 0.1;};
					if (_alt2 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt2];sleep 0.1;};
					_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
					//End Transmission
					_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
					LHD_RU = false;
					sleep 5;
				};

				if (!(_alt isEqualTo LHD_CFA)) then {
					//Altitude has change, advise new change
					_oldPattern = _pattern;
					_cursor = 0;
					{
						_cursor =  _cursor + (_x select 1);
						if (((_Position) < _cursor) && {(_pattern isEqualTo _oldPattern)}) then {_pattern = _x select 0};
					} foreach LHD_PL;
					_alt1 = floor(_alt / 100) * 100;
					_alt2 = (_alt - _alt1);
					LHD_CFA = _alt;
					if (_pattern != _oldpattern) then {
						waitUntil{!LHD_RU};LHD_RU = true;
						_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
						_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 0.3;
						_vehicle vehicleRadio "flyco_word_thisis";sleep 0.1;
						_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
						_vehicle vehicleRadio "flyco_word_enter";sleep 0.3;
						_vehicle vehicleRadio format["flyco_ph_%1",_pattern];sleep 0.1;
						_vehicle vehicleRadio "flyco_word_pattern";sleep 0.8;
						if (_oldalt < _alt) then {
							//Climb
							_vehicle vehicleRadio "flyco_word_climbto";sleep 0.3;
						} else {
							//descend
							_vehicle vehicleRadio "flyco_word_descendto";sleep 0.3;
						};
						_vehicle vehicleRadio format["flyco_digit_%1",_alt1];sleep 0.1;
						if (_alt2 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt2];sleep 0.1;};
						_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
						//End Transmission
						_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
						LHD_RU = false;
					} else {
						// ALTITUDE CHANGED : NOT PATTERN THO
						waitUntil{!LHD_RU};LHD_RU = true;
						_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
						_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 0.3;
						_vehicle vehicleRadio "flyco_word_thisis";sleep 0.1;
						_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
						_vehicle vehicleRadio "flyco_word_maintain";sleep 0.3;
						_vehicle vehicleRadio format["flyco_ph_%1",_pattern];sleep 0.1;
						_vehicle vehicleRadio "flyco_word_pattern";sleep 0.8;
						if (_oldalt < _alt) then {
							//Climb
							_vehicle vehicleRadio "flyco_word_climbto";sleep 0.3;
						} else {
							//descend
							_vehicle vehicleRadio "flyco_word_descendto";sleep 0.3;
						};
						_vehicle vehicleRadio format["flyco_digit_%1",_alt1];sleep 0.1;
						if (_alt2 > 0) then {_vehicle vehicleRadio format["flyco_digit_%1",_alt2];sleep 0.1;};
						_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
						//End Transmission
						_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
						LHD_RU = false;
						//hint format ["Altitude Changed (%1,%2)",_oldPattern,_pattern];
					};
				};

				//calc heading to ship
					_loon1 = _curVector;
					_loon2 = getPosWorld player;
					_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
					_hdg = round((_hdg + 360) mod 360);

				//Calc Distance
					_distance = round((_loon1 distance _loon2) / 100) * 100;
					//hintsilent format ["%1",_distance];
				//Check if vehicle is close enough for next vector
				if ((!LHD_IL) && {(_distance < 500)}) then {
					LHD_PW = false;
					//Vehicle is close, select next waypoint
					_curVectorNum = _curVectorNum + 1;
					if (_curVectorNum > 4) then {_curVectorNum = 1};
					_curVector = markerpos format ["LHD_%1_%2",_pattern,_curVectorNum];

					//Set New position
					_loon1 =_curVector;
					_loon2 = getPosWorld player;

					//Set New Distance
					_distance = round((_curVector distance _loon2) / 100) * 100;

					//Set New Heading
					_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
					_hdg = round((_hdg + 360) mod 360);

					_wD1 = floor(_hdg / 100);
					_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
					_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

					//hint format ["%1 %2",[_wD1,_wD2,_wD3],_hdg];

					//Check if vehicle is on 3rd Waypoint of First Pattern, if so, then guide to land
					if ((_pattern isEqualTo _landingPattern) && {(_curVectorNum isEqualTo (LHD_LT + 1))}) then {
						//Set Next Waypoint
						_curVector = _finals;
						_wp = group player addWaypoint [_curVector,_nearDistance];
						LHD_IL = true;

						//In final pattern, at final turn
						waitUntil{!LHD_RU};LHD_RU = true;
						_vehicle vehicleRadio "flyco_word_thisis";sleep 0.1;
						_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
						_vehicle vehicleRadio "flyco_word_makeleftturnontobase";sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_newheading";sleep 0.4;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_youarecleartolandatbay";sleep 0.4;
						_vehicle vehicleRadio format["flyco_digit_%1",8];sleep DIGITDELAY;
						sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_missedapproachpoint";sleep 0.4;
						_vehicle vehicleRadio format["flyco_digit_%1",LHD_MAD];sleep DIGITDELAY;
						_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
						sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_ifnotinsightat";sleep 0.4;
						_vehicle vehicleRadio "flyco_word_missedapproachpoint";sleep 0.8;
						_vehicle vehicleRadio "flyco_word_vector";sleep 0.4;

						//Set MAP Heading
						_map = getdir lhd;

						_wD1 = floor(_map / 100);
						_wD2 = floor((_map - (_wD1 * 100)) / 10);
						_wD3 = floor(_map - (_wD2 * 10) - (_wD1 * 100));

						_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep DIGITDELAY;
						_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
						LHD_RU = false;
					} else {
						//Set Next Waypoint
						_wp = group player addWaypoint [_curVector, _nearDistance];
						_wp setWaypointStatements ["true", "LHD_PW = true;"];

						//Not on final waypoint, so just transmit new direction
						waitUntil{!LHD_RU};LHD_RU = true;
						_vehicle vehicleRadio "flyco_word_thisis";sleep 0.1;
						_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.3;
						_vehicle vehicleRadio "flyco_word_makeleftturn";sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_newheading";sleep 0.4;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
						_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep DIGITDELAY;
						sleep SENTENCEDELAY;
						if (_distance < (ATCMAXDIGIT * 1000)) then {
							if (_distance < 1000) then {
							//Under a kilometer, report in meters
								_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
								_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
							} else {
							//Over a kilometer
								_distance = floor(_distance / 1000);
								_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
								if (_distance isEqualTo 1) then {
									_vehicle vehicleRadio "flyco_word_kilometer";sleep 0.3;
								} else {
									_vehicle vehicleRadio "flyco_word_kilometers";sleep 0.3;
								};
							};
						};
						_vehicle vehicleRadio "flyco_word_tillnextturn";sleep 0.3;
						sleep SENTENCEDELAY;
						_vehicle vehicleRadio "flyco_word_over";sleep 0.3;
						LHD_RU = false;
					};
				};

					//Set New position
					_loon1 = _curVector;
					_loon2 = getPosWorld player;

					//Set New Distance
					_distance = round((_curVector distance (getPosWorld _vehicle)) / 100) * 100;

				if ((LHD_IL) and {(_distance < 400)}) then {
					LHD_OF = true;
					//Is at gate, advise
					_loon1 = getPosWorld lhd;
					_loon2 = getPosWorld player;
					//Set New Heading
					_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
					_hdg = round((_hdg + 360) mod 360);

					_wD1 = floor(_hdg / 100);
					_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
					_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

					//Set New Distance
					_distance = round((_loon1 distance _loon2) / 100) * 100;

					_wp = group player addWaypoint [_loon1,_nearDistance];

					waitUntil{!LHD_RU};LHD_RU = true;
					_vehicle vehicleRadio "flyco_word_atthegate";sleep 0.8;
					_vehicle vehicleRadio "flyco_word_reducespeed";sleep 0.3;
					_vehicle vehicleRadio "flyco_word_vector";sleep 0.4;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep DIGITDELAY;
					sleep SENTENCEDELAY;
					if (_distance < (ATCMAXDIGIT * 1000)) then {
						if (_distance < 1000) then {
						//Under a kilometer, report in meters
							_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
							_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
						} else {
						//Over a kilometer
							_distance = floor(_distance / 1000);
							_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
							if (_distance isEqualTo 1) then {
								_vehicle vehicleRadio "flyco_word_kilometer";sleep 0.3;
							} else {
								_vehicle vehicleRadio "flyco_word_kilometers";sleep 0.3;
							};
						};
					};
					LHD_RU = false;

					call airboss_fnc_atc_landingapproach;
				};
				sleep 1;
				call airboss_fnc_atc_aliveapproach;
			};
