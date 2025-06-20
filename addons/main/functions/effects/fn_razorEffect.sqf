#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params [["_source", objNull], ["_state", "idle"]];
if (isNull _source) exitWith {};

switch (_state) do {
    case "idle": {
        private _size = 0.5;
        _source setParticleCircle [2, [0, 0, 0]];
        _source setParticleRandom [0, [2, 2, 4], [0, 0, 0], 0, 0.5, [0, 0, 0, 0], 0, 0];
        _source setParticleParams [
            ["\A3\Structures_F_Oldman\Decals\BrokenCarGlass_01_4x4_F.p3d", 1, 0, 0],
            // ["\A3\data_f\ParticleEffects\Universal\Universal", 1, 0, 0],
            "", // animationName, /* String */
            "SpaceObject", // particleType, /* String - Enum: Billboard, SpaceObject */
            1, // timerPeriod, /* Number */
            30, // lifeTime, /* Number */
            [0, 0, 0], // pos3D,
            [0, 0, 0], // moveVelocity, /* 3D Array of numbers. */
            0, // rotationVelocity, /* Number */
            10.075125, //weight
            7.90205, //volume
            0, // rubbing, /* Number */
            [0.01, _size, _size, _size, 0.01], // sizeOverLifetime, /* Array of Numbers */
            [[1, 1, 1, 0.1]], // color, /* Array of Array of RGBA Numbers */
            [0.08], // animationSpeed, /* Array of Number */
            0, // randomDirectionPeriod, /* Number */
            0, // randomDirectionIntensity, /* Number */
            "", // onTimerScript, /* String */
            "", // beforeDestroyScript, /* String */
            _source, // obj, /* Object */
            0, // angle, /* Optional Number - Default: 0 */
            false, // onSurface, /* Optional Boolean */
            0 // bounceOnSurface, /* Optional Number */
            // [[1, 1, 1, 0]] // emissiveColor, /* Optional Array of Array of RGBA Numbers */
        ]; // vectorDirOrVectorDirAndUp /* Optional vector dir or [vectorDir, vectorUp]

        _source setDropInterval 0.15;
    };
    default { };
};
