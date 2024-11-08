#include "\z\diwako_anomalies\addons\main\script_component.hpp"
if !(hasInterface) exitWith {};
params [["_show", false]];

if (isNil QGVAR(skyPsyWaves)) then {
    GVAR(skyPsyWaves) = false;
    GVAR(psySky) = objNull;
};

if (_show isEqualTo GVAR(skyPsyWaves)) exitWith {};
GVAR(skyPsyWaves) = _show;

if (_show) then {
    deleteVehicle GVAR(psySky);
    private _psySky = createSimpleObject ["UserTexture10m_F", [0, 0, 0], true];
    _psySky setVectorDirAndUp [[0,0,1], [0,1,0]];
    _psySky setObjectScale (viewDistance/5);
    _psySky setPosWorld (([] call CBA_fnc_currentUnit) modelToWorldWorld [0, 0, 200]);
    _psySky setObjectMaterial [0, "a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"];
    _psySky setObjectTexture [0, format ["#(rgb,4096,4096,1)ui('RscDisplayEmpty','%1','sky')", QGVAR(psyWavesUI)]];
    GVAR(psySky) = _psySky;

    private _fnc = {
        params ["_psySky"];
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
        _ctrl ctrlSetText (QPATHTOF(data\textures\blowout_psy_sky_ca.paa));
        _ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0;
        displayUpdate _display;
        _ctrl ctrlSetFade 0;
        _ctrl ctrlCommit 120;
        [{
            if (isGamePaused) exitWith {};
            params ["_psySky", "_display"];
            _psySky setPosWorld (player modelToWorldWorld [0, 0, 200]);
            (_display getVariable [QGVAR(texture), controlNull]) ctrlSetAngle [(cba_missionTime % 7200) / 20, 0.5, 0.5];
            displayUpdate _display;

            isNull _psySky
         }, {}, [_psySky, _display]] call CBA_fnc_waitUntilAndExecute;
    };
    [{
        if (GVAR(debug)) then {
            systemChat "Searching display";
        };
        !isNull (findDisplay QGVAR(psyWavesUI))
    }, _fnc, [_psySky]] call CBA_fnc_waitUntilAndExecute;
} else {
    private _display = GVAR(psySky) getVariable [QGVAR(display), displayNull];
    private _ctrl = _display getVariable [QGVAR(texture), controlNull];
    private _commit = 5 * 60;
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit _commit;
    [{
        ctrlDelete _this;
        deleteVehicle GVAR(psySky);
    }, _ctrl, _commit + 10] call CBA_fnc_waitAndExecute;
};
