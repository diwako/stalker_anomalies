#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(anomalyDetector),
            QGVAR(moduleSpringboard),
            QGVAR(moduleElectra),
            QGVAR(moduleBurner),
            QGVAR(moduleMeatgrinder),
            QGVAR(moduleTeleport),
            QGVAR(moduleCreateAnomalyField),
            QGVAR(moduleCreateFog),
            QGVAR(moduleClicker),
            QGVAR(moduleFruitPunch),
            QGVAR(modulePsyDischarge),
            QGVAR(moduleComet),
            QGVAR(moduleWillowisp),
            QGVAR(moduleCreatePsy),
            QGVAR(moduleBlowout),
            QGVAR(moduleBlowoutSystem),
            QGVAR(moduleProceduralExclusion),
            QGVAR(moduleRazor),
            QGVAR(blocker)
        };
        weapons[] = {
            "AnomalyDetector"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_xeh",
            "cba_common"
        };
        author = "diwako";
        authorUrl = "https://github.com/diwako/stalker_anomalies";
        VERSION_CONFIG;
    };
};

#include "cfgEventHandlers.hpp"
#include "cfgFactionClasses.hpp"
#include "cfgSounds.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgWeapons.hpp"
#include "cfgVehicles.hpp"
#include "cfgSfx.hpp"
#include "cfgRSC.hpp"
#include "ZEN_cfgContext.hpp"
