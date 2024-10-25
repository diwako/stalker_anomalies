#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createComet

    Description:
        Creates an anomaly of the type "Comet"

    Parameter:
        _marker - marker ID of path objects, will be used to move said path (default: "")
        _speed - measured in meters per second (default: 6)
        _smoothCurves - interpolates the path corners using bezier curves (default: true)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2024-10-18
*/
params [["_marker", ""], ["_speed", 6], ["_smoothCurves", true]];
if !(isServer) exitWith {nil};

private _varName = "";
if !(_marker isEqualType []) then {
    //created via module
    private _module = _marker;
    _varName = vehicleVarName _module;
    _marker = _module getVariable ["marker", ""];
    _speed = _module getVariable ["speed", 6];
    _smoothCurves = _module getVariable ["smooth", true];
    deleteVehicle _module;
};

if (_marker isEqualTo "") exitWith {
    [{
        hintC format ["There was no marker path set for the comet anomaly. Make sure to set the ""%1"" field in the module or supply a proper first parameter if you are using the script function!", localize "STR_anomaly_comet_marker"];
    }, nil, 1] call CBA_fnc_waitAndExecute;
    nil
};

// find marker num
private _end = 0;
while {getMarkerPos format ["%1%2", _marker, _end] isNotEqualTo [0, 0, 0]} do {
    _end = _end + 1;
};

if (_end isEqualTo 0) exitWith {
    [{
        hintC format ["Comet anomaly could not find a path for ""%1"". Make sure to have at least one marker named ""%1%2""", _marker, 0];
    }, nil, 1] call CBA_fnc_waitAndExecute;
    nil
};

private _pos = getMarkerPos [format ["%1%2", _marker, 0], true];
private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL AGLToASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(anomalyType), "comet", true];
_trg setTriggerInterval 9999;

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker), _marker];
    systemChat format ["Found %1 markers for %2", _end, _marker];
};

_end = _end - 1;
private _totalLength = 0;
private _fnc_generatePoint = {
    params ["_marker", "_num", "_speed", "_end"];
    _end = _end + 1;
    _num = _num + _end;
    private _m1 = AGLToASL getMarkerPos [format ["%1%2", _marker, _num mod _end], true];
    private _m2 = AGLToASL getMarkerPos [format ["%1%2", _marker, (_num + 1) mod _end], true];
    private _dist = _m1 distance _m2;
    _totalLength = _totalLength + _dist;

    private _arr = [
        _totalLength / _speed,
        _m2 vectorAdd [0, 0, 1.5]
    ];
    if (_smoothCurves) then {
        private _m0 = AGLToASL getMarkerPos [format ["%1%2", _marker, (_num - 1) mod _end], true];
        private _m3 = AGLToASL getMarkerPos [format ["%1%2", _marker, (_num + 2) mod _end], true];
        private _vecNormalPrev = _m0 vectorFromTo _m1;
        private _vecNormalNext = _m3 vectorFromTo _m2;
        _arr pushBack (_m1 vectorAdd (_vecNormalPrev vectorMultiply (_dist / 3)) vectorAdd [0, 0, 1.5]);
        _arr pushBack (_m2 vectorAdd (_vecNormalNext vectorMultiply (_dist / 3)) vectorAdd [0, 0, 1.5]);
    } else {
        _arr pushBack _m1;
        _arr pushBack _m2;
    };

    _pathPoints pushBack _arr
};

// private _end = 11;
private _pathPoints = [];
[_marker, -1, _speed, _end] call _fnc_generatePoint;
for "_i" from 0 to _end do {
    [_marker, _i, _speed, _end] call _fnc_generatePoint;
};
_pathPoints select 0 set [0, 0];

GVAR(movingAnomalyHolder) pushBack _trg;
_trg setVariable [QGVAR(pathPoints), _pathPoints, true];

if (GVAR(movingAnomalyPFH) isEqualTo -1) then {
    GVAR(movingAnomalyPFH) = [{
        if (isGamePaused) exitWith {};
        params ["", "_pfhHandle"];
        if (GVAR(movingAnomalyHolder) isEqualTo []) exitWith {
            [_pfhHandle] call CBA_fnc_removePerFrameHandler;
            GVAR(movingAnomalyPFH) = -1;
        };
        {
            private _pos = [_x] call FUNC(movementTick);
            if (GVAR(debug)) then {
                (_x getVariable [QGVAR(debugMarker), ""]) setMarkerPosLocal (ASLToAGL _pos);
            };
        } forEach GVAR(movingAnomalyHolder);
    }, 2] call CBA_fnc_addPerFrameHandler;
};

[_trg] call FUNC(createCometLocal);

GVAR(holder) pushBack _trg;

_trg
