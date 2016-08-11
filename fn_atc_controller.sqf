//Get Variables
_vehicle = vehicle player;

	_loon1 = getPosWorld lhd;
	_loon2 = getPosWorld _vehicle;
	_dir = direction _vehicle;

	_type = 0;
	if ((count _this) > 1) then {
		_initArray = _this select 3;
		_type = _initArray select 0;
	};

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;

		if (_type isEqualTo 0) exitwith {//Player is making initial contact with controller, assign callsign
			//Variable Reset
				LHD_Intention = 0; //Reset intentions, god knows what happened to the last vehicle player was in
				_cursor = 0;
				_typeOf = TypeOf _vehicle;

			_callsignNo = 0;

			{
				_arrayCallsign = _x select 0;
				_arrayKindOf = _x select 1;
				if (_vehicle isKindOf _arrayKindOf) then {
					//Vehicle qualifies for Callsign
					_callsignNo = _cursor;
				};
				_cursor =  _cursor + 1;
			} foreach ATC_Callsigns;

				_callsignArray = ATC_Callsigns select _callsignNo;

				if (_vehicle in (_callsignArray select 2)) then {
					//Vehicle is already assigned a callsign
					ATC_callsign = _callsignArray select 0;
					_callsignPos = (_callsignArray find _vehicle) + 1;
				} else {
					//Assign vehicle a new callsign
					ATC_callsign = _callsignArray select 0;
					_callsignVehicles = _callsignArray select 2;
					_callsignPos = (count _callsignVehicles);
					ATC_callsignNo = _callsignPos + 1;
					_callsignVehicles pushback _vehicle;
					_callsignArrayNew = [(_callsignArray select 0),(_callsignArray select 1),_callsignVehicles];
					ATC_Callsigns set [_callsignNo,_callsignArrayNew];
					publicVariable "ATC_Callsigns";
				};

			LHD_Controlled = true; //Vehicle is now controlled

			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "homer_msg_greeting_1";sleep 0.1;
			_vehicle vehicleRadio "homer_msg_greeting_2";sleep 0.1;
			_vehicle vehicleRadio "homer_msg_callsignassign_1";sleep 0.1;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;

			_isOnDeck = getPosWorld _vehicle in LHD_Deck;

			//if player on deck, transfer to FLYCO
			if (!_isOnDeck) then {
				_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
				_vehicle vehicleRadio "homer_word_over";sleep 0.1;
				LHD_RadioInUse = false;
				_cursor = 0;
				{
					if (_cursor > 0) then {
						call compile format ["ATC_Intention_Orders%1 = player addAction ['HOMER > Intention: %2', airboss_fnc_atc_controller, [1,%1], 20, false, true, '', '(LHD_radio)', -1];",_cursor,(_x select 0)];
					};
					_cursor = _cursor + 1;
				} foreach ATC_Intentions;
			} else {
				_vehicle vehicleRadio "homer_msg_greeting_3";sleep 0.1;
				_vehicle vehicleRadio "homer_callsign_homer";sleep 0.1;
				_vehicle vehicleRadio "homer_word_out";sleep 0.1;
				LHD_RadioInUse = false;

				call airboss_fnc_atc_baseActionsHomer;
			};

			//spawn controller monitor
			_ControlerVM = call airboss_fnc_system_atccontroller;
		};

		if (_type isEqualTo 1) exitwith {//Player has advised new intention
			_intention = _initArray select 1;
			_intentionArray = ATC_Intentions select _intention;
			_VehiclesArray = _intentionArray select 1;
			_VehiclesArray pushback _vehicle;
			_NewATC_Intentions = ATC_Intentions;

			//Remove any old intentions for the vehicle
			_cursor = 0;
			{
				//Cycle through intention listings and make sure vehicle is removed
				_intentionChange = _x;
				_VehiclesChange = _intentionChange select 1;
				if (_vehicle in _VehiclesChange) then {
					_VehiclesChange = _VehiclesChange - [_vehicle];
					_intentionChange set [1,_VehiclesChange];
				};
				_NewATC_Intentions set [_cursor,_intentionChange];
				_cursor = _cursor + 1;
			} foreach ATC_Intentions;

			//hint format ["%1",_NewATC_Intentions];

			//Set Intentions and publish
			LHD_Intention = _intention;
			_intentionArray set [1,_VehiclesArray];
			ATC_Intentions set [_intention,_intentionArray];
			publicVariable "ATC_Intentions";

			_intentionWord = _intentionArray select 2;

			//Remove Actions
			_cursor = 0;
			{
				if (_cursor > 0) then {
					call compile format ["player removeaction ATC_Intention_Orders%1;",_cursor];
				};
				_cursor = _cursor + 1;
			} foreach ATC_Intentions;

			//Radio Received
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "homer_word_roger";sleep 0.5;
			_vehicle vehicleRadio "homer_word_intentionsconfirmedas";sleep 1;
			_vehicle vehicleRadio format ["homer_status_%1",_intentionWord];sleep 2;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.1;
			_vehicle vehicleRadio "homer_word_out";sleep 0.1;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_baseActionsHomer;
		};

		if (_type isEqualTo 2) exitwith {//Player requested transfer to FLYCO
			//Remove Actions
			player removeaction ATC_TransferToFlyco;
			player removeaction ATC_ChangeIntentions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_removePilotActions;
			call airboss_fnc_atc_baseActionsFlyco;
		};

		if (_type isEqualTo 3) exitwith {
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			//Initial Message
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_goahead";sleep 0.5;
			_vehicle vehicleRadio "homer_word_over";sleep 0.5;
			LHD_RadioInUse = false;

			call airboss_fnc_atc_baseActionsHomer;
		};

		if (_type isEqualTo 4) exitwith {//Player is changing their intentions
			LHD_Controlled = true; //Vehicle is now controlled (just in case!)
			//Remove Actions
			call airboss_fnc_atc_removePilotActions;

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_adviseyourintentions";sleep 0.3;
			_vehicle vehicleRadio "homer_word_over";sleep 0.1;
			LHD_RadioInUse = false;

			_cursor = 0;
			{
				if (_cursor > 0) then {
					call compile format ["ATC_Intention_Orders%1 = player addAction ['HOMER > Intention: %2', airboss_fnc_atc_controller, [1,%1], 7, false, true, '', '(LHD_radio)', -1];",_cursor,(_x select 0)];
				};
				_cursor = _cursor + 1;
			} foreach ATC_Intentions;
		};

		if (_type isEqualTo 5) exitwith {//Player has requested an air situation report

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "homer_msg_airsitrep_1";sleep 2.5;
			_counter = 0;
			{
				//Go through each intention set
				_numAircraft = count (_x select 1);
				_type = _x select 2;
				if (_numAircraft > 0) then {
					_counter = _counter + 1;
					//declare status
					_vehicle vehicleRadio format ["homer_digit_%1",_numAircraft];
					_vehicle vehicleRadio "homer_vehicle_aircraft"; sleep 0.5;
					_vehicle vehicleRadio "homer_word_registeredfor"; sleep 0.5;
					_vehicle vehicleRadio format ["homer_status_%1",_type];sleep 2;
					_vehicle vehicleRadio "homer_word_duties"; sleep 0.5;
				};
			} foreach ATC_Intentions;
			if (_counter isEqualTo 0) then {
				_vehicle vehicleRadio "homer_msg_airsitrep_2"; sleep 1;
			};
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_out";sleep 0.1;
			LHD_RadioInUse = false;
		};

		if (_type isEqualTo 6) exitwith {//Player has requested a traffic pattern report
			//Load in pattern Information
			_numPatterns = count LHDPatternLayout;
			_inPattern = count LHDPattern;
			_remainPattern = _inPattern;
			_maxVehicles = 0;
			{_maxVehicles = _maxVehicles + (_x select 1)} foreach LHDPatternLayout;
			_cursor = _inPattern;
			_patternMaxNo = 0;
			_patternName = "alpha";
			_pos = 0;

			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_trafficsitrep_1";sleep 2;
			if (_inPattern > 0) then {
				{
					_patternName = _x select 0;
					_patternMaxNo = _x select 1;
					_remainPattern = _remainPattern - _patternMaxNo;
					_cursor = _patternMaxNo;
					if (_remainPattern < 0) then {
						_cursor = _cursor + _remainPattern;
						_remainPattern = 0;
					};

					_vehicle vehicleRadio format ["flyco_digit_%1",_cursor];
					_vehicle vehicleRadio "flyco_vehicle_aircraft"; sleep 0.5;
					_vehicle vehicleRadio format ["flyco_ph_%1",_patternName];sleep 1;
				} foreach LHDPatternLayout;

				if (_vehicle in LHDPattern) then {
					_pos = (LHDPattern find _vehicle) + 1;
					_vehicle vehicleRadio "flyco_msg_trafficsitrep_2";sleep 0.3;
					_vehicle vehicleRadio format ["flyco_digit_%1",_pos];
					_vehicle vehicleRadio "flyco_word_outof";sleep 0.3;
					_vehicle vehicleRadio format ["flyco_digit_%1",_inPattern];
					_vehicle vehicleRadio "flyco_msg_trafficsitrep_3";sleep 2;
				};
			} else {
				_vehicle vehicleRadio "flyco_msg_trafficsitrep_4";sleep 1;
			};
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.1;
			LHD_RadioInUse = false;
		};
/*
		if (_type isEqualTo 7) exitwith {//Request an aerial training target
			//Pick a target start
			_numTargets = count LHD_TrainingTargetMarkers;
			_tgtNum = floor(random _numTargets);
			_targetPos = LHD_TrainingTargetMarkers select _tgtNum;
			_targetType = _initArray select 1;
			_class = "TargetDrone";
			if(_targetType isEqualTo "ground") then {
				_class = "TargetTank";
			} else {
				_class = "TargetDrone";
			};

			//create the target
			_target = createVehicle [_class, _targetPos, [], 0, "FLY"];
			if(_targetType isEqualTo "aerial") then {
				_group = creategroup East;
				_unit =  _group createUnit ["RU_Soldier_Pilot", _targetPos, [], 0, "NONE"];
				removeallweapons _unit;
				_unit assignAsDriver _target;
				_unit moveinDriver _target;
				_wp = _group addWaypoint [_targetPos, 10];
				_wp setWaypointType "HOLD";
			};
			LHD_TrgTargets pushback _target;

			//add watch to the target
			//_eh = _target addEventHandler ["killed", {}];

			//Calc pos
			_loon1 = _targetPos;

			//calc heading to ship
			_hdg = ((_loon1 Select 0) - (_loon2 Select 0)) ATan2 ((_loon1 Select 1) - (_loon2 Select 1));
			_hdg = (_hdg + 360) mod 360;

			_clock = (_hdg) - (_dir);
			_clock = (_clock + 360) mod 360;
			_clock = round(_clock / 30);
			if (_clock isEqualTo 0) then {_clock = 12};
			_wD1 = floor(_hdg / 100);
			_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
			_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));
			_distance = round((_loon1 distance _loon2) / 100) * 100;

			//advise target location
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format["homer_msg_training_%1_1",_targetType];sleep _sentenceDelay;
			_vehicle vehicleRadio "homer_msg_vectortotarget";sleep _sentenceDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD1];sleep _digitDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD2];sleep _digitDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD3];sleep _digitDelay;
			_vehicle vehicleRadio "homer_word_degrees";sleep _sentenceDelay;

			if (_distance < (ATC_maxDigit * 1000)) then {
				if (_distance < 1000) then {
				//Under a kilometer, report in meters
					_vehicle vehicleRadio format["homer_digit_%1",_distance];sleep 0.4;
					_vehicle vehicleRadio "homer_word_meters";sleep 0.3;
				} else {
				//Over a kilometer
					_distance = floor(_distance / 1000);
					_vehicle vehicleRadio format["homer_digit_%1",_distance];sleep 0.4;
					if (_distance isEqualTo 1) then {
						_vehicle vehicleRadio "homer_word_kilometer";sleep 0.3;
					} else {
						_vehicle vehicleRadio "homer_word_kilometers";sleep 0.3;
					};
				};
			};
			_vehicle vehicleRadio "homer_word_fromyourposition";sleep 1.1;

			//End Transmission
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_out";sleep 0.3;
			LHD_RadioInUse = false;

			//Wait
			_alivetarget = {
				if (alive _target) then {
					sleep 2;
					call _alivetarget;
				};
			};
			call _alivetarget;

			//advise success
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["homer_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["homer_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "homer_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_msg_targetdestroyed";sleep 0.5;
			//End Transmission
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_out";sleep 0.3;
			LHD_RadioInUse = false;

			//dispose of vehicle
			sleep 30;
			deletevehicle _unit;
			deletevehicle _target;
		};

		if (_type isEqualTo 8) exitwith {//Load Cargo
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_cargoload_1";sleep 0.3;
			LHD_RadioInUse = false;

			if ((_vehicle isKindof "MV22") or (_vehicle isKindof "C130J_base")) then {
			_vehicle animate ["ramp_top", 1];
			_vehicle animate ["ramp_bottom", 1];
			};

			//Wait
			_rnd = floor(random 5) + 15;
			sleep _rnd;

			//ok
			_vehicle call fnc_LHD_VehicleLoad;
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_msg_cargoload_2";sleep 0.5;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHD_RadioInUse = false;
			if ((_vehicle isKindof "MV22") or (_vehicle isKindof "C130J_base")) then {
				_vehicle animate ["ramp_top", 0];
				_vehicle animate ["ramp_bottom", 0];
			};
			_spawnMe = [_vehicle,player] call airboss_fnc_system_cargodrop;
		};
*/

		if (_type isEqualTo 9) exitwith {//Cancel targets
			//acknowledge player
			//delete targets
			{deleteVehicle _x} forEach LHD_TrgTargets;
			LHD_TrgTargets = [];
		};
		if (_type isEqualTo 10) exitwith {//Request Vector
			//Calc pos
			_loon1 = LHD_TrgTargets select 0;
			_clock = (_hdg) - (_dir);
			_clock = (_clock + 360) mod 360;
			_clock = round(_clock / 30);
			if (_clock isEqualTo 0) then {_clock = 12};
			_wD1 = floor(_hdg / 100);
			_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
			_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));
			_distance = round((_loon1 distance _loon2) / 100) * 100;

			//advise target location
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "homer_word_roger";sleep _sentenceDelay;
			_vehicle vehicleRadio "homer_msg_vectortotarget";sleep _sentenceDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD1];sleep _digitDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD2];sleep _digitDelay;
			_vehicle vehicleRadio format["homer_digit_%1",_wD3];sleep _digitDelay;
			_vehicle vehicleRadio "homer_word_degrees";sleep _sentenceDelay;

			if (_distance < (ATC_maxDigit * 1000)) then {
				if (_distance < 1000) then {
				//Under a kilometer, report in meters
					_vehicle vehicleRadio format["homer_digit_%1",_distance];sleep 0.4;
					_vehicle vehicleRadio "homer_word_meters";sleep 0.3;
				} else {
				//Over a kilometer
					_distance = floor(_distance / 1000);
					_vehicle vehicleRadio format["homer_digit_%1",_distance];sleep 0.4;
					if (_distance isEqualTo 1) then {
						_vehicle vehicleRadio "homer_word_kilometer";sleep 0.3;
					} else {
						_vehicle vehicleRadio "homer_word_kilometers";sleep 0.3;
					};
				};
			};
			_vehicle vehicleRadio "homer_word_fromyourposition";sleep 1.1;

			//End Transmission
			_vehicle vehicleRadio "homer_callsign_homer";sleep 0.5;
			_vehicle vehicleRadio "homer_word_out";sleep 0.3;
			LHD_RadioInUse = false;
		};
		if (_type isEqualTo 11) exitwith {//Service Aircraft
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_1";sleep 0.3;
			LHD_RadioInUse = false;

			//Wait
			_rnd = floor(random 5) + 15;
			sleep _rnd;

			//ok
			_vehicle call airboss_fnc_VehicleService;
			waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
			_vehicle vehicleRadio format ["flyco_callsign_%1",ATC_callsign];
			_vehicle vehicleRadio format ["flyco_digit_%1",ATC_callsignNo];sleep 0.5;
			_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_msg_vehicleservice_2";sleep 0.5;
			_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.5;
			_vehicle vehicleRadio "flyco_word_out";sleep 0.3;
			LHD_RadioInUse = false;
		};