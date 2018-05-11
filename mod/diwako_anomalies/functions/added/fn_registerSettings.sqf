/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

#define CBA_SETTINGS_CAT "Diwako Stalker Like Anomalies"

//Enable Diwako Anomalies:
[
	"diwako_anomalies_enable"
	,"CHECKBOX"
	,["Enable","Enable/Disable Stalker Like Anomalies"]
	,CBA_SETTINGS_CAT
	,false
	,true
] call CBA_Settings_fnc_init;

//Detection Range:
[
	"ANOMALY_DETECTION_RANGE"
	,"SLIDER"
	,["Detection Range","Distance to nearest anomaly before detector starts to beep"]
	,CBA_SETTINGS_CAT
	,[10, 50, 20, 0]
	,true
] call CBA_Settings_fnc_init;

//Idle distance:
[
	"ANOMALY_IDLE_DISTANCE"
	,"SLIDER"
	,["Particle Idle Distance","Minimum distance to player for particles to idle"]
	,CBA_SETTINGS_CAT
	,[50, 500, 350, 0]
	,true
] call CBA_Settings_fnc_init;

//Detector Item:
[
	"ANOMALY_DETECTOR_ITEM"
	,"EDITBOX"
	,["Detector Item", "Add classname of detector item - required item to use detector, leave empty for no item - example: AnomalyDetector"]
	,CBA_SETTINGS_CAT
	,"AnomalyDetector"
	,true
] call CBA_Settings_fnc_init;

//Bolt Item:
[
	"ANOMALY_BOLT_ITEM"
	,"EDITBOX"
	,["Bolt Item", "Add classname of bolt item - required item to throw bolts, leave empty for no item - example: BagOfBolts"]
	,CBA_SETTINGS_CAT
	,"BagOfBolts"
	,true
] call CBA_Settings_fnc_init;

//Enable Debugging:
[
	"ANOMALY_DEBUG"
	,"CHECKBOX"
	,["Enable Debugging","Displays a marker were an anomaly has been placed."]
	,CBA_SETTINGS_CAT
	,false
	,true
] call CBA_Settings_fnc_init;

nil