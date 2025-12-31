#include "\z\diwako_anomalies\addons\main\script_component.hpp"

private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
private _pos = nil;
private _size = nil;
private _icon = nil;
private _range = GVAR(idleDistance) + 150;
{
    _pos = getPosASL _x;
    _size = linearConversion [_range, 50, _pos distance _camPos, 0, 1, true];
    _icon = switch (_x getVariable QGVAR(anomalyType)) do {
        case "meatgrinder": { QPATHTOF(data\ui\modules\meatgrinder_ca.paa) };
        case "springboard": { QPATHTOF(data\ui\modules\springboard_ca.paa) };
        case "burner": { QPATHTOF(data\ui\modules\burner_ca.paa) };
        case "teleport": { QPATHTOF(data\ui\modules\teleport_ca.paa) };
        case "fog": { QPATHTOF(data\ui\modules\fog_ca.paa) };
        case "electra": { QPATHTOF(data\ui\modules\electra_ca.paa) };
        case "fruitpunch": { QPATHTOF(data\ui\modules\fruitpunch_ca.paa) };
        case "comet": { QPATHTOF(data\ui\modules\comet_ca.paa) };
        case "clicker": { QPATHTOF(data\ui\modules\clicker_ca.paa) };
        case "razor": { QPATHTOF(data\ui\modules\razor_ca.paa) };
        case "willowisp": { QPATHTOF(data\ui\modules\willowisp_ca.paa) };
        default { "\A3\modules_f\data\portraitModule_ca.paa" };
    };
    drawIcon3D [_icon, [1, 1, 1, 1], ASLToAGL _pos, _size, _size, 0, "", true];
} forEach (GVAR(activeAnomalies) inAreaArray [_camPos, _range, _range, 0, false, -1]);
