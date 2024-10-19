#include "\z\diwako_anomalies\addons\main\script_component.hpp"
params["_locOrModule"];

private _pos = switch (typeName _locOrModule) do {
    case "OBJECT": {
        getPosASL _locOrModule
    };
    case "GROUP": {
        getPosASL (leader _locOrModule)
    };
    case "STRING": {
        AGLToASL getMarkerPos _locOrModule
    };
    case "LOCATION": {
        AGLToASL position _locOrModule
    };
    case "TASK": {
        AGLToASL taskDestination _locOrModule
    };
    case "ARRAY": {
        if (_locOrModule isEqualTypeArray [grpNull, 0]) then {
            AGLToASL getWPPos _locOrModule
        } else {
            + _locOrModule
        };
    };
};

if (_locOrModule isEqualType objNull) then {
    deleteVehicle _locOrModule;
};
_pos
