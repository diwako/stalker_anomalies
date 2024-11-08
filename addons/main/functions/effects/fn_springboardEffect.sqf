#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params [["_source",objNull], ["_state","idle"], ["_source2",objNull]];
if (isNull _source) exitWith {};

switch (_state) do {
    case "idle": {
        _source setParticleCircle [2, [0, 0, 0]];
        _source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.5, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\A3\data_f\cl_leaf", 1, 0, 1], "", "SpaceObject", 1, 7, [0, 0, 0], [0, 0, 0.5], 0, 10, 7.9, 0.075, [2, 2, 0.01], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [6, 5, 5], 1, 0, "", "", _source];
        _source setDropInterval 0.2;

        _source2 setParticleCircle [0, [0, 0, 0]];
        _source2 setParticleRandom [0, [1.5, 1.5, 1], [0, 0, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 2, 0.5, [0, 0, 1], [0, 0, 0], 0, 10, 7.9, 0.075, [0, 1, 0.5], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _source2];
        _source2 setDropInterval (0.9 + random 0.5);
    };
    case "active": {
        _source setParticleCircle [0, [0, 0, 0]];
        _source setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
        _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 2, 1, [0, 0, 1], [0, 0, 0], 0, 10, 7.9, 0.075, [0, 10, 5], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _source];
        _source setDropInterval 0.05;

        private _dropPos = (getPos _source) vectorAdd [0, 0, 0.15];
        for "_" from 0 to 75 do {
            private _velocity = (_dropPos vectorFromTo ((_source getPos [10, random 360] vectorAdd [0, 0, -3 + random 10]))) vectorMultiply 12;
            private _size = 2 + random 0.5;
            drop [["\A3\data_f\cl_leaf", 1, 0, 1], "", "SpaceObject", 1,
                5, //lifetime
                _dropPos, // position
                _velocity, // velocity
                0,
                15, // weight
                7.9, 0.075,
                [_size, _size, 0.01], // size
                [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [6, 5, 5], 1, 0, "", "", "", 0, true, 0.3];
        };
        for "_" from 0 to 100 do {
            private _velocity = (_dropPos vectorFromTo (_source getPos [10, random 360])) vectorMultiply (10 + random 10);
            drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13, 0], "", "Billboard", 1,
                0.1 + random 0.5, //lifetime
                _dropPos, // position
                _velocity, // velocity
                1 + random 20, // rotationVelocity
                900, // weight
                50, // volume
                0.075, // rubbing
                [0.5, 3], // size
                [[0.08,0.067,0.052,0],[0.6,0.5,0.4,0.5],[0.6,0.5,0.4,0.4],[0.6,0.5,0.4,0.3],[0.6,0.5,0.4,0.15],[0.6,0.5,0.4,0]], // color
                [1000], // animation phase
                0.05, 0.1, "", "", "", 0, false, 1];
        };
    };
    default { };
};
