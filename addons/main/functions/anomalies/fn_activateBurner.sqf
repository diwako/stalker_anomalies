#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateBurner

    Description:
        Activates anomaly when something enters its activation range

    Parameters:
        _trg - the anomaly trigger that is being activated (default: objNull)
        _list - thisList given by the trigger (default: [])

    Returns:
        nothing

    Author:
    diwako 2017-12-13
*/
params[["_trg",objNull],["_list",[]]];

if (isNull _trg) exitWith {};
if (_trg getVariable [QGVAR(anomalyType),""] != "burner") exitWith {};

private _proxy = _trg getVariable QGVAR(sound);
_proxy say3D "fire2";

if (hasInterface) then {
    private _pos = position _trg;
    private _source = "#particlesource" createVehicleLocal getPos _trg;
    _source setPosASL (getPosASL _trg);
    private _source2 = "#particlesource" createVehicleLocal [((_pos select 0) - 2 + (random 2)), ((_pos select 1) - 2 + (random 2)), _pos select 2];

    [_source, "active"] call FUNC(burnerEffect);
    [_source2, "active"] call FUNC(burnerEffect);

    private _light = "#lightpoint" createVehicleLocal (getPos _proxy);
    _light setLightBrightness 2;
    _light setLightAmbient [1, 0.6, 0.6];
    _light setLightColor [1, 0.6, 0.6];
    _light setLightUseFlare true;
    _light setLightFlareSize 12;
    _light setLightFlareMaxDistance 100;
    _light setLightDayLight true;

    [{
        {
            deleteVehicle _x;
        } forEach _this;
    }, [_source, _source2, _light], 5] call CBA_fnc_waitAndExecute;
};

if (isServer) then {
    _trg setVariable [QGVAR(cooldown), true, true];
    private _men = nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5] select {!(_x getVariable ["anomaly_ignore", false])};
    {
        if !(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air") then {
            deleteVehicle _x;
        };
    } forEach _list;
    {
        if (alive _x) then {
            if (_x isKindOf "Man") then {
                if !(isNil "ace_fire_fnc_burn") then {
                    [_x, 4] call ace_fire_fnc_burn;
                };
                if !(isPlayer _x) then {
                    [{
                        _this setDamage 1;
                    }, _x, 0.5] call CBA_fnc_waitAndExecute;
                } else {
                    if !(isNil "ace_medical_fnc_addDamageToUnit") then {
                        // Ace medical is enabled
                        private _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 1.1;
                        [QGVAR(aceDamage), [_x, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "burn", _x], _x] call CBA_fnc_targetEvent;
                    } else {
                        // Ace medical is not enabled
                        private _dam = damage _x;
                        _x setDamage (_dam + 0.5);
                    };
                };
            } else {
                private _curDam = _x getHitPointDamage "HitEngine";
                if (isNil "_curDam") then {
                    _curDam = 0;
                };
                if (_curDam >= 1) then {
                    _x setDamage 1;
                } else {
                    [QGVAR(setHitPointDamage), [_x, ["HitEngine", (_curDam + 0.15)]], _x] call CBA_fnc_targetEvent;
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
            };
        } else {
            if !(_x isKindOf "landvehicle" || _x isKindOf "air") then {
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            };
        };
    } forEach _men;

    [{
        _this setVariable [QGVAR(cooldown), false, true];
    }, _trg, GVAR(anomalySettingBurnerCooldownMin) + random GVAR(anomalySettingBurnerCooldownRand)] call CBA_fnc_waitAndExecute;
};
