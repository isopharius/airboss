		if ((LHD_Takeoff) && {(alive _vehicle)} && {((getPosWorld lhd distance (getPosWorld _vehicle)) < LHD_DepartureClear_Dis)}) then {
			sleep 0.5;
			call airboss_fnc_atc_distancetakeoff;
		};