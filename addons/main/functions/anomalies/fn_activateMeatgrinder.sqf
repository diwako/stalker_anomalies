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

params[["_trg",objNull],["_list",[]]];

if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "meatgrinder") exitWith {};

private _sucked = [];
if (isServer) then {
    _trg setVariable [QGVAR(cooldown), true, true];
    _men = (nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])};
    private _proxy = _trg getVariable QGVAR(sound);
    [QGVAR(say3D), [_proxy, "anomaly_mincer_blowout"]] call CBA_fnc_globalEvent;
    {
        if (!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
            deleteVehicle _x;
        };
    } forEach _list;
    {
        if (alive _x) then {
            if (_x isKindOf "landvehicle" || _x isKindOf "air") then {
                if (getMass _x <= 10000) then {
                    [QGVAR(suckToLocation), [_x, getPos _trg, 1, 5.8], _x] call CBA_fnc_targetEvent;
                    _sucked pushBackUnique _x;
                };
            } else {
                _sucked pushBackUnique _x;
                [QGVAR(suckToLocation), [_x, getPos _trg, 2], _x] call CBA_fnc_targetEvent;
            };
        } else {
            if (!(_x isKindOf "landvehicle") || _x isKindOf "air") then {
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            };
        };
    } forEach _men;
};

[{
    params ["_trg", "_sucked"];
    if (hasInterface) then {
        private _source = "#particlesource" createVehicleLocal getPos _trg;
        _source setPosASL (getPosASL _trg);
        [_source, "active"] call FUNC(springboardEffect);
        [{
            deleteVehicle _this;
        }, _source, 1] call CBA_fnc_waitAndExecute;
    };

    if (isServer) then {
        {
            if (_x isKindOf "Man") then {
                // ace medical not needed, people trapped in this trap are dead
                _x setDamage 1;
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            } else {
                private _curDam = _x getHitPointDamage "HitHull";
                [QGVAR(setHitPointDamage), [_x, ["HitHull", (_curDam + 0.45), true, _x, _x]], _x] call CBA_fnc_targetEvent;
            };
        } forEach _sucked;
        [{
            _this setVariable [QGVAR(cooldown), false, true];
        }, _trg, anomalySettingMeatgrinderCooldownMin - MEATGRINDER_MIN_COOL_DOWN + random anomalySettingMeatgrinderCooldownRand] call CBA_fnc_waitAndExecute;
    };
}, [_trg, _sucked], MEATGRINDER_MIN_COOL_DOWN] call CBA_fnc_waitAndExecute;
