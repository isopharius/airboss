//Script Settings
#define DIGITDELAY 0.4
#define	SENTENCEDELAY 1

		if (LHD_TR && {(alive _vehicle)}) then {
			_Position = LHDPattern find _vehicle;
			if ((_Position isEqualTo 1) and !LHD_TS) then {
			//Aircraft is next vehicle, get them to prepare
				LHD_TS = true;
				waitUntil{!LHD_RU};LHD_RU = true;
				_vehicle vehicleRadio "flyco_msg_takeoff_standby";sleep 0.3;
				_vehicle vehicleRadio "flyco_word_over";sleep 0.8;
				LHD_RU = false;
			};
			if (_Position isEqualTo 0) then {
				//Direct departure, no traffic

				if (_vehicle iskindof "Plane") then { // This section checks if the main bays are free, it will wait until they are before proceeding
					[0] spawn airboss_fnc_lhdsiren;
					waitUntil{!LHD_RU};LHD_RU = true;
					_vehicle vehicleRadio "flyco_msg_takeoff_standby_plane";
					LHD_RU = false;

					sleep 3;
					_notsafe = true;
					_deckClearFail = false;
					_deckClearMsg = false;
					_counter = 0;
					_counter call seven_fnc_atc_safetakeoff;

				} else {
					[1] spawn airboss_fnc_lhdsiren;
				};

				//Set New Heading
				_hdg = getdir lhd;

				_wD1 = floor(_hdg / 100);
				_wD2 = floor((_hdg - (_wD1 * 100)) / 10);
				_wD3 = floor(_hdg - (_wD2 * 10) - (_wD1 * 100));

				if (LHD_TR) then {
					waitUntil{!LHD_RU};LHD_RU = true;
					_vehicle vehicleRadio format["flyco_callsign_%1",ATC_CS];
					_vehicle vehicleRadio format["flyco_digit_%1",ATC_CN];sleep 0.3;
					_vehicle vehicleRadio "flyco_msg_takeoff_depart_1";sleep SENTENCEDELAY;
					_vehicle vehicleRadio "flyco_word_vector";sleep 0.4;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD1];sleep DIGITDELAY;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD2];sleep DIGITDELAY;
					_vehicle vehicleRadio format["flyco_digit_%1",_wD3];sleep DIGITDELAY;
					sleep SENTENCEDELAY;
					_vehicle vehicleRadio "flyco_word_altitude";sleep 0.4;
					_vehicle vehicleRadio format["flyco_digit_%1",LHDAlt];sleep DIGITDELAY;
					_vehicle vehicleRadio "flyco_word_meters";sleep 0.3;
					sleep SENTENCEDELAY;
					_vehicle vehicleRadio "flyco_msg_takeoff_depart_2";sleep SENTENCEDELAY;
					_vehicle vehicleRadio "flyco_word_over";sleep 0.8;
					LHD_RU = false;
					LHD_TR = false;
					LHD_TO = true;
				};
			};
			sleep 0.5;
			call airboss_fnc_atc_alivetakeoff;
		};