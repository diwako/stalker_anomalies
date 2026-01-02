#include "\z\diwako_anomalies\addons\main\script_component.hpp"

params ["_objects", "_args"];

private _set = _args isEqualTo 1;

_objects findIf { _x getVariable ["anomaly_ignore", false] isNotEqualTo _set } != -1;
