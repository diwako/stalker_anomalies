if (!isNil "zen_custom_modules_fnc_register") then {

    ["Stalker Anomalies", "Spawn Anomaly",
        {
            private _pos = (ASLToAGL (_this select 0));
            private _anomalies = [
                localize "STR_anomaly_burner",
                localize "STR_anomaly_electra",
                localize "STR_anomaly_meatgrinder",
                localize "STR_anomaly_springboard",
                localize "STR_anomaly_teleport",
                localize "STR_anomaly_fog",
                localize "STR_anomaly_fruitpunch",
                localize "STR_anomaly_psy_discharge"
            ];

            ["Spawn anomaly", [
                    ["COMBO", "Anomaly", [_anomalies, _anomalies apply {[_x]}, 0]]
                ],
                {
                    params ["_dialog", "_args"];
                    _dialog params ["_type"];
                    _args params ["_pos", "_anomalies"];
                    _pos = AGLToASL _pos;
                    switch (_anomalies findIf {_x isEqualTo _type}) do {
                        case 0: { [QGVAR(createAnomaly), [[_pos], "burner"]] call CBA_fnc_serverEvent; };
                        case 1: { [QGVAR(createAnomaly), [[_pos], "electra"]] call CBA_fnc_serverEvent; };
                        case 2: { [QGVAR(createAnomaly), [[_pos], "meatgrinder"]] call CBA_fnc_serverEvent; };
                        case 3: { [QGVAR(createAnomaly), [[_pos], "springboard"]] call CBA_fnc_serverEvent; };
                        case 4: {
                            ["Teleport ID (Number)", [
                                    ["SLIDER", "ID", [1, 50, 1, 0]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_id"];
                                    _args params ["_pos"];
                                    _id = floor _id;
                                    [QGVAR(createAnomaly), [[_pos,_id], "teleport"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        case 5: {
                            ["Create fog anomaly", [
                                    ["SLIDER", "Radius", [1, 250, 1]],
                                    ["CHECKBOX", "Rectangle", [false]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_radius", "_rectangle"];
                                    _args params ["_pos"];
                                    [QGVAR(createAnomaly), [[_pos, _radius, _rectangle], "fog"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        case 6: { [QGVAR(createAnomaly), [[_pos], "fruitpunch"]] call CBA_fnc_serverEvent; };
                        case 7: { [QGVAR(createAnomaly), [[_pos], "psyDischarge"]] call CBA_fnc_serverEvent;};
                        default { };
                    };
                }, {}, [_pos, _anomalies]
            ] call zen_dialog_fnc_create;
        }
    ] call zen_custom_modules_fnc_register;

    ["Stalker Anomalies", "Delete Anomalies",
        {
            private _pos = (ASLToAGL (_this select 0));

            ["Delete Anomalies", [
                    ["SLIDER", "Radius", [1, 250, 5]]
                ],
                {
                    params ["_dialog", "_args"];
                    _dialog params ["_radius"];
                    _args params ["_pos"];
                    private _trigs = _pos nearObjects ["EmptyDetector", _radius];
                    _trigs = _trigs select {_x getVariable [QGVAR(anomalyType), ""] isNotEqualTo ""};
                    [QGVAR(deleteAnomalies), [_trigs]] call CBA_fnc_serverEvent;
                }, {}, [_pos]
            ] call zen_dialog_fnc_create;
        }
    ] call zen_custom_modules_fnc_register;
};
