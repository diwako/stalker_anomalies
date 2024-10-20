#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createFruitPunch

    Description:
        Creates an anomaly of the type "Fruit Punch"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])

    Returns:
        Anomaly Trigger

    Author:
    diwako 2018-06-10
*/
params[["_pos",[0,0,0]]];
if !(isServer) exitWith {};

_pos = [_pos] call FUNC(getLocationFromModule);

if (count _pos < 3) then {
    _pos set [2,0];
};

_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "fruitpunch", true];
private _radius = 1.5;
_trg setTriggerArea [_radius, _radius, 0, false, 2];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements [format ["this && {!(thisTrigger getVariable ['%1', false])}", QGVAR(cooldown)], format ["[thisTrigger, thisList] call %1", QFUNC(activateFruitPunch)], ""];

private _proxy = "building" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable [QGVAR(sound), _proxy, true];

private _field = createSimpleObject ["BloodPool_01_Large_New_F", _pos];
_field enableSimulationGlobal false;
_field setPosASL _pos;
_field setDir (random 360);
_field setObjectMaterialGlobal [0, "a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"];
_field setObjectTextureGlobal [0, QPATHTOF(data\textures\fruitpunch) + str (floor random 2) + ".paa"];
_trg setVariable ["field",_field];

private _light = "#lightpoint" createVehicle _pos;
[QGVAR(setLight), [_light, 0.25,[0.4, 0.6, 0.1],[0.5, 1, 1, 4, 0.5, 5],[0.4, 0.6, 0.1],true,false]] call CBA_fnc_globalEventJip;

_trg setVariable ["light",_light];

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
