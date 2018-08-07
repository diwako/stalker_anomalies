/*
	Function: anomaly_fnc_setTrigger

	Description:
        Function which will be remoteExeced to set up the trigger settings
		Made, because when battle eye is enabled it does not allow remoteExec of settrigger commands without cfgremoteexec entry

    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])

    Returns:
        nil

	Author:
	diwako 2018-07-07
*/
params["_trg","_area","_activation","_statements"];

_trg setTriggerArea _area;
_trg setTriggerActivation _activation;
_trg setTriggerStatements _statements;

nil