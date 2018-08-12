/*
	Function: anomaly_fnc_minceCorpse

	Description:
        Turns a given object into (coarsely) minced meat

    Parameter:
        _body - Object that is about to be minced (default: objNull)

    Returns:
        nothing

	Author:
	diwako 2017-12-11
*/
params[["_body",objNull]];

if(isNull _body) exitWith {};

if(isServer) then {
	_body hideObjectGlobal true;
	_body spawn {
		private _proxy = "Land_HelipadEmpty_F" createVehicle position _this;
		_proxy enableSimulationGlobal false;
		_proxy setPos (_this modelToWorld [0,0,0]);
		[_proxy, "anomaly_body_tear_1"] remoteExec ["say3D"];
		sleep 15;
		deleteVehicle _this;
		deleteVehicle _proxy;
	};
};

if(hasInterface) then {
	_source = "#particlesource" createVehicleLocal getPos _body;
	[_body, _source, "meat"] call anomalyEffect_fnc_meatgrinder;
	_source spawn {
		sleep 0.75;
		deleteVehicle _this;
	};
};