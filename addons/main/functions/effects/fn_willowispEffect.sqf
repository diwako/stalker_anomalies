#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params [["_trg", objNull]];
if (isNull _trg) exitWith {};
private _color = _trg getVariable QGVAR(color);
private _spread = _trg getVariable QGVAR(spread);
private _pos = getPos _trg;
private _ligtHolder = [];
private _viewdistance = viewDistance;

for "_" from 1 to (_trg getVariable QGVAR(count)) do {
    private _light = "#lightpoint" createVehicleLocal _pos;
    _light setLightBrightness 0.5;
    _light setLightAmbient _color;
    _light setLightColor _color;
    _light setLightUseFlare true;
    _light setLightFlareSize 0.75;
    _light setLightFlareMaxDistance _viewdistance;
    _light setLightDayLight true;
    _light setLightAttenuation [0, 0, 500, 150, 0, 0];

    _ligtHolder pushBack _light;
};
_trg setVariable [QGVAR(lights), _ligtHolder];

if ((_trg getVariable [QGVAR(pathPoints), []]) isEqualTo []) then {
    private _pathPointsHolder = [];
    private _movementInfoHolder = [];

    for "_" from 1 to (_trg getVariable QGVAR(count)) do {
        private _speed = 0.5 + random 1;
        private _startDir = random 360;
        private _tmpPathPoints = [];
        private _max = 3 + ceil random 4;

        for "_i" from (_max - 1) to _max do {
            _tmpPathPoints pushBack AGLToASL ((_pos getPos [random _spread, (_startDir + (_i * (360 / _max))) mod 360]) vectorAdd [0, 0, 1 + random (_spread / 2)]);
        };

        private _pathPoints = [];
        private _totalLength = 0;

        private _fnc_generatePoint = {
            params ["_tmpPathPoints", "_index", "_pathPoints", "_speed"];
            private _m1 = _tmpPathPoints select _index;
            private _m2 = _tmpPathPoints select ((_index + 1) mod (count _tmpPathPoints));
            if (isNil "_m1" || isNil "_m2") exitWith {
                diag_log format ["m1 %1 | m2 %2", isNil "_m1", isNil "_m2"];
                diag_log format ["index %1 is shit: %2", _index, _tmpPathPoints];
            };
            private _dist = _m1 distance _m2;
            _totalLength = _totalLength + _dist;
            private _arr = [
                _totalLength / _speed,
                _m2
            ];
            private _m0 = _tmpPathPoints select (_index - 1);
            private _m3 = _tmpPathPoints select ((_index + 2) mod (count _tmpPathPoints));
            private _vecNormalPrev = _m0 vectorFromTo _m1;
            private _vecNormalNext = _m3 vectorFromTo _m2;
            _arr pushBack (_m1 vectorAdd (_vecNormalPrev vectorMultiply (_dist / 3)));
            _arr pushBack (_m2 vectorAdd (_vecNormalNext vectorMultiply (_dist / 3)));

            _pathPoints pushBack _arr
        };

        [_tmpPathPoints, -1, _pathPoints, _speed] call _fnc_generatePoint;
        {
            [_tmpPathPoints, _forEachIndex, _pathPoints, _speed] call _fnc_generatePoint;
        } forEach _tmpPathPoints;
        _pathPoints select 0 set [0, 0];

        _pathPointsHolder pushBack _pathPoints;
        _movementInfoHolder pushBack [];
    };

    _trg setVariable [QGVAR(pathPoints), _pathPointsHolder];
    _trg setVariable [QGVAR(movementInfo), _movementInfoHolder];
};

GVAR(willowispHolder) pushBack _trg;

if (GVAR(willowispPFHHandle) isEqualTo -1) then {
    GVAR(wispDummy) = createVehicleLocal ["Building", [0, 0 ,0]];
    GVAR(willowispPFHHandle) = addMissionEventHandler ["Draw3D", {
        if (GVAR(willowispHolder) isEqualTo []) exitWith {
            removeMissionEventHandler ["Draw3D", GVAR(willowispPFHHandle)];
            deleteVehicle GVAR(wispDummy);
            GVAR(willowispPFHHandle) = -1;
        };
        private _player = [] call CBA_fnc_currentUnit;
        private _nightValue = (getPos _player) getEnvSoundController "night";
        private _isDay = _nightValue isEqualTo 0;
        {
            private _trg = _x;
            private _lights = _trg getVariable [QGVAR(lights), []];
            if (isNull _trg || (_trg getVariable [QGVAR(markedForDeletion), false]) || isNull (_trg getVariable [QGVAR(particleSource), objNull])) then {
                GVAR(willowispHolder) deleteAt _forEachIndex;
                {
                    deleteVehicle _x;
                } forEach _lights;
                continue;
            };
            if (_isDay) then {
                {
                    _x setLightBrightness 0;
                } forEach _lights;
            } else {
                {
                    // lights do not support setVariable...
                    GVAR(wispDummy) setVariable [QGVAR(pathPoints), (_trg getVariable QGVAR(pathPoints)) select _forEachIndex];
                    GVAR(wispDummy) setVariable [QGVAR(movementInfo), (_trg getVariable QGVAR(movementInfo)) select _forEachIndex];
                    GVAR(wispDummy) setPosWorld (getPosWorld _x);
                    _x setPosWorld ([GVAR(wispDummy)] call FUNC(movementTick));
                    _x setLightBrightness ((linearConversion [1225, 1600, _player distanceSqr _x, 0, 0.75, true]) * _nightValue);
                } forEach _lights;
            };
        } forEachReversed GVAR(willowispHolder);
    }];
};
