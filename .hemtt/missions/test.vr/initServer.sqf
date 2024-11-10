private _cometObjectPath = [];
for "_i" from 1 to 14 do {
    _cometObjectPath pushBack (missionNamespace getVariable [format ["objPos_%1", _i], objNull]);
};

[_cometObjectPath] call diwako_anomalies_main_fnc_createComet;
