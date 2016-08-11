# airboss
ArmA3 LHD airboss - CUP LHD required

Airboss adds LHD Logistics and Radio controllers for Air/Ground coordination and traffic

HOMER controls LHD airspace
- initial contact with aircraft within airspace
- assigns aircraft callsigns
- coordinates aircraft intentions with WATCHDOG

FLYCO controls LHD traffic
- traffic report
- weather forecast
- takeoff and landing clearance
- assign traffic patterns

WATCHDOG controls Air/Ground support
- initial contact with Land controllers
- assigns ground callsigns
- coordinates Transport/CAS requests

Logistics Control available inside LHD Control Room to spawn vehicles on LHD deck

//spawnable vehicles example

LHD_SpawnableVehicles = [
	"CUP_B_AV8B_LGB",
	"CUP_B_AV8B_Hydra19",
	"CUP_B_AV8B_Deepstrike",
	"CUP_B_CH53E_USMC",
	"CUP_B_MV22_USMC",
	"CUP_B_UH1Y_UNA_F",
	"CUP_B_UH1Y_MEV_F",
	"CUP_B_AH1Z_AT",
	"CUP_B_AH1Z_Escort",
	"CUP_B_AH1Z_14RndHydra",
	"CUP_B_AH1Z_AT",
	"CUP_B_UH1Y_GUNSHIP_F",
	"CUP_B_LAV25_HQ_USMC",
	"CUP_B_LAV25_USMC",
	"CUP_B_LAV25M240_USMC",
	"CUP_B_AAV_USMC",
	"CUP_B_M1A1_Woodland_USMC",
	"B_Slingload_01_Ammo_F",
	"B_Slingload_01_Repair_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Medevac_F",
	"B_Slingload_01_Cargo_F"
];
