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
params [["_trg", objNull], ["_list",[]]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "fruitpunch") exitWith {};

_trg setVariable [QGVAR(cooldown), true];

[QGVAR(fruitPunchEffect), [_trg]] call CBA_fnc_globalEvent;
{
    if (_x isKindOf "Man") then {
        ["fruitpunch", _x] call FUNC(addUnitDamage);
        [QGVAR(fruitpunchOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } else {
        if !(_x isKindOf "LandVehicle" || _x isKindOf "air") then {
            deleteVehicle _x;
        };
    };
} forEach (_list select {!(_x getVariable ["anomaly_ignore", false])});

[{
    _this setVariable [QGVAR(cooldown), false];
}, _trg, 2] call CBA_fnc_waitAndExecute;
