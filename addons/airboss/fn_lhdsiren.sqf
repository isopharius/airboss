//Get Variables
_vehicle = vehicle player;

	if ((_this select 0) isEqualTo 0) then {//LAUNCH SIREN
		_soundSource = createSoundSource ["Alarm_Launch", position lhd, [], 0];

		call airboss_fnc_atc_alivepattern;

		//Deactivate Siren
		deletevehicle _soundSource;
	} else {//DEPARTURE SIREN
		_soundSource = createSoundSource ["Alarm_Departure", position lhd, [], 0];

		call airboss_fnc_atc_alivedeck;

		//Deactivate Siren
		deletevehicle _soundSource;
	};
