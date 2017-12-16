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
if(!hasInterface) exitWith {};

// minimmum distance to player to how idle particles
ANOMALY_IDLE_DISTANCE = 500;
ANOMALY_DETECTION_RANGE = 20;
ANOMALY_DETECTOR_ACTIVE = false;

ACTIVE_ANOMALIES = [];

enableCamShake true;
[] spawn {
	// respawn won't work with this, need better solution than {true}
	// while {alive player} do {
	while {true} do {
		FOUND_ANOMALIES = [];
		_pos = (positionCameraToWorld [0,0,0]);
		// find trigger
		{
			_type = _x getVariable ["anomaly_type", nil];
			// only accept triggers that are anomalies
			if(!(isNil "_type") && (_pos distance _x) <= ANOMALY_IDLE_DISTANCE) then {
				FOUND_ANOMALIES pushBackUnique _x;
				_source = _x getVariable ["anomaly_particle_source", objNull];
				if(isNull _source) then {
					// create idle effect
					private _proxy = "Land_HelipadEmpty_F" createVehicleLocal position _x;
					_proxy attachTo [_x, [0,0,0]];
					_source = "#particlesource" createVehicleLocal getPos _x;
					_arr = [_proxy, _source, "idle"];
					switch (_type) do {
						case "meatgrinder": {_arr call anomalyEffect_fnc_meatgrinder;};
						case "springboard": {_arr call anomalyEffect_fnc_springboard;};
						case "burner": 		{_arr call anomalyEffect_fnc_burner;};
						case "teleport": 		{_arr call anomalyEffect_fnc_teleport;};
						case "electra": 	{
							if(!(_x getVariable ["anomaly_cooldown", false])) then {
								_arr call anomalyEffect_fnc_electra;
							};
						};
						default { };
					};
					_x setVariable ["anomaly_particle_source", _proxy];
				};
			};
		} forEach ANOMALIES_HOLDER;
		// old detection, now not needed anymore
		// } forEach ( (positionCameraToWorld [0,0,0]) nearObjects ["EmptyDetector", ANOMALY_IDLE_DISTANCE]);
		_diff = ACTIVE_ANOMALIES - FOUND_ANOMALIES;
		{
			deleteVehicle (_x getVariable "anomaly_particle_source");
		} forEach _diff;
		ACTIVE_ANOMALIES = FOUND_ANOMALIES;
		sleep 5;
	};
};

if(!isNil "ace_interact_menu_fnc_createAction") then {
	_action = ["anomaly_detector","Enable anomaly detector","",{
		ANOMALY_DETECTOR_ACTIVE = true;
		[] call anomalyDetector_fnc_detector;
	},{!ANOMALY_DETECTOR_ACTIVE},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["anomaly_detector","Turn off anomaly detector","",{
		ANOMALY_DETECTOR_ACTIVE = false;
	},{ANOMALY_DETECTOR_ACTIVE},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
} else {
	player addAction ["Enable anomaly detector", {
		ANOMALY_DETECTOR_ACTIVE = true;
		[] call anomalyDetector_fnc_detector;
	},nil,0,false,true,"","!ANOMALY_DETECTOR_ACTIVE"];
	player addAction ["Enable anomaly detector", {
		ANOMALY_DETECTOR_ACTIVE = false;
	},nil,0,false,true,"","ANOMALY_DETECTOR_ACTIVE"];
};