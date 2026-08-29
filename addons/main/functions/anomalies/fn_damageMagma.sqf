#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params ["_obj", "_trg"];

if !(alive _obj && !(_obj getVariable ["anomaly_ignore", false]) && {lifeState _obj != 'INCAPACITATED'}) exitWith {};

if (_obj isKindOf "Man") then {
    if (missionNamespace getVariable ["ace_fire_enabled", false]) then {
        ["ace_fire_burn", [_obj, 1], _obj] call CBA_fnc_targetEvent;
    };
    if !(isPlayer _obj) then {
        [_obj] call FUNC(scream);
    };
    [{
        ["magma", _this] call FUNC(addUnitDamage);
    }, _obj, [0.5, 0] select (isPlayer _obj)] call CBA_fnc_waitAndExecute;
} else {
    if (_obj isKindOf "LandVehicle" || _obj isKindOf "Air" || _obj isKindOf "Boat") then {
        private _curDam = _obj getHitPointDamage "HitEngine";
        if (isNil "_curDam") then {
            _curDam = 0;
        };
        if (_curDam >= 1) then {
            _curDam = _obj getHitPointDamage "HitHull";
            if (_curDam < 1 ) then {
                [QGVAR(setHitPointDamage), [_obj, ["HitHull", _curDam + 0.01, false]], _obj] call CBA_fnc_targetEvent;
            } else {
                // usually hull damage == 1 kills the vehicle, but some will not do like the darter or static emplacements
                _obj setDamage [1, true, _obj, _obj];
            };
        } else {
            [QGVAR(setHitPointDamage), [_obj, ["HitEngine", _curDam + 0.05, false]], _obj] call CBA_fnc_targetEvent;
        };
    } else {
        // what ever is left...
        if !(_obj isKindOf "Building") then {
            deleteVehicle _obj;
        };
    };
};
if !(isNull _obj) then {
    [QGVAR(magmaOnDamage), [_obj, _trg]] call CBA_fnc_localEvent;
};
