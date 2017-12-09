[] spawn {
	_sleep = 2;
	_m = 0.9 / 5.2;
	_b = 0.1 - (_m * 4.8);
	while {alive player && ANOMALY_DETECTOR_ACTIVE} do {
		_found = false;
		_min = ANOMALY_DETECTION_RANGE + 4;
		{
			_type = _x getVariable ["anomaly_type", nil];
			// only accept triggers that are anomalies
			if(!(isNil "_type") && {!(_x getVariable "anomaly_cooldown")}) then {
				_found = true;
				_tmp = _x distance player;
				if(_tmp < _min) then {
					_min = _tmp;
				};
			};
		} forEach (getpos player nearObjects ["EmptyDetector", ANOMALY_DETECTION_RANGE + 4]);
		if(_found) then {
			playSound "da_2_beep1";
			_sleep = _m * _min + _b;
			if(_sleep < 0.1) then {
				_sleep = 0.1;
			};
		} else {
			_sleep = 1.5;
		};
		sleep _sleep;
	};
	ANOMALY_DETECTOR_ACTIVE = false;
};