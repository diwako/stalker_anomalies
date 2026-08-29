#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params[["_source",objNull], ["_state","idle"]];
if (isNull _source) exitWith {};

switch (_state) do {
    case "idle": {
        _source setParticleCircle [0, [0, 0, 0], true];
        _source setParticleRandom [1, [0.25, 0.25, 0], [0, 0, 1], 1, 0, [0, 0, 0, 0.1], 0, 0];
        // _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,0],"","billboard",1,1,
        _source setParticleParams [["\a3\data_f_orange\ParticleEffects\Universal\orangeExplode_01",4,0,16,0],"","billboard",1,1,
        // _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\GlassShards", 1, 0, 1], "", "SpaceObject",1,1,
        [0,0,0], //position
        [0,0,0], //move velocity
        0, //rotationVelocity
        10.053, //weight
        7.9, //volume
        0, // rubbing
        [1,1,1,1,1,0.01,0.001], //size
        [[1,1,1,-4],[1,1,1,-3],[1,1,1,-2],[1,1,1,-1],[1,1,1,0]], //color
        [1], 0.01, 0.02, "", "", "",0,false,-1,[[3,3,3,0]]];
        _source setParticleFire [0.6*2, 0.25*2, 0.1];
        _source setDropInterval 0.1;
    };
    case "splash": {
        _source setParticleCircle [0, [0, 0, 0], true];
        _source setParticleRandom [0.25, [0.25, 0.25, 0], [0, 0, 1], 50, 0.5, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\a3\data_f_orange\ParticleEffects\Universal\orangeExplode_01",4,0,16,0],"","billboard",1,
        0.25,
        [0,0,0], //position
        [0,0,0], //move velocity
        5, //rotationVelocity
        10.053, //weight
        7.9, //volume
        0, // rubbing
        [4,4,4,4,4,0.01,0.001], //size
        [[0.8,0.1,0.1,-4],[0.8,0.1,0.1,-3],[0.8,0.1,0.1,-2],[0.8,0.2,0.2,-1],[0.8,0.2,0.2,0]], //color
        [1], 0.01, 0.02, "", "", "",0,false,-1,[[3,3,3,0]]];
        _source setDropInterval 0.05;
    };
    default { };
};
