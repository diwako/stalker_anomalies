#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateSpringboard

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
params[["_trg",objNull],["_list",[]]];

if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "springboard") exitWith {};

if (isServer) then {
    _trg setVariable [QGVAR(cooldown), true, true];
    private _proxy = _trg getVariable QGVAR(sound);
    private _sound = ("gravi_blowout" + str ( (floor random 6) + 1 ));
    [QGVAR(say3D), [_proxy, _sound]] call CBA_fnc_globalEvent;
};

[{
    params[["_trg",objNull],["_list",[]]];
    if (hasInterface) then {
        private _source = "#particlesource" createVehicleLocal getPos _trg;
        _source setPosASL (getPosASL _trg);
        [_source, "active"] call FUNC(springboardEffect);
        [{
            deleteVehicle _this;
        }, _source, 1] call CBA_fnc_waitAndExecute;
    };

    if (isServer) then {
        private _men = (nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])};
        {
            if (!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
                deleteVehicle _x;
            };
        } forEach _list;

        {
            if (alive _x) then {
                private _pos1 = getPos _x;
                private _pos2 = getPos _trg;
                private _a = ((_pos1 select 0) - (_pos2 select 0));
                private _b = ((_pos1 select 1) - (_pos2 select 1));
                if !(isPlayer _x) then {
                    if !(_x isKindOf "landvehicle"  || _x isKindOf "air") then {
                        [{
                            _this setDamage 1;
                        }, _x, 0.5] call CBA_fnc_waitAndExecute;
                    };
                } else {
                    if !(isNil "ace_medical_fnc_addDamageToUnit") then {
                        // Ace medical is enabled
                        private _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) * 1.5;
                        [QGVAR(aceDamage), [_x, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "stab", _x] , _x] call CBA_fnc_targetEvent;
                    } else {
                        // Ace medical is not enabled
                        private_dam = damage _x;
                        _x setDamage (_dam + 0.5);
                    };
                };
                private _mult = 4;
                if (_x isKindOf "landvehicle" || _x isKindOf "air") then {
                    if (getMass _x <= 10000) then {
                        _mult = _mult * 2;
                        private _curDam = _x getHitPointDamage "HitHull";
                        [QGVAR(setHitPointDamage), [_x, ["HitHull", (_curDam + 0.45), true, _x, _x]], _x] call CBA_fnc_targetEvent;
                    } else {
                        _mult = 1;
                    };
                };
                // [_x, [_a*_mult, _b*_mult, _mult + (5 / (1 + (abs _a) + (abs _b)))]] remoteExec ["setVelocity", _x];
                [QGVAR(setVelocity), [_x, [_a*_mult, _b*_mult, _mult + (5 / (1 + (abs _a) + (abs _b)))]], _x] call CBA_fnc_targetEvent;
            } else {
                if !(_x isKindOf "landvehicle" || _x isKindOf "air") then {
                    [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
                };
            };
        } forEach _men;

        [{
            _this setVariable [QGVAR(cooldown), false, true];
        }, _trg, GVAR(anomalySettingSpringboardCooldownMin) - SPRINGBOARD_MIN_COOL_DOWN + random GVAR(anomalySettingSpringboardCooldownRand)] call CBA_fnc_waitAndExecute;
    };
}, _this, 0.25] call CBA_fnc_waitAndExecute;
