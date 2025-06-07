#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_addUnitDamage

    Description:
        Adds damage to an object inheriting from the "Man" or "CAManBase" class
        supports multiple medical systems
        Will direct damage to none local units as well

    Parameters:
        _anomalyType - the anomaly type (default: "")
                    valid values:
                    - burner
                    - comet
                    - electra
                    - fog
                    - fruitpunch
                    - springboard
                    - psydischarge
        _unit - unit to damage (default: objNull)

    Returns:
        nothing

    Author:
    diwako 2024-11-02
*/
params [["_anomalyType", "", [""]], ["_unit", objNull, [objNull]]];

if !(alive _unit) exitWith {nil};

if !(local _unit) exitWith {
    [QGVAR(addUnitDamage), _this, _unit] call CBA_fnc_targetEvent;
    nil
};

switch (GVAR(medicalSystem)) do {
    case "vanilla": {
        private _medicalInfo = GVAR(medicalSystemMap) getOrDefault [GVAR(medicalSystem), []];
        private _inflictDamage = (_medicalInfo getOrDefault [_anomalyType, [0.5, 1]]) select !(isPlayer _unit);
        if (_inflictDamage isEqualType {}) then {
            _inflictDamage = _this call _inflictDamage;
        };
        _unit setDamage ((damage _unit) + _inflictDamage);
    };
    case "ace_medical": {
        private _medicalInfo = GVAR(medicalSystemMap) getOrDefault [GVAR(medicalSystem), []];
        (_medicalInfo get _anomalyType) params ["_damageCoefs", "_bodyParts", "_damageType"];
        private _isPlayer = isPlayer _unit;
        private _coef = _damageCoefs select !_isPlayer;
        private _damage = (missionNamespace getVariable [["ace_medical_AIDamageThreshold", "ace_medical_playerDamageThreshold"] select _isPlayer, 1]) * _coef;
        [_unit, _damage, selectRandom _bodyParts, _damageType, _unit] call ace_medical_fnc_addDamageToUnit;

        // handle ambient animals
        if (!(_unit isKindOf "CAManBase") && {_unit isKindOf "Animal_Base_F"}) then {
            _unit setDamage 1;
        };
    };
    case "aps": {
        private _medicalInfo = GVAR(medicalSystemMap) getOrDefault [GVAR(medicalSystem), []];
        (_medicalInfo get _anomalyType) params ["_damageCoefs", "_bodyParts", "_ammo"];
        private _isPlayer = isPlayer _unit;
        private _coef = _damageCoefs select !_isPlayer;
        private _damage = (([diw_armor_plates_main_maxAiHP, diw_armor_plates_main_maxPlayerHP] select _isPlayer) * _coef) / diw_armor_plates_main_damageCoef;
        [_unit, _damage, selectRandom _bodyParts, _unit, _ammo] call diw_armor_plates_main_fnc_receiveDamage;
    };
    case "custom": {
        if (isNil "anomaly_custom_fnc_addUnitDamage") exitWith {
            hintC format ["Medical system set to ""%1"", but function ""anomaly_custom_fnc_addUnitDamage"" not defined!", GVAR(medicalSystem)];
        };
        [_anomalyType, _unit] call anomaly_custom_fnc_addUnitDamage;
    };
    default {
        hintC format ["Medical system ""%1"" is not supported!", GVAR(medicalSystem)];
    };
};

nil
