#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params[["_source",objNull],["_state","idle"]];
if (isNull _source) exitWith {};

switch (_state) do {
    case "idle": {
        _source setParticleCircle [3, [0, 0, 0]];
        _source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0.25], 0, 10, 7.9, 0, [2, 2, 0.01], [[0.1, 0.1, 0.1, 0.5]], [0.08], 1, 0, "", "", _source];
        _source setDropInterval 0.1;
    };
    case "active": {
        if (isClass (configFile >> "CfgCloudlets" >> "ace_cookoff_CookOff")) then {
            _source setParticleClass "ace_cookoff_CookOff";
        } else {
            _source setParticleCircle [0, [2,2,2]];
            _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,0,32,0],"","billboard",1,1,
            [0,0,0], //position
            [0,0,4], //move velocity
            1, //rotationVelocity
            0.4, //weight
            0.45, //volume
            0, // rubbing
            [0.01,0.5,1,1,1.5,0.01,0.001], //size
            [[1,1,1,-4],[1,1,1,-3],[1,1,1,-2],[1,1,1,-1],[1,1,1,0]], //color
            [1], 0.01, 0.02, "", "", "",0,true,0.6,[[3,3,3,0]]];
            _source setParticleRandom [0, [0,0,0], [0,0,0], 0, 0, [0,0,0,0], 5, 1, 0.2];
            // _source setParticleFire [0.6*2, 0.25*2, 0.1];
            _source setDropInterval 0.004;
        };
    };
    default { };
};
