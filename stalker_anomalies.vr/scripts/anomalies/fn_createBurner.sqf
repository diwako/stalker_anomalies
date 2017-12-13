/*
	Function: anomaly_fnc_createBurner

	Description:
        Creates an anomaly of the type "Burner"

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
_trg setVariable ["anomaly_type", "burner", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg, [0, 0, 0.5]];
_trg setVariable ["anomaly_sound", _proxy, true];
_trg setTriggerArea [4, 4, 0, false,2];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateBurner", ""];

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
_trg2 setTriggerStatements ["this && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; sleep random 5; while{triggerActivated _thisTrigger} do {(_thisTrigger getVariable 'anomaly_idle_sound') say3D 'fire_idle'; sleep 8.272060}}", ""];