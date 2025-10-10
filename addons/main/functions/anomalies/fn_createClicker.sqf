#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createClicker

    Description:
        Creates an area anomaly of the type "Clicker"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])
        _radiusA - Radius A parameter of area anomaly (default: 10)
        _radiusB - Radius B parameter of area anomaly (default: 10)
        _isRectangle - is this anomaly rectangular shaped (default: true)
        _angle - Angle the anomaly should have (default: 0)
        _height - Height of the area (default: 8)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2025-02-20
*/
params[["_pos", [0,0,0]], ["_radiusA", 10], ["_radiusB", 10], ["_isRectangle", true], ["_angle" ,0], ["_height", 8]];

if !(isServer) exitWith {};

private _varName = "";
if !(_pos isEqualType []) then {
    _varName = vehicleVarName _pos;
    //created via module
    private _area = _pos getVariable "objectarea";
    _radiusA = _area#0;
    _radiusB = _area#1;
    _angle = _area#2;
    _isRectangle = _area#3;
    _height = _area#4;
    private _module = _pos;
    _pos = getPosASL _pos;
    deleteVehicle _module;
};

if (count _pos < 3) then {
    _pos set [2,0];
};
private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(detectable), false, true];
_trg setVariable [QGVAR(anomalyType), "clicker", true];

_trg setTriggerArea [_radiusA, _radiusB, _angle, _isRectangle, _height];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements [format ["this and !(thisTrigger getVariable ['%1',false])", QGVAR(cooldown)], format ["[thisTrigger, thisList] call %1", QFUNC(activateClicker)], ""];

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos), _pos];
    _marker setMarkerShapeLocal (["ELLIPSE", "RECTANGLE"] select _isRectangle);
    _marker setMarkerSizeLocal [_radiusA, _radiusB];
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _marker setMarkerDirLocal _angle;
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
