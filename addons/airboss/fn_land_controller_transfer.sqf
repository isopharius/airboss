//Get Variables
_vehicle = vehicle player;

//Land base player is requesting a fix on their current location

				call airboss_fnc_land_RemoveActionsWatchdog;

				_mapGrid = (position player) call airboss_fnc_PosToGrid;
				_posStr = _mapGrid call airboss_fnc_GridToStr;
				_mapGridX = _mapGrid select 0;
				_mapGridY = _mapGrid select 1;

				_x1 = floor(_mapGridX / 100);
				_x2 = floor((_mapGridX - (_x1 * 100)) / 10);
				_x3 = floor(_mapGridX - (_x2 * 10) - (_x1 * 100));

				_y1 = floor(_mapGridY / 100);
				_y2 = floor((_mapGridY - (_y1 * 100)) / 10);
				_y3 = floor(_mapGridY - (_y2 * 10) - (_y1 * 100));

				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
				player groupchat format["WATCHDOG: This is WATCHDOG, I have your current position as grid figures %1. Over",_posStr];
				playsound "watchdog_word_thisis";sleep 0.4;
				playsound "watchdog_callsign_watchdog";sleep 0.8;
				playsound "watchdog_msg_currentposition_1";sleep 1.6;
				playsound "watchdog_word_gridfigures";sleep 0.6;
				playsound format ["watchdog_digit_%1",_x1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_x3];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y1];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y2];sleep 0.5;
				playsound format ["watchdog_digit_%1",_y3];sleep 0.5;
				playsound"watchdog_word_over";sleep 0.5;
				LHD_RadioInUse = false;

				call airboss_fnc_land_baseActionsWatchdog;