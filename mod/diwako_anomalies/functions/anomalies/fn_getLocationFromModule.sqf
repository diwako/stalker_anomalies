params["_locOrModule"];

if(typeName _locOrModule == typeName []) exitWith {
    // this is a location
    _locOrModule
};
private _pos = getPosATL _locOrModule;
// get rid of the now useless module!
deleteVehicle _locOrModule;
_pos