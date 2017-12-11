/*
	Function: anomaly_fnc_createMeatgrinder

	Description:
        Creates an anomaly of the type "Meatgrinder"

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
_trg setVariable ["anomaly_type", "meatgrinder", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg, [0, 0, 0.5]];
_trg setVariable ["anomaly_sound", _proxy, true];
_trg setTriggerArea [4, 4, 0, false,2];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateMeatgrinder", ""];

if(isNil "ANOMALIES_HOLDER") then {
	ANOMALIES_HOLDER = [];
};

ANOMALIES_HOLDER pushBackUnique _trg;
publicVariable "ANOMALIES_HOLDER";