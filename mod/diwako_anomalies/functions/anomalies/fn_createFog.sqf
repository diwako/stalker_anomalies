/*
	Function: anomaly_fnc_createFog

	Description:
        Creates an anomaly of the type "Fog"

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])
		_radius - Radius parameter of area anomaly (default: 10)
		_isRectangle - is this anomaly rectangular shaped (default: true)
		
		Currently under construction and does not work on effect right now
		_angle - Angle the anomaly should have (default: 0)

    Returns:
        Anomaly Trigger

	Author:
	diwako 2018-05-22
*/
params[["_pos",[0,0,0]],["_radius",10],["_isRectangle",true],["_angle",0]];
if(!isServer) exitWith {};

if(typeName _pos != typeName []) then {
	//created via module
	private _area = _pos getVariable "objectarea";
	_radius = _area#0;
	_isRectangle = _area#3;
	_angle = _area#2;
	private _module = _pos;
	_pos = getPosATL _pos;
	deleteVehicle _module;
};
_angle = 0;

if(count _pos < 3) then {
	_pos set [2,0];
};

_pos set [2,(_pos#2) - 2];
_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosATL _pos;
_trg setdir _angle;
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_type", "fog", true];
_trg setVariable ["radius", _radius, true];
_trg setVariable ["angle", _angle, true];
[
	_trg, //trigger
	[_radius, _radius, _angle, _isRectangle, 4], // area
	["ANY", "PRESENT", true], // activation
	["this && {round (cba_missiontime mod 2) == 1}", "[thisTrigger,thisList] spawn anomaly_fnc_activateFog", ""] // statements
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
