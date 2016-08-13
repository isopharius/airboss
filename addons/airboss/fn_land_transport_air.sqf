//Get Variables
_vehicle = vehicle player;

_initArray = _this select 3;
_delivery = _this select 1;
_pickup = _this select 2;
_type = _initArray select 0; //0 = Inital Contact

		if (_type isEqualTo 0) exitwith {//Land base player is requesting an air pickup (Phase Zero)

				call airboss_fnc_land_RemoveActionsWatchdog;

				//Select Pickup Location
				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Air Transport Request Received. Mark pickup location through click on Map. Over",toUpper(callsign),callsignNo];
				playsound format ["watchdog_callsign_%1",callsign];sleep 0.7;
				playsound format ["watchdog_digit_%1",callsignNo];sleep 0.5;
				playsound "watchdog_word_thisis";sleep 0.4;
				playsound "watchdog_callsign_watchdog";sleep 0.9;
				playsound "watchdog_msg_transportrequest_1";sleep 4.55;
				playsound "watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				clickpickup = addMissionEventHandler ["MapSingleClick",{[0, 0, (_this select 1), [1]] spawn airboss_fnc_land_transport_air; removeMissionEventHandler ["MapSingleClick", clickpickup]}];
				//onMapSingleClick "[0,0,_pos,[1]] execVM '\airboss\fn_land_transport_air.sqf'; onMapSingleClick ''; true;";
		};

		if (_type isEqualTo 1) exitwith {//Land base player has listed location for pickup

				call airboss_fnc_land_RemoveActionsWatchdog;

				//Create Marker
				Land_AirPickup_marker1 = createMarkerLocal ["Land_AirPickup_marker1", _pickup];
				Land_AirPickup_marker1 setMarkerShapeLocal "ICON";
				Land_AirPickup_marker1 setMarkerPosLocal [(_pickup select 0),(_pickup select 1)];
				Land_AirPickup_marker1 setMarkerTypeLocal "hd_start";
				Land_AirPickup_marker1 setMarkerColorLocal "ColorGreen";
				Land_AirPickup_marker1 setMarkerTextLocal "PICKUP";

				//Confirm Pickup Location
				_mapGrid = _pickup call airboss_fnc_PosToGrid;
				_mapGridX = _mapGrid select 0;
				_mapGridY = _mapGrid select 1;

				_x1 = floor(_mapGridX / 100);
				_x2 = floor((_mapGridX - (_x1 * 100)) / 10);
				_x3 = floor(_mapGridX - (_x2 * 10) - (_x1 * 100));

				_y1 = floor(_mapGridY / 100);
				_y2 = floor((_mapGridY - (_y1 * 100)) / 10);
				_y3 = floor(_mapGridY - (_y2 * 10) - (_y1 * 100));

				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: Roger, Pickup Location confirmed as Grid Figures %1%2%3 %4%5%6. Mark delivery location through another click on Map. Over",_x1,_x2,_x3,_y1,_y2,_y3];
				playsound "watchdog_word_roger";sleep 0.5;
				playsound "watchdog_msg_transportrequest_2";sleep 1.70;
				playsound "watchdog_word_gridfigures";sleep 0.6;
				playsound format ["watchdog_digit_%1",_x1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x3];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y3];sleep 0.5;
				playsound "watchdog_msg_transportrequest_3";sleep 3;
				playsound "watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				call compile format ["clickdeliver = addMissionEventHandler ['MapSingleClick',{[0, (_this select 1), %1, [2]] spawn airboss_fnc_land_transport_air; removeMissionEventHandler ['MapSingleClick', clickdeliver]}]", _pickup];
				//onMapSingleClick format ["[0,_pos,%1,[2]] execVM '\airboss\fn_land_transport_air.sqf'; onMapSingleClick ''; true;",_pickup];
		};

		if (_type isEqualTo 2) exitwith {//Land base player has listed location for delivery

				//Create Marker
				Land_AirPickup_marker2 = createMarkerLocal ["Land_AirPickup_marker2", _delivery];
				Land_AirPickup_marker2 setMarkerShapeLocal "ICON";
				Land_AirPickup_marker2 setMarkerPosLocal [(_delivery select 0),(_delivery select 1)];
				Land_AirPickup_marker2 setMarkerTypeLocal "hd_end";
				Land_AirPickup_marker2 setMarkerColorLocal "ColorGreen";
				Land_AirPickup_marker2 setMarkerTextLocal "DELIVERY";

				//Confirm Delivery Location
				_mapGrid = _delivery call airboss_fnc_PosToGrid;
				_mapGridX = _mapGrid select 0;
				_mapGridY = _mapGrid select 1;

				_x1 = floor(_mapGridX / 100);
				_x2 = floor((_mapGridX - (_x1 * 100)) / 10);
				_x3 = floor(_mapGridX - (_x2 * 10) - (_x1 * 100));

				_y1 = floor(_mapGridY / 100);
				_y2 = floor((_mapGridY - (_y1 * 100)) / 10);
				_y3 = floor(_mapGridY - (_y2 * 10) - (_y1 * 100));

				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: Roger, Delivery Location confirmed as Grid Figures %1%2%3 %4%5%6. Advise number of passengers for pickup. Over",_x1,_x2,_x3,_y1,_y2,_y3];
				playsound "watchdog_word_roger";sleep 0.5;
				playsound "watchdog_msg_transportrequest_4";sleep 2;
				playsound "watchdog_word_gridfigures";sleep 0.6;
				playsound format ["watchdog_digit_%1",_x1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x3];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y3];sleep 0.5;
				playsound "watchdog_msg_transportrequest_5";sleep 2.35;
				playsound "watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				_cursor = 0;
				{
					_cursor = _cursor + 1;
					call compile format ["Land_RequestAirPickup_Pax%1 = player addAction ['WATCHDOG > %1 x Passenger', airboss_fnc_land_transport_air, [3,%1,%2,%3,%4], 7, false, true, '', 'true', -1];",_cursor,_pickup,_delivery,(count units group player)];
				} foreach units group player;
		};

		if (_type isEqualTo 3) exitwith {//Land base player has advised number of passengers

				_pax = _initArray select 1;
				_pickup = _initArray select 2;
				_delivery = _initArray select 3;
				_actionsRemove = _initArray select 4;

				//Remove Actions
				_cursor = 0;
				for "_i" from 1 to _actionsRemove do {
					call compile format ["player removeaction Land_RequestAirPickup_Pax%1;",_i];
				};

				//Respond to player
				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: Roger, Transport request received for %1 passengers. Standby for Confirmation. Over",_pax];
				playsound "watchdog_word_roger";sleep 0.5;
				playsound "watchdog_msg_transportrequest_6";sleep 1.9;
				playsound format ["watchdog_digit_%1",_pax];sleep 0.5;
				playsound "watchdog_word_passengers";sleep 0.8;
				playsound "watchdog_msg_transportrequest_7";sleep 2.35;
				playsound "watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				call airboss_fnc_land_baseActionsWatchdog;

				//Broadcast updated transport listing
				ATC_Tasks_Transport = ATC_Tasks_Transport + [[player,_pickup,_delivery,_pax,[Callsign,CallsignNo],[]]];
				publicVariable "ATC_Tasks_Transport";

				player removeaction Land_RequestAirPickup;
				Land_RequestAirPickup_Cancel = player addAction ["WATCHDOG > Cancel Air Transport Request", airboss_fnc_land_transport_air, [4], 19, false, true, "", "true", -1];

				Land_AwaitingPickupAssign = true;
				Land_AwaitingDelivery = true;
				_counter = 0;
				_counter call airboss_fnc_land_assignpickup;

				if (Land_AwaitingDelivery) then {
					//Heading to Waypoint
					_IsThere = false;
					call airboss_fnc_land_alivedelivery;
				};

				if (Land_AwaitingDelivery) then {
					player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Your have been delivered to your destination. WATCHDOG Out",toUpper(callsign),callsignNo];
				} else {
					player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Your cancellation has been received. WATCHDOG Out",toUpper(callsign),callsignNo];
				};

				//CLOSE TASKING COMPLETELY
				_cursor = 0;
				{
					_CallsignArray = _x select 4;
					_Callsign = _CallsignArray select 0;
					_CallsignNo = _CallsignArray select 1;
					if ((_Callsign isEqualTo callsign) and (_CallsignNo isEqualTo callsignNo)) then {
						//Have right one!
						// Publish Task Cancel
						ATC_Tasks_Transport set [_cursor,"deleteme"];
						ATC_Tasks_Transport = ATC_Tasks_Transport - ["deleteme"];
						publicVariable "ATC_Tasks_Transport";
						ATC_onTask = false;
						ATC_CancelTask = false;
						//Cleanup Task markers (For Pilots on tasks)
						deletemarkerlocal Land_AirPickup_marker1;
						deletemarkerlocal Land_AirPickup_marker2;
					};
					_cursor = _cursor + 1;
				} forEach ATC_Tasks_Transport;

				Land_AwaitingPickupAssign = false;
				Land_AwaitingDelivery = false;
				player removeaction Land_RequestAirPickup_Cancel;
				call airboss_fnc_land_RemoveActionsWatchdog;
				call airboss_fnc_land_baseActionsWatchdog;
		};

		if (_type isEqualTo 4) exitwith {
			Land_AwaitingDelivery = false;
		};