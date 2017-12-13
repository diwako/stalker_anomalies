/*
	Function: anomaly_fnc_activateBurner

	Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
		_list - thisList given by the trigger (default: [])

    Returns:
        nothing

	Author:
	diwako 2017-12-13
*/
params[["_trg",objNull],["_list",[]]];

if(isNull _trg) exitWith {};
if(_trg getVariable ["anomaly_type",""] != "burner") exitWith {};

private _proxy = _trg getVariable "anomaly_sound";
_proxy say3d "fire2";

_pos = position _trg;
_source = "#particlesource" createVehicleLocal getPos _trg;
private _proxy2 = "Land_HelipadEmpty_F" createVehicle [((_pos select 0) - 2 + (random 2)), ((_pos select 1) - 2 + (random 2)), _pos select 2];
_proxy2 enableSimulationGlobal false;
// _proxy2 attachTo [_trg, [2, 2, 0]];
// _proxy2 attachTo [_trg, [((random 4) - 2), ((random 4) -2), 0]];
_source2 = "#particlesource" createVehicleLocal [((_pos select 0) - 2 + (random 2)), ((_pos select 1) - 2 + (random 2)), _pos select 2];
// _source2 = "#particlesource" createVehicleLocal getPos _trg;
private _proxy3 = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy3 enableSimulationGlobal false;
// _proxy3 attachTo [_trg, [-2, -2, 0]];
// _proxy3 attachTo [_trg, [(2 - (random 4)), (2 - (random 4)), 0]];
if(hasInterface) then {
	[_proxy2, _source, "active"] call anomalyEffect_fnc_burner;
	[_proxy3, _source2, "active"] call anomalyEffect_fnc_burner;
};

if(isServer) then {
	_men = nearestObjects [getPos _trg,  ["CAManBase"], 5];
	{
		if(!(_x isKindOf "CAManBase")) then {
			deleteVehicle _x;
		};
	} forEach _list;
	_trg setVariable ["anomaly_cooldown", true, true];
	{
		if(alive _x) then {
			if(!(isPlayer _x)) then {
				_x spawn {
					sleep 0.5;
					_this setDamage 1;
				};
			} else {
				if(!isNil "ace_medical_fnc_addDamageToUnit") then {
					// Ace medical is enabled
					_dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 1.1;
					[_x, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "stab"] remoteExec ["ace_medical_fnc_addDamageToUnit", _x];
				} else {
					// Ace medical is not enabled
					_dam = damage _x;
					_x setDamage _dam + 0.5;
				};
			};
		} else {
			[_x] remoteExec ["anomaly_fnc_minceCorpse"];
		};
	} forEach _men;
};
sleep 5;

if(!(isNull _source)) then {
	deleteVehicle _source;
};
if(!(isNull _proxy2)) then {
	deleteVehicle _proxy2;
};
if(!(isNull _source2)) then {
	deleteVehicle _source2;
};
if(!(isNull _proxy3)) then {
	deleteVehicle _proxy3;
};

if(isServer) then {
	_trg spawn {
		sleep (10 + random 21);
		_this setVariable ["anomaly_cooldown", false, true];
	};
};