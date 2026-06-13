#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateQuarry

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2026-06-08
*/
params[["_trg", objNull], ["_list", []]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "quarry") exitWith {};


_list = _list select {alive _x && {_x isKindOf 'Land'} && {lifeState _x != 'INCAPACITATED'} && !(_x getVariable ["anomaly_ignore", false])};

if (_list isEqualTo []) exitWith {};

_trg setVariable [QGVAR(cooldown), true, true];

_list = _list apply {[_x isKindOf "CAManBase", _trg distanceSqr _x, _x]};
_list sort true;
private _target = _list select 0 select 2;

private _rnd = [-5 + random 10, -5 + random 10, 2 + random 7];
[QGVAR(quarryProjectileEffect), [_trg, _rnd, _target]] call CBA_fnc_globalEvent;

private _posProjectile = (position _trg) vectorAdd _rnd;
[{
    params ["_pos", "_target"];
    private _vector = (_pos vectorFromTo (position _target vectorAdd [0, 0, 1])) vectorMultiply 40;
    private _projectile = QGVAR(quarryProjectile) createVehicle _pos;
    _projectile setVelocity _vector;
}, [_posProjectile, _target], 2] call CBA_fnc_waitAndExecute;

[{
    _this setVariable [QGVAR(cooldown), false, true];
}, _trg, GVAR(anomalySettingQuarryCooldownMin) + random GVAR(anomalySettingQuarryCooldownRand)] call CBA_fnc_waitAndExecute;
