#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_deleteAnomalies

    Description:
        Deletes given anomalies. Can be called on server only!!

    Parameter:
        _anomalies - array containing anomaly triggers (default: [])

    Returns:
        nothing

    Author:
    diwako 2018-01-14
*/

if !(isServer) exitWith {};
params [["_anomalies",[]]];
_anomalies = if !(_anomalies isEqualType []) then {[_anomalies]} else {_anomalies};
private _type = "";
{
    if !(isNull _x) then {
        _type = _x getVariable [QGVAR(anomalyType), ""];
        if (_type isEqualTo "") then { continue; };
        _x setVariable [QGVAR(markedForDeletion), true, true];
        if (GVAR(debug)) then {
            deleteMarker (_x getVariable [QGVAR(debugMarker),""]);
        };
        [QGVAR(deleteParticleSource), [_x]] call CBA_fnc_globalEvent;
        deleteVehicle (_x getVariable [QGVAR(sound), objNull]);
        GVAR(holder) = GVAR(holder) - [_x];
        switch (_type) do {
            case "telepot":{
                // handle teleport anomalies
                private _id = _x getVariable QGVAR(teleportID);
                // _teleporters = [GVAR(teleportIDs), _id] call CBA_fnc_hashGet;
                private _teleporters = GVAR(teleportIDs) get _id;
                _teleporters = _teleporters - [_x, objNull];
                // [GVAR(teleportIDs), _id, _teleporters] call CBA_fnc_hashSet;
                GVAR(teleportIDs) set [_id, _teleporters];
            };
            case "fruitpunch": {
                deleteVehicle (_x getVariable ["light",objNull]);
                deleteVehicle (_x getVariable ["field",objNull]);
            };
            case "comet": {
                GVAR(movingAnomalyHolder) = GVAR(movingAnomalyHolder) - [_x];
            };
            default {};
        };
        [{
            deleteVehicle _this;
        }, _x, 1] call CBA_fnc_waitAndExecute;
    };
} forEach _anomalies;
// publish updated arrays
// publicVariable QGVAR(holder);
publicVariable QGVAR(teleportIDs);
