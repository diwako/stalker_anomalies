#include "\z\diwako_anomalies\addons\main\script_component.hpp"
if !(isServer && {GVAR(procedrualEnable)} && {isNil QGVAR(proceduralGrids) }) exitWith {};

private _halfGridSize = GVAR(proceduralGridSize) / 2;
private _size = worldSize;
private _scanGridSize = (GVAR(proceduralGridSize) * 1.1 * GVAR(proceduralRangeCoef)) max _halfGridSize;
GVAR(proceduralGrids) = [];
for "_i" from 0 to _size step GVAR(proceduralGridSize) do {
    for "_j" from 0 to _size step GVAR(proceduralGridSize) do {
        GVAR(proceduralGrids) pushBack [
            [[_j + _halfGridSize, _i + _halfGridSize], _halfGridSize, _halfGridSize, 0, true], // area definition
            [[_j + _halfGridSize, _i + _halfGridSize], _scanGridSize, _scanGridSize, 0, true, -1], // scan area definition
            GRID_INACTIVE, // status
            [], // cached anomalies data
            [] // spawned anomaly data
        ];
        if (GVAR(debug)) then {
            private _area = createMarkerLocal [format ["proceduralGrid_%1_%2", _j + _halfGridSize, _i + _halfGridSize], [_j, _i]];
            _area setMarkerShapeLocal "RECTANGLE";
            _area setMarkerSizeLocal [_halfGridSize + 10, _halfGridSize + 10];
            _area setMarkerPosLocal [_j + _halfGridSize, _i + _halfGridSize];
            _area setMarkerColorLocal "ColorGrey";
            _area setMarkerAlphaLocal 0.5;
            _area setMarkerTextLocal _area;
        };
    };
};
GVAR(proceduralGridCount) = count GVAR(proceduralGrids);
if (GVAR(proceduralGridCount) <= 0) exitWith {
    hintC "Could not initialize the procedural anomaly system! No grids were created! Check your proceduralGridSize setting!";
};
GVAR(prodecuralAnomalyCount) = 0;
[FUNC(proceduralLoop), nil, 1] call CBA_fnc_waitAndExecute;

