#include "\z\diwako_anomalies\addons\main\script_component.hpp"
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
    // private _m = 0.9 / 5;
    // private _b = 0.1 - (_m * 5);
    sleep 1;
    // small wait so ace interaction window does not gobble up the title text prompt
    titleText ["Detector has been turned on", "PLAIN DOWN"];
    private _lastBeep = CBA_missionTime - 10;
    private _player = [] call CBA_fnc_currentUnit;
    private _type = "";
    while {alive _player && GVAR(detectorActive) && ([_player, GVAR(detectorItem)] call FUNC(hasItem))} do {
        private _found = false;
        private _min = GVAR(detectionRange) + 4;
        // add support for remote controlled units
        private _plr = [] call CBA_fnc_currentUnit;
        private _nearestAnomaly = objNull;
        {
            _type = _x getVariable [QGVAR(anomalyType), nil];
            // only accept triggers that are anomalies
            if (!isNil "_type" &&
                {!GVAR(detectorSensesCooldown) || !(_x getVariable QGVAR(cooldown))} &&
                {_x getVariable [QGVAR(detectable), true]}) then {
                _found = true;
                private _tmp = _x distance _plr;
                if (_tmp < _min) then {
                    _min = _tmp;
                    _nearestAnomaly = _x;
                };
            };
        } forEach (GVAR(holder) inAreaArray [getPos _plr, _min/2, _min/2, 0, false, _min/2]);
        if (_found) then {
            _sleep = linearConversion [GVAR(detectionRange), 5, _min, 1, 0.08, true];
            if ( (CBA_missionTime - _lastBeep) >= _sleep) then {
                if !(GVAR(detector3DSound)) then {
                    playSound (switch (GVAR(detectorVolume)) do {
                        case 1:  { "da_2_beep1_high_1"; };
                        case 2:  { "da_2_beep1_high_2"; };
                        case -1: { "da_2_beep1_low_1"; };
                        case -2: { "da_2_beep1_low_2"; };
                        default  { "da_2_beep1"; };
                    });
                } else {
                    private _sound = switch (GVAR(detectorVolume)) do {
                        case 1:  { 2 };
                        case 2:  { 4 };
                        case -1: { 0.75 };
                        case -2: { 0.5 };
                        default  { 1 };
                    };
                    playSound3D [QPATHTOF(sounds\detector\da-2_beep1.ogg), _player, false, getPosASL _player, _sound * 2, 1, GVAR(detectionRange) * 2, 0, false];
                };
                _lastBeep = CBA_missionTime;
            };
        };
        sleep 0.05;
    };
    GVAR(detectorActive) = false;
    titleText ["Detector has been turned off", "PLAIN DOWN"];
};
