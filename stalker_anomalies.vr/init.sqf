enableSaving [false,false];
enableCamShake true;
setTerrainGrid 25;

[getMarkerPos "Springboard"] call anomaly_fnc_createSpringboard;
[getMarkerPos "Electra"] call anomaly_fnc_createElectra;
[getMarkerPos "Burner"] call anomaly_fnc_createBurner;
[getMarkerPos "Meatgrinder"] call anomaly_fnc_createMeatgrinder;
[getMarkerPos "Teleport_1",1] call anomaly_fnc_createTeleport;
[getMarkerPos "Teleport_2",1] call anomaly_fnc_createTeleport;

// [[7968,3922]] call anomaly_fnc_createMeatgrinder;
// [[7900,3922]] call anomaly_fnc_createMeatgrinder;

// [[7866,3920]] call anomaly_fnc_createElectra;
// [[7850,3920]] call anomaly_fnc_createElectra;
// [[7866,3920],1] call anomaly_fnc_createTeleport;
// [[7850,3920],1] call anomaly_fnc_createTeleport;
// [[7866,3920]] call anomaly_fnc_createBurner;
// [[7866,3920]] call anomaly_fnc_createSpringboard;
// [[7876,3920]] call anomaly_fnc_createSpringboard;
// [[7876,3920]] call anomaly_fnc_createMeatgrinder;

[] call anomaly_fnc_init;