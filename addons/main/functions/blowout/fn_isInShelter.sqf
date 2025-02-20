#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_isInShelter

    Description:
        Check if a given unit is in shelter of a blowout

    Parameters:
        _unit - the unit to check if in shelter (default: objNull)

    Returns:
        nothing

    Author:
    diwako 2024-10-27
*/
params [["_unit", objNull, [objNull]]];

if (_unit getVariable ["blowout_safe", false] || {
    _unit getVariable ["anomaly_ignore", false] || {
    !alive _unit // the dead do not need to fear this anymore
}}) exitWith {true};

private _inside = insideBuilding _unit isEqualTo 1;
if (!isPlayer _unit || !_inside) exitWith {
    _inside
};

private _eyePos = eyePos _unit;

// up
private _trace = lineIntersectsSurfaces [_eyePos vectorAdd [0.5, 0, 0], _eyePos vectorAdd [0.5, 0, 10], _unit, objNull, true, -1, "GEOM", "NONE", true];
if (_trace isEqualTo [] || {_trace findIf {_x select 3 isKindOf "Building"} == -1}) exitWith {false};

_trace = lineIntersectsSurfaces [_eyePos vectorAdd [0, 0.5, 0], _eyePos vectorAdd [0, 0.5, 10], _unit, objNull, true, -1, "GEOM", "NONE", true];
if (_trace isEqualTo [] || {_trace findIf {_x select 3 isKindOf "Building"} == -1}) exitWith {false};

_trace = lineIntersectsSurfaces [_eyePos vectorAdd [-0.5, 0, 0], _eyePos vectorAdd [-0.5, 0, 10], _unit, objNull, true, -1, "GEOM", "NONE", true];
if (_trace isEqualTo [] || {_trace findIf {_x select 3 isKindOf "Building"} == -1}) exitWith {false};

_trace = lineIntersectsSurfaces [_eyePos vectorAdd [0, -0.5, 0], _eyePos vectorAdd [0, -0.5, 10], _unit, objNull, true, -1, "GEOM", "NONE", true];
_trace isNotEqualTo [] && {_trace findIf {_x select 3 isKindOf "Building"} != -1}
