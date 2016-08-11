					if (Land_AwaitingPickupAssign and (alive player) and (Land_AwaitingDelivery)) then {
						private _counter = _this;
						private _cursor = 0;
						//How long has it been?
						if (_counter > 20) then {
							player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Still trying to locate aircraft for your transport request. Please Standby. Over",toUpper(callsign),callsignNo];
							private _counter = 0;
						};

						//Make sure its same task
						{
							private _CallsignArray = _x select 4;
							private _Callsign = _CallsignArray select 0;
							private _CallsignNo = _CallsignArray select 1;
							private _AirCallsign = _x select 5;

							if ((_Callsign isEqualTo callsign) and (_CallsignNo isEqualTo callsignNo)) then {
								//Have right one!
									//hint "horray!";
								//Check if been assigned
								if ((count _AirCallsign) > 0) then {
									//someone is on their way!
									Land_AwaitingPickupAssign = false;
									player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Aircraft has been found for your transport request. %3 %4 is enroute to your location. Over",toUpper(callsign),callsignNo,toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
									Land_AirPickup_marker1 setMarkerTextLocal format ["PICKUP BY %1 %2",toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
									Land_AirPickup_marker2 setMarkerTextLocal format ["DELIVERY BY %1 %2",toUpper(_AirCallsign select 0),(_AirCallsign select 1)];
								};
							};
							private _cursor = _cursor + 1;

						} forEach ATC_Tasks_Transport;
						private _counter = _counter + 1;
						sleep 1;
						_counter call airboss_fnc_land_assignpickup;
					};