			if ((getPosWorld _vehicle in LHD_Deck) and (_vehicle in LHDPattern) and (alive _vehicle) and (alive player)) then {
				sleep 1;
				call airboss_fnc_atc_alivedeck;
			};