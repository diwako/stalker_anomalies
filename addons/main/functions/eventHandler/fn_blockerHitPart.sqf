#include "\z\diwako_anomalies\addons\main\script_component.hpp"
(_this select 0) params ["", "", "", "_position", "_velocity"];

[QGVAR(blockerEffect), [_position, _velocity]] call CBA_fnc_globalEvent;
