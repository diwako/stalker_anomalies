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
            ["fog", _x] call FUNC(addUnitDamage);
            [QGVAR(fogOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
        };
    };
    false
} count (_list select {!(_x getVariable ["anomaly_ignore", false])});
