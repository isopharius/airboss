if ((!isnil "lhd") or isHC) exitwith {};

lhd = _this select 0;
_lp = position lhd;

//add respawn at box
if (isserver) then {
	_c = createvehicle ["B_CargoNet_01_ammo_F", [0,0,0], [], 0, "CAN_COLLIDE"];	//crate
  _c enableSimulation false;
	_c allowdamage false;
	_c setposasl [(_lp select 0) + 7, (_lp select 1) - 15, 16.9];
	[missionnamespace, _c, "USX Syed"] call BIS_fnc_addRespawnPosition;
};

if (!isdedicated) then {

	//Land Variables
		Bases = [];
		BN = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel"];	//base names

		//Task Oriented Variables
		Land_AP = false;	//awaiting pickup
		Land_AD = false;	//awaiting delivery

		Land_ACA = false;	//awaiting cas assign
		Land_ACR = false;	//awaiting cas run

		//Controller Variables
		Controlled = false;
		callsign = "sunray";
		callsignNo = 1;
		Callsigns = [
			// --- Soldiers ---
			["firefly","CAManBase",[]]
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
		//LHDA = true;	//alive
		LHD_PL = [["Charlie",1,500,800],["Delta",4,850,1200]]; //[Name,Positions,xRadius,yRadius] //pattern layout
		LHD_CR = [1000,1500];	//control radius
		LHD_RR = [2500,2500];	//restricted radius
		LHD_LT = 3;	//landing turn
		LHDAlt = 50;
		LHD_WA = 40;	//Warning Altitude
		LHD_MAA = 50;	//missed approach alt
		LHD_MAD = 100;	//missed approach dis
		LHD_DCD = 600;	//departure clear dis
		LHD_FC = [200,400];	//final call
		LHD_EC = ["none",0];	//emergency call
		//LHD_H = 16;	//height
		//LHD_TM = [[2446.1873,4590.564],[2244.7249,3816.0708],[4374.0254,2430.033]];	//Used for assigning targets (for aircraft ground/land)

	//Vehicle Variables
		//Operating
		LHD_C = false;	//Whether aircraft is under control of the LHD (uncontrolled aircraft cannot operate in restricted area)
		LHD_CW = 0;	//Current number of controller warnings
		LHD_I = 0;		//Current aircraft intention
		//LHD_TV = false;	//towing vehicle

		//Training
		LHD_TT = []; //PLAYERS training targets.  Not published!

		//Landing
		LHD_PW = false;	//pattern waypoints
		//LHD_Approach = false;
		LHD_RU = false;	//radio in use
		LHD_CFA = 0; //Current ATC defined flying altitude
		LHD_CP = "alpha";	//current pattern
		LHD_OF = false;
		LHD_IL = false; //True when turned on base
		LHD_HL = false; //True when aircraft has landed
		LHD_MAP = false;	//at map
		//LHD_ICR = false;	//in control room
		LHD_CL = false;	//cancel landing

	//Takeoff
		LHD_TR =  false;	//takeoff request
		LHD_TS = false;	//takeoff standby
		LHD_TO = false;	//takeoff

	//ATC Variables
		LHD_MW = 2;	//This sets the maximum number of restricted airspace warnings before you get classed as enemy
		ATC_CS = "falcon"; //Callsign Aircraft
		ATC_CN = 1; //Callsign number
		ATC_AA = false;	//ATC action added
		CAA = false;	//controller action added
		AAA = false;	//ace action added
		ATC_AV = [];	//action vector base
		ATC_CL = [	//callsigns list
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

		ATC_I = [	//intentions
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

		ATC_T = false;	//on task
		ATC_CT = false;	//cancel task

		ATC_TT = [	//tasks transport
			//[player,(markerpos "x"),(markerpos "y"),2,["firefly",1],[]]
		];  //[requesting player,pickup,delivery,passengers,[land callsign,land callsignNo],[responding vehicle,callsign,callsignNo]]
		ATC_TC = [];	//tasks close air support

	DD = 50001;	//debark display

	LHD_BS = [true,true,true,true,true,true,true,true,true];	//bay status
	LHD_BR = 18;	//bay radius
	LHD_SB = 0;	//selected bay
	LHD_AO = player;	//active object

	//_vehicleCargoPos = getArray (configFile >> "CfgVehicles" >> typeOf _lhd >> "FlightDeckAnchorPositions");

	//bay positions
	LHD_BP = [[13.5543,-103.426,1],[-13.5212,-111.941,1],[-13.5967,-77.292,1],[13.5216,-61.5732,1],[13.5376,-20.1221,1],[13.621,21.5298,1],[13.6259,63.6804,1],[-13.4215,71.6892,1],[13.5995,100.681,1]];

	//LHD_BP = [[-13.5543,103.426,1],[13.5212,111.941,1],[13.5967,77.292,1],[-13.5216,61.5732,1],[-13.5376,20.1221,1],[-13.621,-21.5298,1],[-13.6259,-63.6804,1],[13.4215,-71.6892,1],[-13.5995,-100.681,1]];

	//supplies
		_wv = "(getNumber (_x >> 'side') isEqualTo 1) and (getNumber (_x >> 'scope') isEqualTo 2) and (((configName _x) isKindOf 'LandVehicle') or ((configName _x) isKindOf 'Helicopter'))" configClasses (configFile >> "CfgVehicles");
		_lv = [];	//LHD vehicles
		{
			_lv pushback (configName _x);
		} foreach _wv;

		_lv append [
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

		LHD_SV = _lv;	//spawnable vehicles

		[_lp] execVM "\airboss\lhdmarkers.sqf"; //LHD markers

	//check ACE, add toggle and actions
	am = (isClass(configFile>>"CfgPatches">>"ace_main"));	//acemod
	if (am) then {
		LHD_radio = false;
		_lr = ["lhdradio","Here Be Dolphins","",{LHD_radio = true; [] spawn airboss_fnc_system_controlRoom; hint "TURBO AIRBOSS ACTIVATE!"},{(!LHD_radio)}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _lr] call ace_interact_menu_fnc_addActionToObject;

		_gc = ["landcontrol","Contact Land Controller","",{[nil,nil,nil,[0]] spawn airboss_fnc_land_controller_contact},{(LHD_radio) && (AAA) && ((backpack player) iskindof "TFAR_Bag_Base")}] call ace_interact_menu_fnc_createAction;
		_ac = ["aircontrol","Contact Controller","",{[] spawn airboss_fnc_atc_controller_contact},{(LHD_radio) && (ATC_AA)}] call ace_interact_menu_fnc_createAction;
		_lc = ["lhdcontrol","Logistics Control","",{[] spawn airboss_fnc_ui_debarkationControl},{(getPosWorld player in LHD_Location)}] call ace_interact_menu_fnc_createAction;

		{
			[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
		} foreach [_gc, _ac, _lc];

	} else { //no ACE
		call airboss_fnc_system_controlRoom; //for pilots
	};
};
