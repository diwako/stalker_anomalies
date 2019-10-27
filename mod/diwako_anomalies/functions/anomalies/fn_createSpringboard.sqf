/*
  Function: anomaly_fnc_createSpringboard

  Description:
        Creates an anomaly of the type "Springboard"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])

    Returns:
        nothing

  Author:
  diwako 2017-12-11
*/
params[["_pos",[0,0,0]]];
 
if(!isServer) exitWith {};

_pos = [_pos] call anomaly_fnc_getLocationFromModule;

if(count _pos < 3) then {
    _pos set [2,0];
};
_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosATL _pos;
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_type", "springboard", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable ["anomaly_sound", _proxy, true];
[
    _trg, //trigger
    [4, 4, 0, false,4], // area
    ["ANY", "PRESENT", true], // activation
    ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateSpringboard", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg];
 
if(isNil "ANOMALIES_HOLDER") then {
  ANOMALIES_HOLDER = [];
};
 
ANOMALIES_HOLDER pushBackUnique _trg;
// publicVariable "ANOMALIES_HOLDER";
 
// set up idle sound speaker;
_trg2 = createTrigger ["EmptyDetector", _pos];
_trg2 setPosATL _pos;
_trg setVariable ["anomaly_idle_sound", _trg2, true];
_proxy = "Land_HelipadEmpty_F" createVehicle position _trg2;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg2 modelToWorld [0,0,0.5]);
_trg2 setVariable ["anomaly_idle_sound", _proxy, true];
[
    _trg2, //trigger
    [25, 25, 0, false, 2], // area
    ["ANY", "PRESENT", true], // activation
    ["this && !(thisTrigger getVariable ['anomaly_cooldown',false]) && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; _proxy = _thisTrigger getVariable 'anomaly_idle_sound'; while{!isNull _thisTrigger && {triggerActivated _thisTrigger}} do {_proxy say3D ('gravi_idle0' + str(floor random 2) ); sleep (5 + (random 20) )}}", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg2];

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
