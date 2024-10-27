#include "\z\diwako_anomalies\addons\main\script_component.hpp"
if !(hasInterface) exitWith {};
private _player = [] call CBA_fnc_currentUnit;
private _array = [
    [AGLToASL (_player getPos [2000 + random 2000, random 90]),"siren1",9.445465],
    [AGLToASL (_player getPos [2000 + random 2000, 90 + random 90]),"siren2",11.23115],
    [AGLToASL (_player getPos [2000 + random 2000, 180 + random 90]),"siren1",9.445465],
    [AGLToASL (_player getPos [2000 + random 2000, 270 + random 90]),"siren2",11.23115]
];

[{
    private _fnc_siren = {
        params ["_fnc", "_args"];
        _args params ["_obj", "_sound" ,"_delay"];
        if !(GVAR(blowoutInProgress) && GVAR(blowoutStage) < 3) exitWith {
            deleteVehicle _obj;
        };
        _obj say3D [_sound, 4500, 1];
        [{
            _this call (_this select 0);
        }, _this, _delay] call CBA_fnc_waitAndExecute;
    };
    private _timeout = random 5;
    {
        _x params ["_pos", "_sound" ,"_delay"];
        private _obj = "building" createVehicleLocal _pos;
        _obj setPosASL _pos;
        [{
            _this call (_this select 0);
        }, [_fnc_siren, [_obj, _sound, _delay]], _timeout] call CBA_fnc_waitAndExecute;
        _timeout = _timeout + random 5;
    } forEach _this;
}, _array, random 5] call CBA_fnc_waitAndExecute;
