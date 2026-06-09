#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createQuarry

    Description:
        Creates an anomaly of the type "Quarry"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0])

    Returns:
        Anomaly Trigger

    Author:
    diwako 2026-06-08
*/
params [["_pos", [0,0,0]]];

if !(isServer) exitWith {};

private _varName = "";
if !(_pos isEqualType []) then {
    _varName = vehicleVarName _pos;
};
_pos = [_pos] call FUNC(getLocationFromModule);

if (count _pos < 3) then {
    _pos set [2,0];
};
private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "quarry", true];
_trg setVariable [QGVAR(detectorOffset), 2.5, true];

_trg setTriggerArea [7.5, 7.5, 0, false, 10];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements [format ["this && (thisList select {alive _x && {_x isKindOf 'Land'} && {lifeState _x != 'INCAPACITATED'}}) isNotEqualTo [] && !(thisTrigger getVariable ['%1',false])", QGVAR(cooldown)], format ["[thisTrigger, thisList] call %1", QFUNC(activateQuarry)], ""];

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
