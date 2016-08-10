		if (((alive _vehicle) and (LHD_Takeoff) and ((getPosWorld lhd distance (getPosWorld _vehicle)) < LHD_DepartureClear_Dis))) then {
			sleep 0.5;
			call airboss_fnc_atc_distancetakeoff;
		};