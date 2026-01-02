#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createWillowisp

    Description:
        Creates an anomaly of the type "Will-o'-wisp"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0])
        _color - Color of the lights as an RGB array, string "randomColor" for a random color, or a CfgMarker entry (default: "randomColor")
        _count - Number of lights (default: -1, random between 1 and 5)
        _spread - Maximum distance from the center point in meters (default: 15)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2025-12-30
*/
params [["_pos",[0,0,0]], ["_color", "randomColor", ["", []]], ["_count", -1], ["_spread", 15]];
if !(isServer) exitWith {};

private _varName = "";
if !(_pos isEqualType []) then {
    _varName = vehicleVarName _pos;
    //created via module
    _color = _pos getVariable ["color", "randomColor"];
    _count = _pos getVariable ["count", -1];
    _spread = _pos getVariable ["spread", 15];

    private _module = _pos;
    _pos = getPosASL _pos;
    deleteVehicle _module;
};

if (_count isEqualTo 0) exitWith {};

if (_color isEqualType "") then {
    if (_color isEqualTo "randomColor") then {
        _color = [random 1, random 1, random 1];
    } else {
        _color = getArray (configFile >> "CfgMarkerColors" >> _color >> "color");
        if (_color isEqualTo []) then {
            _color = [random 1, random 1, random 1];
        };
    };
};

if (count _color > 3) then {
    _color = _color select [0,3];
};

if (_count isEqualTo -1) then {
    _count = ceil random 5;
};
_count = round _count;

private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setVariable [QGVAR(color), _color, true];
_trg setVariable [QGVAR(count), _count, true];
_trg setVariable [QGVAR(spread), _spread, true];
_trg setVariable [QGVAR(detectable), false, true];
_trg setVariable [QGVAR(anomalyType), "willowisp", true];

if (isNil QGVAR(holder)) then {
  GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos), _pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker), _marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
