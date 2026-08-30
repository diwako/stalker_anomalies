#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_startPosWorld", "_endPosWorld", ["_duration", 0.75]];
private _magma = createSimpleObject [selectRandom [QPATHTOF(data\models\magmarock.p3d), "Land_Lavaboulder_04_F", "Land_Lavaboulder_03_F", "Land_Lavaboulder_02_F"],_startPosWorld, true];
_magma setPosWorld _startPosWorld;
_magma setDir random 360;
_magma setVectorUp [-1 + random 2, -1 + random 2, -1 + random 2];
_magma setObjectScale (0.02 + random 0.05);
_magma setPhysicsCollisionFlag false;

private _distance = (_startPosWorld distance _endPosWorld) max 5;

private _bezierPoints = [
    _startPosWorld,
    _startPosWorld vectorAdd [0, 0, _distance],
    _endPosWorld vectorAdd [0, 0, _distance],
    _endPosWorld
];

[{
    params ["_magma", "_startTime", "_endTime", "_bezierPoints"];
    private _pos = (linearConversion [_startTime, _endTime, cba_missionTime, 0, 1, true]) bezierInterpolation _bezierPoints;
    _magma setPosWorld _pos;

    cba_missionTime >= _endTime
}, {
    private _pos = ASLToAGL getPosASL (_this select 0);
    drop [["\a3\data_f_orange\ParticleEffects\Universal\orangeExplode_01",4,0,16,0],"","billboard",1,
        0.25 + random 0.25,
        _pos, //position
        [0,0,0], //move velocity
        5 + random 50, //rotationVelocity
        10.053, //weight
        7.9, //volume
        0, // rubbing
        [6,6,6,6,6,0.01,0.001], //size
        [[0.8,0.1,0.1,-4],[0.8,0.1,0.1,-3],[0.8,0.1,0.1,-2],[0.8,0.2,0.2,-1],[0.8,0.2,0.2,0]], //color
        [1], 0.01, 0.02, "", "", "",0,false,-1,[[3,3,3,0]]
    ];
    playSound3D [format ["%1_%2.ogg", QPATHTOF(sounds\anomalies\magma_splash), floor random 7], objNull, false, getPosASL (_this select 0), 2, 0.8 + random 0.4, 50, 0, true];
    private _light = "#lightpoint" createVehicleLocal (_pos vectorAdd [0, 0, 0.1]);
    _light setLightBrightness 0.8;
    _light setLightAmbient [1, 0.6, 0.6];
    _light setLightColor [1, 0.6, 0.6];
    _light setLightUseFlare true;
    _light setLightFlareSize 4;
    _light setLightFlareMaxDistance 100;
    _light setLightDayLight true;
    deleteVehicle (_this select 0);
    [{deleteVehicle _this}, _light, 0.25] call CBA_fnc_waitAndExecute;

}, [_magma, cba_missiontime, cba_missionTime + _duration, _bezierPoints, _endPosWorld]] call CBA_fnc_waitUntilAndExecute;
