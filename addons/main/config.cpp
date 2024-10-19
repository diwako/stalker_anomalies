#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(anomalyDetector),
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
