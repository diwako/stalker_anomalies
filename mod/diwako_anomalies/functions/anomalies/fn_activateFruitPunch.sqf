/*
	Function: anomaly_fnc_activateElectra

	Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
		_list - thisList given by the trigger (default: [])

    Returns:
        nothing

	Author:
	diwako 2018-06-10
*/
if(!isServer) exitWith {};
params[["_trg",objNull],["_list",[]]];

if(isNull _trg) exitWith {};
if(_trg getVariable ["anomaly_type",""] != "fruitpunch") exitWith {};

private _proxy = _trg getVariable "anomaly_sound";
[_proxy, selectRandom["bfuzz_hit","buzz_hit"]] remoteExec ["say3d"];
_trg setVariable ["anomaly_cooldown", true];

private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy setPos (_trg modelToWorld [0,0,0]);
private _source = "#particlesource" createVehicle getPos _trg;
_source setPosATL (getPosATL _trg);
// _source enableSimulation false;
[_proxy, _source, "active"] remoteExec ["anomalyEffect_fnc_fruitPunch"];
{
	if(_x isKindOf "Man") then {
		// if(alive _x) then {
		if(!isNil "ace_medical_fnc_addDamageToUnit") then {
			// Ace medical is enabled
			private _dam = 1;
			if(isPlayer _x) then {
				_dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 5;
			} else {
				_res = _x getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
				_dam = ((_res#0 + _res#1 + _res#2) / 3) / 3;
			};
			[_x, _dam, selectRandom ["leg_l", "leg_r"], "stab"] remoteExec ["ace_medical_fnc_addDamageToUnit", _x];
		} else {
			// Ace medical is not enabled
			_dam = damage _x;
			_x setDamage (_dam + 0.2);
		};
	} else {
		if(!(_x isKindOf "landvehicle" || _x isKindOf "air")) then {
			deleteVehicle _x;	
		};
	};
	false
} count _list;

[{
	params["_trg", "_proxy", "_source"];
	deleteVehicle _proxy;
	deleteVehicle _source;
	_trg setVariable ["anomaly_cooldown", false];
}, [_trg, _proxy, _source], 0.5] call CBA_fnc_waitAndExecute;