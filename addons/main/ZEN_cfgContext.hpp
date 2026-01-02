class ZEN_context_menu_actions {
    class ADDON {
        displayName = "$STR_anomaly_category";
        condition = "missionNamespace getVariable [""diwako_anomalies_main_enable"", false]";
        priority = 3;
        icon = QPATHTOF(data\ui\modules\blowout_ca.paa);
        class ignoreAnomalies {
            displayName = "$STR_anomaly_contextMenu_setIgnore";
            statement = QUOTE([ARR_2(_objects,_args)] call FUNC(setIgnore));
            condition = QUOTE((_objects isNotEqualTo [] || _groups isNotEqualTo []) && {[ARR_2(_objects,_args)] call FUNC(showOptionIgnore)});
            icon = "\x\zen\addons\context_actions\ui\add_ca.paa";
            args = 1;
        };
        class unignoreAnomalies: ignoreAnomalies {
            displayName = "$STR_anomaly_contextMenu_setUnignore";
            icon = "\x\zen\addons\context_actions\ui\remove_ca.paa";
            args = 0;
        };
        class deleteAnomalies {
            displayName = "$STR_anomaly_zeus_delete_anomalies";
            condition = QUOTE(_objects isEqualTo [] && _groups isEqualTo []);
            icon = QPATHTOF(data\ui\modules\blowout_ca.paa);
            class delete10m {
                displayName = "$STR_ZEN_Context_Actions_10m";
                condition = "true";
                icon = "\x\zen\addons\context_actions\ui\remove_ca.paa";
                statement = QUOTE([ARR_2(_position,_args)] call FUNC(findAndDeleteAnomalies));
                args = 10;
            };
            class delete25m: delete10m {
                displayName = "$STR_anomaly_contextMenu_Context_Actions_25m";
                args = 25;
            };
            class delete50m: delete10m {
                displayName = "$STR_ZEN_Context_Actions_50m";
                args = 50;
            };
            class delete100m: delete10m {
                displayName = "$STR_ZEN_Context_Actions_100m";
                args = 100;
            };
            class delete250m: delete10m {
                displayName = "$STR_ZEN_Context_Actions_250m";
                args = 250;
            };
        };
    };
};
