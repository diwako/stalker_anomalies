/*
	Function: anomaly_fnc_activateTeleport

	Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
		_list - thisList given by the trigger (default: [])

    Returns:
        nothing

	Author:
	diwako 2017-12-14
*/
params[["_trg",objNull],["_list",[]]];

if(!isServer) exitWith {};
if(isNull _trg) exitWith {};
if(_trg getVariable ["anomaly_type",""] != "teleport") exitWith {};

_men = nearestObjects [getPos _trg,  ["CAManBase"], 2];
_id = _trg getVariable "anomaly_teleport_id";
_teleporters = [ANOMALY_TELEPORT_IDS, _id] call CBA_fnc_hashGet;

if(count _teleporters < 2) exitWith {
	hintC ("Teleport anomaly at " + str(getpos _trg) + " with id " + str(_id) + " does not have an exit anomaly!")
};

_exit = objNull;
{
	if(_trg != _x) then {
		_exit = _x;
	};
} forEach _teleporters;

if(isNull _exit) exitWith {
	hintC ("It was not possible to find an exit for teleport anomaly at " + str(getpos _trg) + " with id " + str(_id) + "!")
};


_trg setVariable ["anomaly_cooldown", true, true];
_exit setVariable ["anomaly_cooldown", true, true];
private _proxy = _trg getVariable "anomaly_sound";
[_proxy, ("teleport_work_" + str((floor random 2) +	 1))] remoteExec ["say3d"];
_proxy = _exit getVariable "anomaly_sound";
[_proxy, ("teleport_work_" + str((floor random 2) +	 1))] remoteExec ["say3d"];
sleep 0.15;
{
	if(!(_x isKindOf "CAManBase")) then {
		deleteVehicle _x;
	};
} forEach _list;
_exitPos = getpos _exit;
_trg setVariable ["anomaly_cooldown", true, true];
{
	if(alive _x) then {
		[_x, [((_exitPos select 0) + (random 4) - 2), ((_exitPos select 1) + (random 4) - 2), (_exitPos select 2) ]] remoteExec ["setPos",_x];
		if(isPlayer _x) then {
			[] remoteExec ["anomaly_fnc_teleportFlash",_x];
		};
	} else {
		[_x] remoteExec ["anomaly_fnc_minceCorpse"];
	};
} forEach _men;

sleep (10 + (random 10) );

_trg setVariable ["anomaly_cooldown", false, true];
_exit setVariable ["anomaly_cooldown", false, true];