#include "\z\diwako_anomalies\addons\main\script_component.hpp"
#define STAGE_1_TIME 60
#define STAGE_3_TIME 30
#define STAGE_4_TIME 10
if (missionNamespace getVariable [QGVAR(blowoutInProgress), false]) exitWith {
    private _text = "Blowout not started via event. Already in progress!";
    LOG_SYS("INFO",_text);
};

params [
    ["_time", 400, [0, objNull]],
    ["_direction", 0, [0, []]],
    ["_useSirens", true, [true]],
    ["_onlyPlayers", true, [true]],
    ["_environmentParticleEffects", true, [true]]
];

if (_time isEqualType objNull) then {
    //created via module
    private _module = _time;
    _time = _module getVariable "wavetime";
    _direction = _module getVariable "direction";
    _useSirens = _module getVariable "sirens";
    _onlyPlayers = _module getVariable "onlyPlayers";
    _environmentParticleEffects = _module getVariable "environmentParticleEffects";
    deleteVehicle _module;
};

missionNamespace setVariable [QGVAR(blowoutUseSirens), _useSirens, true];
missionNamespace setVariable [QGVAR(blowoutAffectPlayersOnly), _onlyPlayers, true];
missionNamespace setVariable [QGVAR(blowoutEnvironmentParticleEffects), _environmentParticleEffects, true];


private _stage2Time = _time - STAGE_1_TIME - STAGE_3_TIME - STAGE_4_TIME;
if (_stage2Time <= 1) exitWith {
    private _text = format ["Blowout canceled, stage 2 time is one second or below! -> Time given: %1", _time];
    LOG_SYS("WARNING",_text);
};

if !([1, _direction] call FUNC(blowout)) exitWith {
    private _text = "Could not start blowout. Function returned false for stage 1.";
    LOG_SYS("INFO",_text);
};

[{
    if !(GVAR(blowoutInProgress)) exitWith {};
    [2] call FUNC(blowout);
}, nil, STAGE_1_TIME] call CBA_fnc_waitAndExecute;

[{
    if !(GVAR(blowoutInProgress)) exitWith {};
    [3] call FUNC(blowout);
}, nil, STAGE_1_TIME + _stage2Time] call CBA_fnc_waitAndExecute;

[{
    if !(GVAR(blowoutInProgress)) exitWith {};
    [4] call FUNC(blowout);
}, nil, STAGE_1_TIME + _stage2Time + STAGE_3_TIME] call CBA_fnc_waitAndExecute;
nil
