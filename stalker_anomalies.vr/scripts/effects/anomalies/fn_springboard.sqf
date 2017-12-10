params[["_obj",objNull],["_source",objNull],["_state","idle"]];

if(isNull _obj || isNull _source) exitWith {};

switch (_state) do {
	case "idle": {
		_source setParticleCircle [2, [0, 0, 0]];
		_source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.5, [0, 0, 0, 0.1], 0, 0];
		_source setParticleParams [["\A3\data_f\cl_leaf", 1, 0, 1], "", "SpaceObject", 1, 7, [0, 0, 0], [0, 0, 0.5], 0, 10, 7.9, 0.075, [2, 2, 0.01], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [6, 5, 5], 1, 0, "", "", _obj];
		_source setDropInterval 0.2;
	};
	case "active": {
		_source setParticleCircle [0, [0, 0, 0]];
		_source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
		_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 2, 1, [0, 0, 1], [0, 0, 0], 0, 10, 7.9, 0.075, [0, 10, 5], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _obj];
		_source setDropInterval 0.05;
	};
	default { };
};