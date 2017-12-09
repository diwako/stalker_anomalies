if(!hasInterface) exitWith {};

// minimmum distance to player to how idle particles
ANOMALY_IDLE_DISTANCE = 500;
ANOMALY_DETECTION_RANGE = 20;
ANOMALY_DETECTOR_ACTIVE = false;

ACTIVE_ANOMALIES = [];
[] spawn {
	// respawn won't work on this, need better solution then {true}
	while {alive player} do {
		FOUND_ANOMALIES = [];
		// find trigger
		{
			_type = _x getVariable ["anomaly_type", nil];
			// only accept triggers that are anomalies
			if(!(isNil "_type")) then {
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
						case "electra": 	{_arr call anomalyEffect_fnc_electra;};
						default { };
					};
					_x setVariable ["anomaly_particle_source", _proxy];
				};
			};
		} forEach (getpos player nearObjects ["EmptyDetector", ANOMALY_IDLE_DISTANCE]);
		_diff = ACTIVE_ANOMALIES - FOUND_ANOMALIES;
		{
			deleteVehicle (_x getVariable "anomaly_particle_source");
		} forEach _diff;
		ACTIVE_ANOMALIES = FOUND_ANOMALIES;
		sleep 10;
	};
};


_action = ["anomaly_detector","Enable anomaly detector","",{
	ANOMALY_DETECTOR_ACTIVE = true;
	[] call anomalyDetector_fnc_detector;
},{!ANOMALY_DETECTOR_ACTIVE},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

_action = ["anomaly_detector","Turn off anomaly detector","",{
	ANOMALY_DETECTOR_ACTIVE = false;
},{ANOMALY_DETECTOR_ACTIVE},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;