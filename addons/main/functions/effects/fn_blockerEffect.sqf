#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_position", "_velocity"];
if !(hasInterface && {((getPosASL ([] call CBA_fnc_currentUnit)) distance _position) <= GVAR(idleDistance) } ) exitWith {};
private _sparks = "#particlesource" createVehicleLocal _position;
_sparks setPosASL _position;
_sparks setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0], "", "billboard",
    1,1, //lifetime
    [0 ,0, 0], //position
    [0, 0, 0], //move velocity
    1, //rotationVelocity
    10.075125, //weight
    7.90205, //volume
    0, // rubbing
    [0.01, 0.51, 0.51, 0.51, 0.51, 0.4, 0.4, 0.4, 0.4, 0.1, 0.1, 0], //size
    [[1, 0.3, 0.3, -6.5], [1, 0.3, 0.3, -6], [1, 0.3, 0.3, -5.5], [1, 0.3, 0.3, -4.5]], //color
    [1000], 0.5, 0.55, "", "", _sparks,0,true,0.6,[[3,3,3,0]]
];
_sparks setParticleRandom [1, [0, 0, 0], [0.05, 0.1, 0.05], 0.5, 0.04, [0, 0.15, 0.15, 0], 0.3, 0.15, 360];
_sparks setDropInterval 0.05;

[{
    params ["_time", "_timeEnd", "_pos", "_fromTo", "_sparks", "_maxDist"];
    private _curtime = time;
    _sparks setPosASL (_pos vectorAdd (_fromTo vectorMultiply (linearConversion [_time, _timeEnd, _curtime, 0, _maxDist])));
    _curtime > _timeEnd
},{
    params ["", "", "", "", "_sparks"];
    deleteVehicle _sparks;
}, [time, time + 1, _position, _position vectorFromTo (_position vectorAdd _velocity), _sparks, 1 + random 3]] call CBA_fnc_waitUntilAndExecute;
