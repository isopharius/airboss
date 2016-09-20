		if ((LHD_TO) && {(alive _vehicle)} && {((getPosWorld lhd distance (getPosWorld _vehicle)) < LHD_DCD)}) then {
			sleep 0.5;
			call airboss_fnc_atc_distancetakeoff;
		};