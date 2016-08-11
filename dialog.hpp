class RscStandardDisplay;
class CA_Title;

class Bay_RscListNBox {
	style = 16;
	type=102;
	shadow = 0;
	font = "PuristaMedium";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	color[] = {0.95, 0.95, 0.95, 1};
	colorText[] = {1, 1, 1, 1.0};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0, 0, 0, 1};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground2[] = {1, 1, 1, 0.5};
	period = 1.2;

	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class Bay_RscPicture {
	shadow = 0;
	type = 0;
	style = 48;
	sizeEx = 0.023;
	font = "PuristaMedium";
	colorBackground[] = {};
	colorText[] = {};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};

class Bay_RscText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {1, 1, 1, 1.0};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};

class Bay_RscShortcutButton
{
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	colorFocused[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
	colorBackground2[] = {1,1,1,1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	action = "";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "(LHD_radio)";
	};
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class BayButton
{
	idc = -1;
	type = 1;
	style = 2;
	default = 0;
	font = "puristaLight";
	sizeEx = 0.025;
	colorText[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	borderSize = 0;
	soundEnter[] = {"", 0, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0, 1};
	soundEscape[] = {"", 0, 1};
	x = 0.068;
	y = 0.706;
	w = 0.083;
	h = 0.111;
	text = "";
	action = "";
};
class DebarkationControl: RscStandardDisplay
{
	idd = 50001;
	enableSimulation = 1;
	onLoad = "";
	class controlsBackground
	{
		class Mainback: Bay_RscPicture
		{
			idc = 1001;
			x = 0;
			y = 0;
			w = 1.213;
			h = 1.661;
			text = "";
		};
	};
	class controls
	{
		class Title1: CA_Title
		{
			x = 0.041;
			y = 0.011;
			text = "Debarkation Control";
		};
		class CurrentBayPicBorder: Bay_RscPicture
		{
			idc = -1;
			x = 0.025;
			y = 0.12;
			w = 0.145;
			h = 0.194;
			text = "\airboss\button_icon_default_ca.paa";
		};
		class CurrentBayPic: Bay_RscPicture
		{
			idc = 1002;
			x = 0.025;
			y = 0.12;
			w = 0.145;
			h = 0.194;
			text = "";
		};
		class Info1: Bay_RscText
		{
			idc = -1;
			x = 0.194;
			y = 0.124;
			w = 0.324;
			h = 0.039;
			text = "Selected:";
			colorText[] = {0.95,0.95,0.95,1};
		};
		class SelectedBayText: Info1
		{
			idc = 1003;
			x = 0.335;
			text = "None";
			colorText[] = {0.6,0.84,0.47,1.0};
		};
		class Info2: Info1
		{
			y = 0.185;
			text = "Vehicle:";
		};
		class SelectedVehicleText: Info2
		{
			idc = 1004;
			x = 0.335;
			text = "None";
			colorText[] = {0.6,0.84,0.47,1.0};
		};
		class Info3: Info1
		{
			y = 0.245;
			text = "Driver:";
		};
		class SelectedDriverText: Info3
		{
			idc = 1005;
			x = 0.335;
			text = "None";
			colorText[] = {0.6,0.84,0.47,1.0};
		};
		class LHDPicture: Bay_RscPicture
		{
			idc = -1;
			x = 0.011;
			y = 0.468;
			w = 0.99;
			h = 0.659;
			text = "\airboss\picture_lhd_ca.paa";
		};
		class Info4: Info1
		{
			x = 0.688;
			w = 0.302;
			text = "Vehicle Type:";
		};
		class VehicleSpawnBox: Bay_RscListNBox
		{
			idc = 1006;
			x = 0.688;
			y = 0.174;
			w = 0.302;
			h = 0.152;
			onLBSelChanged = "call airboss_fnc_VehicleSpawnBox;";

			class ListScrollBar	{
				color[] = {CUI_Colours_WindowText, 3/4};
				colorActive[] = {CUI_Colours_WindowText, 1};
				colorDisabled[] = {CUI_Colours_WindowText, 1/2};
				thumb = "";
				arrowEmpty = "";
				arrowFull = "";
				border = "";
			};
		};
		class ButtonSpawn: Bay_RscShortcutButton
		{
  			type = 16;
			idc = 1007;
			default = 0;
			x = 0.818;
			y = 0.348;
			text = "Issue";
			onButtonClick = "call airboss_fnc_VehicleSpawn;";
			colorFocused[] = {CUI_Colours_DialogBackground, 3/5};
			colorDisabled[] = {CUI_Colours_DialogBackground, 2/5};
			colorBackground[] = {CUI_Colours_DialogBackground, 4/5};
			colorBackgroundDisabled[] = {CUI_Colours_DialogBackground, 4/5};
			colorBackgroundActive[] = {CUI_Colours_DialogBackground, 5/5};
			colorBackgroundFocused[] = {CUI_Colours_DialogBackground, 5/5};
		};
		class ButtonReturn: ButtonSpawn
		{
			idc = 1008;
			x = 0.025;
			text = "Return";
			onButtonClick = "call airboss_fnc_VehicleReturn;";
		};
		class ButtonService: ButtonSpawn
		{
			idc = 1009;
			x = 0.214;
			text = "Service";
			onButtonClick = "call airboss_fnc_VehicleService;";
		};
		class ButtonLoad: ButtonSpawn
		{
			idc = 1010;
			x = 0.403;
			text = "+ Cargo";
			onButtonClick = "LHD_ActiveObject call fnc_VehicleLoad;";
		};
		class ButtonLoadPeople: ButtonSpawn
		{
			idc = 1011;
			x = 0.592;
			text = "+ Pers";
			onButtonClick = "LHD_ActiveObject call fnc_VehicleLoadPeople;";
		};
		class Bay1PicBorder: Bay_RscPicture
		{
			idc = 1201;
			x = 0.068;
			y = 0.706;
			w = 0.083;
			h = 0.111;
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.6,0.84,0.47,0.7};
			text = "\airboss\button_icon_default_ca.paa";
		};
		class Bay1Pic: Bay_RscPicture
		{
			idc = 1101;
			x = 0.068;
			y = 0.706;
			w = 0.083;
			h = 0.111;
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.6,0.84,0.47,0.7};
			text = "";
		};
		class Bay1Button: BayButton
		{
			idc = 1301;
			x = 0.068;
			y = 0.706;
			action = "[1] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1201,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1201,false] call airboss_fnc_ui_BayOver";
		};
		class Bay2PicBorder: Bay1PicBorder
		{
			idc = 1202;
			x = 0.068;
			y = 0.567;
		};
		class Bay2Pic: Bay1Pic
		{
			idc = 1102;
			x = 0.068;
			y = 0.567;
		};
		class Bay2Button: BayButton
		{
			idc = 1302;
			x = 0.068;
			y = 0.567;
			action = "[2] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1202,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1202,false] call airboss_fnc_ui_BayOver";
		};
		class Bay3PicBorder: Bay1PicBorder
		{
			idc = 1203;
			x = 0.192;
			y = 0.567;
		};
		class Bay3Pic: Bay1Pic
		{
			idc = 1103;
			x = 0.192;
			y = 0.567;
		};
		class Bay3Button: BayButton
		{
			idc = 1303;
			x = 0.192;
			y = 0.567;
			action = "[3] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1203,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1203,false] call airboss_fnc_ui_BayOver";
		};
		class Bay4PicBorder: Bay1PicBorder
		{
			idc = 1204;
			x = 0.228;
			y = 0.706;
		};
		class Bay4Pic: Bay1Pic
		{
			idc = 1104;
			x = 0.228;
			y = 0.706;
		};
		class Bay4Button: BayButton
		{
			idc = 1304;
			x = 0.228;
			y = 0.706;
			action = "[4] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1204,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1204,false] call airboss_fnc_ui_BayOver";
		};
		class Bay5PicBorder: Bay1PicBorder
		{
			idc = 1205;
			x = 0.393;
			y = 0.706;
		};
		class Bay5Pic: Bay1Pic
		{
			idc = 1105;
			x = 0.393;
			y = 0.706;
		};
		class Bay5Button: BayButton
		{
			idc = 1305;
			x = 0.393;
			y = 0.706;
			action = "[5] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1205,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1205,false] call airboss_fnc_ui_BayOver";
		};
		class Bay6PicBorder: Bay1PicBorder
		{
			idc = 1206;
			x = 0.539;
			y = 0.706;
		};
		class Bay6Pic: Bay1Pic
		{
			idc = 1106;
			x = 0.539;
			y = 0.706;
		};
		class Bay6Button: BayButton
		{
			idc = 1306;
			x = 0.539;
			y = 0.706;
			action = "[6] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1206,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1206,false] call airboss_fnc_ui_BayOver";
		};
		class Bay7PicBorder: Bay1PicBorder
		{
			idc = 1207;
			x = 0.69;
			y = 0.706;
		};
		class Bay7Pic: Bay1Pic
		{
			idc = 1107;
			x = 0.69;
			y = 0.706;
		};
		class Bay7Button: BayButton
		{
			idc = 1307;
			x = 0.69;
			y = 0.706;
			action = "[7] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1207,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1207,false] call airboss_fnc_ui_BayOver";
		};
		class Bay8PicBorder: Bay1PicBorder
		{
			idc = 1208;
			x = 0.725;
			y = 0.567;
		};
		class Bay8Pic: Bay1Pic
		{
			idc = 1108;
			x = 0.725;
			y = 0.567;
		};
		class Bay8Button: BayButton
		{
			idc = 1308;
			x = 0.725;
			y = 0.567;
			action = "[8] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1208,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1208,false] call airboss_fnc_ui_BayOver";
		};
		class Bay9PicBorder: Bay1PicBorder
		{
			idc = 1209;
			x = 0.816;
			y = 0.706;
		};
		class Bay9Pic: Bay1Pic
		{
			idc = 1109;
			x = 0.816;
			y = 0.706;
		};
		class Bay9Button: BayButton
		{
			idc = 1309;
			x = 0.816;
			y = 0.706;
			action = "[9] call airboss_fnc_ui_BaySelect;";
			onMouseEnter = "[1209,true] call airboss_fnc_ui_BayOver";
			onMouseExit = "[1209,false] call airboss_fnc_ui_BayOver";
		};
		class ButtonCancel: Bay_RscShortcutButton
		{
			default = 0;
			shortcuts[] = {"0x00050000 + 1"};
			x = 0.817;
			y = 0.932;
			text = "Close";
			onButtonClick = "(ctrlParent (_this select 0)) closeDisplay 2";
			colorFocused[] = {CUI_Colours_DialogBackground, 3/5};
			colorDisabled[] = {CUI_Colours_DialogBackground, 2/5};
			colorBackground[] = {CUI_Colours_DialogBackground, 4/5};
			colorBackgroundDisabled[] = {CUI_Colours_DialogBackground, 4/5};
			colorBackgroundActive[] = {CUI_Colours_DialogBackground, 5/5};
			colorBackgroundFocused[] = {CUI_Colours_DialogBackground, 5/5};
		};
	};
};