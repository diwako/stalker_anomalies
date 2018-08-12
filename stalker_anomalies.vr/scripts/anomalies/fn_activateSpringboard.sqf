/*
	Function: anomaly_fnc_activateSpringboard

	Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
		_list - thisList given by the trigger (default: [])

    Returns:
        nothing

	Author:
	diwako 2017-12-11
*/
params[["_trg",objNull],["_list",[]]];

if(isNull _trg) exitWith {};
if(_trg getVariable ["anomaly_type",""] != "springboard") exitWith {};

if(isServer) then {
	private _proxy = _trg getVariable "anomaly_sound";
	_sound = ("gravi_blowout" + str ( (floor random 6) + 1 ));
	[_proxy, _sound] remoteExec ["say3d"];
};


sleep 0.25;
_source = "#particlesource" createVehicleLocal getPos _trg;
private _proxy2 = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy2 enableSimulationGlobal false;
_proxy2 setPos (_trg modelToWorld [0,0,0.5]);
if(hasInterface) then {
	[_proxy2, _source, "active"] call anomalyEffect_fnc_springboard;
};

if(isServer) then {
	_men = nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5];
	{
		if(!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
			deleteVehicle _x;
		};
	} forEach _list;
	_trg setVariable ["anomaly_cooldown", true, true];
	{
		if(alive _x) then {
			_pos1 = getpos _x;
			_pos2 = getpos _trg;
			_a = ((_pos1 select 0) - (_pos2 select 0));
			_b = ((_pos1 select 1) - (_pos2 select 1));
			if(!(isPlayer _x)) then {
				if(!(_x isKindOf "landvehicle"  || _x isKindOf "air")) then {
					_x spawn {
						sleep 0.5;
						[_this, 1] remoteExec ["setDamage", _this];
					};
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
			_mult = 4;
			if(_x isKindOf "landvehicle" || _x isKindOf "air") then {
				if(getMass _x <= 10000) then {
					_mult = _mult * 2;
					_curDam = _x getHitPointDamage "hitHull";
					[_x, ["hitHull", (_curDam + 0.45)]] remoteExec ["setHitPointDamage", _x];
				} else {
					_mult = 1;
				};
			};
			[_x, [_a*_mult, _b*_mult, _mult + (5 / (1 + (abs _a) + (abs _b)))]] remoteExec ["setVelocity", _x];
		} else {
			if(!(_x isKindOf "landvehicle" || _x isKindOf "air")) then {
				[_x] remoteExec ["anomaly_fnc_minceCorpse"];
			};
		};
	} forEach _men;
};
sleep 1;

if(!(isNull _source)) then {
	deleteVehicle _source;
};
if(!(isNull _proxy2)) then {
	deleteVehicle _proxy2;
};

if(isServer) then {
	_trg spawn {
		sleep (10 + random 6);
		_this setVariable ["anomaly_cooldown", false, true];
	};
};