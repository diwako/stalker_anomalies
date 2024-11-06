#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateSpringboard

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
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "springboard") exitWith {};

_trg setVariable [QGVAR(cooldown), true, true];

[QGVAR(springboardEffect), [_trg]] call CBA_fnc_globalEvent;

[{
    params[["_trg",objNull],["_list",[]]];

    private _men = (nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])};
    {
        if (!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
            deleteVehicle _x;
        };
    } forEach _list;

    {
        if (alive _x) then {
            private _pos1 = getPos _x;
            private _pos2 = getPos _trg;
            private _a = ((_pos1 select 0) - (_pos2 select 0));
            private _b = ((_pos1 select 1) - (_pos2 select 1));
            if !(isPlayer _x) then {
                if !(_x isKindOf "landvehicle"  || _x isKindOf "air") then {
                    [{
                        ["springboard", _this] call FUNC(addUnitDamage);
                    }, _x, 0.5] call CBA_fnc_waitAndExecute;
                };
            } else {
                ["springboard", _x] call FUNC(addUnitDamage);
            };
            private _mult = 4;
            if (_x isKindOf "landvehicle" || _x isKindOf "air") then {
                if (getMass _x <= 10000) then {
                    _mult = _mult * 2;
                    private _curDam = _x getHitPointDamage "HitHull";
                    [QGVAR(setHitPointDamage), [_x, ["HitHull", (_curDam + 0.45), true, _x, _x]], _x] call CBA_fnc_targetEvent;
                } else {
                    _mult = 1;
                };
            };
            // [_x, [_a*_mult, _b*_mult, _mult + (5 / (1 + (abs _a) + (abs _b)))]] remoteExec ["setVelocity", _x];
            [QGVAR(setVelocity), [_x, [_a*_mult, _b*_mult, _mult + (5 / (1 + (abs _a) + (abs _b)))]], _x] call CBA_fnc_targetEvent;
            [QGVAR(springboardOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
        } else {
            if !(_x isKindOf "landvehicle" || _x isKindOf "air") then {
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            };
        };
    } forEach _men;

    [{
        _this setVariable [QGVAR(cooldown), false, true];
    }, _trg, GVAR(anomalySettingSpringboardCooldownMin) - SPRINGBOARD_MIN_COOL_DOWN + random GVAR(anomalySettingSpringboardCooldownRand)] call CBA_fnc_waitAndExecute;
}, _this, 0.25] call CBA_fnc_waitAndExecute;
