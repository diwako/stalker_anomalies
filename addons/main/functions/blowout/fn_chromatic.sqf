#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_chromatic

    Description:
        Create a visual chromatic effect for a short time on a player's screen

    Parameters:
        nothing

    Returns:
        nothing

    Author:
    diwako 2026-10-26
*/
if !(hasInterface) exitWith{};
if (GVAR(debug)) then {
    systemChat "Chromatic effect!";
};
if (isNil QGVAR(ppeChromAberration)) then {
    private _name = "ChromAberration";
    private _priority = 400;
    GVAR(ppeChromAberration) = ppEffectCreate [_name, _priority];
    while {
        GVAR(ppeChromAberration) < 0
    } do {
        _priority = _priority + 1;
        GVAR(ppeChromAberration) = ppEffectCreate [_name, _priority];
    };
};
GVAR(ppeChromAberration) ppEffectEnable true;
GVAR(ppeChromAberration) ppEffectAdjust [0.25,0,true];
GVAR(ppeChromAberration) ppEffectCommit 0.5;

[{
    GVAR(ppeChromAberration) ppEffectAdjust [0,0,true];
    GVAR(ppeChromAberration) ppEffectCommit 1.5;
}, nil, 0.5] call CBA_fnc_waitAndExecute;

[{
    GVAR(ppeChromAberration) ppEffectEnable false;
}, nil, 2.1] call CBA_fnc_waitAndExecute;
nil
