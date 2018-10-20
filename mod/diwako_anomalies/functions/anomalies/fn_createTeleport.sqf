/*
	Function: anomaly_fnc_createTeleport

	Description:
        Creates an anomaly of the type "teleport"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])
		_id - ID which connects teleporters

    Returns:
        Anomaly Trigger

	Author:
	diwako 2017-12-14
*/
params[["_pos",[0,0,0]],["_id",-1]];
if(!isServer) exitWith {};

if(typeName _pos != typeName []) then {
	//created via module
	_id = _pos getVariable ["anomalyid",-1];
	_pos = [_pos] call anomaly_fnc_getLocationFromModule;
};

if(count _pos < 3) then {
	_pos set [2,0];
};

if(_id < 0) exitWith {
	hintC ("Teleport Anomaly ID cannot be below 0. Affected anomaly at " + str(_pos));
};

if (isNil "ANOMALY_TELEPORT_IDS") then {
  ANOMALY_TELEPORT_IDS = [[], []] call CBA_fnc_hashCreate;
};

_teleporters = [ANOMALY_TELEPORT_IDS, _id] call CBA_fnc_hashGet;

if( (count _teleporters) >= 2) exitWith {
	hintC ("Teleport Anomaly with ID " + str(_id) + " cannot be created as there are already 2 anomalies with that id. Affected anomaly at " + str(_pos));
};

_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosATL _pos;
_teleporters pushBack _trg;
[ANOMALY_TELEPORT_IDS, _id, _teleporters] call CBA_fnc_hashSet;
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_teleport_id", _id, true];
_trg setVariable ["anomaly_type", "teleport", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable ["anomaly_sound", _proxy, true];
[
	_trg, //trigger
	[2, 2, 0, false,4], // area
	["ANY", "PRESENT", true], // activation
	["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateTeleport", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg];

if(isNil "ANOMALIES_HOLDER") then {
	ANOMALIES_HOLDER = [];
};

ANOMALIES_HOLDER pushBackUnique _trg;
// publicVariable "ANOMALIES_HOLDER";

// used for deleting anomalies triggered from client
publicVariable "ANOMALY_TELEPORT_IDS";

// set up idle sound speaker;
_trg2 = createTrigger ["EmptyDetector", _pos];
_trg2 setPosATL _pos;
_proxy = "Land_HelipadEmpty_F" createVehicle position _trg2;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg2 modelToWorld [0,0,0.5]);
_trg2 setVariable ["anomaly_idle_sound", _proxy, true];
[
	_trg2, //trigger
	[25, 25, 0, false, 2], // area
	["ANY", "PRESENT", true], // activation
	["this && !(thisTrigger getVariable ['anomaly_cooldown',false]) && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; _proxy = _thisTrigger getVariable 'anomaly_idle_sound'; while{!isNull _thisTrigger && {triggerActivated _thisTrigger} do {_proxy say3D 'teleport_idle'; sleep 3.67075}}", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg];

if(!isNil "ANOMALY_DEBUG" && {ANOMALY_DEBUG}) then {
	_marker = createMarkerLocal [str(_pos),_pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "hd_dot";
	_marker setMarkerTextLocal (_trg getVariable "anomaly_type");
	_trg setVariable ["debug_marker",_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;
_trg2 enableDynamicSimulation false;
_trg2 enableSimulationGlobal false;

_trg
