#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_bloodEffect

    Description:
        Blood splash (texture) postprocess.

    Parameters:
        _time - Bleeding time in seconds, could be <5;90>
                Can be called multiple times, time for blood on screen will update

    Returns:
        nothing

    Author:
    Vladimir Hynek
    diwako 2025-06-20
*/

params [["_time", 0]];

if (GVAR(bloodEffectRunning)) exitWith {
    GVAR(bloodEffectTime) = GVAR(bloodEffectTime) max (time + _time);
    nil
};

GVAR(bloodEffectRunning) = true;
GVAR(bloodEffectTime) = time + _time;

if (isNull (uiNamespace getVariable [QGVAR(RscHealthTextures), displayNull])) then {
    ([QGVAR(RscHealthTextures)] call bis_fnc_rscLayer) cutRsc [QGVAR(RscHealthTextures), "plain"]
};
private _display = uiNamespace getVariable QGVAR(RscHealthTextures);
private _texLower = _display displayCtrl 1211;
_texLower ctrlSetFade 1;
_texLower ctrlCommit 0;

private _texMiddle = _display displayCtrl 1212;
_texMiddle ctrlSetFade 1;
_texMiddle ctrlCommit 0;

private _texUpper = _display displayCtrl 1213;
_texUpper ctrlSetFade 1;
_texUpper ctrlCommit 0;

_texLower ctrlSetFade 0.2;
_texMiddle ctrlSetFade 0.7;
_texUpper ctrlSetFade 0.7;

_texLower ctrlCommit 0.1;
_texMiddle ctrlCommit 0.1;
_texUpper ctrlCommit 0.1;
[{
    GVAR(bloodEffectTime) < time
}, {
    params ["_texLower", "_texMiddle", "_texUpper"];
    GVAR(bloodEffectRunning) = false;
    GVAR(bloodEffectTime) = nil;

    _texUpper ctrlSetFade 1;
    _texUpper ctrlCommit 1.5;
    [{
        if !(GVAR(bloodEffectRunning)) then {
            _this ctrlSetFade 1;
            _this ctrlCommit 1;
        };
    }, _texMiddle, 1] call CBA_fnc_waitAndExecute;
    [{
        if !(GVAR(bloodEffectRunning)) then {
            _this ctrlSetFade 1;
            _this ctrlCommit 0.8;
        };
    }, _texLower, 1.5] call CBA_fnc_waitAndExecute;
}, [_texLower, _texMiddle, _texUpper]] call CBA_fnc_waitUntilAndExecute;

nil
