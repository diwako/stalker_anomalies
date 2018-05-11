/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

if (!hasInterface) exitWith {};

private _enable = missionNamespace getVariable ["diwako_anomalies_enable",false];

if ( _enable && !(missionNamespace getVariable ["anomaly_var_init",false]) ) then {
	[] spawn {
		waitUntil {player == player};
		[] call anomaly_fnc_init;
	};
};