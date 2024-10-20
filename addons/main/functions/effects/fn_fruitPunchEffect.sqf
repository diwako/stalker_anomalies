#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params[["_source",objNull],["_state","idle"]];
if (isNull _source) exitWith {};

switch (_state) do {
    case "idle": {
        _source setParticleCircle [0, [0, 0, 0]];
        _source setParticleRandom [0, [0.5, 0.5, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0.25], 0, 10, 7.9, 0, [0.125,0.125, 0.01], [[0.1, 1, 0.1, 1]], [0.08], 1, 0, "", "", _source,0,false,0,[[0.1, 1, 0.1, 1]]];
        _source setDropInterval 0.75;
    };
    case "active": {
        _source setParticleCircle [0, [0, 0, 0]];
        _source setParticleRandom [0, [0.5, 0.5, 0], [1, 1, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 2], 0, 10, 7.9, 0, [0.125,0.125, 0.01], [[0.1, 1, 0.1, 1]], [0.08], 1, 0, "", "", _source,0,false,0,[[0.1, 1, 0.1, 1]]];
        _source setDropInterval 0.1;
    };
    default { };
};
