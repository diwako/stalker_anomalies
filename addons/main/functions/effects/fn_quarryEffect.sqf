#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params[["_source", objNull], ["_state", "idle"], ["_source2", objNull]];
if (isNull _source || isNull _source2) exitWith {};

switch (_state) do {
    case "idle": {
        private _radius = 10;
        private _radiusSlashed = _radius/2;
        _source setParticleRandom [0, [_radiusSlashed, _radiusSlashed, 0], [0.1,0.1,1], 0, 0.25,[0,0,0,1],1,0,0];
        _source setParticleCircle [_radiusSlashed, [0, 0, 0]];
        _source setParticleParams [
            ["\A3\data_f\ParticleEffects\Universal\Mud.p3d",1,0,1],
            "", //animationName
            "SpaceObject", //particleType
            0.1, //timerPeriod
            10, //lifeTime
            [0,0,0], //position
            [0,0,1.5], //moveVelocity
            1, //rotationVelocity
            6.68, //weight
            5, //volume
            0, //rubbing
            [0.01, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.01], //size
            [[0,0,0,1]], //color
            [1], //animationSpeed
            1, //randomDirectionPeriod
            0, //randomDirectionIntensity
            "", //onTimerScript
            "", //beforeDestroyScript
            _source, //object to attach to
            0, //angle
            true, //onSurface
            0.1 //bounceOnSurface
            ];
        _source setDropInterval 0.1;

        _source2 setParticleRandom [0, [_radiusSlashed + 2, _radiusSlashed + 2, 0], [0.01, 0.01, 0], 0, 0, [0, 0, 0, 0], 0, 0];
        _source2 setParticleCircle [_radiusSlashed, [0, 0, 0]];
        _source2 setParticleParams [
            [
                "\A3\data_f\cl_basic", //particleShape
                1,         //particleFSNtieth
                0,         //particleFSIndex
                1        //particleFSFrameCount
                //true     //particleFSLoop
            ],
            "", //animationName
            "Billboard", //particleType, /*String - Enum: Billboard, SpaceObject*/
            1, //timerPeriod
            50, //lifeTime
            [0, 0, 0], //position, /*3D Array of numbers as relative position to particleSource or (if object at index 18 is set) object. Or (if object at index 18 is set) String as memoryPoint of object.*/
            [0, 0, 0], //moveVelocity, /*3D Array of numbers.*/
            0, //rotationVelocity
            10.075125, //weight
            // 10.078125, //weight
            7.9, //volume
            0, //rubbing
            [0.01, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.01], //size array of numbers
            [[0.37, 0.28, 0.17, 0.75]], //color rgba array of rgba
            // [[1, 1, 1, ((1/_radius) max 0.1)]], //color rgba array of rgba
            [1], //animation speed array of numbers
            1, //randomDirectionPeriod
            0, //randomDirectionIntensity
            "", //onTimerScript
            "", //beforeDestroyScript
            _source2, //object to attach to
            0 //angle, /*Optional Number - Default: 0*/
            //false, //onSurface
            //0 //bounceOnSurface number
            //[] // emmision colors array or rgba
        ];
        _source2 setDropInterval 0.05;
    };
    default { };
};
