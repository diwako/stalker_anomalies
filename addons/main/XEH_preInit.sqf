#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "settings.inc.sqf"

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
            case "psyDischarge": { _args call FUNC(createPsyDischarge) };
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

    [QGVAR(fruitPunchEffect), {
        if (isNull _this) exitWith {};
        [_this, "active"] call FUNC(fruitPunchEffect);
    }] call CBA_fnc_addEventHandler;
};

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

[QGVAR(aceDamage), {
    _this call ace_medical_fnc_addDamageToUnit;
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
            };
        };
        case 2: {
            if !(hasInterface) exitWith {};
            playSound "blowout_wave_2";
            [] call FUNC(chromatic);
            [1] call FUNC(psyEffect);
            [] call FUNC(blowoutRumble);
            [true] call FUNC(showPsyWavesInSky);
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
            if !(hasInterface) exitWith {};
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
                if !([_player] call FUNC(isInShelter)) then {
                    _player setDamage 1;
                };
            }, nil, 10] call CBA_fnc_waitAndExecute;
        };
        default {
        };
    };
}] call CBA_fnc_addEventHandler;

ADDON = true;
