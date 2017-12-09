params["_obj","_pos",["_intensity",1]];

_time = time + 10;

while {(alive _obj) && (time <= _time)} do {
	_pos2 = getpos _obj;
	_a = ((_pos select 0) - (_pos2 select 0));
	_b = ((_pos select 1) - (_pos2 select 1));
	_dir = [_a,_b] call CBA_fnc_vectDir;
	_obj setVelocity [_a * _intensity, _b * _intensity, 0.2];
};