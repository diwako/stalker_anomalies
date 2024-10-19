#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_teleportFlash

    Description:
        flashes the screen when using a teleporter

    Parameter:

    Returns:
        nothing

    Author:
    diwako 2017-12-14
*/

if !(hasInterface) exitWith {};

// if (isNil "ANOMALY_TELEPORT_FLASH") then {
//     ANOMALY_TELEPORT_FLASH = ppEffectCreate ["colorCorrections", 1501];
// };
// ANOMALY_TELEPORT_FLASH ppEffectAdjust [
//         1.0, 1.0, 0.0,
//         [1.0, 1.0, 1.0, 1.0],
//         [0.0, 1.0, 1.0, 1.0],
//         [0.199, 0.587, 0.114, 0.0]
//         ];
// ANOMALY_TELEPORT_FLASH ppEffectCommit 0;
// ANOMALY_TELEPORT_FLASH ppEffectEnable true;
// ANOMALY_TELEPORT_FLASH ppEffectCommit 2;
// ANOMALY_TELEPORT_FLASH ppEffectAdjust [
//         1.0, 1.0, 0.0,
//         [1.0, 1.0, 1.0, 0.0],
//         [0.0, 1.0, 1.0, 1.0],
//         [0.199, 0.587, 0.114, 0.0]
//         ];

setApertureNew [1,1,1,1];
[{
    setApertureNew [-1];
}, nil, 0.5] call CBA_fnc_waitAndExecute;
