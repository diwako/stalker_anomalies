#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateFog

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2017-12-11
*/
params[["_trg",objNull], ["_list",[]]];

if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "fog") exitWith {};

{
    if ((_x isKindOf "Man") && {local _x}) then {
        if !(toUpper(goggles _x) in GVAR(gasMasks)) then {
            if (isPlayer _x) then {
                private _effect = [4];
                if (isNil QGVAR(blurHandle)) then {
                    private _name = "DynamicBlur";
                    private _priority = 400;
                    GVAR(blurHandle) = ppEffectCreate [_name, _priority];
                    while {
                        GVAR(blurHandle) < 0
                    } do {
                        _priority = _priority + 1;
                        GVAR(blurHandle) = ppEffectCreate [_name, _priority];
                    };
                    GVAR(blurHandle) ppEffectEnable true;
                };
                GVAR(blurHandle) ppEffectAdjust _effect;
                GVAR(blurHandle) ppEffectCommit 1;
                [{
                    GVAR(blurHandle) ppEffectAdjust [0];
                    GVAR(blurHandle) ppEffectCommit 10;
                }, nil, 1] call CBA_fnc_waitAndExecute;
            };
            if ((cba_missiontime - 2.5) > (_x getVariable[QGVAR(cough), -1])) then {
                // cough cough
                [{
                    params["_unit"];
                    private _coughers = ["WoundedGuyA_02","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_07","WoundedGuyA_08"];
                    [QGVAR(say3D), [_unit, selectRandom _coughers]] call CBA_fnc_globalEvent;
                }, [_x], (random 2)] call CBA_fnc_waitAndExecute;
                _x setVariable[QGVAR(cough),cba_missiontime];
            };
            if (!isNil "ace_medical_fnc_addDamageToUnit") then {
                // Ace medical is enabled
                private _dam = 1;
                if (isPlayer _x) then {
                    _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 20;
                } else {
                    _res = _x getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
                    _dam = ((_res#0 + _res#1 + _res#2) / 3) / 6;
                };
                [_x, _dam, "body", "punch", _x] call ace_medical_fnc_addDamageToUnit;
            } else {
                // Ace medical is not enabled
                private _dam = damage _x;
                _x setDamage (_dam + 0.05);
            };
        };
    };
    false
} count (_list select {!(_x getVariable ["anomaly_ignore", false])});
