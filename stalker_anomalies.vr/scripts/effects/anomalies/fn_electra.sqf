params[["_obj",objNull],["_source",objNull],["_state","idle"]];

if(isNull _obj || isNull _source) exitWith {};

switch (_state) do {
	case "idle": {
		_source setParticleCircle [2, [0, 0, 0]];
		_source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
		_source setParticleParams [["\A3\data_f\blesk1", 1, 0, 1], "", "SpaceObject", 1, 1, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0.005, [0.05, 0.05, 0.05], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _obj];
		_source setDropInterval 0.2;
	};
	default {};
};

