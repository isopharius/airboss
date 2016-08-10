//Get Variables
_vehicle = vehicle player;

	_loon1 = getPosWorld lhd;
	_loon2 = position _vehicle;
	_dir = direction _vehicle;
	_initArray = _this select 3;
	_type = _initArray select 0; //0 = Inital Contact //0 = Inital Contact, //1 = Initial Intentions set // 2 = Transfer to FLYCO // 3 = Transfer to HOMER

	if (ATC_ControllerActionAdded) then {
		LHD_Action_ContactControl = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;
	_pickup = getPosWorld player;
	_delivery = _pickup;
	_pax = 0;
	_LandCallsign = [];
	_newTask = [];
	_nearDistance = 100;
	_distanceR = 0;

		if (_type isEqualTo 0) then { // Action Transport Tasking
			_cursor = 0;

			{
				_raisedBy = _x select 0;
				_actionedBy = _x select 5;
				if (alive _raisedBy) then {
					if ((count _actionedBy isEqualTo 0) and (!ATC_onTask)) then {
						//Task has not been actioned by anyone

						player removeaction ATC_ChangeIntentions;

						// Get Variables
						ATC_CancelTask = false;

						_pickup = _x select 1;
						_delivery = _x select 2;
						_pax = _x select 3;
						_LandCallsign = _x select 4;
						_newTask = [_raisedBy,_pickup,_delivery,_pax,_LandCallsign,[ATC_callsign,ATC_callsignNo]];
						ATC_onTask = true;

						// Publish Task Taken
						ATC_Tasks_Transport set [_cursor,_newTask];
						publicVariable "ATC_Tasks_Transport";

						// Create markers
						Air_TaskMarker1 = createMarkerLocal ["Air_TaskMarker1", _pickup];
						Air_TaskMarker1 setMarkerShapeLocal "ICON";
						Air_TaskMarker1 setMarkerTypeLocal "hd_start";
						Air_TaskMarker1 setMarkerPosLocal [(_pickup select 0),(_pickup select 1)];
						Air_TaskMarker1 setMarkerColorLocal "ColorGreen";
						Air_TaskMarker1 setMarkerTextLocal format ["PICKUP : %1 %2",toUpper(_LandCallsign select 0),(_LandCallsign select 1)];

						Air_TaskMarker2 = createMarkerLocal ["Air_TaskMarker2", _delivery];
						Air_TaskMarker2 setMarkerShapeLocal "ICON";
						Air_TaskMarker2 setMarkerTypeLocal "hd_end";
						Air_TaskMarker2 setMarkerPosLocal [(_delivery select 0),(_delivery select 1)];
						Air_TaskMarker2 setMarkerColorLocal "ColorGreen";
						Air_TaskMarker2 setMarkerTextLocal format ["DROP OFF : %1 %2",toUpper(_LandCallsign select 0),(_LandCallsign select 1)];

						//Inform Pilot
						waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
						_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
						_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
						_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
						_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
						_vehicle vehicleRadio "homer_msg_transporttasking_1";sleep 3;
						_vehicle vehicleRadio "homer_word_standbyfordetails";sleep 3;
						_vehicle vehicleRadio "homer_word_proceedtoGF";sleep 1.3;

						//Reformat Pickup
						_mapGrid = _pickup call airboss_fnc_PosToGrid;
						_mapGridX = _mapGrid select 0;
						_mapGridY = _mapGrid select 1;

						_x1 = floor(_mapGridX / 100);
						_x2 = floor((_mapGridX - (_x1 * 100)) / 10);
						_x3 = floor(_mapGridX - (_x2 * 10) - (_x1 * 100));

						_y1 = floor(_mapGridY / 100);
						_y2 = floor((_mapGridY - (_y1 * 100)) / 10);
						_y3 = floor(_mapGridY - (_y2 * 10) - (_y1 * 100));

						_vehicle vehicleRadio format ["homer_digit_%1",_x1];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_x2];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_x3];sleep 1;
						_vehicle vehicleRadio format ["homer_digit_%1",_y1];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_y2];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_y3];sleep 1;

						//Give Bearing
						_loon1 = _pickup;
						_loon2 = getPosWorld _vehicle;
						_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
						_hdg = round((_hdg + 360) mod 360);

						_wD1 = floor(_hdg / 100);
						_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
						_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));
						_vehicle vehicleRadio "homer_word_bearing";sleep 0.8;
						_vehicle vehicleRadio format ["homer_digit_%1",_wD1];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_wD2];sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",_wD3];sleep 1;
						_vehicle vehicleRadio "homer_word_degrees";sleep 0.8;

						_vehicle vehicleRadio "homer_word_andpickup";sleep 0.8;
						_vehicle vehicleRadio format ["homer_callsign_%1",(_LandCallsign select 0)];
						_vehicle vehicleRadio format ["homer_digit_%1",(_LandCallsign select 1)];sleep 0.5;
						if (_pax > 1) then {
						_vehicle vehicleRadio "homer_word_with";sleep 0.5;
						_vehicle vehicleRadio format ["homer_digit_%1",(_pax - 1)];sleep 0.5;
						_vehicle vehicleRadio "homer_word_passengers";sleep 1;
						};
						_vehicle vehicleRadio "homer_word_markersplacedonmap";sleep 1;
						_vehicle vehicleRadio "homer_word_over";sleep 0.5;
						LHD_RadioInUse = false;
					};
					_cursor = _cursor + 1;
				} else {
					//The creator is dead!  Remove the tasking
					ATC_Tasks_Transport set [_cursor,"deleteme"];
					ATC_Tasks_Transport = ATC_Tasks_Transport - ["deleteme"];
					publicVariable "ATC_Tasks_Transport";
					ATC_onTask = false;
					ATC_CancelTask = false;
				};
			} foreach ATC_Tasks_Transport;

			if (ATC_onTask) then {

				ATC_Action_CancelTask = player addAction ["HOMER > Cancel Current Task", airboss_fnc_atc_tasking_transport, [1], 18, false, true, "", "true", -1];

				//Create Waypoint Pickup
				_wp1 = group player addWaypoint [_pickup, _nearDistance];
				_wp1 setWaypointType "LOAD";

				//Create Waypoint Delivery
				_wp2 = group player addWaypoint [_delivery, _nearDistance];
				_wp2 setWaypointType "TR UNLOAD";

				//Heading to Waypoint
				_distanceR = (_vehicle distance _delivery);
				_IsThere = false;

				call airboss_fnc_atc_taskalive;

				if (!ATC_CancelTask) then {
					player vehiclechat "HOMER: Units have been delivered to their location, task completed. HOMER Out";
				};

				{_x setwaypointposition [position player,0];} foreach waypoints group player;
				sleep 1;
				{deletewaypoint _x;} foreach waypoints group player;

				ATC_onTask = false;

				deletemarkerlocal Air_TaskMarker1;
				deletemarkerlocal Air_TaskMarker2;
				player removeaction ATC_Action_CancelTask;

			};

		} else { //Task Cancellation
			player removeaction ATC_Action_CancelTask;
			ATC_CancelTask = true;
			_cursor = 0;
			_raisedBy = player;
			_pickup = getPosWorld player;
			_delivery = _pickup;
			_pax = 0;
			_LandCallsign = [];
			_newTask = [];

			//REMOVE FROM TASKING
			{
				_AirCallsign2 = _x select 5;
				if (((_AirCallsign2 select 0) isEqualTo ATC_callsign) and ((_AirCallsign2 select 1) isEqualTo ATC_callsignNo)) then {
					//Have right one!
					_raisedBy = _x select 0;
					_pickup = _x select 1;
					_delivery = _x select 2;
					_pax = _x select 3;
					_LandCallsign = _x select 4;
					_newTask = [_raisedBy,_pickup,_delivery,_pax,_LandCallsign,[]];
					// Publish Task Cancel
					ATC_Tasks_Transport set [_cursor,_newTask];
					publicVariable "ATC_Tasks_Transport";
				};
				_cursor = _cursor + 1;
			} forEach ATC_Tasks_Transport;

			//ATC_onTask = false;
			deletemarkerlocal Air_TaskMarker1;
			deletemarkerlocal Air_TaskMarker2;

			player vehiclechat "HOMER: Roger, Cancellation of task received and processed. HOMER Out";
		};