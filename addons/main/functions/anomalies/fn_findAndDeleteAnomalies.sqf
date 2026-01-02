#include "\z\diwako_anomalies\addons\main\script_component.hpp"

params ["_pos", "_radius"];

[QGVAR(deleteAnomalies), [(_pos nearObjects ["EmptyDetector", _radius]) select {_x getVariable [QGVAR(anomalyType), ""] isNotEqualTo ""}]] call CBA_fnc_serverEvent;
