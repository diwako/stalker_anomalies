/*
	Function: anomaly_fnc_init

	Description:
        Initialises the use of anomalies in the mission, called form init.sqf!

    Parameter:

    Returns:
        nothing

	Author:
	diwako 2017-12-11
*/

if(missionNamespace getVariable ["anomaly_var_init",false]) exitWith {};
missionNamespace setVariable ["anomaly_var_init",true];

if(isServer && isMultiplayer) then {
	// publish PFH which publishes all anomalies each 5 seconds
	[{
		params ["_args", "_pfhHandle"];
		_args params ["_transmitted"];
		private _count = count ANOMALIES_HOLDER;
		// systemChat format["%1 to %2", _count, _transmitted];
		if(_count != _transmitted) then {
			// systemChat "SYNC!";
			publicVariable "ANOMALIES_HOLDER";
			_args set [0, _count];
		};
	}, 5, [0] ] call CBA_fnc_addPerFrameHandler;
};

if(!hasInterface) exitWith {};

// if true, displays a marker were anomaly has been placed.
ANOMALY_DEBUG = false;

// minimmum distance to player to how idle particles
ANOMALY_IDLE_DISTANCE = 350;
// distance to nearest anomaly detector starts to beep
ANOMALY_DETECTION_RANGE = 20;
// required item to use detector, leave empty for no item
ANOMALY_DETECTOR_ITEM = "";
// required item to be able to throw bolts, leave empty for no item
ANOMALY_BOLT_ITEM = "";
// enter item google classes which function as gasmasks
ANOMALY_GAS_MASKS = ["GP5_RaspiratorPS","GP5Filter_RaspiratorPS","GP7_RaspiratorPS","GP21_GasmaskPS","SE_S10","G_Respirator_white_F","MASK_M40_OD","MASK_M40","MASK_M50"];

/*== DO NOT EDIT Below unless you know what you are doing! ==*/
ACTIVE_ANOMALIES = [];
ANOMALY_DETECTOR_ACTIVE = false;
ANOMALY_BOLT_THROW_TIME = (time - 1);

enableCamShake true;
if(isNil "ANOMALIES_HOLDER") then {
	ANOMALIES_HOLDER = [];
};

[{
	// params ["_args", "_pfhHandle"]; //maybe needed for later
	FOUND_ANOMALIES = [];
	_pos = (positionCameraToWorld [0,0,0]);

	// find trigger
	{
		_type = _x getVariable ["anomaly_type", nil];
		// only accept triggers that are anomalies
		if(!(isNil "_type") && (_pos distance _x) <= ANOMALY_IDLE_DISTANCE) then {
			FOUND_ANOMALIES pushBackUnique _x;
			private _source = _x getVariable ["anomaly_particle_source", objNull];
			if(isNull _source) then {
				// create idle effect
				private _proxy = "Land_HelipadEmpty_F" createVehicleLocal position _x;
				_proxy enableSimulation false;
				_proxy setPos (_x modelToWorld [0,0,0]);
				_source = "#particlesource" createVehicleLocal getPos _x;
				_source setPosATL (getPosATL _x);
				// _source enableSimulation false;
				_arr = [_proxy, _source, "idle"];
				switch (_type) do {
					case "meatgrinder": {_arr call anomalyEffect_fnc_meatgrinder;};
					case "springboard": {_arr call anomalyEffect_fnc_springboard;};
					case "burner": 		{_arr call anomalyEffect_fnc_burner;};
					case "teleport": 	{_arr call anomalyEffect_fnc_teleport;};
					case "fog": 		{_arr call anomalyEffect_fnc_fog;};
					case "electra": 	{
						if(!(_x getVariable ["anomaly_cooldown", false])) then {
							_arr call anomalyEffect_fnc_electra;
						} else {
							deleteVehicle _proxy;
						};
					};
					case "fruitpunch": 	{_arr call anomalyEffect_fnc_fruitPunch;};
					default { };
				};
				_x setVariable ["anomaly_particle_source", _proxy];
			};
		};
		false
	} count ANOMALIES_HOLDER;

	_diff = ACTIVE_ANOMALIES - FOUND_ANOMALIES;
	{
		deleteVehicle (_x getVariable "anomaly_particle_source");
		false
	} count _diff;
	ACTIVE_ANOMALIES = FOUND_ANOMALIES;
}, 5, [] ] call CBA_fnc_addPerFrameHandler;

if(!isNil "ace_interact_menu_fnc_createAction") then {
	_action = ["anomaly_detector","Enable anomaly detector","",{
		ANOMALY_DETECTOR_ACTIVE = true;
		[] call anomalyDetector_fnc_detector;
	},{!ANOMALY_DETECTOR_ACTIVE && [player, ANOMALY_DETECTOR_ITEM] call anomaly_fnc_hasItem},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["anomaly_detector","Turn off anomaly detector","",{
		ANOMALY_DETECTOR_ACTIVE = false;
	},{ANOMALY_DETECTOR_ACTIVE},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

	if ! (isClass(configFile >> "CfgPatches" >> "diwako_anomalies")) then {
		_action = ["throw_bolt","Throw a bolt","",{
			[player] call anomaly_fnc_throwBolt;
		},{ANOMALY_BOLT_THROW_TIME < time && [player, ANOMALY_BOLT_ITEM] call anomaly_fnc_hasItem},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

		[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
	};
	
} else {
	[["Enable anomaly detector", {
		ANOMALY_DETECTOR_ACTIVE = true;
		[] call anomalyDetector_fnc_detector;
	},nil,0,false,true,"","!ANOMALY_DETECTOR_ACTIVE  && [_target, ANOMALY_DETECTOR_ITEM] call anomaly_fnc_hasItem && alive _target"]] call CBA_fnc_addPlayerAction;
	[["Disable anomaly detector", {
		ANOMALY_DETECTOR_ACTIVE = false;
	},nil,0,false,true,"","ANOMALY_DETECTOR_ACTIVE"]]  call CBA_fnc_addPlayerAction;
	if !(isClass(configFile >> "CfgPatches" >> "diwako_anomalies")) then {
		[["Throw a bolt", {
			[player] call anomaly_fnc_throwBolt;
		},nil,0,false,true,"","ANOMALY_BOLT_THROW_TIME < time && [_target, ANOMALY_BOLT_ITEM] call anomaly_fnc_hasItem && alive _target"]] call CBA_fnc_addPlayerAction;
	};
};

// add Ares modules for zeus
if(!isNil "Ares_fnc_RegisterCustomModule") then {
	["Stalker Anomalies", "Spawn Anomaly", 
		{
			_pos = _this select 0;
			private _anomalies = ["Burner","Electra","Meatgrinder","Springboard","Teleport","Fog","Fruit Punch"];

			private _dialogResult =
			[
				"Spawn anomaly",
				[
					["Anomaly", _anomalies]
				]
			] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith {};

			_dialogResult params ["_type"];

			switch (_type) do {
				case 0: { [_pos] remoteExec ["anomaly_fnc_createBurner",2] };
				case 1: { [_pos] remoteExec ["anomaly_fnc_createElectra",2] };
				case 2: { [_pos] remoteExec ["anomaly_fnc_createMeatgrinder",2] };
				case 3: { [_pos] remoteExec ["anomaly_fnc_createSpringboard",2] };
				case 4: {
					private _dialogResult =
					[
						"Teleport ID (Number)",
						[
							["ID", "NUMBER"]
						]
					] call Ares_fnc_ShowChooseDialog;
					if (count _dialogResult == 0) exitWith {};
					_dialogResult params ["_id"];
					_id = parseNumber _id;
					[_pos,_id] remoteExec ["anomaly_fnc_createTeleport",2] 
				};
				case 5: {
					private _dialogResult =
					[
						"Create fog anomaly",
						[
							["Radius", "NUMBER"],
							["Rectangle", ["Yes","no"]]
						]
					] call Ares_fnc_ShowChooseDialog;
					if (count _dialogResult == 0) exitWith {};
					_dialogResult params ["_radius","_rectangle"];
					_radius = parseNumber _radius;
					[_pos,_radius,(_rectangle == 0)] remoteExec ["anomaly_fnc_createFog",2] 
				};
				case 6: { [_pos] remoteExec ["anomaly_fnc_createFruitPunch",2] };
				default { };
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	["Stalker Anomalies", "Delete Anomalies", 
		{
			_pos = _this select 0;
			private _radius = ["1","5","10","100","250"];

			private _dialogResult =
			[
				"Delete anomalies",
				[
					["Radius", _radius]
				]
			] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith {};
			_dialogResult params ["_selected"];
			
			_radius = parseNumber (_radius select _selected);
			_trigs = _pos nearObjects ["EmptyDetector", _radius];
			[_trigs] remoteExec ["anomaly_fnc_deleteAnomalies",2];
		}
	] call Ares_fnc_RegisterCustomModule;
};

if(typeName ANOMALY_GAS_MASKS == typeName "") then {
	ANOMALY_GAS_MASKS = ANOMALY_GAS_MASKS splitString ",";
};

{
	// set them upper case so we can use the "in" operator without any problems
	ANOMALY_GAS_MASKS set[_forEachIndex,toUpper(ANOMALY_GAS_MASKS#_forEachIndex)];
} forEach ANOMALY_GAS_MASKS;
