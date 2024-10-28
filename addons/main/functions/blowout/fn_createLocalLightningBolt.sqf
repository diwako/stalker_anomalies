#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_createLocalLightningBolt

    Description:
        Creates a none destructive local only thunderbolt with sound and light

    Parameters:
        _pos - PositionAGL, can be left empty for effect around player (default: [)

    Returns:
        nothing

    Author:
    diwako 2026-10-26
*/
if !(hasInterface) exitWith {};
if (isNil QGVAR(thunderSounds)) then {
    // Ambient thunder sounds from the map, to support custom thunder claps
    private _soundSets = getArray (configFile >> "CfgWorlds" >> worldName >> "Weather" >> "ThunderboltNorm" >> "soundSet");
    private _soundShaders = [];
    {
        _soundShaders append getArray (configFile >> "CfgSoundSets" >> _x >> "soundShaders");
    } forEach _soundSets;
    _soundShaders = _soundShaders arrayIntersect _soundShaders;
    private _sounds = [];
    {
        _sounds append ((getArray (configFile >> "CfgSoundShaders" >> _x >> "samples")) apply {_x select 0});
    } forEach _soundShaders;
    GVAR(thunderSounds) = (_sounds arrayIntersect _sounds) apply {
        if (_x find "." == -1) then {
            _x = _x + ".wss";
        };
        if (_x find "\" == 0) then {
            _x = _x select [1, count _x - 1];
        };
        _x
    };
};
params [["_pos", []]];
if (_pos isEqualTo []) then {
    _pos = [player, 750] call CBA_fnc_randPos;
};
private _light = "#lightpoint" createVehicleLocal _pos;
_light setPosATL [_pos select 0, _pos select 1, (_pos select 2) + 10];
_light setLightDayLight true;
_light setLightBrightness 300;
_light setLightAmbient [0.05, 0.05, 0.1];
_light setLightColor [1, 1, 2];
_light setLightUseFlare true;
_light setLightFlareSize 500;
_light setLightFlareMaxDistance 300;

private _lightning = (selectRandom ["lightning1_F", "lightning2_F"]) createVehicleLocal _pos;
_lightning hideObject true;
_lightning setDir random 360;
_lightning setPos _pos;

private _miniWait = random 0.1;

[{
    _this setLightBrightness 0;
    _this setLightUseFlare false;
}, _light, 0.1] call CBA_fnc_waitAndExecute;

[{
    params ["_pos", "_lightning"];
    _lightning hideObject false;

    playSound3D [selectRandom GVAR(thunderSounds), objNull, false, AGLToASL _pos, 2, 1, 10000, 0, true];
}, [_pos, _lightning], 0.1 + _miniWait] call CBA_fnc_waitAndExecute;

private _lightningFlickerNum = 3 + random 1;
private _iOutside = 0;

for "_i" from 0 to _lightningFlickerNum do {
    [{
        _this setLightBrightness (100 + random 100);
    }, _light, 0.1 + _miniWait + (0.1 * _i)] call CBA_fnc_waitAndExecute;
    _iOutside = _i;
};

[{
    {
        deleteVehicle _x;
    } forEach _this
}, [_light, _lightning], 0.1 + _miniWait + (0.1 * (_iOutside + 1))] call CBA_fnc_waitAndExecute;

nil
