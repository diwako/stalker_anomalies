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
    titleText [localize "STR_Detector_turned_on", "PLAIN DOWN"];
    private _lastBeep = CBA_missionTime - 10;
    private _player = [] call CBA_fnc_currentUnit;
    while {alive _player && GVAR(detectorActive) && ([_player, GVAR(detectorItem)] call FUNC(hasItem))} do {
        private _found = false;
        private _min = GVAR(detectionRange);
        private _areaRange = _min + 10;
        // add support for remote controlled units
        private _plr = [] call CBA_fnc_currentUnit;
        {
            // only accept triggers that are anomalies
            if (!isNil {_x getVariable [QGVAR(anomalyType), nil]} &&
                {!GVAR(detectorSensesCooldown) || !(_x getVariable QGVAR(cooldown))} &&
                {_x getVariable [QGVAR(detectable), true]}) then {
                private _tmp = ((_x distance _plr) - (_x getVariable [QGVAR(detectorOffset), 4])) max 0;
                if (_tmp < _min) then {
                    _found = true;
                    _min = _tmp;
                };
            };
        } forEach ((GVAR(holder)+GVAR(localCometHolder)) inAreaArray [getPos _plr, _areaRange, _areaRange, 0, false, _areaRange]);
        if (_found) then {
            _sleep = linearConversion [GVAR(detectionRange), 0.5, _min, 1, 0.08, true];
            if ( (CBA_missionTime - _lastBeep) >= _sleep) then {
                if (GVAR(detector3DSound)) then {
                    private _sound = switch (GVAR(detectorVolume)) do {
                        case 1:  { 2 };
                        case 2:  { 4 };
                        case -1: { 0.75 };
                        case -2: { 0.5 };
                        default  { 1 };
                    };
                    playSound3D [QPATHTOF(sounds\detector\da-2_beep1.ogg), _player, false, getPosASL _player, _sound * 2, 1, GVAR(detectionRange) * 2, 0, false];
                } else {
                    playSound (switch (GVAR(detectorVolume)) do {
                        case 1:  { "da_2_beep1_high_1"; };
                        case 2:  { "da_2_beep1_high_2"; };
                        case -1: { "da_2_beep1_low_1"; };
                        case -2: { "da_2_beep1_low_2"; };
                        default  { "da_2_beep1"; };
                    });
                };
                _lastBeep = CBA_missionTime;
            };
        };
        sleep 0.05;
    };
    GVAR(detectorActive) = false;
    titleText [localize "STR_Detector_turned_off", "PLAIN DOWN"];
};
