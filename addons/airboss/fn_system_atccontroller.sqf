_vehicle = vehicle player;

	if ((LHD_C) && {(alive _vehicle)}) then { //Player is controlled

		// --- EMERGENCY NOTIFICATION --- //
		if (((LHD_EC select 1) != 0) && {(getPosWorld player in LHD_ControlArea)}) then {
			//Someone has declared an emergency, let's face it, its probably Walker
			_em_callsign = LHD_EC select 0;
			_em_callsignNo = LHD_EC select 1;

			if !((_em_callsign isEqualTo ATC_CS) && {(_em_callsignNo isEqualTo ATC_CN)}) then {
				//Radio
				waitUntil{!LHD_RU};LHD_RU = true;
				_vehicle vehicleRadio "flyco_word_alltraffic";sleep 0.3;
				_vehicle vehicleRadio "flyco_word_thisis";sleep 0.3;
				_vehicle vehicleRadio "flyco_callsign_flyco";sleep 1;
				_vehicle vehicleRadio format["flyco_callsign_%1",_em_callsign];
				_vehicle vehicleRadio format["flyco_digit_%1",_em_callsignNo];sleep 0.3;
				_vehicle vehicleRadio "flyco_msg_emergency_1";sleep 0.5;
				_vehicle vehicleRadio "flyco_msg_emergency_2";sleep 3;
				_vehicle vehicleRadio "flyco_word_isayagain";sleep 1;
				_vehicle vehicleRadio format["flyco_callsign_%1",_em_callsign];
				_vehicle vehicleRadio format["flyco_digit_%1",_em_callsignNo];sleep 0.3;
				_vehicle vehicleRadio "flyco_msg_emergency_1";sleep 0.5;
				_vehicle vehicleRadio "flyco_msg_emergency_2";sleep 3;
				_vehicle vehicleRadio "flyco_callsign_flyco";sleep 0.1;
				_vehicle vehicleRadio "flyco_word_out";sleep 0.1;
				LHD_RU = false;
			};

			LHD_EC = ["none",0];
		};
		// ------------------------------- //

		// --- TASK CHECKING NOTIFICATION --- //
		if (!ATC_T) then {
			if (LHD_I isEqualTo 3) then {
				sleep (ATC_CN / 4); //So not everyone responds at the same time!
				[0,0,0,[0]] call airboss_fnc_atc_tasking_transport;
			};
			if (LHD_I isEqualTo 6) then {
				sleep (ATC_CN / 4);
				[0,0,0,[0]] call airboss_fnc_atc_tasking_closeairsupport;
			};
		};
		sleep 1;
		call airboss_fnc_system_atccontroller;
	};