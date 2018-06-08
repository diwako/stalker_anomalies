/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

private _enable = missionNamespace getVariable ["diwako_anomalies_enable",false];

if ( _enable && !(missionNamespace getVariable ["anomaly_var_init",false]) ) then {
	if(isDedicated) then {
		[] call anomaly_fnc_init;
	} else {
		[] spawn {
			waitUntil {player == player};
			[] call anomaly_fnc_init;
		};
	};
};
