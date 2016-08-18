class CfgPatches
{
	class airboss
	{
		requiredVersion = 0.1;
		author[] = { "isopharius" };
		authorUrl = "http://7cmbg.com";
		version = 0.1;
		weapons[] = {};
		units[] = {};

		requiredAddons[] =
		{
			"CUP_WaterVehicles_LHD"
		};
	};
};

class CfgMods {
	class PREFIX {
		dir = "@airboss";
		name = "LHD Airboss";
		picture = "";
		actionName = "Website";
		action = "https://github.com/isopharius/airboss";
		overview = "Airboss provides Logistics and traffic control for the CUP LHD";
		tooltip = "LHD Airboss";
		author = "isopharius";
	};
};

#include "dialog.hpp"

class CfgFunctions
{
	#include "CfgFunctions.hpp"
};

class CfgSounds
{
	#include "CfgSounds.hpp"
};

class CfgRadio
{
	#include "CfgRadio.hpp"
};

class CfgSFX
{
	#include "CfgSfx.hpp"
};

class CfgVehicles
{
	#include "CfgVehicles.hpp"
};

class Extended_InitPost_EventHandlers {
	class CUP_B_LHD_WASP_USMC_Empty
	{
	  airbossinit = "[(_this select 0)] spawn airboss_fnc_lhdinit;";
	};
};
