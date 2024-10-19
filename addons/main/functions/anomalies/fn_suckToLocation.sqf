#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_suckToLocation

    Description:
        sucks a given object slightly above a given position

    Parameter:
        _obj - Object that is about to be sucked in
        _pos - given position
        _intensity - Force Multiplier (default: 1)
        _duration - duration of the effect     (default: 10)

    Returns:
        nothing

    Author:
    diwako 2017-12-11
*/
params["_obj","_pos",["_intensity",1], ["_duration", 10]];

[{
    params ["_obj", "_time", "_pos", "_intensity"];
    private _pos2 = getPos _obj;
    private _a = ((_pos select 0) - (_pos2 select 0));
    private _b = ((_pos select 1) - (_pos2 select 1));
    _obj setVelocity [_a * _intensity, _b * _intensity, 0.2];

    !alive _obj || (time > _time)
}, {
    // nop
}, [_obj, time + _duration, _pos, _intensity]] call CBA_fnc_waitUntilAndExecute;
