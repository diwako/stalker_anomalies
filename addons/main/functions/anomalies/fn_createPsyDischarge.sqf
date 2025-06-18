#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createPsyDischarge

    Description:
        Creates a psy discharge at given location
        Make sure to run this on all machines!

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0]])

    Returns:
        nothing

    Author:
    diwako 2022-01-26
*/
#define DISCHARGE_TIME 5
params[["_pos", [0,0,0]]];

if (_pos isEqualType objNull) then {
    if (isServer) then {
        [{
            deleteVehicle _this;
        }, _pos, 10] call CBA_fnc_waitAndExecute;
    };
    _pos = getPosASL _pos;
};
_pos = (AGLToASL ([ASLToAGL _pos] call CBA_fnc_getPos)) vectorAdd [0, 0, 50];

if (hasInterface && {((AGLToASL positionCameraToWorld [0,0,0]) distance _pos) < (getObjectViewDistance select 0)}) then {
    private _sphere = createSimpleObject ["Sign_Sphere100cm_F", _pos, true];
    _sphere setPosASL _pos;
    _sphere setVectorDir [0, 0, 0];
    _sphere setVectorUp [0, 0, 1];
    _sphere setObjectTexture [0, "#(argb,8,8,3)color(0.88,0.88,0.88,0.5,co)"];
    _sphere setObjectTexture [1, "#(argb,8,8,3)color(0.88,0.88,0.88,0.5,co)"];
    _sphere setObjectScale 0.01;
    private _particleEmitter = "#particlesource" createVehicleLocal _pos;
    _particleEmitter setPosASL _pos;
    [_particleEmitter, "idle"] call FUNC(electraEffect);
    _particleEmitter setDropInterval 0.01;
    // _particleEmitter setPosASL _pos;
    private _light = "#lightpoint" createVehicleLocal _pos;
    _light setLightBrightness 1;
    _light setLightAmbient [0.6, 0.6, 1];
    _light setLightColor [0.6, 0.6, 1];
    _light setLightUseFlare true;
    _light setLightFlareSize 100;
    _light setLightFlareMaxDistance 500;
    _light setLightDayLight true;
    _light setPosASL _pos;

    playSound3D [QPATHTOF(sounds\anomalies\psydischarge.ogg), objNull, false, _pos, 5, 1, 1500, 0, true];

    [{
        params ["_sphere", "_particleEmitter", "_light", "_endTime"];
        private _remaining = _endTime - cba_missiontime;
        private _size = linearConversion [DISCHARGE_TIME, 0, _remaining, 1, 10];
        // _sphere setObjectScale (linearConversion [DISCHARGE_TIME, 0, _remaining, 1, 10]);
        _sphere setObjectScale (_size * 1.5);
        // _particleEmitter setParticleCircle [_size - 1, [0, 0, 0]];
        _particleEmitter setParticleRandom [0, [_size, _size, _size], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _light setLightBrightness (linearConversion [DISCHARGE_TIME, 0, _remaining, 2, 7.5]);
        _light setLightFlareSize _size;
        _remaining <= 0
    }, {
        params ["_sphere", "_particleEmitter", "_light"];
        _sphere setObjectScale 12;
        deleteVehicle _particleEmitter;
        _light setLightBrightness 20;
        _light setLightFlareSize 100;

        private _pos = getPosASL _sphere;
        _particleEmitter = "#particlesource" createVehicleLocal _pos;
        _particleEmitter setParticleCircle [0, [0, 0, 0]];
        _particleEmitter setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _particleEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 2, 1, [0, 0, 1], [0, 0, 0], 0, 10, 7.9, 0.075, [0, 50], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 1], [0.5, 0.5, 0.5, 1], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _particleEmitter];
        _particleEmitter setDropInterval 0.05;
        _particleEmitter setPosASL _pos;

        [{
            {
                deleteVehicle _x;
            } forEach _this;
        }, [_sphere], 0.05] call CBA_fnc_waitAndExecute;

        [{
            {
                deleteVehicle _x;
            } forEach _this;
        }, [_particleEmitter, _light], 0.25] call CBA_fnc_waitAndExecute;
    }, [_sphere, _particleEmitter, _light, cba_missiontime + DISCHARGE_TIME]] call CBA_fnc_waitUntilAndExecute;
};

[{
    params ["_pos"];
    private _units = (allUnits select {local _x && {isNull objectParent _x && {!(_x getVariable ["anomaly_ignore", false])}}}) inAreaArray [ASLToAGL _pos, GVAR(anomalySettingPsyRange), GVAR(anomalySettingPsyRange), 0, false, -1];

    {
        if (_x isEqualTo []) then {
            // ouch
            ["psydischarge", _units select _forEachIndex] call FUNC(addUnitDamage);
        };
    } forEach (lineIntersectsSurfaces [_units apply {[getPosASL _x, _pos, _x, objNull, true, 1, "FIRE", "GEOM"]}]);
}, [_pos], DISCHARGE_TIME] call CBA_fnc_waitAndExecute;
