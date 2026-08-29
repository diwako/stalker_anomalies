#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createMagma

    Description:
        Creates an anomaly of the type "Magma"

    Parameter:
        _pos - PositionASL where the anomaly should be (default: [0,0,0])
        _addScorchMark - Boolean, if a scorchmark object should be added to the ground (default: true)

    Returns:
        Anomaly Trigger

    Author:
    diwako 2026-08-29
*/
params[["_pos", [0,0,0]], ["_addScorchMark", true]];

if !(isServer) exitWith {};

private _varName = "";
if (_pos isEqualType objNull) then {
    //created via module
    private _module = _pos;
    _varName = vehicleVarName _module;
    _addScorchMark = _module getVariable ["scorchMark", true];

    _pos = getPosASL _module;
    deleteVehicle _module;
};

if (count _pos < 3) then {
    _pos set [2,0];
};
private _trg = createTrigger ["EmptyDetector", _pos];
if (_varName isNotEqualTo "") then { missionNamespace setVariable [_varName, _trg, true]; };
_trg setPosASL _pos;
_trg setVariable [QGVAR(cooldown), false, true];
_trg setVariable [QGVAR(active), false];
_trg setVariable [QGVAR(anomalyType), "magma", true];
_trg setVariable [QGVAR(detectorOffset), 10, true];

private _fnc_Filter = {thisList select { !(_x getVariable ['anomaly_ignore', false]) && {alive _x} && {lifeState _x != 'INCAPACITATED'} && {!(_x isKindOf "WeaponHolderSimulated") }}};

_trg setTriggerArea [10, 10, 0, false, 5];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerStatements [format ["this && {!(thisTrigger getVariable ['%1',false])} && {!(thisTrigger getVariable ['%2',false])} && {(call %3) isNotEqualTo []}", QGVAR(cooldown), QGVAR(active), _fnc_Filter], format ["[thisTrigger, (call %2)] call %1", QFUNC(activateMagma), _fnc_Filter], ""];

if (isNil QGVAR(holder)) then {
    GVAR(holder) = [];
};

GVAR(holder) pushBack _trg;

if (GVAR(debug)) then {
    private _marker = createMarkerLocal [str(_pos),_pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerTextLocal (_trg getVariable QGVAR(anomalyType));
    _trg setVariable [QGVAR(debugMarker),_marker];
};

// disable trigger until player is near
_trg enableDynamicSimulation false;
_trg enableSimulationGlobal false;

if (_addScorchMark && (getPos _trg select 2 < 0.5)) then {
    private _decal = createSimpleObject ["Land_Decal_ScorchMark_01_small_F", _pos];
    _decal setDir random 360;
    _decal setObjectScale 10;
    _trg setVariable [QGVAR(scorchMark), _decal];

    _decal = createSimpleObject ["Land_ClutterCutter_large_F", _pos];
    // _decal setObjectScale 2;
    _decal setVariable ["anomaly_ignore", true];
    _trg setVariable [QGVAR(grassCutter), _decal];
};

private _light = "#lightpoint" createVehicle _pos;
_light setPosASL _pos;
private _jipID = [QGVAR(setLight), [_light, 1, [1, 0.6, 0.6], nil, [1, 0.6, 0.6], true, true]] call CBA_fnc_globalEventJip;
[_jipID, _light] call CBA_fnc_removeGlobalEventJIP;

_trg setVariable [QGVAR(light), _light];

_trg
