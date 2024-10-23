#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createTeleport

    Description:
        Creates an anomaly of the type "teleport"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])
        _id - ID which connects teleporters

    Returns:
        Anomaly Trigger

    Author:
    diwako 2017-12-14
*/
params[["_pos",[0,0,0]],["_id",-1]];
if !(isServer) exitWith {};

if !(_pos isEqualType []) then {
    //created via module
    _id = _pos getVariable ["anomalyid",-1];
    _pos = [_pos] call FUNC(getLocationFromModule);
};

if (count _pos < 3) then {
    _pos set [2,0];
};

if (_id < 0) exitWith {
    hintC ("Teleport Anomaly ID cannot be below 0. Affected anomaly at " + str(_pos));
};

if (isNil QGVAR(teleportIDs)) then {
//   GVAR(teleportIDs) = [[], []] call CBA_fnc_hashCreate;
  GVAR(teleportIDs) = createHashMap;
};

// _teleporters = [GVAR(teleportIDs), _id] call CBA_fnc_hashGet;
_teleporters = GVAR(teleportIDs) getOrDefault [_id, []];

_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosASL _pos;
_teleporters pushBack _trg;
// [GVAR(teleportIDs), _id, _teleporters] call CBA_fnc_hashSet;
GVAR(teleportIDs) set [_id, _teleporters];
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(teleportID), _id, true];
_trg setVariable [QGVAR(anomalyType), "teleport", true];
private _proxy = "building" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable [QGVAR(sound), _proxy, true];
[QGVAR(setTrigger), [
    _trg, //trigger
    [2, 2, 0, false,4], // area
    ["ANY", "PRESENT", true], // activation
    [format ["this and !(thisTrigger getVariable ['%1',false])", QGVAR(cooldown)], format ["[thisTrigger,thisList] call %1", QFUNC(activateTeleport)], ""] // statements
]] call CBA_fnc_globalEventJip;

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;
// publicVariable QGVAR(holder);

// used for deleting anomalies triggered from client
publicVariable QGVAR(teleportIDs);

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
