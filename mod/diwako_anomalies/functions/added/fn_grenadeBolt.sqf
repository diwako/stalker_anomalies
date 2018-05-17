/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

params ["_projectile"];

private _obj = createVehicle ["bolt_throw_dummy", getPos _projectile, [], 0, "CAN_COLLIDE"]; 
// private _obj = createVehicle ["Land_Balloon_01_air_F", getPos _projectile, [], 0, "CAN_COLLIDE"]; 
_obj attachTo [_projectile]; 

[_obj] spawn {
	params ["_obj"];
	sleep 10;
	detach _obj;
	deleteVehicle _obj;
};

nil