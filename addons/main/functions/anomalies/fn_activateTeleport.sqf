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
if (isNull _trg || !isServer || _trg getVariable [QGVAR(anomalyType),""] != "teleport") exitWith {};

private _men = nearestObjects [getPos _trg,  ["Man", "LandVehicle", "Air"], 2.5];
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

{
    _x setVariable [QGVAR(cooldown), true, true];
} forEach _teleporters;

[QGVAR(teleportEffect), [_trg, _exit]] call CBA_fnc_globalEvent;

[{
    params["_trg", "_list", "_exit", "_men"];
    {
        if !(_x isKindOf "Man" || _x isKindOf "LandVehicle" || _x isKindOf "Air")  then {
            deleteVehicle _x;
        };
    } forEach _list;
    private _exitPos = getPos _exit;
    {
        if (alive _x) then {
            private _doTeleport = false;
            if (_x isKindOf "Man") then {
                _doTeleport = true;
                if (isPlayer _x) then {
                    [QGVAR(teleportFlash), nil, _x] call CBA_fnc_targetEvent;
                };
            };
            if ((_x isKindOf "LandVehicle" || _x isKindOf "Air") && {getMass _x < 10000}) then {
                _doTeleport = true;
                {
                    if (isPlayer _x) then {
                        [QGVAR(teleportFlash), nil, _x] call CBA_fnc_targetEvent;
                    };
                } forEach crew _x;
            };

            if (_doTeleport) then {
                [QGVAR(teleportOnEnter), [_x, _trg, _exit]] call CBA_fnc_localEvent;
                _x setPos [((_exitPos select 0) + (random 4) - 2), ((_exitPos select 1) + (random 4) - 2), (_exitPos select 2) ];
                [QGVAR(teleportOnExit), [_x, _trg, _exit]] call CBA_fnc_localEvent;
            };
        } else {
            if !(_x isKindOf "LandVehicle" || _x isKindOf "Air") then {
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            };
        };
    } forEach _men;

    [{
        params ["_trg"];
        private _id = _trg getVariable QGVAR(teleportID);
        if (isNil "_id") exitWith {}; // was deleted during cooldown
        private _teleporters = GVAR(teleportIDs) getOrDefault [_id, []];
        {
            _x setVariable [QGVAR(cooldown), false, true];
        } forEach _teleporters;
    }, [_trg], GVAR(anomalySettingTeleportCooldownMin) - TELEPORT_MIN_COOL_DOWN + (random GVAR(anomalySettingTeleportCooldownRand))] call CBA_fnc_waitAndExecute;
}, [_trg, _list, _exit, _men], TELEPORT_MIN_COOL_DOWN] call CBA_fnc_waitAndExecute;
