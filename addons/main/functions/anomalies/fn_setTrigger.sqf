#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_setTrigger

    Description:
        Function which will set up the trigger settings

    Parameter:
        _trg - Trigger
        _area - setTriggerArea params
        _activation - setTriggerActivation params
        _statements - setTriggerStatements params

    Returns:
        nil

    Author:
    diwako 2018-08-07
*/
params["_trg","_area","_activation","_statements"];

_trg setTriggerArea _area;
_trg setTriggerActivation _activation;
_trg setTriggerStatements _statements;

nil
