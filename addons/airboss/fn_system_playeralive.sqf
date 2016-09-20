		if (alive player) then {
			//init
			_vehicle = objectParent player;

			if((!isNull _vehicle) && {(player isEqualTo driver _vehicle)} && {(_vehicle isKindOf "Air")} && {!(_vehicle isKindOf "ParachuteBase")}) then {

				if (!am) then {
					player removeaction Action_ContactControl;
				} else {
					AAA = false;
				};
				CAA = false;

				call airboss_fnc_land_RemoveActionsWatchdog;
				call airboss_fnc_system_vehiclealive;

				//Remove any targets
					{deleteVehicle _x} forEach LHD_TT;
					LHD_TT = [];

				//Remove from intentions
					_intention = LHD_I;
					_intentionArray = ATC_I select _intention;
					_VehiclesArray = _intentionArray select 1;
					_VehiclesArray = _VehiclesArray - [_vehicle];
					_intentionArray set [1,_VehiclesArray];
					ATC_I set [_intention,_intentionArray];
					publicVariable "ATC_I";

				//Player not in vehicle any more
					LHD_CW = 0;
					ATC_AA = false;
					ATC_T = false;
					LHD_C = false;
					LHD_I = 0;
					call airboss_fnc_atc_removePilotActions;

			} else { //Player is not driver

				//ground action
				if (!CAA) then {
					if (!am) then {
						Action_ContactControl = player addAction ["Contact Land Controller", airboss_fnc_land_controller_contact, [0], 7, false, true, "", "(backpack player) iskindof 'TFAR_Bag_Base'", -1];
					} else {
						AAA = true;
					};
					CAA = true;
				};

				//debarkation action
				if ((!am) && {(getPosWorld player in LHD_Location)}) then {
					LHD_Action_DebarkationControl = player addAction ["Access Logistics Control", airboss_fnc_ui_debarkationControl, nil, 7, false, true, "", "true", -1];
					waitUntil{!(getPosWorld player in LHD_Location)};
					player removeAction LHD_Action_DebarkationControl;
				};
			};

			sleep 1;
			call airboss_fnc_system_playeralive;
		};
