#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_trig"];
if !(hasInterface) exitWith {};
deleteVehicle (_trig getVariable [QGVAR(particleSource), objNull]);
deleteVehicle (_trig getVariable [QGVAR(particleSource2), objNull]);
