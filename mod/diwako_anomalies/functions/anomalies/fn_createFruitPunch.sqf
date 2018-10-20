/*
	Function: anomaly_fnc_createFruitPunch

	Description:
        Creates an anomaly of the type "Fruit Punch"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])
		
    Returns:
        Anomaly Trigger

	Author:
	diwako 2018-06-10
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
_trg setVariable ["anomaly_type", "fruitpunch", true];
private _radius = 1.5;
_trg setTriggerArea [_radius, _radius, 0, false, 2];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateFruitPunch", ""];

private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0.5]);
_trg setVariable ["anomaly_sound", _proxy, true];

private _field = createSimpleObject ["BloodPool_01_Large_New_F", _pos];
_field enableSimulationGlobal false;
_field setPosATL _pos;
_field setDir (random 360);
_field setObjectMaterialglobal [0, "a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"];
_field setObjectTextureGlobal [0,"diwako_anomalies\data\textures\fruitpunch" + str (floor random 2) + ".paa"];
_trg setVariable ["field",_field];

private _light = "#lightpoint" createVehicle _pos;
[_light,0.25,[0.4, 0.6, 0.1],[0.5, 1, 1, 4, 0.5, 5],[0.4, 0.6, 0.1],true,false] remoteExec ["anomaly_fnc_setLight",0,_light];

_trg setVariable ["light",_light];

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
	// the random interval is there to no have two sounds play at the very same time
	["this && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; sleep random 5; while{!isNull _thisTrigger && {triggerActivated _thisTrigger}} do {(_thisTrigger getVariable 'anomaly_idle_sound') say3D 'buzz_idle'; sleep 5.325}}", ""] // statements
] remoteExec ["anomaly_fnc_setTrigger", 0, _trg2];

if(isNil "ANOMALIES_HOLDER") then {
  ANOMALIES_HOLDER = [];
};

ANOMALIES_HOLDER pushBackUnique _trg;

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
