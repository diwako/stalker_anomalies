/*
	Function: anomaly_fnc_createAnomalyField

	Description:
        Creates and anomaly field with specific amount of each anomaly type

    Parameter:
        _posParams - array containing parameters for the function CBA_fnc_randPosArea, See dokumentation here:http://cbateam.github.io/CBA_A3/docs/files/common/fnc_randPosArea-sqf.html (default: [])
        _springboard 	- how many anomalies of the type springboard should be created (default: 0)
        _burner 		- how many anomalies of the type burner should be created (default: 0)
        _electra 		- how many anomalies of the type electra should be created (default: 0)
        _meatgrinder 	- how many anomalies of the type meatgrinder should be created (default: 0)

    Returns:
        array of all crated anomalies

	Author:
	diwako 2018-03-21
*/
params["_posParams",["_springboard",0],["_burner",0],["_electra",0],["_meatgrinder",0]];

_anomalies = [];

for "_i" from 1 to _springboard do {
	_pos = _posParams call CBA_fnc_randPosArea;
	_anomalies pushBack ([_pos] call anomaly_fnc_createSpringboard);
};

for "_i" from 1 to _burner do {
	_pos = _posParams call CBA_fnc_randPosArea;
	_anomalies pushBack ([_pos] call anomaly_fnc_createBurner);
};

for "_i" from 1 to _electra do {
	_pos = _posParams call CBA_fnc_randPosArea;
	_anomalies pushBack ([_pos] call anomaly_fnc_createElectra);
};

for "_i" from 1 to _meatgrinder do {
	_pos = _posParams call CBA_fnc_randPosArea;
	_anomalies pushBack ([_pos] call anomaly_fnc_createMeatgrinder);
};

_anomalies