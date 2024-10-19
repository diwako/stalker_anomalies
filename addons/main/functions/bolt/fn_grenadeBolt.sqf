#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

params ["_projectile"];

private _obj = createVehicle [QGVAR(boltThrowDummy), getPos _projectile, [], 0, "CAN_COLLIDE"];
// private _obj = createVehicle ["Land_Balloon_01_air_F", getPos _projectile, [], 0, "CAN_COLLIDE"];
_obj attachTo [_projectile];
[{
    detach _this;
    deleteVehicle _this;
}, _obj, 10] call CBA_fnc_waitAndExecute;

nil
