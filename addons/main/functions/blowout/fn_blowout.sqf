#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params [["_stage", 0, [0]], ["_direction", 0, [0]]];
/*
0 - no or stop blowout/re-enable ambient environment
1 - stage 1 / pause ambient environment, overcast to 1, one minute of "silence", then blowout sound + sirens
2 - stage 2 / psy 1, screen shaking, blow out rumble  + thunderstorm
3 - stage 3 / psy 2, even more screen shaking + more thunderstorm + blow out rumble
4 - commit blowout (kill players not in cover) / blowout sound commit
*/
if !(isServer) exitWith {};
if (isNil QGVAR(blowoutInProgress)) then { GVAR(blowoutInProgress) = false };
if (isNil QGVAR(blowoutStage)) then { GVAR(blowoutStage) = 0 };

if (GVAR(blowoutStage) == _stage) exitWith {
    private _text = "Blowout already at this stage!";
    LOG_SYS("WARNING",_text);
    systemChat _text;
    false
};
if (GVAR(blowoutStage) >= _stage && {_stage != 0}) exitWith {
    private _text = "Turning down the blowout event is not possible! You can disable it by setting it to stage 0!";
    LOG_SYS("WARNING",_text);
    systemChat _text;
    false
};

GVAR(blowoutStage) = _stage;
publicVariable QGVAR(blowoutStage);
if (GVAR(debug)) then {
    systemChat format ["COORDINATOR Blowout entered stage: %1", _stage];
};

switch (GVAR(blowoutStage)) do {
    case 0: {
        GVAR(blowoutInProgress) = false;
        setWind [-0.160582,2.80532, true];
        publicVariable QGVAR(blowoutInProgress);
        [QGVAR(blowOutStage), [0]] call CBA_fnc_globalEvent;
        ace_weather_disableWindSimulation = GVAR(aceWeatherDisableWindSimulation);
    };
    case 1: {
        GVAR(blowoutInProgress) = true;
        GVAR(aceWeatherDisableWindSimulation) = missionNamespace getVariable ["ace_weather_disableWindSimulation", false];
        ace_weather_disableWindSimulation = true;
        publicVariable QGVAR(blowoutInProgress);
        GVAR(blowoutDirection) = _direction;
        publicVariable QGVAR(blowoutDirection);
        0 setLightnings 1;
        private _time = random [20, 30, 40];
        [QGVAR(blowOutStage), [1, [_time]]] call CBA_fnc_globalEvent;

        [{
            if !(GVAR(blowoutInProgress)) exitWith {};
            [{
                if !(GVAR(blowoutInProgress)) exitWith {};
                forceWeatherChange;
                private _wind = (([0, 0, 0] getPos [1, GVAR(blowoutDirection)]) vectorFromTo [0, 0, 0]) vectorMultiply 10;
                setWind [_wind select 0, _wind select 1, true];
            }, nil, 15] call CBA_fnc_waitAndExecute;
        }, nil, 60 - _time] call CBA_fnc_waitAndExecute;
    };
    case 2: {
        if !(GVAR(blowoutInProgress)) exitWith {};
        private _wind = (([0, 0, 0] getPos [1, GVAR(blowoutDirection)]) vectorFromTo [0, 0, 0]) vectorMultiply 20;
        setWind [_wind select 0, _wind select 1, true];
        [QGVAR(blowOutStage), [2]] call CBA_fnc_globalEvent;
    };
    case 3: {
        if !(GVAR(blowoutInProgress)) exitWith {};
        private _wind = (([0, 0, 0] getPos [1, GVAR(blowoutDirection)]) vectorFromTo [0, 0, 0]) vectorMultiply 1000;
        setWind [_wind select 0, _wind select 1, true];
        [QGVAR(blowOutStage), [3]] call CBA_fnc_globalEvent;
    };
    case 4: {
        if !(GVAR(blowoutInProgress)) exitWith {};
        [QGVAR(blowOutStage), [4]] call CBA_fnc_globalEvent;

        [{
            if !(GVAR(blowoutInProgress)) exitWith {};
            [{
                if !(GVAR(blowoutInProgress)) exitWith {};
                [0] call FUNC(blowout);
            }, nil, 8] call CBA_fnc_waitAndExecute;
        }, nil, 7] call CBA_fnc_waitAndExecute;
    };
    default { };
};

true
