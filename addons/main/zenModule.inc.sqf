if !(isNil "zen_custom_modules_fnc_register") then {

    [localize "STR_anomaly_category", localize "STR_anomaly_zeus_spawn_anomaly",
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

            [localize "STR_anomaly_zeus_spawn_anomaly", [
                    ["COMBO", localize "STR_anomaly_singular", [_anomalies, _anomalies apply {[_x]}, 0]]
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
                            [localize "STR_anomaly_teleport", [
                                    ["SLIDER", localize "STR_anomaly_teleport_id", [0, 50, 0, 0]]
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
                            [localize "STR_anomaly_fog", [
                                    ["SLIDER", localize "str_a3_cfgvehicles_sign_radius_f0", [1, 250, 1]],
                                    ["CHECKBOX", localize "str_disp_arcmark_rect", [false]]
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
                        case 7: { [QGVAR(createAnomaly), [[_pos], "psyDischarge"]] call CBA_fnc_globalEvent;};
                        default { };
                    };
                }, {}, [_pos, _anomalies]
            ] call zen_dialog_fnc_create;
        }
    ] call zen_custom_modules_fnc_register;

    [localize "STR_anomaly_category", localize "STR_anomaly_zeus_delete_anomalies",
        {
            private _pos = (ASLToAGL (_this select 0));

            [localize "STR_anomaly_zeus_delete_anomalies", [
                    ["SLIDER", localize "str_a3_cfgvehicles_sign_radius_f0", [1, 250, 5]]
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

    [localize "STR_anomaly_category", localize "STR_anomaly_zeus_start_stop_blowout",
        {
            if (missionNamespace getVariable [QGVAR(blowoutInProgress), false]) then {
                [localize "STR_anomaly_zeus_stop_blowout", [
                    ["TOOLBOX:YESNO", [localize "STR_anomaly_zeus_stop_blowout", localize "STR_anomaly_zeus_stop_blowout_desc"]]
                    ],
                    {
                        params ["_dialog"];
                        _dialog params ["_choice"];
                        if (_choice isEqualTo 1) then {
                            [QGVAR(stopBlowout), []] call CBA_fnc_serverEvent;
                            [localize "STR_anomaly_zeus_stop_blowout_hint"] call zen_common_fnc_showMessage;
                        };
                    }, {}, []
                ] call zen_dialog_fnc_create;
            } else {
                [localize "STR_anomaly_zeus_start_blowout", [
                        ["SLIDER", [localize "STR_anomaly_zeus_start_blowout_time", localize "STR_anomaly_zeus_start_blowout_time_desc"], [102, 999, 400, 0]],
                        ["SLIDER", [localize "STR_anomaly_zeus_start_blowout_direction", localize "STR_anomaly_zeus_start_blowout_direction_desc"], [0, 359, 0, 0]],
                        ["CHECKBOX", [localize "STR_anomaly_zeus_start_blowout_sirens", localize "STR_anomaly_zeus_start_blowout_sirens_desc"], [true]],
                        ["CHECKBOX", [localize "STR_anomaly_zeus_start_blowout_only_players", localize "STR_anomaly_zeus_start_blowout_only_players_desc"], [true]]
                    ],
                    {
                        params ["_dialog"];
                        _dialog params ["_time", "_direction", "_useSirens", "_onlyPlayers"];
                        [QGVAR(startBlowout), [floor _time, floor _direction, _useSirens, _onlyPlayers]] call CBA_fnc_serverEvent;
                        [format [localize "STR_anomaly_zeus_start_blowout_hint", floor ((floor _time) / 60), (floor _time) mod 60]] call zen_common_fnc_showMessage;
                    }, {}, []
                ] call zen_dialog_fnc_create;
            };
        }
    ] call zen_custom_modules_fnc_register;
};
