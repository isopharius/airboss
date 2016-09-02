if ((!isnil "lhd") or isHC) exitwith {};

lhd = _this select 0;
_lhdpos = position lhd;

//add respawn at box
if (isserver) then {
	_crate = createvehicle ["B_CargoNet_01_ammo_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    _crate enableSimulation false;
	_crate allowdamage false;
	_crate setposasl [(_lhdpos select 0) + 7, (_lhdpos select 1) - 15, 16.9];
	[missionnamespace, _crate, "USX Syed"] call BIS_fnc_addRespawnPosition;
};

if (!isdedicated) then {

	_lhddir = getdir lhd;

	//Land Variables
		Bases = [];
		BaseNames = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel"];

		//Task Oriented Variables
		Land_AwaitingPickupAssign = false;
		Land_AwaitingDelivery = false;

		Land_AwaitingCASAssign = false;
		Land_AwaitingCASRun = false;

		//Controller Variables
		Controlled = false;
		callsign = "sunray";
		callsignNo = 1;
		Callsigns = [
			// --- Soldiers ---
			["firefly","Man",[]]
		];

	//LHD Variables
	/*
		MapY = 5120;
		call {
			if (worldname isEqualTo "Altis") exitwith { MapY = 40000 };
			if (worldname isEqualTo "pja306") exitwith { MapY = 20480 };
			if (worldname isEqualTo "chernarus") exitwith { MapY = 20480 };
			if (worldname isEqualTo "Napf") exitwith { MapY = 20480 };
			if (worldname isEqualTo "stratis") exitwith { MapY = 10200 };
		};
	*/
		LHDAlive = true;
		LHDPattern = [];
		LHDPatternLayout = [["Charlie",1,500,800],["Delta",4,850,1200]]; //[Name,Positions,xRadius,yRadius]
		LHD_ControlRadius = [1000,1500];
		LHD_RestrictedRadius = [2500,2500];
		LHDLandingTurnNum = 3;
		LHDAlt = 50;
		LHD_WarnAltitude = 40;
		LHD_MissedApproach_Alt = 50;
		LHD_MissedApproach_Dis = 100;
		LHD_DepartureClear_Dis = 600;
		LHD_FinalCall = [200,400];
		LHD_height = 16;
		LHD_Emergency_Call = ["none",0];
		LHD_TrainingTargetMarkers = [[2446.1873,4590.564],[2244.7249,3816.0708],[4374.0254,2430.033]];	//Used for assigning targets (for aircraft ground/land)

	//Vehicle Variables
		//Operating
		LHD_Controlled = false;	//Whether aircraft is under control of the LHD (uncontrolled aircraft cannot operate in restricted area)
		LHD_ControlWarning = 0;	//Current number of controller warnings
		LHD_Intention = 0;		//Current aircraft intention
		LHD_TowingVehicle = false;

		//Training
		LHD_TrgTargets = []; //PLAYERS training targets.  Not published!

		//Landing
		LHD_PatternWaypointComp = false;
		LHD_Approach = false;
		LHD_RadioInUse = false;
		LHD_CurrentFlyAlt = 0; //Current ATC defined flying altitude
		LHD_CurrentPattern = "alpha";
		LHD_OnFinals = false;
		LHD_IsLanding = false; //True when turned on base
		LHD_HasLanded = false; //True when aircraft has landed
		LHD_AtMAP = false;
		LHD_InControlRoom = false;
		LHD_CancelLanding = false;

	//Takeoff
		LHD_TakeoffRequest =  false;
		LHD_TakeoffStandby = false;
		LHD_Takeoff = false;

	//ATC Variables
		LHD_MaxWarnings = 2;	//This sets the maximum number of restricted airspace warnings before you get classed as enemy
		ATC_callsign = "falcon"; //Callsign Aircraft
		ATC_callsignNo = 1; //Callsign number
		ATC_ControllerActionAdded = false;
		ControllerActionAdded = false;
		ACEActionAdded = false;
		ATC_Action_VectorBase =[];
		ATC_Callsigns = [
			// --- Aircraft ---
			["sparrow","All",[]],
			["falcon","Plane",[]],
			["angel","Helicopter",[]],
			["crossbow","MV22",[]],
			["thunder","UK3CB_BAF_Merlin_HC3_CSAR",[]],
			["gunship","UK3CB_BAF_Apache_AH1_AT",[]],
			["jester","AV8B2",[]],
			["warthog","A10",[]],
			["eagle","AV8B",[]],
			["striker","F35B",[]],
			["longhorn","C130J",[]],
			// --- Vehicles ---
			["playtime","Car",[]],
			["ironside","Tank",[]],
			["cracker","StaticWeapon",[]],
			["firefly","StaticMGWeapon",[]],
			["claybird","StaticAAWeapon",[]],
			["starlight","HMMWV_Ambulance ",[]]
		];//	["callsign",[Types],[Vehicles assigned]],

		//	Land Co-ordinator	watchdog
		//	Armour/Tanks		ironside
		//	Transport Vehicles	playtime
		//	Artillery/Mortar	cracker
		//	Machine Gun			firefly
		//	Anti-Air			claybird
		//	Medical				starlight
		//	Commander			sunray

		ATC_Intentions = [
			["Unknown",[],"unknown"],
			["Unavailable",[],"unavailable"],
			["Training",[],"training"],
			["Transport",[],"transport"],
			["Cargo Supply",[],"cargosupply"],
			["Gunship Support",[],"gunshipsupport"],
			["Close Air Support",[],"closeairsupport"],
			["Precision Strike",[],"precisionstrike"],
			["Reconnaissance",[],"recon"]
		];

		ATC_onTask = false;
		ATC_CancelTask = false;

		ATC_Tasks_Transport = [
			//[player,(markerpos "x"),(markerpos "y"),2,["firefly",1],[]]
		];  //[requesting player,pickup,delivery,passengers,[land callsign,land callsignNo],[responding vehicle,callsign,callsignNo]]
		ATC_Tasks_CloseAirSupport = [];

	DebarkDialog="DebarkationControl";
	DebarkDisplay=50001;

	LHD_BayStatus = [true,true,true,true,true,true,true,true,true];
	LHD_BayRadius = 18;
	LHD_SelectedBay = 0;
	LHD_ActiveObject = player;

	//_vehicleCargoPos = getArray (configFile >> "CfgVehicles" >> typeOf _lhd >> "FlightDeckAnchorPositions");

	//LHD_BayPositions = [[-13.5543,103.426,1],[13.5212,111.941,1],[13.5967,77.292,1],[-13.5216,61.5732,1],[-13.5376,20.1221,1],[-13.621,-21.5298,1],[-13.6259,-63.6804,1],[13.4215,-71.6892,1],[-13.5995,-100.681,1]];

	LHD_BayPositions = [[13.5543,-103.426,1],[-13.5212,-111.941,1],[-13.5967,-77.292,1],[13.5216,-61.5732,1],[13.5376,-20.1221,1],[13.621,21.5298,1],[13.6259,63.6804,1],[-13.4215,71.6892,1],[13.5995,100.681,1]];

	//supplies
		_westvehicles = "(getNumber (_x >> 'side') isEqualTo 1) and (getNumber (_x >> 'scope') isEqualTo 2) and (((configName _x) isKindOf 'LandVehicle') or ((configName _x) isKindOf 'Helicopter'))" configClasses (configFile >> "CfgVehicles");
		_lhdvehicles = [];
		{
			_lhdvehicles pushback (configName _x);
		} foreach _westvehicles;

		_lhdvehicles append [
			"Box_NATO_AmmoVeh_F",
			"B_supplyCrate_F",
			"B_CargoNet_01_ammo_F",
			"CargoNet_01_box_F",
			"CargoNet_01_barrels_F",
			"Land_Pod_Heli_Transport_04_bench_F",
			"Land_Cargo10_military_green_F",
			"Land_Cargo20_military_green_F",
			"Land_Cargo40_military_green_F",
			"Land_FMradio_F"
		];

		LHD_SpawnableVehicles = _lhdvehicles;

		[] execVM "\airboss\lhdmarkers.sqf"; //LHD markers

	//check ACE, add toggle and actions
	acemod = (isClass(configFile>>"CfgPatches">>"ace_main"));
	if (acemod) then {
		LHD_radio = false;
		_lhdradio = ["lhdradio","Here Be Dolphins","",{LHD_radio = true; [] spawn airboss_fnc_system_controlRoom; hint "TURBO AIRBOSS ACTIVATE!"},{(!LHD_radio)}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _lhdradio] call ace_interact_menu_fnc_addActionToObject;

		_landcontrol = ["landcontrol","Contact Land Controller","",{[nil,nil,nil,[0]] spawn airboss_fnc_land_controller_contact},{(LHD_radio) and (ACEActionAdded) and ((backpack player) iskindof "TFAR_Bag_Base")}] call ace_interact_menu_fnc_createAction;
		_aircontrol = ["aircontrol","Contact Controller","",{[] spawn airboss_fnc_atc_controller_contact},{(LHD_radio) and (ATC_ControllerActionAdded)}] call ace_interact_menu_fnc_createAction;
		_lhdcontrol = ["lhdcontrol","Logistics Control","",{[] spawn airboss_fnc_ui_debarkationControl},{(getPosWorld player in LHD_Location)}] call ace_interact_menu_fnc_createAction;

		{
			[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
		} foreach [_landcontrol,_aircontrol,_lhdcontrol];

	} else { //no ACE
		call airboss_fnc_system_controlRoom; //for pilots
	};
};
