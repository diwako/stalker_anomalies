#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_obj"];
if (isNull _obj) exitWith {};

private _pathPoints = _obj getVariable [QGVAR(pathPoints), []];
if (_pathPoints isEqualTo []) exitWith {};

private _movementInfo = _obj getVariable [QGVAR(movementInfo), []];
if (_movementInfo isEqualTo []) then {
    _movementInfo = [
        0, // _pathIndex
        _pathPoints select -1 select 0, // _endTime
        getPosASL _pos, // _lastPos
        cba_missionTime mod (_pathPoints select -1 select 0), // _lastTime
        count _pathPoints // _pathCount
    ];
    _obj setVariable [QGVAR(movementInfo), _movementInfo];
};
_movementInfo params ["_pathIndex", "_endTime", "_lastPos", "_lastTime", "_pathCount"];

private _delatTime = cba_missionTime mod _endTime;
(_pathPoints select _pathIndex) params ["_timeToTake", "_newPos", "_bezierPoint1", "_bezierPoint2"];
while {_delatTime >= _timeToTake || {_lastTime > _delatTime}} do {
    // next pos
    _pathIndex = _pathIndex + 1;
    if (_pathCount <= _pathIndex) then {
        _pathIndex = 0;
        _movementInfo set [5, cba_missionTime + _endTime];
    };
    _movementInfo set [0, _pathIndex];
    _movementInfo set [2, _newPos];
    _movementInfo set [3, _timeToTake];
    _lastPos = _newPos;
    _lastTime = _timeToTake;
    private _newPathPoint = _pathPoints select _pathIndex;
    _timeToTake = _newPathPoint select 0;
    _newPos = _newPathPoint select 1;
    _bezierPoint1 = _newPathPoint select 2;
    _bezierPoint2 = _newPathPoint select 3;
    // systemChat format ["NEW Waypoint: %1 | %2 | %3 | %4", _pathIndex, _delatTime, _timeToTake, _lastTime];
};

// private _interPolatedPos = (_lastPos vectorAdd ((_newPos vectorDiff _lastPos) vectorMultiply (linearConversion [_lastTime, _timeToTake, _delatTime, 0, 1, true]))) vectorAdd [0, 0, 1.5];

private _interPolatedPos =(linearConversion [_lastTime, _timeToTake, _delatTime, 0, 1, false]) bezierInterpolation [_lastPos, _bezierPoint1, _bezierPoint2, _newPos];

_obj setPosASL _interPolatedPos;
_interPolatedPos
