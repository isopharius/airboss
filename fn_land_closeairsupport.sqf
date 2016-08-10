//Get Variables
_vehicle = vehicle player;


	_initArray = _this select 3;
	_delivery = _this select 1;
	_pickup = _this select 2;
	_type = _initArray select 0; //0 = Inital Contact

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;

		if (_type isEqualTo 0) exitwith {//Land base player is requesting an air pickup (Phase Zero)

				call airboss_fnc_land_RemoveActionsWatchdog;

				//Select Pickup Location
				player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. air strike request initiated. Mark start and finish locations through click on map. Over",toUpper(callsign),callsignNo];

				onMapSingleClick "[0,0,_pos,[1]] execVM '\airboss\fn_land_closeairsupport.sqf'; onMapSingleClick ''; true;";
		};
		if (_type isEqualTo 1) exitwith {//Land base player has listed location for pickup

				call airboss_fnc_land_RemoveActionsWatchdog;

				//Create Marker
				Land_CloseAirSupport_marker1 = createMarkerLocal ["Land_CloseAirSupport_marker1", _pickup];
				Land_CloseAirSupport_marker1 setMarkerShapeLocal "ICON";
				Land_CloseAirSupport_marker1 setMarkerPosLocal [(_pickup select 0),(_pickup select 1)];
				Land_CloseAirSupport_marker1 setMarkerTypeLocal "mil_dot";
				Land_CloseAirSupport_marker1 setMarkerColorLocal "ColorRed";
				Land_CloseAirSupport_marker1 setMarkerTextLocal "STRIKE START";

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

				onMapSingleClick format ["[0,_pos,%1,[2]] execVM '\airboss\fn_land_closeairsupport.sqf'; onMapSingleClick ''; true;",_pickup];
		};
		if (_type isEqualTo 2) exitwith {//Land base player has listed location for delivery

				//Create Marker
				Land_CloseAirSupport_marker2 = createMarkerLocal ["Land_CloseAirSupport_marker2", _delivery];
				Land_CloseAirSupport_marker2 setMarkerShapeLocal "ICON";
				Land_CloseAirSupport_marker2 setMarkerPosLocal [(_delivery select 0),(_delivery select 1)];
				Land_CloseAirSupport_marker2 setMarkerTypeLocal "mil_dot";
				Land_CloseAirSupport_marker2 setMarkerColorLocal "ColorRed";
				Land_CloseAirSupport_marker2 setMarkerTextLocal "STRIKE END";

				//Orientate Markers
				_loon1 = markerpos Land_CloseAirSupport_marker1;
				_loon2 = markerpos Land_CloseAirSupport_marker2;
				_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
				_hdg = ((_hdg + 360) mod 360) + 180;

				Land_CloseAirSupport_marker2 setMarkerTypeLocal "mil_arrow";
				Land_CloseAirSupport_marker1 setMarkerTypeLocal "mil_arrow";
				Land_CloseAirSupport_marker1 setMarkerDirLocal _hdg;
				Land_CloseAirSupport_marker2 setMarkerDirLocal _hdg;

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

				player groupchat format["WATCHDOG: Roger, Fire Location start at Grid Figures %1%2%3 %4%5%6. Confirm Request. Over",_x1,_x2,_x3,_y1,_y2,_y3];

				call compile format ["Land_RequestCAS_Confirm = player addAction ['WATCHDOG > Confirm Request', airboss_fnc_land_closeairsupport, [3,%1,%2,True], 8, false, true, '', 'true', -1];",_pickup,_delivery];
				call compile format ["Land_RequestCAS_Cancel = player addAction ['WATCHDOG > Cancel Request', airboss_fnc_land_closeairsupport, [3,%1,%2,false], 7, false, true, '', 'true', -1];",_pickup,_delivery];
		};
		if (_type isEqualTo 3) exitwith {//Land base player has confirmed target

			_confirm = _initArray select 3;
				if (_confirm) then {
					_pickup = _initArray select 1;
					_delivery = _initArray select 2;

					//Remove Actions
					player removeAction Land_RequestCAS_Confirm;
					player removeAction Land_RequestCAS_Cancel;

					//Respond to player
					player groupchat "WATCHDOG: Roger, air strike request received. Standby for Confirmation. Over";

					call airboss_fnc_land_baseActionsWatchdog;

					//Broadcast updated transport listing
					ATC_Tasks_CloseAirSupport = ATC_Tasks_CloseAirSupport + [[player,_pickup,_delivery,_pax,[Callsign,CallsignNo],[]]];
					publicVariable "ATC_Tasks_CloseAirSupport";

					player removeaction Land_RequestCAS;
					Land_RequestCloseAirSupport_Cancel = player addAction ["WATCHDOG > Cancel Air Strike", airboss_fnc_land_closeairsupport, [4], 19, false, true, "", "true", -1];

					Land_AwaitingCASAssign = true;
					_counter = 0;

					Land_AwaitingCASRun = true;
					call airboss_fnc_land_cascallsign;

					if (Land_AwaitingCASRun) then {
						//Heading to Waypoint
						_distanceR = (player distance _delivery);
						_IsThere = false;

						call airboss_fnc_land_aliveplayer;
					};

					if (Land_AwaitingCASRun) then {
						player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Attack Complete. WATCHDOG Out",toUpper(callsign),callsignNo];
					} else {
						player groupchat format["WATCHDOG: %1 %2. This is WATCHDOG. Your cancellation has been received. WATCHDOG Out",toUpper(callsign),callsignNo];
					};

						deletemarkerlocal Land_CloseAirSupport_marker1;
						deletemarkerlocal Land_CloseAirSupport_marker2;


					//CLOSE TASKING COMPLETELY
					_cursor = 0;
					{
						_CallsignArray = _x select 4;
						_Callsign = _CallsignArray select 0;
						_CallsignNo = _CallsignArray select 1;
						if ((_Callsign isEqualTo callsign) and (_CallsignNo isEqualTo callsignNo)) then {
							//Have right one!
							// Publish Task Cancel
							ATC_Tasks_CloseAirSupport set [_cursor,"deleteme"];
							ATC_Tasks_CloseAirSupport = ATC_Tasks_CloseAirSupport - ["deleteme"];
							publicVariable "ATC_Tasks_CloseAirSupport";
							ATC_onTask = false;
							ATC_CancelTask = false;
							//Cleanup Task markers (For Pilots on tasks)
							deletemarkerlocal Land_CloseAirSupport_marker1;
							deletemarkerlocal Land_CloseAirSupport_marker2;
						};
						_cursor = _cursor + 1;
					} forEach ATC_Tasks_CloseAirSupport;

					Land_AwaitingCASAssign = false;
					Land_AwaitingCASRun = false;
					player removeaction Land_RequestCloseAirSupport_Cancel;
					call airboss_fnc_land_RemoveActionsWatchdog;
					call airboss_fnc_land_baseActionsWatchdog;
				} else {
					player groupchat format["WATCHDOG: %1 %2. Roger, air strike request cancelled. WATCHDOG Out",toUpper(callsign),callsignNo];
					Land_AwaitingCASAssign = false;
					Land_AwaitingCASRun = false;
					player removeAction Land_RequestCAS_Confirm;
					player removeAction Land_RequestCAS_Cancel;
					call airboss_fnc_land_RemoveActionsWatchdog;
					call airboss_fnc_land_baseActionsWatchdog;
					deletemarkerlocal Land_CloseAirSupport_marker1;
					deletemarkerlocal Land_CloseAirSupport_marker2;
				};
		};
		if (_type isEqualTo 4) exitwith {
			Land_AwaitingCASAssign = false;
			Land_AwaitingCASRun = false;
		};