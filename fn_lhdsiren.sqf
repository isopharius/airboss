//Get Variables
private _vehicle = vehicle player;


	private _siren = _this select 0; //0 = , //1 =

//Script Settings
	private _digitDelay = 0.4;
	private _sentenceDelay = 1;
	private _maxDigit = ATC_maxDigit;

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