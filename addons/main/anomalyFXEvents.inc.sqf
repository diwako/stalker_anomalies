DFUNC(playLocalAnomalyActivationSound) = {
    params ["_trg", "_sound"];
    private _proxy = _trg getVariable [QGVAR(sound), objNull];
    if (isNull _proxy) then {
        _proxy = "building" createVehicleLocal getPos _trg;
        _proxy setPosASL ((getPosASL _trg) vectorAdd [0,0,0.5]);
        _proxy enableSimulation false;
        _trg setVariable [QGVAR(sound), _proxy];
    };
    private _time = time;
    _proxy setVariable [QGVAR(time), _time];
    _proxy say3D _sound;
    [{
        params ["_proxy", "_time"];
        if (_time isEqualTo (_proxy getVariable [QGVAR(time), 0])) then {
            deleteVehicle _proxy;
        };
    }, [_proxy, _time], 10] call CBA_fnc_waitAndExecute;
};

[QGVAR(fruitPunchEffect), {
    params ["_trg"];
    if (isNull _trg) exitWith {};
    [_trg, selectRandom ["bfuzz_hit","buzz_hit"]] call DFUNC(playLocalAnomalyActivationSound);
    private _source = "#particlesource" createVehicleLocal getPos _trg;
    _source setPosASL (getPosASL _trg);

    [_source, "active"] call FUNC(fruitPunchEffect);
    [{
        deleteVehicle _this;
    }, _source, 0.33] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(burnerEffect), {
    params ["_trg"];
    if (isNull _trg) exitWith {};
    [_trg, selectRandom ["fire2", "fire_loop"]] call DFUNC(playLocalAnomalyActivationSound);

    private _pos = getPos _trg;
    private _source = "#particlesource" createVehicleLocal getPos _trg;
    _source setPosASL (getPosASL _trg);
    private _source2 = "#particlesource" createVehicleLocal [((_pos select 0) - 2 + (random 2)), ((_pos select 1) - 2 + (random 2)), _pos select 2];

    [_source, "active"] call FUNC(burnerEffect);
    [_source2, "active"] call FUNC(burnerEffect);

    private _light = "#lightpoint" createVehicleLocal ((getPos _trg) vectorAdd [0, 0, 0.5]);
    _light setLightBrightness 2;
    _light setLightAmbient [1, 0.6, 0.6];
    _light setLightColor [1, 0.6, 0.6];
    _light setLightUseFlare true;
    _light setLightFlareSize 12;
    _light setLightFlareMaxDistance 100;
    _light setLightDayLight true;

    [{
        params ["_source", "_time"];
        if (_time < time) then {
            private _dropPos = getPos _source;
            for "_" from 0 to 50 do {
                private _velocity = (_dropPos vectorFromTo (_source getPos [10, random 360])) vectorMultiply (2 + random 5);
                drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13, 0], "", "Billboard", 1,
                    0.1 + random 0.5, //lifetime
                    _dropPos, // position
                    _velocity, // velocity
                    1 + random 20, // rotationVelocity
                    900, // weight
                    50, // volume
                    0.075, // rubbing
                    [0.1, 2], // size
                    [[0.08,0.067,0.052,0],[0.6,0.5,0.4,0.5],[0.6,0.5,0.4,0.4],[0.6,0.5,0.4,0.3],[0.6,0.5,0.4,0.15],[0.6,0.5,0.4,0]], // color
                    [1000], // animation phase
                    0.05, 0.1, "", "", "", 0, false, 1];
            };
            _this set [1, time + 0.2];
        };

        isNull _source
    }, {}, [_source, time]] call CBA_fnc_waitUntilAndExecute;

    [{
        {
            deleteVehicle _x;
        } forEach _this;
    }, [_source, _source2, _light], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(springboardEffect), {
    params ["_trg"];
    if (isNull _trg) exitWith {};
    [_trg, format ["gravi_blowout%1", (floor random 10) + 1]] call DFUNC(playLocalAnomalyActivationSound);

    [{
        params ["_trg"];
        private _source = "#particlesource" createVehicleLocal getPos _trg;
        _source setPosASL (getPosASL _trg);
        [_source, "active"] call FUNC(springboardEffect);
        [{
            deleteVehicle _this;
        }, _source, 1] call CBA_fnc_waitAndExecute;
    }, _this, 0.25] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(electraEffect), {
    params ["_trg", "_list"];
    if (isNull _trg) exitWith {};
    [_trg, format ["electra_blast%1", (floor random 2) + 1]] call DFUNC(playLocalAnomalyActivationSound);

    private _light = "#lightpoint" createVehicleLocal ((getPos _trg) vectorAdd [0, 0, 0.5]);
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
    if (_plr in _list) then {
        addCamShake [15, 3, 25];
    };

    [{
        params ["_plr", "_trg"];
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
    }, [_plr, _trg], 2] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(meatgrinderEffect), {
    params ["_trg"];
    if (isNull _trg) exitWith {};
    [_trg, "anomaly_mincer_blowout"] call DFUNC(playLocalAnomalyActivationSound);

    [{
        params ["_trg", "_stopTime", "_nextDropTime"];
        private _time = time;
        if (_time > _nextDropTime) then {
            private _dropPos = _trg getPos [random 5.5, random 360];
            private _velocity = ((_dropPos vectorFromTo (getPos _trg)) vectorMultiply 3) vectorAdd [0, 0, 0.1];
            private _size = 2 + random 0.5;
            drop [["\A3\data_f\cl_leaf", 1, 0, 1], "", "SpaceObject", 1,
                2, //lifetime
                _dropPos, // position
                _velocity, // velocity
                0,
                7, // weight
                7.9, 0.075,
                [_size, _size, 0.01], // size
                [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [6, 5, 5], 1, 0, "", "", ""];
            _this set [2, _time + 0.02];
        };

        _time >= _stopTime
    }, {}, [_trg, time + MEATGRINDER_MIN_COOL_DOWN, -10]] call cba_fnc_waitUntilAndExecute;

    [{
        params ["_trg"];
        if (isNull _trg) exitWith {};
        private _source = "#particlesource" createVehicleLocal getPos _trg;
        _source setPosASL (getPosASL _trg);
        [_source, "active"] call FUNC(springboardEffect);
        [{
            deleteVehicle _this;
        }, _source, 1] call CBA_fnc_waitAndExecute;
    }, [_trg], MEATGRINDER_MIN_COOL_DOWN] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(teleportEffect), {
    params ["_trg", "_exit"];
    if (isNull _trg || isNull _exit) exitWith {};
    [_trg, format ["teleport_work_%1", (floor random 2) + 1]] call DFUNC(playLocalAnomalyActivationSound);
    [_exit, format ["teleport_work_%1", (floor random 2) + 1]] call DFUNC(playLocalAnomalyActivationSound);
}] call CBA_fnc_addEventHandler;

[QGVAR(clickerEffect), {
    params ["_pos"];

    private _light = "#lightpoint" createVehicleLocal ASLToAGL _pos;
    _light setLightBrightness 1;
    _light setLightAmbient [1, 1, 1];
    _light setLightColor [1, 1, 1];
    _light setLightUseFlare true;
    _light setLightFlareMaxDistance 500;
    _light setLightDayLight true;
    _light setLightFlareSize 5;

    private _fnc_flicker = {
        params ["_light", "_fnc"];
        if (isNull _light) exitWith {};
        private _rand = 0.9 + random 0.25;
        _light setLightBrightness _rand;
        _light setLightFlareSize (linearConversion [0.9, 1.15, _rand, 4.5, 5.2]);

        [_fnc, _this] call CBA_fnc_execNextFrame;
    };
    [_light, _fnc_flicker] call _fnc_flicker;

    playSound3D [format ["%1_%2.ogg", QPATHTOF(sounds\anomalies\clicker_charge_hum), floor random 3], objNull, false, _pos, 5, 1, 75, 3 - CLICKER_EXPLODE_TIME, true];
    [{
        params ["_pos"];
        playSound3D [format ["%1_%2.ogg", QPATHTOF(sounds\anomalies\clicker_charge), floor random 4], objNull, false, _pos, 5, 1, 75, 0, true];
    }, [_pos], 0.1] call CBA_fnc_waitAndExecute;

    [{
        params ["_pos", "_light"];
        deleteVehicle _light;
        _light = "#lightpoint" createVehicleLocal ASLToAGL _pos;
        _light setLightBrightness 5;
        _light setLightAmbient [1, 1, 1];
        _light setLightColor [1, 1, 1];
        _light setLightUseFlare true;
        _light setLightFlareMaxDistance 200;
        _light setLightDayLight true;
        _light setLightFlareSize 8;

        playSound3D [format ["%1_%2.ogg", QPATHTOF(sounds\anomalies\clicker_impact), floor random 8], objNull, false, _pos, 5, 1, 350, 0, true];

        [{
            params ["_light"];
            deleteVehicle _light;
        }, [_light], 0.1] call CBA_fnc_waitAndExecute;

        private _intersect = lineIntersectsSurfaces [_pos, _pos vectorAdd [0, 0, -4], objNull, objNull, true, -1, "FIRE", "GEOM"];
        if (_intersect isNotEqualTo []) then {
            private _intesected = false;
            private _groundPos = [];
            private _distance = 4;
            {
                private _obj = _x select 2;
                if (isNull _obj || _obj isKindOf "House_F") exitWith {
                    _distance = _pos distance (_x select 0);
                    _groundPos = ASLToAGL (_x select 0);
                    _intesected = true;
                };
            } forEach _intersect;

            if (_intesected) then {
                private _strength = linearConversion [0, 4, _distance, 1, 0, true];
                for "_" from 0 to 100 do {
                    private _velocity = (_groundPos vectorFromTo (_groundPos getPos [10, random 360])) vectorMultiply ((10 * _strength) + random (10 * _strength));
                    _velocity set [2, 0.15];
                    drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13, 0], "", "Billboard", 1,
                        0.1 + random 0.5, //lifetime
                        _groundPos, // position
                        _velocity, // velocity
                        1 + random 20, // rotationVelocity
                        900, // weight
                        50, // volume
                        0.075, // rubbing
                        [0.5 * _strength, 2.6 * _strength], // size
                        [[0.08,0.067,0.052,0],[0.6,0.5,0.4,0.5],[0.6,0.5,0.4,0.4],[0.6,0.5,0.4,0.3],[0.6,0.5,0.4,0.15],[0.6,0.5,0.4,0]], // color
                        [1000], // animation phase
                        0.05, 0.1, "", "", "", 0, false, 1];
                };
            };
        };
    }, [_pos, _light], CLICKER_EXPLODE_TIME] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(blockerEffect), {
    _this call FUNC(blockerEffect);
}] call CBA_fnc_addEventHandler;
