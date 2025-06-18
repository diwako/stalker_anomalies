#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateElectra

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
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "electra") exitWith {};

[QGVAR(electraEffect), [_trg, _list]] call CBA_fnc_globalEvent;

{
    deleteVehicle _x;
} forEach (_list select {!(_x isKindOf "Man" || {_x isKindOf "LandVehicle"} || {_x isKindOf "air"})});
{
    if (alive _x) then {
        if (_x isKindOf "LandVehicle" || _x isKindOf "air") then {
            // switch of the engine
            private _curDam = _x getHitPointDamage "HitEngine";
            [QGVAR(setHitPointDamage), [_x, ["HitEngine", 1, false, _x, _x]], _x] call CBA_fnc_targetEvent;
            private _curDam2 = _x getHitPointDamage "HitHull";
            [QGVAR(setHitPointDamage), [_x, ["HitHull", _curDam2 + 0.1, true, _x, _x]], _x] call CBA_fnc_targetEvent;
            [{
                params ["_veh", "_curDam"];
                [QGVAR(setHitPointDamage), [_veh, ["HitEngine", _curDam + 0.25, true, _veh, _veh]], _veh] call CBA_fnc_targetEvent;
            }, [_x, _curDam], 5] call CBA_fnc_waitAndExecute;
        } else {
            // [_x, getPos _trg, 2, 2] remoteExec [QFUNC(suckToLocation),_x];
            [{
                ["electra", _this] call FUNC(addUnitDamage);
            }, _x, 1 + (random 1)] call CBA_fnc_waitAndExecute;
        };
        [QGVAR(electraOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } else {
        if (!(_x isKindOf "LandVehicle" || _x isKindOf "air") ) then {
            [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
        };
    };
} forEach ((nearestObjects [getPos _trg,  ["Man", "LandVehicle", "air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])});

_trg setVariable [QGVAR(cooldown), true, true];
[{
    _this setVariable [QGVAR(cooldown), false, true];
}, _trg, GVAR(anomalySettingBurnerCooldownMin) + random GVAR(anomalySettingBurnerCooldownRand)] call CBA_fnc_waitAndExecute;
