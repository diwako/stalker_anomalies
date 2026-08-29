#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateMagma

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2026-08-29
*/

params[["_trg", objNull], ["_list", []]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType), ""] != "magma") exitWith {};

private _target = selectRandom _list;
_trg setVariable [QGVAR(active), true, true];

[QGVAR(magmaActivation), [_trg, _target]] call CBA_fnc_globalEvent;

[{
    params ["_trg", "_target"];
    !((_target inArea _trg) && {alive _target} && {lifeState _target != "INCAPACITATED"})
}, {
    params ["_trg"];
    _trg setVariable [QGVAR(active), false, true];
    _trg setVariable [QGVAR(cooldown), true, true];
    [{
        _this setVariable [QGVAR(cooldown), false, true];
    }, _trg, GVAR(anomalySettingMagmaCooldownMin) + random GVAR(anomalySettingMAgmarCooldownRand)] call CBA_fnc_waitAndExecute;
}, [_trg, _target]] call CBA_fnc_waitUntilAndExecute
