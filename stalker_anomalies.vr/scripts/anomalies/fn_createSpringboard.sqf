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
 
_trg = createTrigger ["EmptyDetector", _pos];
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_type", "springboard", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg, [0, 0, 0.5]];
_trg setVariable ["anomaly_sound", _proxy, true];
_trg setTriggerArea [4, 4, 0, false,4];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateSpringboard", ""];
 
if(isNil "ANOMALIES_HOLDER") then {
  ANOMALIES_HOLDER = [];
};
 
ANOMALIES_HOLDER pushBackUnique _trg;
publicVariable "ANOMALIES_HOLDER";
 
// set up idle sound speaker;
_trg2 = createTrigger ["EmptyDetector", _pos];
_proxy = "Land_HelipadEmpty_F" createVehicle position _trg2;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg2, [0, 0, 0.5]];
_trg2 setVariable ["anomaly_idle_sound", _proxy, true];
_trg2 setTriggerArea [25, 25, 0, false, 2];
_trg2 setTriggerActivation ["ANY", "PRESENT", true];
// the random interval is there to no have two sounds play at the very same time
_trg2 setTriggerStatements ["this && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; _proxy = _thisTrigger getVariable 'anomaly_idle_sound'; while{triggerActivated _thisTrigger} do {_proxy say3D ('gravi_idle0' + str(floor random 2) ); sleep (5 + (random 20) )}}", ""];