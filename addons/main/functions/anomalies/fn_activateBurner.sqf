#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateBurner

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2017-12-13
*/
params[["_trg",objNull], ["_list",[]]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "burner") exitWith {};

_trg setVariable [QGVAR(cooldown), true, true];

private _men = nearestObjects [getPos _trg,  ["Man","LandVehicle","air"], 5] select {!(_x getVariable ["anomaly_ignore", false])};
{
    if !(_x isKindOf "Man" || _x isKindOf "LandVehicle" || _x isKindOf "air") then {
        deleteVehicle _x;
    };
} forEach _list;

[QGVAR(burnerEffect), [_trg]] call CBA_fnc_globalEvent;

{
    if (alive _x) then {
        if (_x isKindOf "Man") then {
            if (!isNil "ace_fire_enabled" && {ace_fire_enabled}) then {
                ["ace_fire_burn", [_x, 4], _x] call CBA_fnc_targetEvent;
            };
            [{
                ["burner", _this] call FUNC(addUnitDamage);
            }, _x, [0.5, 0] select (isPlayer _x)] call CBA_fnc_waitAndExecute;
        } else {
            private _curDam = _x getHitPointDamage "HitEngine";
            if (isNil "_curDam") then {
                _curDam = 0;
            };
            if (_curDam >= 1) then {
                _x setDamage [1, true, _x, _x];
            } else {
                [QGVAR(setHitPointDamage), [_x, ["HitEngine", _curDam + 0.15, false]], _x] call CBA_fnc_targetEvent;
                if !(_x isKindOf "tank") then {
                    [QGVAR(setHit), [_x, ["wheel_1_1_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_1_2_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_1_3_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_1_4_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_2_1_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_2_2_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_2_3_steering", 1]], _x] call CBA_fnc_targetEvent;
                    [QGVAR(setHit), [_x, ["wheel_2_4_steering", 1]], _x] call CBA_fnc_targetEvent;
                };
            };
        };
        [QGVAR(burnerOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } else {
        if !(_x isKindOf "LandVehicle" || _x isKindOf "Air") then {
            [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
        };
    };
} forEach _men;

[{
    _this setVariable [QGVAR(cooldown), false, true];
}, _trg, GVAR(anomalySettingBurnerCooldownMin) + random GVAR(anomalySettingBurnerCooldownRand)] call CBA_fnc_waitAndExecute;
