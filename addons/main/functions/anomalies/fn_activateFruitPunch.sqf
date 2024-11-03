#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateFuitPunch

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2018-06-10
*/
if !(isServer) exitWith {};
params [["_trg",objNull], ["_list",[]]];

if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "fruitpunch") exitWith {};

private _proxy = _trg getVariable QGVAR(sound);
[QGVAR(say3D), [_proxy, selectRandom ["bfuzz_hit","buzz_hit"]]] call CBA_fnc_globalEvent;
_trg setVariable [QGVAR(cooldown), true];

private _source = "#particlesource" createVehicle getPos _trg;
_source setPosASL (getPosASL _trg);
[QGVAR(fruitPunchEffect), _source] call CBA_fnc_globalEvent;
{
    if (_x isKindOf "Man") then {
        ["fruitpunch", _x] call FUNC(addUnitDamage);
        [QGVAR(fruitpunchOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } else {
        if !(_x isKindOf "landvehicle" || _x isKindOf "air") then {
            deleteVehicle _x;
        };
    };
    false
} count (_list select {!(_x getVariable ["anomaly_ignore", false])});
[{
    deleteVehicle _this;
}, _source, 0.33] call CBA_fnc_waitAndExecute;
[{
    params ["_trg", "_source"];
    deleteVehicle _source;
    _trg setVariable [QGVAR(cooldown), false];
}, [_trg, _source], 2] call CBA_fnc_waitAndExecute;
