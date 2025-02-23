#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "settings.inc.sqf"

/*
Valid values:
- vanilla
- ace_medical
- aps
- custom
*/
GVAR(medicalSystem) = call {
    if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) exitWith {"ace_medical"};
    if (isClass(configFile >> "CfgPatches" >> "diw_armor_plates_main")) exitWith {"aps"};
    "vanilla"
};

GVAR(medicalSystemMap) = createHashMap;
GVAR(medicalSystemMap) set ["vanilla", createHashMapFromArray [
    // [anomaly_type, [player_damage, ai_damage]]
    ["burner", [0.5, 1]],
    ["comet", [0.5, 1]],
    ["electra", [0.5, 1]],
    ["fog", [0.05, 0.05]],
    ["fruitpunch", [0.2, 0.2]],
    ["springboard", [0.5, 1]],
    ["psydischarge", [{0.35 + random 0.75}, {0.5 + random 0.75}]],
    ["clicker", [{0.1 + random 0.5}, {0.5 + random 0.5}]]
]];
GVAR(medicalSystemMap) set ["ace_medical", createHashMapFromArray [
    // [anomaly_type, [[multiplier_player, ai], body_part_array, damage_type]]
    ["burner", [[0.9, 10], ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "burn"]],
    ["comet", [[0.9, 10], ["head", "body"], "burn"]],
    ["electra", [[1, 10], ["head", "body"], "stab"]],
    ["fog", [[0.2, 0.2], ["body"], "punch"]],
    ["fruitpunch", [[0.2, 0.333], ["leg_l", "leg_r"], "stab"]],
    ["springboard", [[1.5, 10], ["leg_l", "leg_r"], "stab"]],
    ["psydischarge", [[0.9, 0.9], ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "backblast"]],
    ["clicker", [[1.5, 3], ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "backblast"]]
]];
GVAR(medicalSystemMap) set ["aps", createHashMapFromArray [
    // [anomaly_type, [[multiplier_player, ai], body_part_array, bullet_type]]
    ["burner", [[0.9, 2], ["head", "pelvis", "hands", "legs"], "B_65x39_Caseless"]],
    ["comet", [[0.9, 2], ["head", "pelvis", "hands", "legs"], "B_65x39_Caseless"]],
    ["electra", [[1, 2], ["head", "pelvis", "hands", "legs"], "B_45ACP_Ball"]],
    ["fog", [[0.05, 0.2], ["pelvis"], "B_9x21_Ball"]],
    ["fruitpunch", [[0.2, 0.333], ["legs"], "B_9x21_Ball"]],
    ["springboard", [[1.5, 2], ["legs"], "B_45ACP_Ball"]],
    ["psydischarge", [[0.9, 0.9], ["head", "pelvis", "hands", "legs"], "B_9x21_Ball"]],
    ["clicker", [[1.5, 2], ["head", "pelvis", "hands", "legs"], "B_45ACP_Ball"]]
]];

if (isServer) then {
    GVAR(movingAnomalyPFH) = -1;
    GVAR(movingAnomalyHolder) = [];
    [QGVAR(createAnomaly), {
        params ["_args", "_type"];
        switch (_type) do {
            case "meatgrinder":  { _args call FUNC(createMeatgrinder) };
            case "springboard":  { _args call FUNC(createSpringboard) };
            case "burner":       { _args call FUNC(createBurner) };
            case "teleport":     { _args call FUNC(createTeleport) };
            case "fog":          { _args call FUNC(createFog) };
            case "electra":      { _args call FUNC(createElectra) };
            case "fruitpunch":   { _args call FUNC(createFruitpunch) };
            case "psyDischarge": { /* Handled in global eventhandler */ };
            case "clicker":      { _args call FUNC(createClicker) };
            default {
                hintC ( format ["Unknown type: %1", _type]);
            };
        };
    }] call CBA_fnc_addEventHandler;

    [QGVAR(deleteAnomalies), {
        _this call FUNC(deleteAnomalies);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(stopBlowout), {
        if !(missionNamespace getVariable [QGVAR(blowoutInProgress), false]) exitWith {};
        [0] call FUNC(blowout);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(startBlowout), {
        _this call FUNC(blowoutCoordinator);
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(say3D), {
        params ["_obj", "_sound"];
        _obj say3D _sound;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(teleportFlash), {
        [] call FUNC(teleportFlash);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(deleteParticleSource), {
        params ["_trg"];
        [_trg] call FUNC(deleteParticleSource);
        // delete local only idle sound
        deleteVehicle (_trg getVariable [QGVAR(soundIdleLocal), objNull]);
    }] call CBA_fnc_addEventHandler;

    #include "anomalyFXEvents.inc.sqf"
};

[QGVAR(createAnomaly), {
    params ["_args", "_type"];
    if (_type isEqualTo "psyDischarge") then {
        _args call FUNC(createPsyDischarge)
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(setLight), {
    params [["_light", objNull]];
    if (isNull _light) exitWith {};
    _this call FUNC(setLight);
}] call CBA_fnc_addEventHandler;

[QGVAR(suckToLocation), {
    _this call FUNC(suckToLocation);
}] call CBA_fnc_addEventHandler;

[QGVAR(minceCorpse), {
    _this call FUNC(minceCorpse);
}] call CBA_fnc_addEventHandler;

[QGVAR(setTrigger), {
    params [["_trg", objNull]];
    if (isNull _trg) exitWith {};
    _this call FUNC(setTrigger);
}] call CBA_fnc_addEventHandler;

[QGVAR(addUnitDamage), {
    _this call FUNC(addUnitDamage);
}] call CBA_fnc_addEventHandler;

[QGVAR(setHit), {
    params ["_obj", "_args"];
    _obj setHit _args;
}] call CBA_fnc_addEventHandler;

[QGVAR(setHitPointDamage), {
    params ["_obj", "_args"];
    _obj setHitPointDamage _args;
}] call CBA_fnc_addEventHandler;

[QGVAR(setVelocity), {
    params ["_obj", "_args"];
    _obj setVelocity _args;
}] call CBA_fnc_addEventHandler;

[QGVAR(blowOutStage), {
    params ["_stage", ["_args", []]];
    if (!GVAR(blowoutInProgress) && _stage > 0) exitWith {};
    if (GVAR(debug)) then {
        systemChat format ["EVENT Blowout entered stage: %1 | args: %2", _stage, _args];
    };
    switch (_stage) do {
        case 0: {
            enableEnvironment true;
            if (hasInterface) then {
                30 fadeEnvironment 1;
                [0] call FUNC(psyEffect);
                [false] call FUNC(showPsyWavesInSky);
                private _fnc_lightning = {
                    if (time >= (_this select 1)) exitWith {};
                    [] call FUNC(createLocalLightningBolt);
                    [{
                        _this call (_this select 0);
                    }, _this, 3 + random 4] call CBA_fnc_waitAndExecute;
                };

                [_fnc_lightning, time + 60] call _fnc_lightning;
            };
        };
        case 1: {
            _args params ["_time"];
            60 setOvercast 1;
            if (hasInterface) then {
                _time fadeEnvironment 0;
            };
            [{
                if !(GVAR(blowoutInProgress)) exitWith {};
                enableEnvironment false;
                if (GVAR(debug)) then {
                    systemChat "Environment disabled";
                };
            }, nil, _time] call CBA_fnc_waitAndExecute;
            if (hasInterface) then {
                [{
                    if !(GVAR(blowoutInProgress)) exitWith {};
                    private _pos = AGLToASL (([] call CBA_fnc_currentUnit) getPos [5000, GVAR(blowoutDirection)]);
                    private _obj = QGVAR(boltThrowDummy) createVehicleLocal _pos;
                    _obj setPosASL _pos;
                    _obj say3D ["blowout_begin", 50000, 1];
                    [{
                        deleteVehicle _this;
                    }, _obj, 30] call CBA_fnc_waitAndExecute;
                    [] call FUNC(chromatic);
                    [{
                        if !(GVAR(blowoutInProgress)) exitWith {};
                        playSound "blowout_wave_1";
                        [] call FUNC(chromatic);
                        // [1] call FUNC(psyEffect);
                    }, nil, 15] call CBA_fnc_waitAndExecute;
                    [{
                        if !(GVAR(blowoutInProgress)) exitWith {};
                        [] call FUNC(blowoutSirens);
                    }, nil, 18 + random 10] call CBA_fnc_waitAndExecute;
                }, nil, 60 - _time] call CBA_fnc_waitAndExecute;
                [{
                    private _pos = AGLToASL (([] call CBA_fnc_currentUnit) getPos [5000, GVAR(blowoutDirection)]);
                    private _obj = QGVAR(boltThrowDummy) createVehicleLocal _pos;
                    _obj setPosASL _pos;
                    _obj say3D [selectRandom ["blowout_begin_01", "blowout_begin_02"], 50000, 1];
                    [{
                        deleteVehicle _this;
                    }, _obj, 40] call CBA_fnc_waitAndExecute;
                }, nil, 25] call CBA_fnc_waitAndExecute;
            };
        };
        case 2: {
            if !(hasInterface) exitWith {};
            playSound "blowout_wave_2";
            [] call FUNC(chromatic);
            [1] call FUNC(psyEffect);
            [] call FUNC(blowoutRumble);
            [true] call FUNC(showPsyWavesInSky);

            if !(GVAR(blowoutEnvironmentParticleEffects)) exitWith {};
            private _leaves = "#particlesource" createVehicleLocal [0, 0, 0];
            _leaves setParticleRandom [0, [25, 25, 25], [1, 1, 0], 3, 0.75, [0, 1, 0, 0.5], 1, 1];
            _leaves setDropInterval 0.005;

            private _fnc_leaves = {
                params ["_source", "_fnc", "_oldWind"];
                if (GVAR(blowoutStage) < 2) exitWith {
                    deleteVehicle _source;
                };

                private _player = [] call CBA_fnc_currentUnit;
                _source setPosASL AGLToASL (positionCameraToWorld  [0, 0, 0]);
                private _wind = wind;

                if (_wind isNotEqualTo _oldWind) then {
                    _source setParticleParams [
                        // ["a3\data_f\ParticleEffects\Hit_Leaves\Leaves.p3d", 1, 1, 1],
                        ["\A3\data_f\cl_leaf", 1, 1, 1],
                        "",
                        "SpaceObject",
                        1,
                        8,
                        vectorNormalized _wind vectorMultiply -20, // position
                        [0, 0, 0], // velocity
                        2,0.000001,
                        0.0, // volume
                        1, // rubbing
                        [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0.1], // size
                        [[0.68,0.68,0.68,1]], // color
                        [1.5,1],13,13,"","",vehicle _player,0,
                        true,
                        0.2,
                        [[0, 0, 0, 0]]
                    ];
                };
                _source enableSimulation (vectorMagnitude _wind > 5 && {insideBuilding _player isNotEqualTo 1});

                [_fnc, [_source, _fnc, _wind], 2] call CBA_fnc_waitAndExecute;
            };
            [_leaves, _fnc_leaves, []] call _fnc_leaves;

            private _fnc_dust = {
                params ["_fnc"];
                if (GVAR(blowoutStage) < 2) exitWith {};

                private _wind = wind;
                if (vectorMagnitude _wind > 8 && {insideBuilding ([] call CBA_fnc_currentUnit) isNotEqualTo 1}) then {
                    // private _pos = positionCameraToWorld [0,0,0];
                    private _pos = positionCameraToWorld [0,0,0] vectorAdd (_wind vectorMultiply -5);
                    private _right = _wind select 0 * 2;
                    private _forward = _wind select 1 * 2;

                    private _radius = 0;
                    private _lifetime = 0;
                    private _randomdir = 0;
                    private _size = 0;
                    private _color = [];
                    private _randomColor = 0;
                    for "_i" from 1 to 15 do {
                        _radius= 10 + random (80 - 10);
                        _randomdir = random 360;
                        _lifetime = 8 + random (15 - 8);
                        _size = 0.75 + random (3 - 0.75);
                        _randomColor = -0.5 + random 0.7;
                        _color = [0.69, 0.616, 0.498, 0.3] vectorAdd [_randomColor, _randomColor, _randomColor];
                        drop [
                            "\A3\data_f\cl_basic",
                            "", "Billboard",
                            0,
                            _lifetime,
                            [(_pos select 0) + _radius * sin _randomdir, (_pos select 1) + _radius * cos _randomdir, 0.13],
                            [_right, _forward, 0],
                            _lifetime / 5,
                            0.2, // weight
                            0.075, // volume
                            0.01, // rubbing
                            [0.001, _size, _size, _size, _size,  0.001],
                            [[0.69, 0.616, 0.498, 0], _color, _color, _color, _color, _color, _color, [0.69, 0.616, 0.498, 0]], [0], 0, 0, "",  "", "", 0, true, 0.75
                        ];
                    };
                };

                [_fnc, [_fnc], 0.25] call CBA_fnc_waitAndExecute;
            };
            [_fnc_dust] call _fnc_dust;


            private _sticks  = "#particlesource" createVehicleLocal [0, 0, 0];
            _sticks setParticleRandom [0, [20, 20, 10], [1, 1, 2], 1.5, 0.2, [0, 0, 0, 0.5], 1, 1, 0, 0.3];
            _sticks setDropInterval 0.2;

            private _fnc_sticks = {
                params ["_source", "_fnc", "_oldWind"];
                if (GVAR(blowoutStage) < 2) exitWith {
                    deleteVehicle _source;
                };

                private _player = [] call CBA_fnc_currentUnit;
                _source setPosASL AGLToASL (positionCameraToWorld  [0, 0, 0]);
                private _wind = wind;

                if (_wind isNotEqualTo _oldWind) then {
                    _source setParticleParams [
                        ["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks", 1, 1, 1],
                        "", "SpaceObject", 1,
                        10,
                        [0,0,0],
                        [_wind select 0, _wind select 1, 7],
                        2, // weight
                        0.000001, // volume
                        0.0, 0.4, // rubbing
                        [0.9], // size
                        [[0.68,0.68,0.68,1]],
                        [0], 13, 13, "", "", vehicle _player, 0, true , 1, [[0,0,0,0]]
                    ];
                };
                _source enableSimulation (vectorMagnitude _wind > 5 && {insideBuilding _player isNotEqualTo 1});

                [_fnc, [_source, _fnc, _wind], 2] call CBA_fnc_waitAndExecute;
            };
            [_sticks, _fnc_sticks, []] call _fnc_sticks;

        };
        case 3: {
            if !(hasInterface) exitWith {};
            playSound "blowout_wave_3";
            [10] call FUNC(blowoutWave);
            [{
                [] call FUNC(chromatic);
                playSound "blowout_wave_2";
            }, nil, 10] call CBA_fnc_waitAndExecute;
            [] call FUNC(chromatic);
            [2] call FUNC(psyEffect);
        };
        case 4: {
            if !(hasInterface) exitWith {
                [{
                    if (GVAR(blowoutIsLethal) && {!GVAR(blowoutInProgress) || GVAR(blowoutAffectPlayersOnly)}) exitWith {};
                    private _units = allUnits;
                    if !(isServer) then {
                        // maybe headless client should not kill itself
                        _units = _units - [player];
                    };
                    {
                        if (local _x && {alive _x} && {isDamageAllowed _x} && {!([_x] call FUNC(isInShelter))}) then {
                            _x setDamage [1, true, _x, _x];
                        };
                    } forEach _units;
                }, nil, 10] call CBA_fnc_waitAndExecute;
            };
            [] call FUNC(blowoutWave);

            [{
                if !(GVAR(blowoutInProgress)) exitWith {};
                playSound "blowout_wave_3";
                [] call FUNC(chromatic);
                private _player = [] call CBA_fnc_currentUnit;
                if !([_player] call FUNC(isInShelter)) then {
                    private _position = _player selectionPosition selectRandom ["spine","spine1","spine2","spine3","head","leftshoulder","leftarm","leftarmroll","leftforearm","leftforearmroll","lefthand","rightshoulder","rightarm","rightarmroll","rightforearm","rightforearmroll","righthand","pelvis","leftupleg","leftuplegroll","leftleg","leftlegroll","leftfoot","rightupleg","rightuplegroll","rightleg","rightlegroll","rightfoot"];
                    _player addForce [(vectorNormalized velocity _player) vectorMultiply (100 + random 200), _position, false];
                };
            }, nil, 7] call CBA_fnc_waitAndExecute;

            [{
                if !(GVAR(blowoutInProgress)) exitWith {};
                playSound "blowout";
                private _player = [] call CBA_fnc_currentUnit;
                [] call FUNC(chromatic);
                if (GVAR(blowoutIsLethal)) then {
                    if (isDamageAllowed _player && {!([_player] call FUNC(isInShelter))}) then {
                        _player setDamage [1, true, _player, _player];
                    };
                    if !(GVAR(blowoutAffectPlayersOnly)) then {
                        {
                            if (local _x && {!isNull _x && {alive _x && {isDamageAllowed _x && {!([_x] call FUNC(isInShelter))}}}}) then {
                                _x setDamage [1, true, _x, _x];
                            };
                        } forEach (allUnits - [player, _player]);
                    };
                };
            }, nil, 10] call CBA_fnc_waitAndExecute;
        };
        default {
        };
    };
}] call CBA_fnc_addEventHandler;

ADDON = true;
