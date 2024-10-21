#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createElectra

    Description:
        Creates an anomaly of the type "Electra"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])

    Returns:
        Anomaly Trigger

    Author:
    diwako 2017-12-11
*/
params[["_pos",[0,0,0]]];

if (!isServer) exitWith {};

_pos = [_pos] call FUNC(getLocationFromModule);

if (count _pos < 3) then {
    _pos set [2,0];
};

private _trg = createTrigger ["EmptyDetector", _pos];
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "electra", true];
private _proxy = "building" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable [QGVAR(sound), _proxy, true];
[QGVAR(setTrigger), [
    _trg, //trigger
    [4, 4, 0, false,4], // area
    ["ANY", "PRESENT", true], // activation
    [format ["this and !(thisTrigger getVariable ['%1',false])", QGVAR(cooldown)], format ["[thisTrigger,thisList] call %1", QFUNC(activateElectra)], ""] // statements
]] call CBA_fnc_globalEventJip;

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
