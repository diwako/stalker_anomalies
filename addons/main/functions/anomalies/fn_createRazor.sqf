#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
  Function: diwako_anomalies_main_fnc_createRazor

  Description:
        Creates an anomaly of the type "Razor"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])

    Returns:
        Anomaly Trigger

  Author:
  diwako 2025-06-20
*/
params[["_pos",[0,0,0]]];

if (!isServer) exitWith {};

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
// _trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "razor", true];
_trg setVariable [QGVAR(detectable), false, true];

private _jipID = [QGVAR(setTrigger), [
    _trg, //trigger
    [4, 4, 0, false, 4], // area
    ["ANY", "PRESENT", true], // activation
    [format ["[thisTrigger, thisList] call %1", QFUNC(activateRazor)], "", ""] // statements
]] call CBA_fnc_globalEventJip;
[_jipID, _trg] call CBA_fnc_removeGlobalEventJIP;

_jipID = [QGVAR(createBlocker), [_trg]] call CBA_fnc_globalEventJip;
[_jipID, _trg] call CBA_fnc_removeGlobalEventJIP;

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
