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
        private _proxy = "building" createVehicle position _this;
        _proxy setPos (_this modelToWorld [0,0,0]);
        _proxy enableSimulationGlobal false;
        [_proxy, "anomaly_body_tear_1"] remoteExec ["say3D"];
        sleep 15;
        deleteVehicle _this;
        deleteVehicle _proxy;
    };
};

if(hasInterface) then {
    private _source = "#particlesource" createVehicleLocal getPos _body;
    _source setPosWorld (getPosWorld _body);
    [_source, "meat"] call anomalyEffect_fnc_meatgrinder;
    _source spawn {
        sleep 0.75;
        deleteVehicle _this;
    };
};