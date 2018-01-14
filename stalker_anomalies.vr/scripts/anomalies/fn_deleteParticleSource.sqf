params["_trig"];
if(!hasInterface) exitWith {};
_source = _trig getVariable ["anomaly_particle_source", objNull];
if(!(isNull _source)) then {
	deleteVehicle _source;
};