//Get Variables
_vehicle = vehicle player;

	if (ATC_ControllerActionAdded) then {
		ATC_ControllerActionAdded = false;
		if (!acemod) then {
			player removeaction LHD_Action_ContactControl;
		};
	};

//Player has advised new intention
			_intention = (_this select 3) select 1;
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