/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

#define CBA_SETTINGS_CAT localize "STR_anomaly_settings_name"

//Enable Diwako Anomalies:
[
	"diwako_anomalies_enable"
	,"CHECKBOX"
	,[(localize "STR_anomaly_settings_enable"),localize "STR_anomaly_settings_enable_desc"]
	,CBA_SETTINGS_CAT
	,false
	,true
] call CBA_Settings_fnc_init;

//Detection Range:
[
	"ANOMALY_DETECTION_RANGE"
	,"SLIDER"
	,[localize "STR_anomaly_settings_detectionRange", localize "STR_anomaly_settings_detectionRange_desc"]
	,CBA_SETTINGS_CAT
	,[10, 50, 20, 0]
	,true
] call CBA_Settings_fnc_init;

//Idle distance:
[
	"ANOMALY_IDLE_DISTANCE"
	,"SLIDER"
	,[localize "STR_anomaly_settings_particleDistance",localize "STR_anomaly_settings_particleDistance_desc"]
	,CBA_SETTINGS_CAT
	,[350, 700, 350, 0]
	,true
] call CBA_Settings_fnc_init;

//Trigger activation distance:
[
	"ANOMALY_TRIGGER_DISTANCE"
	,"SLIDER"
	,[localize "STR_anomaly_settings_triggerDistance",localize "STR_anomaly_settings_triggerDistance_desc"]
	,CBA_SETTINGS_CAT
	,[200, 500, 300, 0]
	,true
] call CBA_Settings_fnc_init;

//Detector Item:
[
	"ANOMALY_DETECTOR_ITEM"
	,"EDITBOX"
	,[localize "STR_anomaly_settings_detectorItem", localize "STR_anomaly_settings_detectorItem_desc"]
	,CBA_SETTINGS_CAT
	,"AnomalyDetector"
	,true
] call CBA_Settings_fnc_init;

/*
//Bolt Item:
[
	"ANOMALY_BOLT_ITEM"
	,"EDITBOX"
	,["Bolt Item", "Add classname of bolt item - required item to throw bolts, leave empty for no item - example: BagOfBolts"]
	,CBA_SETTINGS_CAT
	,"BagOfBolts"
	,true
] call CBA_Settings_fnc_init;
*/

//Enable Debugging:
[
	"ANOMALY_DEBUG"
	,"CHECKBOX"
	,[localize "STR_anomaly_settings_debug",localize "STR_anomaly_settings_debug_desc"]
	,CBA_SETTINGS_CAT
	,false
	,true
] call CBA_Settings_fnc_init;

//Set gasmask items:
[
	"ANOMALY_GAS_MASKS"
	,"EDITBOX"
	,[localize "STR_anomaly_settings_gasmasks",localize "STR_anomaly_settings_gasmasks_desc"]
	,CBA_SETTINGS_CAT
	,"GP5_RaspiratorPS,GP5Filter_RaspiratorPS,GP7_RaspiratorPS,GP21_GasmaskPS,SE_S10,G_Respirator_white_F,MASK_M40_OD,MASK_M40,MASK_M50"
	,true
] call CBA_Settings_fnc_init;

nil