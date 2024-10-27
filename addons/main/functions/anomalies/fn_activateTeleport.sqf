#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateTeleport

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

if !(isServer) exitWith {};
if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "teleport") exitWith {};

private _men = nearestObjects [getPos _trg,  ["Man","landvehicle"], 2];
private _id = _trg getVariable QGVAR(teleportID);
private _teleporters = GVAR(teleportIDs) getOrDefault [_id, []];

if (count _teleporters <= 1) exitWith {
    hintC format ["There is no other teleporter with ID %2 for the one at %1!", getPos _trg, _id];
};

private _exit = selectRandom (_teleporters - [_trg]);

if (isNull _exit) then {
    _teleporters = _teleporters - [objNull];
    GVAR(teleportIDs) set [_id, _teleporters];
    publicVariable QGVAR(teleportIDs);

    _exit = selectRandom (_teleporters - [_trg]);
};

if (isNil "_exit") exitWith {
    hintC format ["It was not possible to find an exit for teleport anomaly at %1 with id %2!", getPos _trg, _id];
};

_trg setVariable [QGVAR(cooldown), true, true];
_exit setVariable [QGVAR(cooldown), true, true];
private _proxy = _trg getVariable QGVAR(sound);
[QGVAR(say3D), [_proxy, "teleport_work_" + str((floor random 2) + 1)]] call CBA_fnc_globalEvent;
_proxy = _exit getVariable QGVAR(sound);
[QGVAR(say3D), [_proxy, "teleport_work_" + str((floor random 2) + 1)]] call CBA_fnc_globalEvent;

[{
    params["_trg", "_list", "_exit", "_men"];
    {
        if (!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air"))  then {
            deleteVehicle _x;
        };
    } forEach _list;
    private _exitPos = getPos _exit;
    private _obj = objNull;
    {
        _obj = _x;
        if (alive _obj) then {
            private _doTeleport = false;
            if (_x isKindOf "Man") then {
                _doTeleport = true;
                if (isPlayer _obj) then {
                    [QGVAR(teleportFlash), nil, _obj] call CBA_fnc_targetEvent;
                };
            };
            if ((_obj isKindOf "landvehicle"  || _x isKindOf "air") && {getMass _obj < 10000}) then {
                _doTeleport = true;
                {
                    if (isPlayer _x) then {
                        [QGVAR(teleportFlash), nil, _x] call CBA_fnc_targetEvent;
                    };
                } forEach crew _obj;
            };

            if (_doTeleport) then {
                // [_obj, [((_exitPos select 0) + (random 4) - 2), ((_exitPos select 1) + (random 4) - 2), (_exitPos select 2) ]] remoteExec ["setPos", _obj];

                [QGVAR(teleportOnEnter), [_obj, _trg, _exit]] call CBA_fnc_localEvent;
                _obj setPos [((_exitPos select 0) + (random 4) - 2), ((_exitPos select 1) + (random 4) - 2), (_exitPos select 2) ];
                [QGVAR(teleportOnExit), [_obj, _trg, _exit]] call CBA_fnc_localEvent;
            };
        } else {
            if (!(_obj isKindOf "landvehicle" || _x isKindOf "air")) then {
                [QGVAR(minceCorpse), [_obj]] call CBA_fnc_globalEvent;
            };
        };
    } forEach _men;

    [{
        params["_trg", "_exit"];
        _trg setVariable [QGVAR(cooldown), false, true];
        _exit setVariable [QGVAR(cooldown), false, true];
    }, [_trg, _exit], GVAR(anomalySettingTeleportCooldownMin) - TELEPORT_MIN_COOL_DOWN + (random GVAR(anomalySettingTeleportCooldownRand))] call CBA_fnc_waitAndExecute;
}, [_trg, _list, _exit, _men], TELEPORT_MIN_COOL_DOWN] call CBA_fnc_waitAndExecute;
