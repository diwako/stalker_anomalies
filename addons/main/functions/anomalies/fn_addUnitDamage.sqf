#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_anomalyType", "_unit"];

if !(local _unit) exitWith {
    [QGVAR(addUnitDamage), _this, _unit] call CBA_fnc_targetEvent;
};

switch (GVAR(medicalSystem)) do {
    case "vanilla": {
        private _medicalInfo = GVAR(medicalSystemMap) getOrDefault [GVAR(medicalSystem), []];
        private _inflictDamage = (_medicalInfo get _anomalyType) select !(isPlayer _unit);
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
