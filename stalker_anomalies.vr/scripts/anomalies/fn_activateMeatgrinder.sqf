/*
	Function: anomaly_fnc_activateMeatgrinder

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
if(_trg getVariable ["anomaly_type",""] != "meatgrinder") exitWith {};

_sucked = [];
if(isServer) then {
	_men = nearestObjects [getPos _trg,  ["CAManBase"], 5];
	private _proxy = _trg getVariable "anomaly_sound";
	[_proxy, "anomaly_mincer_blowout"] remoteExec ["say3d"];
	{
		if(!(_x isKindOf "CAManBase")) then {
			deleteVehicle _x;
		};
	} forEach _list;
	_trg setVariable ["anomaly_cooldown", true, true];
	{
		if(alive _x) then {
			_sucked pushBackUnique _x;
			[_x, getpos _trg,2] remoteExec ["anomaly_fnc_suckToLocation",_x];
		} else {
			[_x] remoteExec ["anomaly_fnc_minceCorpse"];
		};
	} forEach _men;
};
sleep 5.8;
{
	// ace medical not needed, people trapped in this trap are dead
	_x setDamage 1;
	[_x] remoteExec ["anomaly_fnc_minceCorpse"];
} forEach _sucked;

if(hasInterface) then {
	_source = "#particlesource" createVehicleLocal getPos _trg;
	private _proxy2 = "Land_HelipadEmpty_F" createVehicle position _trg;
	_proxy2 enableSimulationGlobal false;
	_proxy2 attachTo [_trg, [0, 0, 0.5]];
	[_trg, _proxy2, "active"] call anomalyEffect_fnc_springboard;
	sleep 1;
	deleteVehicle _proxy2;
	deleteVehicle _source;
};


if(isServer) then {
	_trg spawn {
		sleep (60 + random 60);
		_this setVariable ["anomaly_cooldown", false, true];
	};
};