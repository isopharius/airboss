					if (Land_AP && {(Land_AD)} && {(alive player)}) then {
						_counter = _this;
						_cursor = 0;
						//How long has it been?
						if (_counter > 20) then {
							player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Still trying to locate aircraft for your transport request. Please Standby. Over",toUpper(callsign),callsignNo];
							_counter = 0;
						};

						//Make sure its same task
						{
							_CallsignArray = _x select 4;
							_Callsign = _CallsignArray select 0;
							_CallsignNo = _CallsignArray select 1;
							_AirCallsign = _x select 5;

							if ((_Callsign isEqualTo callsign) && {(_CallsignNo isEqualTo callsignNo)}) then {
								//Have right one!
									//hint "horray!";
								//Check if been assigned
								if ((count _AirCallsign) > 0) then {
									//someone is on their way!
									Land_AP = false;
									player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Aircraft has been found for your transport request. %3 %4 is enroute to your location. Over",toUpper(callsign),callsignNo,toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
									Land_AirPickup_marker1 setMarkerTextLocal format ["PICKUP BY %1 %2",toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
									Land_AirPickup_marker2 setMarkerTextLocal format ["DELIVERY BY %1 %2",toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
								};
							};
							_cursor = _cursor + 1;

						} forEach ATC_TT;
						_counter = _counter + 1;
						sleep 1;
						_counter call airboss_fnc_land_assignpickup;
					};