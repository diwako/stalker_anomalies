#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_minceCorpse

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

if (isNull _body) exitWith {};

if (isServer) then {
    _body hideObjectGlobal true;
    private _proxy = "building" createVehicle position _body;
    _proxy setPosASL getPosASL _body;
    _proxy enableSimulationGlobal false;
    // _proxy setPos (_this modelToWorld [0,0,0]);
    [QGVAR(say3D), [_proxy, "anomaly_body_tear_1"]] call CBA_fnc_globalEvent;
    [{
        params ["_body", "_proxy"];
        deleteVehicle _body;
        deleteVehicle _proxy;
    }, [_body, _proxy], 15] call CBA_fnc_waitAndExecute;
};

if (hasInterface) then {
    private _source = "#particlesource" createVehicleLocal getPos _body;
    _source setPosASL (getPosASL _body);
    [_source, "meat"] call FUNC(meatgrinderEffect);
    [{
        deleteVehicle _this;
    }, _source, 0.75] call CBA_fnc_waitAndExecute;
};
