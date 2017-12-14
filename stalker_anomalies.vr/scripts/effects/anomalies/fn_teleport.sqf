params[["_obj",objNull],["_source",objNull],["_state","idle"]];

if(isNull _obj || isNull _source) exitWith {};

switch (_state) do {
	case "idle": {
		_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,    1,    [0,0,.4],[0,0,1],0,1,1,0,[.25,3,.25,0],[[1,1,1,1],[1,1,1,1]],[1.5,0.5],0,0,"","",_obj]; 
       _source setDropInterval .1; 
	};
	default { };
};