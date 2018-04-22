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
_source2 = "#particlesource" createVehicleLocal [((_pos select 0) - 2 + (random 2)), ((_pos select 1) - 2 + (random 2)), _pos select 2];
private _proxy3 = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy3 enableSimulationGlobal false;

_light = objNull;
if(hasInterface) then {
	[_proxy2, _source, "active"] call anomalyEffect_fnc_burner;
	[_proxy3, _source2, "active"] call anomalyEffect_fnc_burner;

	_light = "#lightpoint" createVehicleLocal (getpos _proxy);
	_light setLightBrightness 1;
	_light setLightAmbient [1, 0.6, 0.6];
	_light setLightColor [1, 0.6, 0.6];
	_light setLightUseFlare false;
	_light setLightFlareSize 100;
	_light setLightFlareMaxDistance 100;
	_light setLightDayLight true;
};

if(isServer) then {
	_trg setVariable ["anomaly_cooldown", true, true];
	_men = nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5];
	{
		if(!(_x isKindOf "Man" || _x isKindOf "landvehicle"|| _x isKindOf "air")) then {
			deleteVehicle _x;
		};
	} forEach _list;
	{
		if(alive _x) then {
			if(_x isKindOf "Man") then {
				if(!(isPlayer _x)) then {
					_x spawn {
						sleep 0.5;
						_this setDamage 1;
						[_this,1] remoteExec ["setDamage",_this];
					};
				} else {
					if(!isNil "ace_medical_fnc_addDamageToUnit") then {
						// Ace medical is enabled
						_dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 1.1;
						[_x, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "stab"] remoteExec ["ace_medical_fnc_addDamageToUnit", _x];
					} else {
						// Ace medical is not enabled
						_dam = damage _x;
						[_x,(_dam + 0.5)] remoteExec ["setDamage",_x];
					};
				};
			} else {
				_curDam = _x getHit "motor";
				if(isNil "_curDam") then {
					_curDam = 0;
				};
				if(_curDam >= 1) then {
					_x setDamage 1;
				} else {
					[_x, ["motor", (_curDam + 0.15)]] remoteExec ["setHit", _x];
					if(!(_x isKindOf "tank"))then {
						[_x, ["wheel_1_1_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_1_2_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_1_3_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_1_4_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_2_1_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_2_2_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_2_3_steering", 1]] remoteExec ["setHit", _x];
						[_x, ["wheel_2_4_steering", 1]] remoteExec ["setHit", _x];
					};
				};
			};
		} else {
			if(!(_x isKindOf "landvehicle" || _x isKindOf "air")) then {
				[_x] remoteExec ["anomaly_fnc_minceCorpse"];
			};
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
if(!(isNull _light)) then {
	deleteVehicle _light;
};

if(isServer) then {
	_trg spawn {
		sleep (5 + random 21);
		_this setVariable ["anomaly_cooldown", false, true];
	};
};