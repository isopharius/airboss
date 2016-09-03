			if ((getPosWorld _vehicle in LHD_Deck) && {(_vehicle in LHDPattern)} && {(alive _vehicle)} && {(alive player)}) then {
				sleep 1;
				call airboss_fnc_atc_alivedeck;
			};