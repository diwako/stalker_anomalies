#include "\z\diwako_anomalies\addons\main\script_component.hpp"

params [["_unit", objNull]];

if (!GVAR(allowUnitScreams) || !alive _unit || {!(_unit isKindOf "CAManBase")}) exitWith {};

if (_unit getVariable [QGVAR(nextScreamAllowed), 0] > time) exitWith {};
_unit setVariable [QGVAR(nextScreamAllowed), time + 0.3];

private _voice = toLowerANSI speaker _unit;
if (_voice in ["ace_novoice", "novoice"]) exitWith {};

// fetching these dynamically is not possible with ace loaded sooooo...
// we do it hardcoded, results should not vary too much

if (isNil QGVAR(speakerCache)) then {
    GVAR(speakerCache) =createHashMapFromArray [
        ["male08eng", "P01"],
        ["male02gre", "P10"],
        ["male03eng", "P11"],
        ["male03engb", "P12"],
        ["male04eng", "P13"],
        ["male05gre", "P14"],
        ["male06gre", "P15"],
        ["male04gre", "P16"],
        ["male05engb", "P17"],
        ["male05eng", "P18"],
        ["male06eng", "P02"],
        ["male09eng", "P03"],
        ["male07eng", "P04"],
        ["male03gre", "P05"],
        ["male02engb", "P06"],
        ["male01engb", "P07"],
        ["male01gre", "P08"],
        ["male02eng", "P09"]
    ];
};

private _speaker = GVAR(speakerCache) getOrDefault [_voice, "P01"];
private _sound = format ["A3\sounds_f\characters\human-sfx\%1\Max_Hit_%2.wss", _speaker, ceil random 5];
if !(fileExists _sound) then {
    _sound = format ["A3\sounds_f\characters\human-sfx\%1\Hit_Max_%2.wss", _speaker, ceil random 5];
};
if (fileExists _sound) then {
    playSound3D [_sound, _unit, false, AGLToASL (_unit modelToWorld (_unit selectionPosition "head")), 3 + random 2, 0.9 + random 0.2, 150];
} else {
    systemChat _sound;
};
