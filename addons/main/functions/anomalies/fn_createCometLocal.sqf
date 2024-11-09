#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createCometLocal

    Description:
        Creates the anomaly on the local machine for smooth locomotion.
        Creates the actual trigger for damage handling

    Parameter:
        _sourceTrg - Server governed pointer trigger (default: objNull])

    Returns:
       nothing

    Author:
    diwako 2024-10-18
*/
params [["_sourceTrg", objNull]];
if (isNull _sourceTrg || !simulationEnabled _sourceTrg) exitWith {
    if (GVAR(debug)) then {
        systemChat "Comet did not add source, exit condition early";
    };
};

private _pathPoints = _sourceTrg getVariable [QGVAR(pathPoints), []];
if (_pathPoints isEqualTo []) exitWith {};

private _pos = getPosASL _sourceTrg;
private _trg = createTrigger ["EmptyDetector", _pos, false];
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false];
_trg setVariable [QGVAR(pathPoints), _pathPoints];
_trg setVariable [QGVAR(sourceTrg), _sourceTrg];
_trg setVariable [QGVAR(anomalyType), "comet"];
_trg setTriggerInterval 0.1;

[
    _trg,
    [3, 3, 0, false, 3], // area
    ["ANY", "PRESENT", true], // activation
    [format ["this and !(thisTrigger getVariable ['%1',false])", QGVAR(cooldown)], format ["[thisTrigger, thisList] call %1", QFUNC(activateComet)], ""] // statements
] call FUNC(setTrigger);

if (hasInterface) then {
    // fire
    private _particleSource = "#particlesource" createVehicleLocal _pos;
    _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 0, 32, 0], "", "billboard",
        1,1, //lifetime
        [0,0,0], //position
        [0,0,0], //move velocity
        1, //rotationVelocity
        0.6, //weight
        0.45, //volume
        0, // rubbing
        [2,2,2,2,1,0.5,0.00], //size
        [[0.5,0.5,1,-4],[0.5,0.5,1,-3],[0.5,0.5,1,-2],[0.5,0.5,1,-1],[0.5,0.5,1,0]], //color
        [1], 0.01, 0.02, "", "", _particleSource,0,true,0.6,[[3,3,3,0]]
    ];
    _particleSource setParticleRandom [0, [0,0,0], [0,0,0], 0, 0, [0,0,0,0], 5, 1, 0.2];
    _particleSource setDropInterval 0.1;

    _sourceTrg setVariable [QGVAR(particleSource), _particleSource];

    private _light = "#lightpoint" createVehicleLocal _pos;
    _light setLightAmbient [1, 0.75, 0.75];
    _light setLightColor [1, 0.75, 0.75];
    _light setLightBrightness 5;
    _light setLightFlareMaxDistance 100;
    _light setLightUseFlare true;
    _light setLightDayLight true;
    _light setLightFlareSize 5;

    // refract
    private _particleSource2 = "#particlesource" createVehicleLocal _pos;
    _particleSource2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1],"","billboard",
        1,3, //lifetime
        [0,0,0], //position
        [0,0,0], //move velocity
        1, //rotationVelocity
        0.05, //weight
        0.04, //volume
        1.05, // rubbing
        [5, 5, 3, 1.5, 0.75, 0.33, 0.1, 0.01], //size
        [[0.1, 0.1, 0.1, 0.5]], //color
        [1.2], 0.1, 0.05, "", "", _particleSource2,0,true,0
    ];
    _particleSource2 setParticleRandom [0, [0, 0, 0], [1, 1, 1], 20, 0, [0, 0, 0, 0], 0, 0, 0.5];
    _particleSource2 setDropInterval 0.01;

    // sparks
    private _particleSource3 = "#particlesource" createVehicleLocal _pos;
    _particleSource3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0], "", "billboard",
        1,1, //lifetime
        [0,0,0], //position
        [0, 0, 0], //move velocity
        1, //rotationVelocity
        1.05, //weight
        1, //volume
        0.17, // rubbing
        [0.5, 0.51, 0.51, 0.51, 0.51, 0.4, 0.4, 0.4, 0.4, 0.1, 0.1, 0], //size
        [[1, 0.3, 0.3, -6.5], [1, 0.3, 0.3, -6], [1, 0.3, 0.3, -5.5], [1, 0.3, 0.3, -4.5]], //color
        [1000], 0.5, 0.55, "", "", _particleSource3,0,true,0.6,[[3,3,3,0]]
    ];
    _particleSource3 setParticleRandom [2.5, [1, 1, 1], [0.2, 1, 0.2], 2, 0.04, [0, 0.15, 0.15, 0], 0.3, 0.15, 360];
    _particleSource3 setDropInterval 0.05;

    private _sound = createSoundSourceLocal [QGVAR(soundComet), _pos, [], 0];

    _trg setVariable [QGVAR(attached), [_particleSource, _light, _particleSource2, _particleSource3, _sound]];
};

[{
    params ["_trg", "_sourceTrg"];
    if (isGamePaused) exitWith {false};
    private _pos = [_trg] call FUNC(movementTick);
    {
        _x setPosASL _pos;
    } forEach (_trg getVariable [QGVAR(attached), []]);

    isNull _sourceTrg || { isNull (_sourceTrg getVariable [QGVAR(particleSource), objNull] )|| {!simulationEnabled _sourceTrg}}
}, {
    params ["_trg", "_sourceTrg"];
    if (GVAR(debug)) then {
        systemChat "Comet stopped";
        systemChat format ["srcTrg null: %1", isNull _sourceTrg];
        systemChat format ["srcTrg particlesrc null: %1", isNull (_sourceTrg getVariable [QGVAR(particleSource), objNull])];
        systemChat format ["srcTrg not simulated: %1", !simulationEnabled _sourceTrg];
    };

    {
        deleteVehicle _x;
    } forEach (_trg getVariable [QGVAR(attached), []]);
    deleteVehicle _trg;
    deleteVehicle (_sourceTrg getVariable [QGVAR(particleSource), objNull]);
}, [
    _trg,
    _sourceTrg
]] call CBA_fnc_waitUntilAndExecute;
