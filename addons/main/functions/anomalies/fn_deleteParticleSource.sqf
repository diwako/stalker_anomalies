#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_trg"];
if !(hasInterface) exitWith {};
deleteVehicle (_trg getVariable [QGVAR(particleSource), objNull]);
deleteVehicle (_trg getVariable [QGVAR(particleSource2), objNull]);
