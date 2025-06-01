#include "\z\diwako_anomalies\addons\main\script_component.hpp"

params ["_module"];

if (isNil QGVAR(proceduralExclusionZones)) then {
    GVAR(proceduralExclusionZones) = [];
};

(_module getVariable "objectarea") params ["_radiusA", "_radiusB", "_angle", "_isRectangle", "_height"];
private _pos = getPosASL _module;

GVAR(proceduralExclusionZones) pushBack [
    _pos,
    _radiusA,
    _radiusB,
    _angle,
    _isRectangle,
    _height
];
