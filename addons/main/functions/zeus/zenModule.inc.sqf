if !(isNil "zen_custom_modules_fnc_register") then {

    [localize "STR_anomaly_category", localize "STR_anomaly_zeus_spawn_anomaly",
        {
            private _pos = (ASLToAGL (_this select 0));
            private _anomalies = [
                [localize "STR_anomaly_burner", localize "STR_anomaly_burner_desc", QPATHTOF(data\ui\modules\burner_ca.paa)],
                [localize "STR_anomaly_electra", localize "STR_anomaly_electra_desc", QPATHTOF(data\ui\modules\electra_ca.paa)],
                [localize "STR_anomaly_meatgrinder", localize "STR_anomaly_meatgrinder_desc", QPATHTOF(data\ui\modules\meatgrinder_ca.paa)],
                [localize "STR_anomaly_springboard", localize "STR_anomaly_springboard_desc", QPATHTOF(data\ui\modules\springboard_ca.paa)],
                [localize "STR_anomaly_teleport", localize "STR_anomaly_teleport_desc", QPATHTOF(data\ui\modules\teleport_ca.paa)],
                [localize "STR_anomaly_fog", localize "STR_anomaly_fog_desc", QPATHTOF(data\ui\modules\fog_ca.paa)],
                [localize "STR_anomaly_fruitpunch", localize "STR_anomaly_fruitpunch_desc", QPATHTOF(data\ui\modules\fruitpunch_ca.paa)],
                [localize "STR_anomaly_psy_discharge", localize "STR_anomaly_psy_discharge_desc", QPATHTOF(data\ui\modules\psydischarge_ca.paa)],
                [localize "STR_anomaly_clicker", localize "STR_anomaly_clicker_desc", QPATHTOF(data\ui\modules\clicker_ca.paa)],
                [localize "STR_anomaly_razor", localize "STR_anomaly_razor_desc", QPATHTOF(data\ui\modules\razor_ca.paa)],
                [localize "STR_anomaly_willowisp", localize "STR_anomaly_willowisp_desc", QPATHTOF(data\ui\modules\willowisp_ca.paa)],
                [localize "STR_anomaly_psy", localize "STR_anomaly_psy_desc", QPATHTOF(data\ui\modules\psy_ca.paa)]
            ];

            [localize "STR_anomaly_zeus_spawn_anomaly", [
                    ["COMBO", localize "STR_anomaly_singular", [_anomalies apply {_x select 0}, _anomalies, 0]]
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
                                    ["SLIDER:RADIUS", localize "str_a3_cfgvehicles_sign_radius_f0", [1, 250, 50, 1, ASLToAGL _pos, [1, 0, 0, 1]]],
                                    ["CHECKBOX", localize "str_disp_arcmark_rect", [false]],
                                    ["COLOR", localize "str_a3_cfgvehicles_modulestrategicmapimage_f_arguments_color_0", [249/255, 248/255, 242/255]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_radius", "_rectangle", "_color"];
                                    _args params ["_pos"];
                                    [QGVAR(createAnomaly), [[_pos, _radius, _rectangle, 0, _color], "fog"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        case 6: { [QGVAR(createAnomaly), [[_pos], "fruitpunch"]] call CBA_fnc_serverEvent; };
                        case 7: { [QGVAR(createAnomaly), [[_pos], "psyDischarge"]] call CBA_fnc_globalEvent;};
                        case 8: {
                            [localize "STR_anomaly_clicker", [
                                    ["SLIDER:RADIUS", format ["%1 A", localize "str_a3_cfgvehicles_sign_radius_f0"], [1, 250, 10, 1, ASLToAGL _pos, [1, 0, 0, 1]]],
                                    ["SLIDER:RADIUS", format ["%1 B", localize "str_a3_cfgvehicles_sign_radius_f0"], [1, 250, 10, 1, ASLToAGL _pos, [0, 0, 1, 1]]],
                                    ["SLIDER", localize "str_a3_cfgvehicles_modulestrategicmapimage_f_arguments_height_0", [1, 250, 1, 1]],
                                    ["CHECKBOX", localize "str_disp_arcmark_rect", [false]],
                                    ["SLIDER", localize "str_a3_cfgvehicles_modulepositioning_f_arguments_rotation_0", [0, 359]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_radiusA", "_radiusB", "_height", "_rectangle", "_angle"];
                                    _args params ["_pos"];
                                    [QGVAR(createAnomaly), [[_pos, _radiusA, _radiusB, _rectangle, _angle, _height], "clicker"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        case 9: { [QGVAR(createAnomaly), [[_pos], "razor"]] call CBA_fnc_serverEvent; };
                        case 10: {
                            [localize "STR_anomaly_willowisp", [
                                    ["SLIDER", localize "str_a3_cfgvehicles_moduleanimals_f_arguments_count", [1, 20, 1, 0]],
                                    ["COLOR", localize "str_a3_cfgvehicles_modulestrategicmapimage_f_arguments_color_0", [random 1, random 1, random 1]],
                                    ["SLIDER:RADIUS", localize "STR_A3_TargetBootcampTable_maxdistance", [1, 100, 15, 1, ASLToAGL _pos, [1, 0, 0, 1]]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_count", "_color", "_spread"];
                                    _args params ["_pos"];
                                    [QGVAR(createAnomaly), [[_pos, _color, round _count, _spread], "willowisp"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        case 11: {
                            [localize "STR_anomaly_psy", [
                                    ["SLIDER", localize "STR_anomaly_psy_strength", [1, 3, 1, 0]],
                                    ["SLIDER:RADIUS", format ["%1 A", localize "str_a3_cfgvehicles_sign_radius_f0"], [1, 250, 10, 1, ASLToAGL _pos, [1, 0, 0, 1]]],
                                    ["SLIDER:RADIUS", format ["%1 B", localize "str_a3_cfgvehicles_sign_radius_f0"], [1, 250, 10, 1, ASLToAGL _pos, [0, 0, 1, 1]]],
                                    ["SLIDER", localize "str_a3_cfgvehicles_modulestrategicmapimage_f_arguments_height_0", [-1, 250, -1, 0]],
                                    ["CHECKBOX", localize "str_disp_arcmark_rect", [false]]
                                ],
                                {
                                    params ["_dialog", "_args"];
                                    _dialog params ["_strength", "_radiusA", "_radiusB", "_height", "_rectangle"];
                                    _args params ["_pos"];
                                    [QGVAR(createAnomaly), [[_pos, _strength, _radiusA, _radiusB, _rectangle, 0, _height], "psy"]] call CBA_fnc_serverEvent;
                                }, {}, [_pos]
                            ] call zen_dialog_fnc_create;
                        };
                        default { };
                    };
                }, {}, [_pos, _anomalies apply {_x select 0}]
            ] call zen_dialog_fnc_create;
        },
        QPATHTOF(data\ui\icon.paa)
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
                        ["CHECKBOX", [localize "STR_anomaly_zeus_start_blowout_only_players", localize "STR_anomaly_zeus_start_blowout_only_players_desc"], [true]],
                        ["CHECKBOX", [localize "STR_anomaly_zeus_start_blowout_is_lethal", localize "STR_anomaly_zeus_start_blowout_is_lethal_desc"], [true]],
                        ["CHECKBOX", [localize "STR_anomaly_zeus_start_blowout_env_particle_effect", localize "STR_anomaly_zeus_start_blowout_env_particle_effect_desc"], [true]]
                    ],
                    {
                        params ["_dialog"];
                        _dialog params ["_time", "_direction", "_useSirens", "_onlyPlayers", "_isLethal", "_environmentParticleEffects"];
                        [QGVAR(startBlowout), [floor _time, floor _direction, _useSirens, _onlyPlayers, _isLethal, _environmentParticleEffects]] call CBA_fnc_serverEvent;
                        [format [localize "STR_anomaly_zeus_start_blowout_hint", floor ((floor _time) / 60), (floor _time) mod 60]] call zen_common_fnc_showMessage;
                    }, {}, []
                ] call zen_dialog_fnc_create;
            };
        },
        QPATHTOF(data\ui\modules\blowout_ca.paa)
    ] call zen_custom_modules_fnc_register;
};
