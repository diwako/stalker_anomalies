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
	diwako 2017-12-11
*/
params[["_trg",objNull],["_list",[]]];

if(isNull _trg) exitWith {};
if(_trg getVariable ["anomaly_type",""] != "electra") exitWith {};

if(isServer) then {
	private _proxy = _trg getVariable "anomaly_sound";
	_sound = ("electra_blast" + str ( (floor random 2) + 1 ));
	[_proxy, _sound] remoteExec ["say3d"];

	_men = nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5];
	test = _men;
	{
		if(!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
			deleteVehicle _x;
		};
	} forEach _list;
	{
		if(alive _x) then {
			if(!(isPlayer _x)) then {
				if(_x isKindOf "landvehicle" || _x isKindOf "air") then {
					[_x] spawn {
						params["_x"];
						// switch of the engine
						_curDam = 0;
						if(_x isKindOf "landvehicle" ) then {
							_curDam = _x getHit "engine";
							[_x, ["engine", 1]] remoteExec ["setHit", _x];
						} else {
							_curDam = _x getHitPointDamage "HitEngine";
							[_x, ["HitEngine", 1]] remoteExec ["setHitPointDamage", _x];
						};
						_curDam2 = _x getHitPointDamage "hitHull";
						[_x, ["hitHull", (_curDam2 + 0.1)]] remoteExec ["setHitPointDamage", _x];
						sleep 5;
						if(_x isKindOf "landvehicle" ) then {
							[_x, ["engine", (_curDam + 0.25)]] remoteExec ["setHit", _x];
						} else {
							[_x, ["HitEngine", (_curDam + 0.25)]] remoteExec ["setHitPointDamage", _x];
						};
					};
				} else {
					[_trg, _x] spawn {
						params["_trg","_x"];
						[_x, getpos _trg, 2, 2] remoteExec ["anomaly_fnc_suckToLocation",_x];
						sleep 2;
						[_x,1] remoteExec ["setDamage",_x];
					};
				};
			};

		} else {
			if(!(_x isKindOf "landvehicle" || _x isKindOf "air") ) then {
				[_x] remoteExec ["anomaly_fnc_minceCorpse"];
			};
		};
	} forEach _men;
	[_trg] spawn {
		params["_trg"];
		_trg setVariable ["anomaly_cooldown", true, true];
		sleep (30 + random 11);
		_trg setVariable ["anomaly_cooldown", false, true];
	};
};

if(hasInterface) then {
	[_trg] spawn {
		params["_trg"];
		_proxy = _trg getVariable "anomaly_sound";
		_light = "#lightpoint" createVehicleLocal (getpos _proxy);
		_light setLightBrightness 10;
		_light setLightAmbient [0.6, 0.6, 1];
		_light setLightColor [0.6, 0.6, 1];
		_light setLightUseFlare true;
		_light setLightFlareSize 100;
		_light setLightFlareMaxDistance 100;
		_light setLightDayLight true;
		sleep 0.1;
		_light setLightBrightness 0;
		sleep 0.1;
		_light setLightBrightness 10;
		sleep 0.2;
		_light setLightBrightness 0;
		sleep 1.2;
		_light setLightBrightness 10;
		sleep 0.1;
		_light setLightBrightness 0;
		sleep 0.1;
		_light setLightBrightness 10;
		sleep 0.2;
		deleteVehicle _light;
	};
	_plr = ([] call CBA_fnc_currentUnit);
	_in = (_plr in _list );
	if( _in ) then {
		[_plr, getpos _trg, 2, 2] spawn anomaly_fnc_suckToLocation;
		addCamShake [15, 3, 25];
	};
	// if( vehicle _plr in _list && { (vehicle _plr) isKindOf "landvehicle" && {(driver vehicle _plr) == _plr}}) then {
		// [(vehicle _plr)] spawn {
			// params["_veh"];
			// switch of the engine
			// _curDam = _veh getHit "engine";
			// [_veh, ["engine", 1]] remoteExec ["setHit", _veh];
			// _curDam2 = _veh getHitPointDamage "hitHull";
			// [_veh, ["hitHull", (_curDam2 + 0.1)]] remoteExec ["setHitPointDamage", _veh];
			// sleep 5;
			// [_veh, ["engine", (_curDam + 0.25)]] remoteExec ["setHit", _veh];
		// };
	// };
	sleep 2;
	if( _in ) then {
		if(!isNil "ace_medical_fnc_addDamageToUnit") then {
			// Ace medical is enabled
			sleep 0.05;
			_dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]);
			[_plr, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "stab"] call ace_medical_fnc_addDamageToUnit;
		} else {
			// Ace medical is not enabled
			_dam = damage _plr;
			_plr setDamage (_dam + 0.5);
		};
	};
	_proxy = _trg getVariable ["anomaly_particle_source", objNull];

	if(!isNull _proxy) then {
		deleteVehicle _proxy;
		waitUntil { sleep 0.2; !(_trg getVariable ["anomaly_cooldown", false])};
		if(_plr distance _trg < ANOMALY_IDLE_DISTANCE) then {
			_proxy = "Land_HelipadEmpty_F" createVehicleLocal position _trg;
			_proxy enableSimulation false;
			_proxy setPos (_trg modelToWorld [0,0,0]);
			_source = "#particlesource" createVehicleLocal getPos _trg;
			[_proxy, _source, "idle"] call anomalyEffect_fnc_electra;
			_trg setVariable ["anomaly_particle_source", _proxy];
		};
	};
};