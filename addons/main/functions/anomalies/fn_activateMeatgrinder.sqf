#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateMeatgrinder

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2017-12-11
*/

params[["_trg",objNull], ["_list",[]]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "meatgrinder") exitWith {};

_trg setVariable [QGVAR(cooldown), true, true];

{
    deleteVehicle _x;
} forEach (_list select {!(_x isKindOf "Man" || {_x isKindOf "LandVehicle"} || {_x isKindOf "Air"})});

private _men = (nearestObjects [getPos _trg,  ["Man", "LandVehicle" ,"Air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])};
private _sucked = [];
{
    if (alive _x) then {
        if (_x isKindOf "LandVehicle" || _x isKindOf "Air") then {
            if (getMass _x <= 10000) then {
                [QGVAR(suckToLocation), [_x, getPos _trg, 1, 5.8], _x] call CBA_fnc_targetEvent;
                _sucked pushBack _x;
            };
        } else {
            _sucked pushBack _x;
            [QGVAR(suckToLocation), [_x, getPos _trg, 2], _x] call CBA_fnc_targetEvent;
        };
    } else {
        if !(_x isKindOf "LandVehicle" || _x isKindOf "Air") then {
            [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
        };
    };
} forEach _men;

[QGVAR(meatgrinderEffect), [_trg]] call CBA_fnc_globalEvent;

[{
    params ["_trg", "_sucked"];
    {
        if (_x isKindOf "Man") then {
            // ace medical not needed, people trapped in this trap are dead
            _x setDamage [1, true, _x, _x];
            [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
        } else {
            private _curDam = _x getHitPointDamage "HitHull";
            [QGVAR(setHitPointDamage), [_x, ["HitHull", (_curDam + 0.45), true, _x, _x]], _x] call CBA_fnc_targetEvent;
        };
        [QGVAR(meatgrinderOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } forEach _sucked;
    [{
        _this setVariable [QGVAR(cooldown), false, true];
    }, _trg, anomalySettingMeatgrinderCooldownMin - MEATGRINDER_MIN_COOL_DOWN + random anomalySettingMeatgrinderCooldownRand] call CBA_fnc_waitAndExecute;
}, [_trg, _sucked], MEATGRINDER_MIN_COOL_DOWN] call CBA_fnc_waitAndExecute;
