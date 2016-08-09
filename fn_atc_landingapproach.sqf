						if (LHD_IsLanding and !LHD_HasLanded and LHD_Approach and (alive _vehicle)) then {
						//Aircraft is past finals, heading into land.  Call distances.
							//Set New Distance
							_distanceA = round(position lhd distance (position _vehicle));
							_distance = round(_distanceA / 100) * 100;
							if ((_distance in LHD_FinalCall) and (_distance != _prevdistance)) then {
								waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
								if (_distance < (ATC_maxDigit * 1000)) then {
									if (_distance < 1000) then {
									//Under a kilometer, report in meters
										_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
										_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
									} else {
									//Over a kilometer
										_distance = floor(_distance / 1000);
										_vehicle vehicleRadio format["flyco_digit_%1",_distance];sleep 0.4;
										if (_distance == 1) then {
											_vehicle vehicleRadio "flyco_word_kilometer";sleep 0.3;
										} else {
											_vehicle vehicleRadio "flyco_word_kilometers";sleep 0.3;
										};
									};
								};
								LHD_RadioInUse = false;
								_prevdistance = _distance;
							};

							if ((_distanceA <= LHD_MissedApproach_Dis) and !LHD_AtMAP) then {
								//At Missed Approach Point
								LHD_AtMAP = true;
								waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
								_vehicle vehicleRadio "flyco_word_missedapproachpoint";sleep 0.3;
								_vehicle vehicleRadio "flyco_word_callvisual";sleep 0.3;
								_vehicle vehicleRadio "flyco_word_checkgeardown";sleep 0.3;
								LHD_RadioInUse = false;
							};
							//Check to see if landed
							_vehpos = getPosASL _vehicle;
							if ((speed _vehicle < 1) and (getPos player in LHD_Deck) and LHD_IsLanding) then {
								LHD_HasLanded = true;
							};
							//hintsilent format ["%1",_distance];
							sleep 0.5;
							call airboss_fnc_atc_landingapproach;
						};