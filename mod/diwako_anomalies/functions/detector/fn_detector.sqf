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
    private _sleep = 2;
    private _m = 0.9 / 5;
    private _b = 0.1 - (_m * 5);
    sleep 1:
    // small wait so ace interaction window does not gobble up the title text prompt
    titleText [localize "STR_Detector_turned_on", "PLAIN DOWN"];
    private _lastBeep = CBA_missionTime - 10;
    while {alive player && ANOMALY_DETECTOR_ACTIVE && ([player, ANOMALY_DETECTOR_ITEM] call anomaly_fnc_hasItem)} do {
        private _found = false;
        private _min = ANOMALY_DETECTION_RANGE + 4;
        // add support for remote controlled units
        private _plr = [] call CBA_fnc_currentUnit;
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
            _sleep = _m * _min + _b;
            if(_sleep < 0.1) then {
                _sleep = 0.1;
            } else {
                if( _sleep > 1) then {
                    _sleep = 1;
                };
            };
            if( (CBA_missionTime - _lastBeep) >= _sleep) then {
                switch (ANOMALY_DETECTOR_VOLUME) do {
                    case 1: { playSound "da_2_beep1_high_1"; };
                    case 2: { playSound "da_2_beep1_high_2"; };
                    case -1: { playSound "da_2_beep1_low_1"; };
                    case -2: { playSound "da_2_beep1_low_2"; };
                    default { playSound "da_2_beep1"; };
                };
                _lastBeep = CBA_missionTime;
            };
        };
        sleep 0.05;
    };
    ANOMALY_DETECTOR_ACTIVE = false;
    titleText [localize "STR_Detector_turned_off", "PLAIN DOWN"];
};