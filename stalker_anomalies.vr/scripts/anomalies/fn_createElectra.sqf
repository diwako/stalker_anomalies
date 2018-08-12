/*
	Function: anomaly_fnc_createElectra

	Description:
        Creates an anomaly of the type "Electra"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])

    Returns:
        Anomaly Trigger

	Author:
	diwako 2017-12-11
*/
params[["_pos",[0,0,0]]];

if(!isServer) exitWith {};

// _pos = [_pos] call anomaly_fnc_getLocationFromModule;

if(count _pos < 3) then {
	_pos set [2,0];
};
_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosATL _pos;
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_type", "electra", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable ["anomaly_sound", _proxy, true];
[_trg, [4, 4, 0, false,4]] remoteExec ["setTriggerArea",0,_trg];
[_trg, ["ANY", "PRESENT", true]] remoteExec ["setTriggerActivation",0,_trg];
[_trg, ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateElectra", ""]] remoteExec ["setTriggerStatements",0,_trg];

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
[_trg2, [50, 50, 0, false, 2]] remoteExec ["setTriggerArea",0,_trg];
[_trg2, ["ANY", "PRESENT", true]] remoteExec ["setTriggerActivation",0,_trg];
// the random interval is there to no have two sounds play at the very same time
[_trg2, ["this && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; sleep random 5; while{!isNull _thisTrigger && {triggerActivated _thisTrigger}} do {(_thisTrigger getVariable 'anomaly_idle_sound') say3D 'electra_idle1'; sleep 5.455}}", ""]] remoteExec ["setTriggerStatements", 0, _trg];

if(!isNil "ANOMALY_DEBUG" && {ANOMALY_DEBUG}) then {
	_marker = createMarkerLocal [str(_pos),_pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "hd_dot";
	_marker setMarkerTextLocal (_trg getVariable "anomaly_type");
};
_trg
