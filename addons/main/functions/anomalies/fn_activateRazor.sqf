#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateRazor

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        boolean, always false

    Author:
    diwako 2025-06-20
*/
params[["_trg",objNull], ["_list",[]]];
if (isNull _trg || _trg getVariable [QGVAR(anomalyType),""] != "razor") exitWith {false};
// systemChat format ["Tick: %1", time];
private _player = [] call CBA_fnc_currentUnit;
if (hasInterface && ({_list isNotEqualTo [] || GVAR(razorPlayInsideSound)})) then {
    if (GVAR(razorPlayInsideSound)) then {
        if (_player getVariable [QGVAR(razorAnomaly), objNull] isEqualTo _trg && !(_player in _list)) then {
            GVAR(razorPlayInsideSound) = false;
            _player setVariable [QGVAR(razorAnomaly), nil];
            deleteVehicle GVAR(razorPlayerSound)
        };
    } else {
        if (_player in _list) then {
            GVAR(razorPlayInsideSound) = true;
            _player setVariable [QGVAR(razorAnomaly), _trg];
            private _recursion = {
                params ["_recursion"];
                [{
                    isNull GVAR(razorPlayerSound)
                }, {
                    if (GVAR(razorPlayInsideSound)) then {
                        params ["_recursion"];
                        GVAR(razorPlayerSound) = playSound QGVAR(razorInside1);
                        [_recursion] call _recursion;
                    };
                }, [_recursion]] call CBA_fnc_waitUntilAndExecute;
            };

            GVAR(razorPlayerSound) = playSound QGVAR(razorInside1);
            [_recursion] call _recursion;
        };
    };
};

private _men = _list select {
    local _x
    && { alive _x }
    && { !(_x getVariable ["anomaly_ignore", false]) }
    && { _x isKindOf "Man" || {_x isKindOf "LandVehicle"} || {_x isKindOf "Air"} }
};

{
    if (_x isKindOf "Man") then {
        if (_player isEqualTo _x) then {
            [0.6] call FUNC(bloodEffect);
        };
        ["razor", _x] call FUNC(addUnitDamage);
    } else {
        if !(_x isKindOf "tank") then {
            [QGVAR(setHit), [_x, ["wheel_1_1_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_1_2_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_1_3_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_1_4_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_2_1_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_2_2_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_2_3_steering", 1]], _x] call CBA_fnc_targetEvent;
            [QGVAR(setHit), [_x, ["wheel_2_4_steering", 1]], _x] call CBA_fnc_targetEvent;
        };
    };
    [QGVAR(razorOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
} forEach (_men select {
    (abs speed _x) > 5
    || { stance _x == "STAND" && {(abs speed _x) > 0.5} }
});

false
