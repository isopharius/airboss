//Get Variables
_vehicle = vehicle player;

	_siren = _this select 0; //0 = , //1 =

//Script Settings
	_digitDelay = 0.4;
	_sentenceDelay = 1;
	_maxDigit = ATC_maxDigit;

	if (_siren isEqualTo 0) then {//LAUNCH SIREN
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