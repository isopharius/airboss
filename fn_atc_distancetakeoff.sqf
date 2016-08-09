		if (((alive _vehicle) and (LHD_Takeoff) and ((position lhd distance (position _vehicle)) < LHD_DepartureClear_Dis))) then {
			sleep 0.5;
			call airboss_fnc_atc_distancetakeoff;
		};