#include "\z\diwako_anomalies\addons\main\script_component.hpp"
#define BRIGHTNESS 15
if !(hasInterface) exitWith {};
params [["_show", false], ["_useSkyLight", true]];

if (isNil QGVAR(skyPsyWaves)) then {
    GVAR(skyPsyWaves) = false;
    GVAR(psySky) = objNull;
    GVAR(skyPsyLightCurrentBrightness) = 0;
};

if (_show isEqualTo GVAR(skyPsyWaves)) exitWith {};
GVAR(skyPsyWaves) = _show;
GVAR(skyPsyTime) = time;

if (_show) then {
    deleteVehicle (GVAR(psySky) getVariable [QGVAR(light), objNull]);
    deleteVehicle GVAR(psySky);
    private _psySky = createSimpleObject ["UserTexture10m_F", [0, 0, 0], true];
    _psySky setVectorDirAndUp [[0,0,1], [0,1,0]];
    _psySky setObjectScale (viewDistance/5);
    _psySky setPosWorld (([] call CBA_fnc_currentUnit) modelToWorldWorld [0, 0, 200]);
    _psySky setObjectMaterial [0, "a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"];
    _psySky setObjectTexture [0, format ["#(rgb,4096,4096,1)ui('RscDisplayEmpty','%1','sky')", QGVAR(psyWavesUI)]];
    GVAR(psySky) = _psySky;

    private _fnc = {
        params ["_psySky" ,"_useSkyLight"];
        if (GVAR(debug)) then {
            systemChat "Display found!";
        };
        private _display = findDisplay QGVAR(psyWavesUI);
        _psySky setVariable [QGVAR(display), _display];

        // clean up old control if still exists
        ctrlDelete (_display getVariable [QGVAR(texture), controlNull]);
        private _ctrl = _display ctrlCreate ["RscPicture", -1];
        _display setVariable [QGVAR(texture), _ctrl];
        private _size = 0.5;
        _ctrl ctrlSetPosition [(1-_size) / 2, (1-_size) / 2, _size, _size];
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        _ctrl ctrlSetText GVAR(psySkyTecture);
        _ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0;
        displayUpdate _display;
        _ctrl ctrlSetFade 0;
        private _commit = 120;
        _ctrl ctrlCommit _commit;

        private _light = objNull;
        if (_useSkyLight) then {
            GVAR(skyPsyLightMaxBrightness) = BRIGHTNESS * (overcast max ((1 - (moonPhase date)) / 2));
            if (GVAR(skyPsyLightMaxBrightness) <= 2) exitWith {
                if (GVAR(debug)) then {
                    systemChat "Sky light disabled due to low brightness";
                };
            };
            _light = "#lightpoint" createVehicleLocal [0, 0, 0];
            GVAR(psySky) setVariable [QGVAR(light), _light];
            _light setLightAmbient GVAR(psySkyLightColor);
            _light setLightColor GVAR(psySkyLightColor);
            _light setLightUseFlare false;
            _light setLightFlareSize 100;
            _light setLightFlareMaxDistance 1000;
            _light setLightDayLight true;
            _light setLightBrightness 0;
            GVAR(skyPsyLightExecTime) = _commit;
        };

        [{
            if (isGamePaused) exitWith {};
            params ["_psySky", "_display", "_light"];
            private _pos = ([] call CBA_fnc_currentUnit) modelToWorldWorld [0, 0, 200];
            _psySky setPosWorld _pos;
            (_display getVariable [QGVAR(texture), controlNull]) ctrlSetAngle [(cba_missionTime % 7200) / 20, 0.5, 0.5];
            displayUpdate _display;

            if !(isNull _light) then {
                GVAR(skyPsyLightCurrentBrightness) = abs (([-GVAR(skyPsyLightMaxBrightness), 0] select GVAR(skyPsyWaves)) + (linearConversion [GVAR(skyPsyTime), GVAR(skyPsyTime) + GVAR(skyPsyLightExecTime), time, 0, GVAR(skyPsyLightMaxBrightness), true]));
                _light setLightBrightness GVAR(skyPsyLightCurrentBrightness);
                _light setPosWorld _pos;
            };

            isNull _psySky
         }, {
            params ["", "", "_light"];
            deleteVehicle _light;
         }, [_psySky, _display, _light]] call CBA_fnc_waitUntilAndExecute;
    };
    [{
        if (GVAR(debug)) then {
            systemChat "Searching display";
        };
        !isNull (findDisplay QGVAR(psyWavesUI))
    }, _fnc, [_psySky, _useSkyLight]] call CBA_fnc_waitUntilAndExecute;
} else {
    private _display = GVAR(psySky) getVariable [QGVAR(display), displayNull];
    private _ctrl = _display getVariable [QGVAR(texture), controlNull];
    private _commit = 5 * 60;
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit _commit;
    GVAR(skyPsyLightMaxBrightness) = GVAR(skyPsyLightCurrentBrightness);
    GVAR(skyPsyLightExecTime) = _commit;
    [{
        ctrlDelete _this;
        deleteVehicle GVAR(psySky);
        if (GVAR(debug)) then {
            systemChat "Display deleted!";
        };
    }, _ctrl, _commit + 10] call CBA_fnc_waitAndExecute;
};
