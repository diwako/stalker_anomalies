#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params[["_source",objNull], ["_state","idle"], ["_attached", objNull]];
if (isNull _source || isNull _attached) exitWith {};

switch (_state) do {
    case "idle": {
        private _radius = _attached getVariable QGVAR(radius);
        private _angle = _attached getVariable QGVAR(angle);
        private _rectangle = _attached getVariable QGVAR(rectangle);
        if (_rectangle) then {
            _source setParticleCircle [0, [0, 0, 0]];
            _source setParticleRandom [0, [_radius, _radius, 0], [0.01, 0.01, 0], 0, 0, [0, 0, 0, 0], 0, 0];
        } else {
            _source setParticleCircle [_radius/2, [0, 0, 0]];
            _source setParticleRandom [0, [_radius/2, _radius/2, 0], [0.01, 0.01, 0], 0, 0, [0, 0, 0, 0], 0, 0];
        };
        _source setParticleParams [
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
            [0, 0, 2], //position, /*3D Array of numbers as relative position to particleSource or (if object at index 18 is set) object. Or (if object at index 18 is set) String as memoryPoint of object.*/
            [0, 0, 0], //moveVelocity, /*3D Array of numbers.*/
            0, //rotationVelocity
            10.075125, //weight
            // 10.078125, //weight
            7.9, //volume
            0, //rubbing
            [0.01, 5, 5, 0.01], //size array of numbers
            [[(249/255), (248/255), (242/255), ((1/_radius) max 0.1)]], //color rgba array of rgba
            // [[1, 1, 1, ((1/_radius) max 0.1)]], //color rgba array of rgba
            [1], //animation speed array of numbers
            1, //randomDirectionPeriod
            0, //randomDirectionIntensity
            "", //onTimerScript
            "", //beforeDestroyScript
            _source, //object to attach to
            _angle //angle, /*Optional Number - Default: 0*/
            //false, //onSurface
            //0 //bounceOnSurface number
            //[] // emmision colors array or rgba
        ];
        private _dropSpeed = (1/_radius) max 0.01;
        _source setDropInterval _dropSpeed;
    };
    default { };
};
