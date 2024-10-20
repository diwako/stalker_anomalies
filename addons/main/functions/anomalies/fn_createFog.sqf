#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createFog

    Description:
        Creates an anomaly of the type "Fog"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])
        _radius - Radius parameter of area anomaly (default: 10)
        _isRectangle - is this anomaly rectangular shaped (default: true)

        Currently under construction and does not work on effect right now
        _angle - Angle the anomaly should have (default: 0)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2018-05-22
*/
params[["_pos",[0,0,0]],["_radius",10],["_isRectangle",true],["_angle",0]];
if (!isServer) exitWith {};

if !(_pos isEqualType []) then {
    //created via module
    private _area = _pos getVariable "objectarea";
    _radius = _area#0;
    _isRectangle = _area#3;
    // _angle = _area#2;
    private _module = _pos;
    _pos = getPosASL _pos;
    deleteVehicle _module;
};
private _angle = 0;

if (count _pos < 3) then {
    _pos set [2,0];
};

_pos set [2,(_pos#2) - 2];
_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosASL _pos;
_trg setDir _angle;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "fog", true];
_trg setVariable [QGVAR(radius), _radius, true];
_trg setVariable [QGVAR(angle), _angle, true];
_trg setVariable [QGVAR(rectangle), _isRectangle, true];
[QGVAR(setTrigger), [
    _trg, //trigger
    [_radius, _radius, _angle, _isRectangle, 4], // area
    ["ANY", "PRESENT", true], // activation
    ["this && {round (cba_missiontime mod 2) == 1}", format ["[thisTrigger, thisList] call %1", QFUNC(activateFog)], ""] // statements
]] call CBA_fnc_globalEventJip;

if (isNil QGVAR(holder)) then {
  GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;
// publicVariable QGVAR(holder);

if (GVAR(debug)) then {
    _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal (["ELLIPSE", "RECTANGLE"] select _isRectangle);
    // _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerSizeLocal [_radius, _radius];
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
