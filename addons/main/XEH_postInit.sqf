#include "script_component.hpp"

if (
    !GVAR(enable) ||
    missionNamespace getVariable [QGVAR(var_init), false]
) exitWith {
    LOG_SYS("INFO","STALKER Anomaly mod has been disabled via setting.");
};

missionNamespace setVariable [QGVAR(var_init),true];

if (isServer && {isMultiplayer}) then {
    // global var used for checking if an anomaly should stay activatable
    GVAR(activatableHolder) = [];

    // cba event handler for activating anomalies
    [QGVAR(enableAnomaly), {
        params [["_added",[]]];
        {
            private _index = GVAR(activatableHolder) pushBackUnique _x;
            if (_index > -1) then {
                _x enableSimulationGlobal true;
                if (_x getVariable [QGVAR(anomalyType), ""] isEqualTo "comet") then {
                    // start precise tracking the anomaly
                    [_x] call FUNC(createCometLocal);
                };
                if (GVAR(debug)) then {
                    systemChat format["Enabled a '%1' anomaly",_x getVariable QGVAR(anomalyType)];
                    (_x getVariable [QGVAR(debugMarker),""]) setMarkerColorLocal "ColorBlue";
                };
            };
        } forEach _added;
    }] call CBA_fnc_addEventHandler;

    // publish PFH which publishes all anomalies each 5 seconds
    [{
        params ["_args", "_pfhHandle"];
        _args params ["_transmitted"];
        private _count = count GVAR(holder);
        if (_count isNotEqualTo _transmitted) then {
            publicVariable QGVAR(holder);
            _args set [0, _count];
        };

        private _players = [] call CBA_fnc_players;
        // for "_i" from ((count GVAR(activatableHolder)) - 1) to 0 step -1 do {
            // private _anomaly = GVAR(activatableHolder)#_i;
         {
            private _anomaly = _x;
            if ((_players inAreaArray [getPosWorld _anomaly, GVAR(triggerDistance), GVAR(triggerDistance), 0, false, -1]) isEqualTo []) then {
                _anomaly enableSimulationGlobal false;
                GVAR(activatableHolder) deleteAt _forEachIndex;
                if (GVAR(debug)) then {
                    systemChat format["Disabled a '%1' anomaly",_anomaly getVariable QGVAR(anomalyType)];
                    (_anomaly getVariable [QGVAR(debugMarker),""]) setMarkerColorLocal "ColorBlack";
                };
            };
        } forEachReversed GVAR(activatableHolder);
    }, 5, [0] ] call CBA_fnc_addPerFrameHandler;
};

if (isServer) then {
    ["CAManBase", "Fired", {
        // params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_mag", "_projectile"];
        params ["", "", "", "", "_ammo", "", "_projectile"];
        if (_ammo == QGVAR(boltAmmo)) then {
            [_projectile] call FUNC(grenadeBolt);
        };
    }, true] call CBA_fnc_addClassEventHandler;
};

if !(hasInterface) exitWith {};

/*== DO NOT EDIT Below unless you know what you are doing! ==*/
GVAR(activeAnomalies) = [];
GVAR(detectorActive) = false;
GVAR(detectorVolume) = 0;

enableCamShake true;
if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

[{
    // params ["_args", "_pfhHandle"]; //maybe needed for later
    private _foundAnomalies = [];
    private _anomaliesToActivate = [];
    private _curPlayer = [] call CBA_fnc_currentUnit;
    private _pos = (positionCameraToWorld [0,0,0]);
    private _type = "";
    private _debug = GVAR(debug);
    private _speedmod = ((speed player) / 6) max 1;
    private _triggerActivateDistance = GVAR(triggerDistance) * _speedmod;
    private _idleDistance = GVAR(idleDistance) * _speedmod;
    private _fnc_addIdleSoundsLocal = {
        params ["_trg", "_type"];
        if !(isNull (_trg getVariable [QGVAR(soundIdleLocal), objNull])) exitWith {};
        private _sound = createSoundSourceLocal [_type, [0, 0, 0], [], 0];
        _sound setPosASL (getPosASL _trg);
        _trg setVariable [QGVAR(soundIdleLocal), _sound];
    };

    // find trigger
    {
        _type = _x getVariable [QGVAR(anomalyType), "unknown"];
        if (_type isEqualTo "unkown" || {_x getVariable [QGVAR(markedForDeletion), false]}) then {
            continue;
        };
        _foundAnomalies pushBack _x;
        private _source = _x getVariable [QGVAR(particleSource), objNull];
        if (isNull _source) then {
            // check between moving and none moving anomalies
            if (_type isNotEqualTo "comet") then {
                // create idle effect
                _source = "#particlesource" createVehicleLocal getPos _x;
                _source setPosASL (getPosASL _x);
                switch (_type) do {
                    case "meatgrinder": {[_source, "idle"] call FUNC(meatgrinderEffect);};
                    case "springboard": {
                        private _source2 = "#particlesource" createVehicleLocal [0,0,0];
                        _source2 setPosASL (getPosASL _x);
                        [_source, "idle", _source2] call FUNC(springboardEffect);
                        _x setVariable [QGVAR(particleSource2), _source2];
                        [_x, QGVAR(soundSpringboard)] call _fnc_addIdleSoundsLocal;
                    };
                    case "burner": {
                        [_source, "idle"] call FUNC(burnerEffect);
                        [_x, QGVAR(soundBurner)] call _fnc_addIdleSoundsLocal;
                    };
                    case "teleport": {
                        [_source, "idle"] call FUNC(teleportEffect);
                        [_x, QGVAR(soundTeleport)] call _fnc_addIdleSoundsLocal;
                    };
                    case "fog": {
                        [_source, "idle", _x] call FUNC(fogEffect);
                    };
                    case "electra": {
                        if !(_x getVariable [QGVAR(cooldown), false]) then {
                            [_source, "idle"] call FUNC(electraEffect);
                        };
                        [_x, QGVAR(soundElectra)] call _fnc_addIdleSoundsLocal;
                    };
                    case "fruitpunch": {
                        [_source, "idle"] call FUNC(fruitPunchEffect);
                        [_x, QGVAR(soundFruitpunch)] call _fnc_addIdleSoundsLocal;
                    };
                    default { };
                };
                _x setVariable [QGVAR(particleSource), _source];
            } else {
                [_x] call FUNC(createCometLocal);
            };
            if (GVAR(debug)) then {
                systemChat format["Particleadd to '%1'",_x getVariable QGVAR(anomalyType)];
                (_x getVariable [QGVAR(debugMarker),""]) setMarkerColorLocal "ColorGreen";
            };
        };
    } forEach (GVAR(holder) inAreaArray [_pos, _idleDistance, _idleDistance, 0, false, -1]);

    {
        // if the anomaly is not enabled, do not wait for the server to active it for you, enable it locally and tell the server to activate it for everyone
        if !(simulationEnabled _x) then {
            _x enableSimulation true;
            _anomaliesToActivate pushBack _x;
            if (_debug) then {
                (_x getVariable [QGVAR(debugMarker),""]) setMarkerColorLocal "ColorRed";
            };
        };
    } forEach (GVAR(holder) inAreaArray [getPosWorld _curPlayer, _triggerActivateDistance, _triggerActivateDistance, 0, false, -1]);

    // tell the server to activate it for everyone
    if (_anomaliesToActivate isNotEqualTo []) then {
        [QGVAR(enableAnomaly), [_anomaliesToActivate]] call CBA_fnc_serverEvent;
    };

    private _isNotMp = !isMultiplayer;
    {
        [_x] call FUNC(deleteParticleSource);
        // delete local only idle sound
        deleteVehicle (_x getVariable [QGVAR(soundIdleLocal), objNull]);
        // if player is not playing in multiplayer disable it here.
        // in mp the server will disable the trigger
        if (_isNotMp) then {
            if (_debug) then {
                (_x getVariable [QGVAR(debugMarker),""]) setMarkerColorLocal "ColorBlack";
            };
            _x enableSimulation false;
        };
    } forEach (GVAR(activeAnomalies) - _foundAnomalies);
    GVAR(activeAnomalies) = _foundAnomalies;
}, 5, [] ] call CBA_fnc_addPerFrameHandler;

if !(isNil "ace_interact_menu_fnc_createAction") then {
    private _action = [QGVAR(anomalyDetectorOn),(localize "STR_anomaly_enable_detector"),QPATHTOF(data\ui\AnomalyDetector.paa),{
        GVAR(detectorActive) = true;
        [] call FUNC(detector);
    },{!GVAR(detectorActive) && [ace_player, GVAR(detectorItem)] call FUNC(hasItem)},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(anomalyDetectorOff),(localize "STR_anomaly_disable_detector"),QPATHTOF(data\ui\AnomalyDetector.paa),{
        GVAR(detectorActive) = false;
    },{GVAR(detectorActive)},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(blowoutCheck), localize "STR_anomaly_blowout_safe_check_name", QPATHTOF(data\ui\modules\blowout_ca.paa), {
        if ([ace_player] call FUNC(isInShelter)) then {
            titleText [localize "STR_anomaly_blowout_safe_check_safe", "PLAIN DOWN"];
        } else {
            titleText [localize "STR_anomaly_blowout_safe_check_not_safe", "PLAIN DOWN"];
        };
    },{
        missionNamespace getVariable [QGVAR(blowoutStage), 0] > 1
    }] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
} else {
    [[localize "STR_anomaly_enable_detector", {
        GVAR(detectorActive) = true;
        [] call FUNC(detector);
    },nil,0,false,true,"", format ["!%1  && [_target, %2] call %3 && alive _target", QGVAR(detectorActive), QGVAR(detectorItem), QFUNC(hasItem)]]] call CBA_fnc_addPlayerAction;
    [[(localize "STR_anomaly_disable_detector"), {
        GVAR(detectorActive) = false;
    },nil,0,false,true,"",format ["%1", QGVAR(detectorActive)]]]  call CBA_fnc_addPlayerAction;

    [[localize "STR_anomaly_blowout_safe_check_name", {
        params ["_target"];
        if ([_target] call FUNC(isInShelter)) then {
            titleText [localize "STR_anomaly_blowout_safe_check_safe", "PLAIN DOWN"];
        } else {
            titleText [localize "STR_anomaly_blowout_safe_check_not_safe", "PLAIN DOWN"];
        };
    },nil,0,false,true,"",format ["missionNamespace getVariable ['%1', 0] > 1", QGVAR(blowoutStage)]]]  call CBA_fnc_addPlayerAction;
};

[GVAR(detectorItem), "CONTAINER", "Activate Anomaly Detector", nil, nil,
    [{!GVAR(detectorActive)}, {!GVAR(detectorActive)}], {
    GVAR(detectorActive) = true;
    [] call FUNC(detector);
    false
}, false] call CBA_fnc_addItemContextMenuOption;

[GVAR(detectorItem), "CONTAINER", "Deactivate Anomaly Detector", nil, nil,
    [{GVAR(detectorActive)}, {GVAR(detectorActive)}], {
    GVAR(detectorActive) = false;
    false
}, false] call CBA_fnc_addItemContextMenuOption;

[GVAR(detectorItem), "CONTAINER", "Increase Volume", nil, nil,
    [{GVAR(detectorVolume) < 2}, {GVAR(detectorActive)}], {
    GVAR(detectorVolume) = GVAR(detectorVolume) + 1;
    false
}, false] call CBA_fnc_addItemContextMenuOption;

[GVAR(detectorItem), "CONTAINER", "Decrease Volume", nil, nil,
    [{GVAR(detectorVolume) > -2}, {GVAR(detectorActive)}], {
    GVAR(detectorVolume) = GVAR(detectorVolume) - 1;
    false
}, false] call CBA_fnc_addItemContextMenuOption;

if (isClass(configFile >> "CfgPatches" >> "ace_advanced_throwing")) then {
    ["ace_advanced_throwing_throwFiredXEH", {
        params ["_unit", "", "", "", "", "_mag"];
        if (local _unit) then {
            _unit setVariable [QGVAR(lastGrenadeMag), _mag];
        };
    }] call CBA_fnc_addEventHandler;
    ["ace_throwableThrown", {
        params ["_unit", "_activeThrowable"];
        if (typeOf _activeThrowable == QGVAR(boltAmmo) && _unit getVariable [QGVAR(lastGrenadeMag), ""] == "bolts_infinite") then {
            _unit addMagazine "bolts_infinite";
            _unit selectThrowable "bolts_infinite";
        };
        _unit setVariable [QGVAR(lastGrenadeMag), nil]
    }] call CBA_fnc_addEventHandler;
};

// add Zen modules for zeus
#include "functions\zeus\zenModule.inc.sqf"

GVAR(zeusIconHandle) = -1;
["zen_curatorDisplayLoaded", {
    if (!GVAR(zeusShowAnomalies) || GVAR(zeusIconHandle) isNotEqualTo -1) exitWith {};
    GVAR(zeusIconHandle) = addMissionEventHandler ["Draw3D", {
        call FUNC(zeusDraw3D);
    }];
}] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", {
    if (GVAR(zeusIconHandle) >= 0) then {
        removeMissionEventHandler ["Draw3D", GVAR(zeusIconHandle)];
        GVAR(zeusIconHandle) = -1;
    };
}] call CBA_fnc_addEventHandler;
