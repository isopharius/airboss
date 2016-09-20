#define ATCMAXDIGIT 60

						if (LHD_IL && !LHD_HL && Land_APproach && {(alive _vehicle)}) then {
						//Aircraft is past finals, heading into land.  Call distances.
							//Set New Distance
							_distanceA = round(position lhd distance (position _vehicle));
							_distance = round(_distanceA / 100) * 100;
							if ((_distance in LHD_FC) && {(_distance != _prevdistance)}) then {
								waitUntil{!LHD_RU};LHD_RU = true;
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
								_prevdistance = _distance;
							};

							if (!LHD_MAP && {(_distanceA <= LHD_MAD)}) then {
								//At Missed Approach Point
								LHD_MAP = true;
								waitUntil{!LHD_RU};LHD_RU = true;
								_vehicle vehicleRadio "flyco_word_missedapproachpoint";sleep 0.3;
								_vehicle vehicleRadio "flyco_word_callvisual";sleep 0.3;
								_vehicle vehicleRadio "flyco_word_checkgeardown";sleep 0.3;
								LHD_RU = false;
							};
							//Check to see if landed
							if (LHD_IL && {(speed _vehicle < 1)} && {(getPosWorld player in LHD_Deck)}) then {
								LHD_HL = true;
							};
							//hintsilent format ["%1",_distance];
							sleep 0.5;
							call airboss_fnc_atc_landingapproach;
						};