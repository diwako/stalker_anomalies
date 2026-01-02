#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createPsyField

    Description:
        Creates an anomaly of the type "Psy". Harmless anomaly, it just causes the psy effect

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0])
        _strength - Strength of the anomaly, range from 1 to 3 (default: 1)
        _radiusA - Radius A parameter of area anomaly (default: 10)
        _radiusB - Radius B parameter of area anomaly (default: 10)
        _isRectangle - is this anomaly rectangular shaped (default: true)
        _angle - Angle the anomaly should have (default: 0)
        _height - Height of the anomaly, -1 for infinite (default: -1)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2026-01-02
*/
params[["_pos", [0,0,0]], ["_strength", 1], ["_radiusA", 10], ["_radiusB", 10], ["_isRectangle", true], ["_angle", 0], ["_height", -1]];
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

    _strength = _pos getVariable "strength";

    private _module = _pos;
    _pos = getPosASL _pos;
    deleteVehicle _module;
};

_strength = round (_strength min 3);
if (_strength < 1) exitWith {};

if (count _pos < 3) then {
    _pos set [2,0];
};

private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setDir _angle;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "psy", true];
_trg setVariable [QGVAR(strength), str _strength, true];
_trg setVariable [QGVAR(detectable), false, true];

private _psyID = format ["psy_trigger#%1", _pos];

private _jipID = [QGVAR(setTrigger), [
    _trg, //trigger
    [_radiusA, _radiusB, _angle, _isRectangle, _height], // area
    ["ANY", "PRESENT", true], // activation
    ["this && hasInterface && {([] call CBA_fnc_currentUnit) in thisList}", format ["[%2, '%3'] call %1", QFUNC(psyEffect), _strength, _psyID], format ["[0, '%2'] call %1", QFUNC(psyEffect), _psyID]] // statements
]] call CBA_fnc_globalEventJip;
[_jipID, _trg] call CBA_fnc_removeGlobalEventJIP;

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;
// publicVariable QGVAR(holder);

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal (["ELLIPSE", "RECTANGLE"] select _isRectangle);
    // _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerSizeLocal [_radiusA, _radiusB];
    _marker setMarkerDirLocal _angle;
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
