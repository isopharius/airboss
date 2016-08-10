_vehicle = vehicle player;


	if ((LHD_Controlled) and (alive _vehicle)) then { //Player is controlled

		// --- EMERGENCY NOTIFICATION --- //
		if (((LHD_Emergency_Call select 1) != 0) and (getPosWorld player in LHD_ControlArea)) then {
			//Someone has declared an emergency, let's face it, its probably Walker
			_em_callsign = LHD_Emergency_Call select 0;
			_em_callsignNo = LHD_Emergency_Call select 1;

			if !((_em_callsign == ATC_callsign) and (_em_callsignNo == ATC_callsignNo)) then {
				//Radio
				waitUntil{!LHD_RadioInUse};LHD_RadioInUse = true;
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
				LHD_RadioInUse = false;
			};

			LHD_Emergency_Call = ["none",0];
		};
		// ------------------------------- //

		// --- TASK CHECKING NOTIFICATION --- //
		if (!ATC_onTask) then {
			if (LHD_Intention == 3) then {
				sleep (ATC_callsignNo / 4); //So not everyone responds at the same time!
				_taskingRequest = [0,0,0,[0]] call airboss_fnc_atc_tasking_transport;
			};
			if (LHD_Intention == 6) then {
				sleep (ATC_callsignNo / 4);
				_taskingRequest = [0,0,0,[0]] execVM airboss_fnc_atc_tasking_closeairsupport;
			};
		};
		sleep 1;
		call airboss_fnc_system_atccontroller;
	};