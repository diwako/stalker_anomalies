params[["_obj",objNull],["_source",objNull],["_state","idle"]];

if(isNull _obj || isNull _source) exitWith {};

switch (_state) do {
	case "idle": {
		_source setParticleCircle [3, [0, 0, 0]];
		_source setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
		_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0.25], 0, 10, 7.9, 0, [2, 2, 0.01], [[0.1, 0.1, 0.1, 0.5]], [0.08], 1, 0, "", "", _obj];
		_source setDropInterval 0.1;
	};
	case "active": {
		_source setParticleClass "ace_cookoff_CookOff";
	};
	default { };
};