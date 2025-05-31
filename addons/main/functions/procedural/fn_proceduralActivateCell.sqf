#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_gridData", "_index"];
_gridData params ["_area", "", "_status", "_cachedAnomalies", "_spawnedAnomalies"];
_area params ["_posArea", "_radius"];

if (_cachedAnomalies isEqualTo false) exitWith {
    // cell was already initialized, but no anomalies were in it
    // just set the cell to active
    GVAR(proceduralGrids) select _index set [2, GRID_ACTIVE];
};

private _anomalies = [];
if (_status isEqualTo GRID_PARTIAL) then {
    // cell is partially initialized, select the cached data of none spawned anomalies
    _anomalies = GVAR(proceduralGrids) select _index select 4;
    _cachedAnomalies = _cachedAnomalies select [count _anomalies];
};

if (_cachedAnomalies isEqualTo []) then {
    // generate anomaly positions
    private _areaSquared = (2 * _radius) * (2 * _radius);
    private _anomalyDensity = (_areaSquared / (4200 * 6)) * GVAR(proceduralCountCoef);
    private _pos = [];

    private _fnc_cond = {
        params ["_pos"];
        !(isNil "_pos" || {_pos isEqualTo []} || {surfaceIsWater _pos} || {(nearestTerrainObjects [_pos, ["All"], 3, false, true]) isNotEqualTo []} || {(nearestObjects [_pos, ["All"], 3, true]) isNotEqualTo []})
    };

    // step 1: standalone anomalies
    private _type = "";
    for "_i" from 1 to _anomalyDensity do {
        _pos = [_area] call CBA_fnc_randPosArea;
        if ([_pos] call _fnc_cond) then {
            _type = selectRandomWeighted ["springboard", 10, "burner", 4, "electra", 3, "meatgrinder", 1];
            _cachedAnomalies pushBack [AGLToASL _pos, _type];
        };
    };

    // step 2: clusters
    private _clusterNO = _anomalyDensity / 100;
    private _clusterChance = 0.2 * GVAR(proceduralCountCoef);
    {
        private _pos = locationPosition _x;
        private _size = size _x;
        _pos = [[_pos, _size select 0, _size select 1, 0, true]] call CBA_fnc_randPosArea;
        _type = selectRandomWeighted ["springboard", 10, "burner", 4, "electra", 3, "meatgrinder", 1, "fruitpunch", 2, "clicker", 0.5, "fog", 1];
        if (_type in ["clicker", "fog"]) then {
            _cachedAnomalies pushBack [AGLToASL _pos, _type, _size];
        } else {
            private _newArea = [_pos, 15, 15, 0, false];
            for "_j" from 1 to (1 + (floor random 6)) do {
                _pos = [_newArea] call CBA_fnc_randPosArea;
                if ([_pos] call _fnc_cond) then {
                    _cachedAnomalies pushBack [AGLToASL _pos, _type];
                };
            };
        };
    } forEach ((nearestLocations [_posArea, [], _radius]) select {random 1 < _clusterChance});

    if (_cachedAnomalies isEqualTo []) then {
        // no anomalies were generated
        GVAR(proceduralGrids) select _index set [3, false];
    } else {
        GVAR(proceduralGrids) select _index set [3, _cachedAnomalies];
    };
};

private _newStatus = GRID_ACTIVE;
{
    if (GVAR(prodecuralAnomalyCount) >= GVAR(proceduralMaxAnomalyCount)) then {
        _newStatus = GRID_PARTIAL;
        break;
    };
    _x params ["_pos", "_type", ["_size", [25, 25]]];

    GVAR(prodecuralAnomalyCount) = GVAR(prodecuralAnomalyCount) + 1;
    private _anomaly = switch (_type) do {
        case "springboard": {[_pos] call FUNC(createSpringboard)};
        case "burner": {[_pos] call FUNC(createBurner)};
        case "electra": {[_pos] call FUNC(createElectra)};
        case "meatgrinder": {[_pos] call FUNC(createMeatgrinder)};
        case "fruitpunch": {[_pos] call FUNC(createFruitPunch)};
        case "clicker": {[_pos, (_size select 0) max (33 + random 33), (_size select 1) max (33 + random 33)] call FUNC(createClicker)};
        case "fog": {[_pos, (_size select 0) max (_size select 1) max 25] call FUNC(createFog)};
        default {objNull};
    };
    _anomalies pushBack _anomaly;
} forEach _cachedAnomalies;

GVAR(proceduralGrids) select _index set [2, _newStatus];
GVAR(proceduralGrids) select _index set [4, _anomalies];
