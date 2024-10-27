#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_activateElectra

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
if (_trg getVariable [QGVAR(anomalyType),""] != "electra") exitWith {};

if (isServer) then {
    private _proxy = _trg getVariable QGVAR(sound);
    _sound = ("electra_blast" + str ( (floor random 2) + 1 ));
    [QGVAR(say3D), [_proxy, _sound]] call CBA_fnc_globalEvent;

    _men = (nearestObjects [getPos _trg,  ["Man","landvehicle","air"], 5]) select {!(_x getVariable ["anomaly_ignore", false])};
    {
        if (!(_x isKindOf "Man" || _x isKindOf "landvehicle" || _x isKindOf "air")) then {
            deleteVehicle _x;
        };
    } forEach _list;
    {
        if (alive _x) then {
            if (_x isKindOf "landvehicle" || _x isKindOf "air") then {
                // switch of the engine
                private _curDam = 0;
                if (_x isKindOf "landvehicle" ) then {
                    _curDam = _x getHit (getText(configOf _x >> "HitPoints" >> "HitEngine" >> "name"));
                    [QGVAR(setHitPointDamage), [_x, ["HitEngine", 1, true, _x, _x]], _x] call CBA_fnc_targetEvent;
                } else {
                    _curDam = _x getHitPointDamage "HitEngine";
                    [QGVAR(setHitPointDamage), [_x, ["HitEngine", 1, true, _x, _x]], _x] call CBA_fnc_targetEvent;
                };
                private _curDam2 = _x getHitPointDamage "HitHull";
                [QGVAR(setHitPointDamage), [_x, ["HitHull", (_curDam2 + 0.1)]], _x] call CBA_fnc_targetEvent;
                [{
                    private ["_veh", "_curDam"];
                    if (_veh isKindOf "landvehicle" ) then {
                        [QGVAR(setHitPointDamage), [_veh, ["HitEngine", (_curDam + 0.25)], true, _x, _x], _x] call CBA_fnc_targetEvent;
                    } else {

                        [QGVAR(setHitPointDamage), [_veh, ["HitEngine", (_curDam + 0.25), true, _x, _x]], _veh] call CBA_fnc_targetEvent;
                    };
                }, [_x, _curDam], 5] call CBA_fnc_waitAndExecute;
            } else {
                // [_x, getPos _trg, 2, 2] remoteExec [QFUNC(suckToLocation),_x];
                [{
                    _this setDamage 1;
                }, _x, 2] call CBA_fnc_waitAndExecute;
            };
            [QGVAR(electraOnDamage), [_x, _trg]] call CBA_fnc_localEvent;
        } else {
            if (!(_x isKindOf "landvehicle" || _x isKindOf "air") ) then {
                [QGVAR(minceCorpse), [_x]] call CBA_fnc_globalEvent;
            };
        };
    } forEach (_men select {!isPlayer _x});

    _trg setVariable [QGVAR(cooldown), true, true];
    [{
        _this setVariable [QGVAR(cooldown), false, true];
    }, _trg, GVAR(anomalySettingBurnerCooldownMin) + random GVAR(anomalySettingBurnerCooldownRand)] call CBA_fnc_waitAndExecute;
};

if (hasInterface) then {
    private _light = "#lightpoint" createVehicleLocal (getPos (_trg getVariable QGVAR(sound)));
    _light setLightBrightness 10;
    _light setLightAmbient [0.6, 0.6, 1];
    _light setLightColor [0.6, 0.6, 1];
    _light setLightUseFlare true;
    _light setLightFlareSize 100;
    _light setLightFlareMaxDistance 100;
    _light setLightDayLight true;
    [{
        _this setLightBrightness 0;
    }, _light, 0.1] call CBA_fnc_waitAndExecute;
    [{
        _this setLightBrightness 10;
    }, _light, 0.2] call CBA_fnc_waitAndExecute;
    [{
        _this setLightBrightness 0;
    }, _light, 0.4] call CBA_fnc_waitAndExecute;
    [{
        _this setLightBrightness 10;
    }, _light, 1.6] call CBA_fnc_waitAndExecute;
    [{
        _this setLightBrightness 0;
    }, _light, 1.7] call CBA_fnc_waitAndExecute;
    [{
        _this setLightBrightness 10;
    }, _light, 1.8] call CBA_fnc_waitAndExecute;
    [{
        deleteVehicle _this;
    }, _light, 2] call CBA_fnc_waitAndExecute;

    private _plr = ([] call CBA_fnc_currentUnit);
    private _in = (_plr in _list );
    if (_in) then {
        // [_plr, getPos _trg, 2, 2] spawn FUNC(suckToLocation);
        addCamShake [15, 3, 25];
    };
    private _veh = vehicle _plr;
    if (_veh in _list && {_veh isKindOf "landvehicle" && {(driver _veh) isEqualTo _plr}}) then {
        [QGVAR(setHitPointDamage), [_veh, ["HitEngine", 1, true, _x, _x]], _veh] call CBA_fnc_targetEvent;
        private _curDam2 = _veh getHitPointDamage "HitHull";
        [QGVAR(setHitPointDamage), [_veh, ["HitHull", (_curDam2 + 0.1), true, _x, _x]], _veh] call CBA_fnc_targetEvent;

        [{
            private _curDam = _this getHit (getText(configOf _this >> "HitPoints" >> "HitEngine" >> "name"));
            [QGVAR(setHitPointDamage), [_this, ["HitEngine", (_curDam + 0.25), true, _x, _x]], _this] call CBA_fnc_targetEvent;
        }, _veh, 5] call CBA_fnc_waitAndExecute;
    };

    [{
        params ["_plr", "_in", "_trg"];
        if (_in) then {
            if !(isNil "ace_medical_fnc_addDamageToUnit") then {
                // Ace medical is enabled
                private _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]);
                [_plr, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "stab", _plr] call ace_medical_fnc_addDamageToUnit;
            } else {
                // Ace medical is not enabled
                private _dam = damage _plr;
                _plr setDamage (_dam + 0.5);
            };
        };

        private _source = _trg getVariable [QGVAR(particleSource), objNull];
        if !(isNull _source) then {
            deleteVehicle _source;
            [{
                !(_this getVariable [QGVAR(cooldown), false])
            }, {
                if (isNull _this) exitWith {};
                if (([] call CBA_fnc_currentUnit) distance _this < GVAR(idleDistance)) then {
                    private _source = "#particlesource" createVehicleLocal getPos _this;
                    _source setPosASL (getPosASL _this);
                    [_source, "idle"] call FUNC(electraEffect);
                    _this setVariable [QGVAR(particleSource), _source];
                };
            }, _trg] call CBA_fnc_waitUntilAndExecute;
        };
    }, [_plr, _in, _trg], 2] call CBA_fnc_waitAndExecute;
};
