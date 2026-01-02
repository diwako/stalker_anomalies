#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_psyEffect

    Description:
        Hear psy voices, see filmgrain, screen becomes orange

    Parameters:
        _strength - Integer Number as strength of the effects, 0 for off and max of 3 for maximum effect (default: 0)

    Returns:
        nothing

    Author:
    diwako 2024-10-26
*/
if !(hasInterface) exitWith {};
params [["_strength", 0], ["_id", "mission"]];
if (_strength < 0 || _strength > 3) exitWith {};

if (isNil QGVAR(psyIDMap)) then {
    GVAR(psyIDMap) = createHashMap;
};
_id = toLowerANSI _id;
if (_strength > 0) then {
    GVAR(psyIDMap) set [_id, _strength];
} else {
    GVAR(psyIDMap) deleteAt _id;
};
_strength = selectMax values GVAR(psyIDMap);
// nothing left in the map
if (isNil "_strength") then {
    _strength = 0;
};

if (isNil QGVAR(psyActive)) then {
    GVAR(psyActive) = false;
};

GVAR(psyStrength) = _strength;

if !(GVAR(psyActive)) then {
    GVAR(psyActive) = true;
    [] spawn {
        if(isNil QGVAR(ppeColorCorrections)) then {
            private _name = "colorCorrections";
            private _priority = 400;
            GVAR(ppeColorCorrections) = ppEffectCreate [_name, _priority];
            while {
                GVAR(ppeColorCorrections) < 0
            } do {
                _priority = _priority + 1;
                GVAR(ppeColorCorrections) = ppEffectCreate [_name, _priority];
            };
        };
        GVAR(ppeColorCorrections) ppEffectEnable true;
        // if(isNil QGVAR(ppeFilmGrain)) then {
        //     private _name = "filmGrain";
        //     private _priority = 400;
        //     GVAR(ppeFilmGrain) = ppEffectCreate [_name, _priority];
        //     while {
        //         GVAR(ppeFilmGrain) < 0
        //     } do {
        //         _priority = _priority + 1;
        //         GVAR(ppeFilmGrain) = ppEffectCreate [_name, _priority];
        //     };
        // };
        // GVAR(ppeFilmGrain) ppEffectEnable true;
        private _curStrength = -1;
        // private _modGrain = 1;
        private _modPissFilter = 1;
        private _wiggleStrength = 0;
        private _wiggleFrequency = 0;
        while {GVAR(psyActive) && _curStrength != 0} do {
            if (_curStrength != GVAR(psyStrength)) then {
                // avaluate strength change
                _curStrength = GVAR(psyStrength);
                switch (GVAR(psyStrength)) do {
                    case 1: {
                        // _modGrain = 3.33;
                        // _modPissFilter = 0.66;
                        _modPissFilter = 0.98;
                        _wiggleStrength = 1;
                        _wiggleFrequency = 0.5;
                    };
                    case 2: {
                        // _modGrain = 6.66;
                        // _modPissFilter = 0.333;
                        _modPissFilter = 0.5;
                        _wiggleStrength = 1.5;
                        _wiggleFrequency = 1;
                    };
                    case 3: {
                        // _modGrain = 10;
                        // _modPissFilter = 0;
                        _modPissFilter = 0.25;
                        _wiggleStrength = 3;
                        _wiggleFrequency = 1.5;
                    };
                    default { };
                };
                GVAR(ppeColorCorrections) ppEffectAdjust [1, 1, -0.002, [0.0, 0.0, 0.0, 0.0], [1, 0.9, 0.6, (1 * _modPissFilter)],  [0.5, 0.5, 1, 0]];
                GVAR(ppeColorCorrections) ppEffectCommit 10;
                // GVAR(ppeFilmGrain) ppEffectAdjust [(0.1 * _modGrain), 2, 0.1, 0.1, 2, true];
                // GVAR(ppeFilmGrain) ppEffectCommit 10;
            };
            if (isNil QGVAR(blowoutInProgress) || {!(GVAR(blowoutInProgress))}) then {
                addCamShake [_wiggleStrength, 15.9*2, _wiggleFrequency];
            };
            if (GVAR(psyStrength) != 0) then {
                playSound format ["psy_voices_%1", GVAR(psyStrength)];
            };
            sleep 15.9;
        };
        GVAR(ppeColorCorrections) ppEffectAdjust [1, 1, -0.002, [0.0, 0.0, 0.0, 0.0], [1, 0.9, 0.6, 1],  [0.5, 0.5, 1, 0]];
        GVAR(ppeColorCorrections) ppEffectCommit 10;
        // GVAR(ppeFilmGrain) ppEffectAdjust [0.1, 2, 0.1, 0.1, 2, true];
        // GVAR(ppeFilmGrain) ppEffectCommit 10;
        GVAR(psyActive) = false;
        sleep 11;
        if !(GVAR(psyActive)) then {
            GVAR(ppeColorCorrections) ppEffectEnable false;
            // GVAR(ppeFilmGrain) ppEffectEnable false;
        };
    };
};
