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
        // if (alive _x) then {
        if (!isNil "ace_medical_fnc_addDamageToUnit") then {
            // Ace medical is enabled
            private _dam = 1;
            if (isPlayer _x) then {
                _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 5;
            } else {
                _res = _x getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
                _dam = ((_res#0 + _res#1 + _res#2) / 3) / 3;
            };
            [QGVAR(aceDamage), [_x, _dam, selectRandom ["leg_l", "leg_r"], "stab", _x] , _x] call CBA_fnc_targetEvent;
        } else {
            // Ace medical is not enabled
            _dam = damage _x;
            _x setDamage (_dam + 0.2);
        };
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
