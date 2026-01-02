#include "\z\diwako_anomalies\addons\main\script_component.hpp"

params ["_objects", "_args"];

private _set = _args isEqualTo 1;

{
    _x setVariable ["anomaly_ignore", _set, true];
} forEach _objects;
