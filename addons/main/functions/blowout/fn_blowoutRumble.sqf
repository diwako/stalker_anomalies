#include "\z\diwako_anomalies\addons\main\script_component.hpp"
#define RUMBLE_DUR 7.62665
if !(hasInterface) exitWith {};

private _fnc_rumble = {
    if !(GVAR(blowoutInProgress)) exitWith {};
    if (GVAR(blowoutStage) < 3) then {
        addCamShake [0.75, RUMBLE_DUR * 2, 25];
    } else {
        addCamShake [5, RUMBLE_DUR * 2, 25];
    };
    playSound "blowout_rumble";
    [{
        _this call (_this select 0);
    }, _this, RUMBLE_DUR / 2] call CBA_fnc_waitAndExecute;
};

private _fnc_lightning = {
    if !(GVAR(blowoutInProgress)) exitWith {};
    private _sleep = 3 + random 2;
    if (GVAR(blowoutStage) > 2) then {
        _sleep = 0.5 + random 1;
    };
    [] call FUNC(createLocalLightningBolt);
    [{
        _this call (_this select 0);
    }, _this, _sleep] call CBA_fnc_waitAndExecute;
};

[_fnc_rumble] call _fnc_rumble;
[_fnc_lightning] call _fnc_lightning;
