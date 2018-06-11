/*
	Function: anomaly_fnc_deleteAnomalies

	Description:
        Deletes given anomalies. Can be called on server only!!

    Parameter:
        _anomalies - array containing anomaly triggers (default: [])

    Returns:
        nothing

	Author:
	diwako 2018-01-14
*/

if(!isServer) exitWith {};
params [["_anomalies",[]]];
_anomalies = if (typeName _anomalies != typeName []) then {[_anomalies]} else {_anomalies};
{
	if(!isNull _x) then {
		_type = _x getVariable ["anomaly_type", ""];
		if(!isNil "ANOMALY_DEBUG" && {ANOMALY_DEBUG}) then {
			deleteMarker str(getPos _x);
		};
		if(_type != "") then {
			[_x] remoteExec ["anomaly_fnc_deleteParticleSource"];
			deleteVehicle (_x getVariable ["anomaly_sound", objNull]);
			_trg2 = _x getVariable ["anomaly_idle_sound", objNull];
			if(!(isNull _trg2)) then {
				deleteVehicle (_trg2 getVariable ["anomaly_idle_sound", objNull]);
				deleteVehicle _trg2;
			};
			ANOMALIES_HOLDER = ANOMALIES_HOLDER - [_x];
			if(_type == "teleport") then {
				// handle teleport anomalies
				_id = _x getVariable "anomaly_teleport_id";
				_teleporters = [ANOMALY_TELEPORT_IDS, _id] call CBA_fnc_hashGet;
				for "_i" from 0 to ((count _teleporters) -1 ) do {
					if( (_teleporters select _i) == _x ) then {
						_teleporters = _teleporters - [_x];
					};
				};
				[ANOMALY_TELEPORT_IDS, _id, _teleporters] call CBA_fnc_hashSet;
			};

			if(_type == "fruitpunch") then {
				private _trg = _x;
				deleteVehicle (_trg getVariable ["light",objNull]);
				deleteVehicle (_trg getVariable ["field",objNull]);
				_x = _trg;
			};
			[_x] spawn {
				// wait for clients to delete particle source
				params ["_x"];
				sleep 0.5;
				deleteVehicle _x;
			};
		};
	};
} forEach _anomalies;
// publish updated arrays
// publicVariable "ANOMALIES_HOLDER";
publicVariable "ANOMALY_TELEPORT_IDS";
