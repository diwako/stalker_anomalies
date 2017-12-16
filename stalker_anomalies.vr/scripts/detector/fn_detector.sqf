/*
	Function: detector_fnc_detector

	Description:
        Spawns an infinite loop to detect anomalies and produce beeping sounds
		Will stop if player is dead or player deactivates detector

    Parameter:

    Returns:
        nothing

	Author:
	diwako 2017-12-11
*/

[] spawn {
	_sleep = 2;
	_m = 0.9 / 5;
	_b = 0.1 - (_m * 5);
	sleep 1:
	// small wait so ace interaction window does not gobble up the title text prompt
	titleText ["Detector has been turned on", "PLAIN DOWN"];
	while {alive player && ANOMALY_DETECTOR_ACTIVE} do {
		_found = false;
		_min = ANOMALY_DETECTION_RANGE + 4;
		// add support for remote controlled units
		_plr = [] call CBA_fnc_currentUnit;
		{
			_type = _x getVariable ["anomaly_type", nil];
			// only accept triggers that are anomalies
			if(!(isNil "_type") && {!(_x getVariable "anomaly_cooldown")}) then {
				_found = true;
				_tmp = _x distance _plr;
				if(_tmp < _min) then {
					_min = _tmp;
				};
			};
		} forEach (getpos _plr nearObjects ["EmptyDetector", ANOMALY_DETECTION_RANGE + 4]);
		if(_found) then {
			playSound "da_2_beep1";
			_sleep = _m * _min + _b;
			if(_sleep < 0.1) then {
				_sleep = 0.1;
			} else {
				if( _sleep > 1) then {
					_sleep = 1;
				};
			};
		} else {
			_sleep = 1;
		};
		sleep _sleep;
	};
	ANOMALY_DETECTOR_ACTIVE = false;
	titleText ["Detector has been turned off", "PLAIN DOWN"];
};