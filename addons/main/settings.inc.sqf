/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

#define CBA_SETTINGS_CAT localize "STR_anomaly_settings_name"
#define SUB_CAT_GENERAL format ["1 - %1", localize "STR_anomaly_settings_generalSettingCategory"]
#define SUB_CAT_DETECTOR format ["2 - %1", localize "STR_anomaly_detector"]
#define SUB_CAT_ANOMALIES format ["3 - %1", localize "STR_anomaly_settings_anomalySettingCategory"]
#define SUB_CAT_PROCEDURAL format ["4 - %1", localize "STR_anomaly_settings_proceduralsettingcategory"]

//Enable Diwako Anomalies:
[
    QGVAR(enable)
    ,"CHECKBOX"
    ,[(localize "STR_anomaly_settings_enable"), localize "STR_anomaly_settings_enable_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
    ,true
    ,true
] call CBA_fnc_addSetting;

//Idle distance:
[
    QGVAR(idleDistance)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_particleDistance", localize "STR_anomaly_settings_particleDistance_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
    ,[350, 700, 350, 0]
    ,true
] call CBA_fnc_addSetting;

//Trigger activation distance:
[
    QGVAR(triggerDistance)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_triggerDistance", localize "STR_anomaly_settings_triggerDistance_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
    ,[200, 500, 300, 0]
    ,true
] call CBA_fnc_addSetting;

//Set gasmask items:
[
    QGVAR(gasMasksSetting)
    ,"EDITBOX"
    ,[localize "STR_anomaly_settings_gasmasks", localize "STR_anomaly_settings_gasmasks_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
    ,"G_AirPurifyingRespirator_02_black_F,G_AirPurifyingRespirator_02_olive_F,G_AirPurifyingRespirator_02_sand_F,G_AirPurifyingRespirator_01_F,G_RegulatorMask_F,GP5_RaspiratorPS,GP5Filter_RaspiratorPS,GP7_RaspiratorPS,GP21_GasmaskPS,SE_S10,G_Respirator_white_F,MASK_M40_OD,MASK_M40,MASK_M50"
    ,true
    ,{
        params ["_value"];
        GVAR(gasMasks) = _value splitString ",";
        {
            // set them upper case so we can use the "in" operator without any problems
            GVAR(gasMasks) set [_forEachIndex, toUpper(GVAR(gasMasks)#_forEachIndex)];
        } forEach GVAR(gasMasks);
    }
] call CBA_fnc_addSetting;

if (isClass(configFile >> "CfgPatches" >> "zen_common")) then {
    [
        QGVAR(zeusShowAnomalies)
        ,"CHECKBOX"
        ,[(localize "STR_anomaly_settings_zeus_show_anomalies"), localize "STR_anomaly_settings_zeus_show_anomalies_desc"]
        ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
        ,true
        ,false
    ] call CBA_fnc_addSetting;
} else {
    GVAR(zeusShowAnomalies) = false;
};

//Enable Debugging:
[
    QGVAR(debug)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_debug", localize "STR_anomaly_settings_debug_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
    ,false
    ,true
] call CBA_fnc_addSetting;

/* Detector specific settings */

//Detection Range:
[
    QGVAR(detectionRange)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_detectionRange", localize "STR_anomaly_settings_detectionRange_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_DETECTOR]
    ,[10, 50, 20, 0]
    ,true
] call CBA_fnc_addSetting;

//Detector Item:
[
    QGVAR(detectorItem)
    ,"EDITBOX"
    ,[localize "STR_anomaly_settings_detectorItem", localize "STR_anomaly_settings_detectorItem_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_DETECTOR]
    ,"AnomalyDetector"
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(detector3DSound)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_detector3DSound", localize "STR_anomaly_settings_detector3DSound_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_DETECTOR]
    ,false
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(detectorSensesCooldown)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_detectorSensesCooldown", localize "STR_anomaly_settings_detectorSensesCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_DETECTOR]
    ,false
    ,true
] call CBA_fnc_addSetting;

/* Anomaly specific settings */

[
    QGVAR(anomalySettingBurnerCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_burner"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 10, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingBurnerCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_burner"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 10, 1]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingElectraCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_electra"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 0.2, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingElectraCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_electra"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 2, 1]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingMeatgrinderCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_meatgrinder"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[MEATGRINDER_MIN_COOL_DOWN, 600, MEATGRINDER_MIN_COOL_DOWN+0.2, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingMeatgrinderCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_meatgrinder"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 5, 1]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingPsyRange)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_psyRange", localize "STR_anomaly_settings_psyRange_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[5, 200, 15, 0]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingSpringboardCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_springboard"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[SPRINGBOARD_MIN_COOL_DOWN, 600, SPRINGBOARD_MIN_COOL_DOWN+0.2, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingSpringboardCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_springboard"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 2, 1]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingTeleportCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_teleport"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[TELEPORT_MIN_COOL_DOWN, 600, TELEPORT_MIN_COOL_DOWN+2, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingTeleportCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_teleport"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 5, 1]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(anomalySettingClickerCooldownMin)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_minCooldown", localize "STR_anomaly_clicker"], localize "STR_anomaly_settings_minCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[CLICKER_MIN_COOL_DOWN, 600, 1, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(anomalySettingClickerCooldownRand)
    ,"SLIDER"
    ,[format ["%1 %2", localize "STR_anomaly_settings_randCooldown", localize "STR_anomaly_clicker"], localize "STR_anomaly_settings_randCooldown_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_ANOMALIES]
    ,[0, 600, 5, 1]
    ,true
] call CBA_fnc_addSetting;

/* Procedural anomaly spawning system */

[
    QGVAR(procedrualEnable)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_enable", localize "STR_anomaly_settings_proceduralEnable_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,false
    ,true
    ,nil
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(proceduralGridSize)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_procedural_gridSize", localize "STR_anomaly_settings_procedural_gridSize_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,[100, 5000, 500, 0]
    ,true
    ,nil
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(procedrualScanInterval)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_procedural_procedrualScanInterval", localize "STR_anomaly_settings_procedural_procedrualScanInterval_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,[1, 300, 10, 1]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(proceduralMaxAnomalyCount)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_procedural_proceduralMaxAnomalyCount", localize "STR_anomaly_settings_procedural_proceduralMaxAnomalyCount_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,[100, 2000, 800, 0]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(proceduralCountCoef)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_procedural_proceduralCountCoef", localize "STR_anomaly_settings_procedural_proceduralCountCoef_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,[0.01, 5, 1, 2]
    ,true
    ,nil
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(proceduralRangeCoef)
    ,"SLIDER"
    ,[localize "STR_anomaly_settings_procedural_proceduralRangeCoef", localize "STR_anomaly_settings_procedural_proceduralRangeCoef_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,[0.5, 5, 1, 2]
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(procedrualResetOnEmission)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_procedural_procedrualResetOnEmission", localize "STR_anomaly_settings_procedural_procedrualResetOnEmission_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,true
    ,true
] call CBA_fnc_addSetting;
[
    QGVAR(procedrualAllowOverPopulation)
    ,"CHECKBOX"
    ,[localize "STR_anomaly_settings_procedural_allowOverPopulation", localize "STR_anomaly_settings_procedural_allowOverPopulation_desc"]
    ,[CBA_SETTINGS_CAT, SUB_CAT_PROCEDURAL]
    ,true
    ,true
] call CBA_fnc_addSetting;
