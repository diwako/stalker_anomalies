#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateComet

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2024-10-19
*/
params[["_trg",objNull], ["_list",[]]];
if (isNull _trg || _trg getVariable [QGVAR(anomalyType),""] != "comet") exitWith {};

private _local = _list select {local _x && {!(_x getVariable ["anomaly_ignore", false])}};

// no need to do anything here, nothing local to handle
if (_local isEqualTo []) exitWith {};

_trg setVariable [QGVAR(cooldown), true];
{
    if (_x isKindOf "Man") then {
        if !(isNil "ace_fire_fnc_burn") then {
            [_x, 4] call ace_fire_fnc_burn;
        };
        if (isPlayer _x) then {
            ["comet", _x] call FUNC(addUnitDamage);
        } else {
            [{
                ["comet", _this] call FUNC(addUnitDamage);
            }, _x, 0.5] call CBA_fnc_waitAndExecute;
        };
    } else {
        private _curDam = _x getHitPointDamage "HitEngine";
        if (isNil "_curDam") then {
            _curDam = 0;
        };
        if (_curDam >= 1) then {
            _x setDamage 1;
        } else {
            _x setHitPointDamage ["HitEngine", (_curDam + 0.15), true, _x, _x];
            if !(_x isKindOf "tank") then {
                _x setHit ["wheel_1_1_steering", 1];
                _x setHit ["wheel_1_2_steering", 1];
                _x setHit ["wheel_1_3_steering", 1];
                _x setHit ["wheel_1_4_steering", 1];
                _x setHit ["wheel_2_1_steering", 1];
                _x setHit ["wheel_2_2_steering", 1];
                _x setHit ["wheel_2_3_steering", 1];
                _x setHit ["wheel_2_4_steering", 1];
            };
        };
    };
    [QGVAR(cometOnDamage), [_x, _trg getVariable QGVAR(sourceTrg)]] call CBA_fnc_localEvent;
} forEach _local;

[{
    _this setVariable [QGVAR(cooldown), false];
}, _trg, 1] call CBA_fnc_waitAndExecute;
