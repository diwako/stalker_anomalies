params ["_source", ["_scale", 1] , "_type"];
if (isNull _source) exitWith {};
private _radius = 1.5;

_source setParticleCircle [0, [0, 0, 0], true];
if (_type isEqualTo "dirt") then {
    _source setParticleRandom [0, [(_radius/2) * _scale, (_radius/2) * _scale, 0], [0.01, 0.01, 0], 0, 0, [0, 0, 0, 0], 0, 0];
    _source setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Mud.p3d",1,0,1],
        "", //animationName
        "SpaceObject", //particleType
        1, //timerPeriod
        150, //lifeTime
        [0, 0, 0], //position, /*3D Array of numbers as relative position to particleSource or (if object at index 18 is set) object. Or (if object at index 18 is set) String as memoryPoint of object.*/
        [0, 0, 0], //moveVelocity, /*3D Array of numbers.*/
        0, //rotationVelocity
        10.073, //weight
        // 10.073125, //weight
        // 10.074125, //weight
        // 10.075125, //weight
        7.9, //volume
        0, //rubbing
        [0.01, 0.1 * _scale, 0.1 * _scale, 0.01], //size array of numbers
        [[249/255, 248/255, 242/255, 0.33]], //color rgba array of rgba
        [1], //animation speed array of numbers
        1, //randomDirectionPeriod
        0, //randomDirectionIntensity
        "", //onTimerScript
        "", //beforeDestroyScript
        _source //object to attach to
        // 0 //angle, /*Optional Number - Default: 0*/
        //false, //onSurface
        //0 //bounceOnSurface number
        //[] // emmision colors array or rgba
    ];
    _source setDropInterval 5;
};
if (_type isEqualTo "dust") then {
    _source setParticleRandom [0, [(_radius/2) * _scale, (_radius/2) * _scale, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
    _source setParticleParams [
        [
            "\A3\data_f\ParticleEffects\Universal\Universal", //particleShape
            16,   //particleFSNtieth
            12,   //particleFSIndex
            7,    //particleFSFrameCount
            0     //particleFSLoop
        ],
        "", //animationName
        "Billboard", //particleType, /*String - Enum: Billboard, SpaceObject*/
        1, //timerPeriod
        150, //lifeTime
        [0, 0, 0], //position, /*3D Array of numbers as relative position to particleSource or (if object at index 18 is set) object. Or (if object at index 18 is set) String as memoryPoint of object.*/
        [0, 0, 0], //moveVelocity, /*3D Array of numbers.*/
        0, //rotationVelocity
        10.073125, //weight
        // 10.074125, //weight
        // 10.075125, //weight
        7.9, //volume
        0, //rubbing
        [0.01, 1.5 * _scale, 1.5 * _scale, 0.01], //size array of numbers
        [[101/255, 76/255, 50/255, 0.33]], //color rgba array of rgba
        [0.1], //animation speed array of numbers
        1, //randomDirectionPeriod
        0, //randomDirectionIntensity
        "", //onTimerScript
        "", //beforeDestroyScript
        _source //object to attach to
        // 0 //angle, /*Optional Number - Default: 0*/
        //false, //onSurface
        //0 //bounceOnSurface number
        //[] // emmision colors array or rgba
    ];
    _source setDropInterval 10;
};
