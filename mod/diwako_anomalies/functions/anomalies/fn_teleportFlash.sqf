/*
    Function: anomaly_fnc_teleportFlash

    Description:
        flashes the screen when using a teleporter

    Parameter:

    Returns:
        nothing

    Author:
    diwako 2017-12-14
*/

if(!hasInterface) exitWith {};

// if(isNil "ANOMALY_TELEPORT_FLASH") then {
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
[] spawn {
    setApertureNew [1,1,1,1];
    sleep 0.5;
    setApertureNew [-1];
};