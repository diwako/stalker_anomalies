#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createAnomalyField

    Description:
        Creates and anomaly field with specific amount of each anomaly type

    Parameter:
        _posParams - Array containing parameters for the function CBA_fnc_randPosArea. (default: [])
                See documentation here: http://cbateam.github.io/CBA_A3/docs/files/common/fnc_randPosArea-sqf.html
        _springboard - Number of springboard anomalies to create (default: 0)
        _burner - Number of burner anomalies to create (default: 0)
        _electra - Number of electra anomalies to create (default: 0)
        _meatgrinder - Number of meatgrinder anomalies to create (default: 0)

    Returns:
        Array of all created anomalies

    Author:
    diwako 2018-03-21
*/
params["_posParams", ["_springboard",0], ["_burner",0], ["_electra",0], ["_meatgrinder",0]];
if !(isServer) exitWith {nil};

if !(_posParams isEqualType []) then {
    //created via module
    private _pos = _posParams getVariable "objectarea";
    _springboard = _posParams getVariable ["springboards",0];
    _burner = _posParams getVariable ["burners",0];
    _electra = _posParams getVariable ["electras",0];
    _meatgrinder = _posParams getVariable ["meatgrinders",0];
    private _module = _posParams;
    _posParams = [[(getPos _posParams), _pos#0, _pos#1, _pos#2, _pos#3]];
    deleteVehicle _module;
};

private _anomalies = [];
private _pos = [];

for "_i" from 1 to _springboard do {
    _pos = _posParams call CBA_fnc_randPosArea;
    _pos set [2, 0];
    _anomalies pushBack ([AGLToASL _pos] call FUNC(createSpringboard));
};

for "_i" from 1 to _burner do {
    _pos = _posParams call CBA_fnc_randPosArea;
    _pos set [2, 0];
    _anomalies pushBack ([AGLToASL _pos] call FUNC(createBurner));
};

for "_i" from 1 to _electra do {
    _pos = _posParams call CBA_fnc_randPosArea;
    _pos set [2, 0];
    _anomalies pushBack ([AGLToASL _pos] call FUNC(createElectra));
};

for "_i" from 1 to _meatgrinder do {
    _pos = _posParams call CBA_fnc_randPosArea;
    _pos set [2, 0];
    _anomalies pushBack ([AGLToASL _pos] call FUNC(createMeatgrinder));
};

_anomalies
