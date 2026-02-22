#include "\z\diwako_anomalies\addons\main\script_component.hpp"
#define SPACING 80
if !(hasInterface) exitWith {};
params [["_time", 10], ["_showPressure", true]];
if (isNil QGVAR(blowoutDirection)) then {
    GVAR(blowoutDirection) = random 360;
};

private _horizon = viewDistance;
private _sound = createSoundSourceLocal [QGVAR(blowoutWave), [0, 0, 0], [], 0];
private _velocityVectorForPressureWave = [sin GVAR(blowoutDirection), cos GVAR(blowoutDirection), 0] vectorMultiply -((_horizon / _time) * 10);

[{
    if (isGamePaused) exitWith {};
    params ["_startTime", "_endTime", "_fullEndTime", "_horizon", "_sound", "_showPressure", "_velocityVectorForPressureWave"];
    private _time = time;

    private _pos = ([] call CBA_fnc_currentUnit) getPos [linearConversion [_startTime, _endTime, _time, _horizon, 0, false], GVAR(blowoutDirection)];
    _sound setPosASL AGLToASL _pos;
    _pos set [2, 0];
    for "_i" from -10 to 10 do {
        private _size = random 40;

        private _dropPos = _pos getPos [
            (_i * SPACING) + ((random SPACING) - SPACING/2),
            (GVAR(blowoutDirection) + 90) mod 360
        ] vectorAdd [
            0,
            0,
            5 + random 10
        ];

        drop [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2,
            _dropPos, [0, 0, 0], 0, 10, 7.6, 0,
            [0, 60 + _size, 40 + _size, 10 + _size, _size, 0],
            [[1 - random 0.3, 1 - random 0.3,1 - random 0.3,-2],[1,1,1,0]],
            [0.08], 1, 0, "", "", ""];

        if (random 1 < 0.25) then {
            drop [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2,
                _dropPos, [0, 0, 0], 0, 10, 7.6, 0,
                [50 + _size, 40+ _size, 10 + _size, _size, 0],
                [[0, 0.5 + random 0.3, 0.5 + random 0.3, -10],[0, 0.5, 0.5, 0]],
                [0.08], 1, 0, "", "", ""];
            if (_showPressure && {random 1 < 0.5}) then {
                drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13, 0], "", "Billboard", 1,
                    25, // lifetime
                    _dropPos getPos [-500, GVAR(blowoutDirection)],
                    _velocityVectorForPressureWave, // velocity
                    0,
                    2,
                    1,
                    0.01, // rubbing
                    [60 - random 15, 30 - random 5, 0.1], // size
                    [[0.05,0.05,0.05,0.65], [0.05,0.05,0.05,0.65], [0.05,0.05,0.05,0.65], [0.05,0.05,0.05,0.55], [0.05,0.05,0.05,0.45],[0.05,0.05,0.05,0.35],[0.05,0.05,0.05,0.26],[0.05,0.05,0.05,0.18],[0.05,0.05,0.05,0.08],[0.05,0.05,0.05,0.03],[0.05,0.05,0.05,0.01]], // color
                    [1000], //anim speed
                    0.4, 0.09, "", "", "", 0, true, 0.01];
            };
        };
    };

    _time >= _fullEndTime
},{
    params ["", "", "", "", "_sound"];
    deleteVehicle _sound;
}, [time, time + _time, time + _time + _time, _horizon, _sound, _showPressure, _velocityVectorForPressureWave]] call CBA_fnc_waitUntilAndExecute;
