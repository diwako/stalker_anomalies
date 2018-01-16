/*
	Function: anomaly_fnc_throwBolt

	Description:
        Makes given player perform a bolt throw.

    Parameter:
		_unit - Player that should perform the action
    Returns:
        nothing

	Author:
	diwako 2018-01-14
*/
params [["_unit",objNull]];

if(isNull _unit) exitWith {};
if(!local _unit) exitWith {[_unit] remoteExec ["anomaly_fnc_throwBolt", _unit]};
if(!isPlayer _unit) exitWith {};

if( (vehicle _unit) != _unit) exitWith {};

[_unit] spawn {
	params ["_unit"];
	_pos = getPosATL _unit;

	_direction = [0, 70, 500];
	_velocity = 18;

	_anims = [];
	_offset = 0;
	_curWeapon = currentWeapon _unit;
	_curWeaponType = 0;
	if(primaryWeapon _unit != "" && {primaryWeapon _unit == _curWeapon}) then {
		_curWeaponType = 1;
	};
	if(handgunWeapon _unit != "" && {handgunWeapon _unit == _curWeapon}) then {
		_curWeaponType = 2;
	};
	if(secondaryWeapon _unit != "" && {secondaryWeapon _unit == _curWeapon}) exitWith {
		hint "Cannot throw a bolt with a heavy weapon equipped";
	};
	
	switch (stance _unit) do {
		case "STAND": { 
			_anims = [
				["AwopPercMstpSgthWnonDnon_start", 0.833],
				["AwopPercMstpSgthWrflDnon_Start1", 1.575],
				["AwopPercMstpSgthWpstDnon_Part1", (0.533 + 1.709 + 0.505)]
			] select _curWeaponType;
			_offset = 1.8;
		};
		case "CROUCH": {
			_anims = [
				["AwopPknlMstpSgthWpstDnon_Part1", (0.533 + 1.709 + 0.505)],
				["AwopPknlMstpSgthWrflDnon_Start", 1.333],
				["AwopPknlMstpSgthWpstDnon_Part1", (0.533 + 1.709 + 0.505)]
			] select _curWeaponType;
			_offset = 1;
		};
		case "PRONE": {
			_anims = [
				["AwopPpneMstpSgthWnonDnon_start", 0.995],
				["AwopPpneMstpSgthWrflDnon_Start", 1.212],
				["AwopPpneMstpSgthWpstDnon_Part1", (0.784 + 1.5150 + 0.249)]
			] select _curWeaponType;
			_offset = 0.2;
		};
		default {};
	};
	if(count _anims == 0) exitWith {};
	_pos = [_pos select 0, _pos select 1, (_pos select 2) + _offset];

	_anims params ["_anim","_sleep"];
	[_unit,_anim] remoteExec ["playMove"];
	sleep _sleep;

	_obj = createVehicle ["WeaponHolderSimulated", _pos, [], 0, "CAN_COLLIDE"];
	_obj addMagazineAmmoCargo ["HandGrenade_Stone", 1, 30];

	// thanks ACE!
	private _p2 = (eyePos _unit) vectorAdd (AGLToASL (positionCameraToWorld _direction)) vectorDiff (AGLToASL (positionCameraToWorld [0, 0, 0]));
	private _p1 = AGLtoASL (_obj modelToWorldVisual [0, 0, 0]);

	private _newVelocity = (_p1 vectorFromTo _p2) vectorMultiply _velocity;
	_obj setVelocity _newVelocity;
	_obj addTorque [500 - random 1000, 500 - random 1000, 500 - random 1000];

	ANOMALY_BOLT_THROW_TIME = (time + 10);
	
	sleep 0.25;
	waitUntil {sleep 0.1; ( (velocity _obj select 0) == 0.0 && (velocity _obj select 1) == 0.0 ) };
	deleteVehicle _obj;
};