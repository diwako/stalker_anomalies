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

    [QGVAR(teleportOnEnter),{
        params ["_unit", "_enterTrigger", "_exitTrigger"];

        [_unit, _enterTrigger, _exitTrigger] call (_enterTrigger getVariable [QGVAR(onEnterCode), {}]);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(teleportOnExit),{
        params ["_unit", "_enterTrigger", "_exitTrigger"];

        [_unit, _enterTrigger, _exitTrigger] call (_exitTrigger getVariable [QGVAR(onExitCode), {}]);
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

ADDON = true;
