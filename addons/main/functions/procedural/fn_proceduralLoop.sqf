#include "\z\diwako_anomalies\addons\main\script_component.hpp"
if !(isServer) exitWith {};

[{
    [] call FUNC(proceduralLoop);
}, [], GVAR(procedrualScanInterval)] call CBA_fnc_waitAndExecute;

if !(GVAR(procedrualEnable)) exitWith {};

private _players = ([] call CBA_fnc_players) select {alive _x && {!(_x getVariable ["anomaly_ignore", false])} && {_x isKindOf "CAManBase"}};

if (_players isEqualTo []) exitWith {};

// private _players = allunits select {alive _x && {_x isKindOf "CAManBase"}};
private _timePerGrid = GVAR(procedrualScanInterval) / GVAR(proceduralGridCount);

{
    [{
        params ["_players", "_gridData", "_index"];
        _gridData params ["_area", "_scanArea", "_status", "_cachedAnomalies", "_spawnedAnomalies"];
        private _hasPlayers = (_players inAreaArray _scanArea) isNotEqualTo [];
        private _fnc_delete = {
            GVAR(prodecuralAnomalyCount) = GVAR(prodecuralAnomalyCount) - (count _spawnedAnomalies);
            [_spawnedAnomalies] call FUNC(deleteAnomalies);
            GVAR(proceduralGrids) select _index set [2, GRID_INACTIVE];
            GVAR(proceduralGrids) select _index set [4, []];
        };
        switch (_status) do {
            case GRID_INACTIVE: {
                if (_hasPlayers) then {
                    [_gridData, _index] call FUNC(proceduralActivateCell);
                };
            };
            case GRID_ACTIVE: {
                if !(_hasPlayers) then {
                    call _fnc_delete;
                };
            };
            case GRID_PARTIAL: {
                if (_hasPlayers) then {
                    [_gridData, _index] call FUNC(proceduralActivateCell);
                } else {
                    call _fnc_delete;
                };
            };
        };
        if (GVAR(debug) && {_status isNotEqualTo (GVAR(proceduralGrids) select _index select 2)}) then {
            private _marker = format ["proceduralGrid_%1_%2", _area select 0 select 0, _area select 0 select 1];
            _marker setMarkerColorLocal (["ColorGrey", "ColorYellow", "ColorGreen"] select (GVAR(proceduralGrids) select _index select 2));
            // systemChat format ["Grid %1 status changed to %2", _marker, GVAR(proceduralGrids) select _index select 2];
        };
    }, [_players, _x, _forEachIndex], _timePerGrid * _forEachIndex] call CBA_fnc_waitAndExecute;
} forEach GVAR(proceduralGrids);
