		if (alive player) then {
			//init
			_vehicle = vehicle player;

			if((!isNull objectParent player) and (player isEqualTo driver _vehicle) and (_vehicle isKindOf "Air") and !(_vehicle isKindOf "ParachuteBase")) then {

				if (!acemod) then {
					player removeaction Action_ContactControl;
				} else {
					ACEActionAdded = false;
				};
				ControllerActionAdded = false;

				call airboss_fnc_land_RemoveActionsWatchdog;
				call airboss_fnc_system_vehiclealive;

				//Remove any targets
					{deleteVehicle _x} forEach LHD_TrgTargets;
					LHD_TrgTargets = [];

				//Remove from intentions
					_intention = LHD_Intention;
					_intentionArray = ATC_Intentions select _intention;
					_VehiclesArray = _intentionArray select 1;
					_VehiclesArray = _VehiclesArray - [_vehicle];
					_intentionArray set [1,_VehiclesArray];
					ATC_Intentions set [_intention,_intentionArray];
					publicVariable "ATC_Intentions";

				//Player not in vehicle any more
					LHD_ControlWarning = 0;
					ATC_ControllerActionAdded = false;
					ATC_onTask = false;
					LHD_Controlled = false;
					LHD_Intention = 0;
					call airboss_fnc_atc_removePilotActions;

			} else { //Player is not driver

				//ground action
				if (!ControllerActionAdded) then {
					if (!acemod) then {
						Action_ContactControl = player addAction ["Contact Land Controller", airboss_fnc_land_controller, [0], 7, false, true, "", "(backpack player) iskindof 'TFAR_Bag_Base'", -1];
					} else {
						ACEActionAdded = true;
					};
					ControllerActionAdded = true;
				};

				//debarkation action
				if ((!acemod) and (getPosWorld player in LHD_Location)) then {
					LHD_Action_DebarkationControl = player addAction ["Access Logistics Control", airboss_fnc_ui_debarkationControl, [], 7, false, true, "", "(LHD_radio)", -1];
					waitUntil{!(getPosWorld player in LHD_Location)};
					player removeAction LHD_Action_DebarkationControl;
				};
			};

			sleep 1;
			call airboss_fnc_system_playeralive;
		};