/*
Diwako Stalker Like Anomalies - added functions by Belbo
*/

if !(hasInterface) exitWith {};

private _unit = player;

if (isClass(configFile >> "CfgPatches" >> "ace_advanced_throwing")) then {

	["ace_firedPlayer", {
		params ["_unit","_weapon","_muzzle","_mode","_ammo","_mag","_projectile"];
		if ( _ammo == "bolt_ammo" ) then {
			if ( _mag == "bolts_infinite_mag" ) then {
				_unit addMagazine _mag;
				while { !( (currentThrowable player) select 0 == _mag ) } do {
					[_unit] call ace_weaponselect_fnc_selectNextGrenade;
				};
			};
			[_projectile] call anomaly_fnc_grenadeBolt;
		};
	}] call CBA_fnc_addEventHandler;

} else {

	player addEventhandler ["fired",{
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_mag", "_projectile"];
		if ( _ammo == "bolt_ammo" ) then {
			[_projectile] call anomaly_fnc_grenadeBolt;
		};
	}];
};

nil