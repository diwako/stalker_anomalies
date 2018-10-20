/*
	Function: anomaly_fnc_createMeatgrinder

	Description:
        Creates an anomaly of the type "Meatgrinder"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])

    Returns:
        Anomaly Trigger

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
_trg setVariable ["anomaly_type", "meatgrinder", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);

_trg setVariable ["anomaly_sound", _proxy, true];
[
	_trg, //trigger
	[4, 4, 0, false,4], // area
	["ANY", "PRESENT", true], // activation
	["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateMeatgrinder", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg];

if(isNil "ANOMALIES_HOLDER") then {
	ANOMALIES_HOLDER = [];
};

ANOMALIES_HOLDER pushBackUnique _trg;
// publicVariable "ANOMALIES_HOLDER";

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

_trg
