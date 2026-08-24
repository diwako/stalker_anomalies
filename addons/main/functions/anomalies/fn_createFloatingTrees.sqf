#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createFloatingTrees

    Description:
        Creates an anomaly of the type "Floating Trees"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0])
        _range - Radius parameter of area anomaly (default: 10)
                 or area param [a, b, isRectangle, direction, height]

    Returns:
        Anomaly Trigger, or objNull when creation failed

    Author:
    diwako 2026-08-23
*/
params[["_pos", [0,0,0]], ["_range", 10]];

if !(isServer) exitWith {};

private _area = [_range, [_range, _range, 0 , false, -1]] select (_range isEqualType 0);
private _dir = 0;

private _varName = "";
if !(_pos isEqualType []) then {
    _varName = vehicleVarName _pos;
    //created via module
    _area = _pos getVariable "objectarea";
    _dir = getDir _pos;

    private _module = _pos;
    _pos = getPosASL _pos;
    deleteVehicle _module;
};

if (count _pos < 3) then {
    _pos set [2, 0];
};

private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setDir _dir;
_trg setTriggerArea _area;

// get trees
private _maxdist = (_area select 0) max (_area select 1);
_maxdist = sqrt (2 * (_maxdist * _maxdist));
private _terrainTrees = ((nearestTerrainObjects [_trg, ["Tree"], _maxdist]) inAreaArray _trg) select {alive _x && !(isObjectHidden _x)};
_terrainTrees append (((nearestObjects [_trg, ["Tree"], _maxdist]) inAreaArray _trg) select {alive _x && !(isObjectHidden _x)});

if (_terrainTrees isEqualTo []) exitWith {
    deleteVehicle _trg;
    objNull
};

private _substitutes = [];
private _particlePos = [];
{
    (getModelInfo _x) params ["", "_model", "", "_origin"];
    private _posWorldTree = (getPosWorld _x) vectorAdd [0, 0, -3 + random 3] vectorAdd (_origin vectorMultiply -1);
    private _simple = createSimpleObject [_model, _posWorldTree];
    _simple setVectorDirAndUp [vectorDir _x, vectorUp _x];
    private _objectScale = getObjectScale _x;
    _simple setObjectScale _objectScale;
    _simple enableSimulationGlobal false;
    _substitutes pushBack _simple;

    private _lis = lineIntersectsSurfaces [(getPosASL _x) vectorAdd [0, 0, 1], (getPosASL _x) vectorAdd [0, 0, -10], _x, _simple, true, 1, "GEOM", "FIRE", true];
    if (_lis isNotEqualTo []) then {
        (_lis select 0) params ["_posASL", "_vectorUp"];
        private _crater = createSimpleObject ["Land_ShellCrater_01_F", _posASL];
        _crater setPosASL _posASL;
        _crater setDir random 360;
        _crater setVectorUp _vectorUp;
        _crater setObjectScale _objectScale;
        _crater enableSimulationGlobal false;
        _substitutes pushBack _crater;
    };

    if (random 1 > 0.2) then {
        private _rocks = createSimpleObject [selectRandom ["Land_BluntStones_erosion", "Land_Cliff_stoneCluster_F"], _posWorldTree];
        _rocks setPosWorld (_posWorldTree vectorAdd (_origin vectorMultiply _objectScale) vectorAdd [-0.25 + random 0.5, -0.25 + random 0.5, -1 - (random 2)]);
        _rocks setDir random 360;
        _rocks setVectorUp [-1 + random 2, -1 + random 2, -1 + random 2];
        _rocks setObjectScale ((0.25 + random 0.5) * _objectScale);
        _rocks enableSimulationGlobal false;
        _substitutes pushBack _rocks;
    };

    // private _mempoint = createSimpleObject ["Sign_Arrow_Yellow_F", _posWorldTree];
    // _mempoint setPosWorld (_posWorldTree vectorAdd (_origin vectorMultiply _objectScale));
    _particlePos pushBack [_posWorldTree vectorAdd (_origin vectorMultiply _objectScale), _objectScale];

    _x enableSimulationGlobal false;
    _x allowDamage false;
    _x hideObjectGlobal true;
} forEach _terrainTrees;

_trg setVariable [QGVAR(anomalyType), "trees", true];
_trg setVariable [QGVAR(detectable), false, true];
_trg setVariable [QGVAR(terrainTrees), _terrainTrees];
_trg setVariable [QGVAR(substitutes), _substitutes];
_trg setVariable [QGVAR(particlePos), _particlePos, true];

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal (["ELLIPSE", "RECTANGLE"] select (_area select 3));
    // _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerSizeLocal [_area select 0, _area select 1];
    _marker setMarkerDirLocal (_area select 2);
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker), _marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

_trg
