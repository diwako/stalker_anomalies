#include "\z\diwako_anomalies\addons\main\script_component.hpp"
if !(isServer) exitWith {};
params [
    ["_minimalDelay", 10, [0, objNull]],
    ["_maximumDelay", 60, [0, []]],
    ["_condition", {true}, ["", {}, false]],
    ["_blowoutTime", 400, [0, []]],
    ["_direction", 0, [0, []]],
    ["_useSirens", true, [true]],
    ["_onlyPlayers", true, [true]],
    ["_isLethal", true, [true]],
    ["_environmentParticleEffects", true, [true]],
    ["_psyWave", true, [true]]
];

if (_minimalDelay isEqualType objNull) then {
    //created via module
    private _module = _minimalDelay;
    _minimalDelay = _module getVariable "minimalDelay";
    _maximumDelay = _module getVariable "maximumDelay";
    _condition = _module getVariable "condition";
    _blowoutTime = _module getVariable "wavetime";
    _direction = _module getVariable "direction";
    _useSirens = _module getVariable "sirens";
    _onlyPlayers = _module getVariable "onlyPlayers";
    _isLethal = _module getVariable "isLethal";
    _environmentParticleEffects = _module getVariable "environmentParticleEffects";
    _psyWave = _module getVariable "psyWave";
    deleteVehicle _module;
};

if (_maximumDelay isEqualType [] ||
    {_condition isEqualType false} ||
    {_blowoutTime isEqualType []} ||
    {_direction isEqualType []}) exitWith {
    private _text = "Blowout System canceled, one or more parameters are of invalid type!";
    systemChat _text;
    LOG_SYS("WARNING",_text);
};

_minimalDelay = _minimalDelay * 60;
_maximumDelay = _maximumDelay * 60;
if (_condition isEqualType "") then {
    _condition = compile _condition;
};

if !(isNil QGVAR(blowoutSystemPfhHandle)) exitWith {
    [GVAR(blowoutSystemPfhHandle)] call CBA_fnc_removePerFrameHandler;
};
GVAR(blowoutSystemPfhHandle) = [{
    (_this select 0) params [
        "_lastBlowout",
        "_minimalDelay",
        "_maximumDelay",
        "_condition",
        "_blowoutTime",
        "_direction",
        "_useSirens",
        "_onlyPlayers",
        "_isLethal",
        "_environmentParticleEffects",
        "_psyWave"
    ];

    if !(missionNamespace getVariable [QGVAR(blowoutInProgress), false]) then {
        if (GVAR(debug)) then {
            systemChat format ["Blowout System: %1 | Max %2", CBA_missionTime - _lastBlowout - _minimalDelay, _maximumDelay - _minimalDelay];
        };
        if (CBA_missionTime - _lastBlowout >= ((_minimalDelay + random(_maximumDelay)) min _maximumDelay)) then {
            if ([] call _condition) then {
                [_blowoutTime, _direction, _useSirens, _onlyPlayers, _isLethal, _environmentParticleEffects, _psyWave] call FUNC(blowoutCoordinator);
                (_this select 0) set [0, CBA_missionTime + _blowoutTime + 60];
            } else {
                (_this select 0) set [0, CBA_missionTime];
            };
        };
    };
}, 30, [CBA_missionTime, _minimalDelay, _maximumDelay, _condition, _blowoutTime, _direction, _useSirens, _onlyPlayers, _isLethal, _environmentParticleEffects, _psyWave] ] call CBA_fnc_addPerFrameHandler;
