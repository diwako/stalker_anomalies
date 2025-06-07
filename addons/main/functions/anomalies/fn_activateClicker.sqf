#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateClicker

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2025-02-20
*/
params[["_trg", objNull], ["_list", []]];
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "clicker") exitWith {};

private _targets = _list select {alive _x && {lifeState _x != "INCAPACITATED" && {!(_x getVariable [QGVAR(isGettingClicked), false]) && {!(_x getVariable ["anomaly_ignore", false])}}}};

_trg setVariable [QGVAR(cooldown), true];
if (_targets isEqualTo []) exitWith {
    [{
        _this setVariable [QGVAR(cooldown), false];
    }, _trg, 1] call CBA_fnc_waitAndExecute;
};

private _target = selectRandom _targets;
_target setVariable [QGVAR(isGettingClicked), true];
[{
    _this setVariable [QGVAR(isGettingClicked), false];
}, _target, CLICKER_EXPLODE_TIME + 2 + random 5] call CBA_fnc_waitAndExecute;

[{
    _this setVariable [QGVAR(cooldown), false];
}, _trg, GVAR(anomalySettingClickerCooldownMin) + random GVAR(anomalySettingClickerCooldownRand)] call CBA_fnc_waitAndExecute;

private _velocity = vectorNormalized velocity _target;
private _flashBandPos = getPosASL _target vectorAdd (_velocity vectorMultiply ((speed _target) * 1/4 * (CLICKER_EXPLODE_TIME + 0.5))) vectorAdd [0, 0, 1.25];

private _pelvisPos = AGLToASL (_target modelToWorld (_target selectionPosition "pelvis"));
private _intersect = lineIntersectsSurfaces [_pelvisPos, _flashBandPos, _target, objNull, true, -1, "FIRE", "GEOM"];
// move flashbang infront of a blocking wall or terrain
if (_intersect isNotEqualTo []) then {
    {
        private _obj = _x select 2;
        if !(!isNull _obj && ({_obj isKindOf "Man" || {_obj isKindOf "LandVehicle" || {_obj isKindOf "air"}}})) exitWith {
            private _distPartial = ((_pelvisPos distance (_x select 0)) - 0.4) max 0;
            _flashBandPos = getPosASL _target vectorAdd (vectorNormalized (_pelvisPos vectorFromTo _flashBandPos) vectorMultiply _distPartial);
        };
    } forEach _intersect;
};

[QGVAR(clickerEffect), [_flashBandPos]] call CBA_fnc_globalEvent;
[{
    params ["_pos", "_list", "_trg"];
    private _targets = nearestObjects [ASLToAGL _pos, ["Man", "LandVehicle", "air"], 3] select {
        alive _x && {
        !(_x getVariable ["anomaly_ignore", false]) && {
        (lineIntersectsSurfaces [AGLToASL (_x modelToWorld (_x selectionPosition "pelvis")), _pos, _x, objNull, true, 1, "FIRE", "GEOM"]) isEqualTo []}}
    };
    {
        if (_x isKindOf "Man") then {
            if (!isNil "ace_fire_enabled" && {ace_fire_enabled}) then {
                ["ace_fire_burn", [_x, 1.1], _x] call CBA_fnc_targetEvent;
            };
            if (isPlayer _x) then {
                [QGVAR(teleportFlash), nil, _x] call CBA_fnc_targetEvent;
            };
            ["clicker", _x] call FUNC(addUnitDamage);
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
        [QGVAR(clickerOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
    } forEach _targets;

    {
        if !(_x isKindOf "Man" || _x isKindOf "LandVehicle" || _x isKindOf "air") then {
            deleteVehicle _x;
        };
    } forEach _list;
}, [_flashBandPos, _list, _trg], CLICKER_EXPLODE_TIME] call CBA_fnc_waitAndExecute;
