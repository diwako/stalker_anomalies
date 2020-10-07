class CfgPatches
{
    class diwako_anomalies
    {
        units[] = {
            "AnomalyDetector_Item",
            "BagOfBolts_Item"
        };
        weapons[] = {
            "AnomalyDetector",
            "BagOfBolts"
        };
        requiredVersion = 1.98;
        requiredAddons[] = {
            "cba_xeh",
            "cba_common"
        };
        version = "1.16";
        versionStr = "1.16";
        author = "diwako";
        authorUrl = "https://github.com/diwako/stalker_anomalies";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}
class Extended_PreInit_EventHandlers {
    class anomaly_settings {
        init = "call anomaly_fnc_registerSettings";
    };
};

#include "cfgFactionClasses.hpp"
#include "cfgFunctions.hpp"
#include "cfgSounds.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgWeapons.hpp"
#include "cfgVehicles.hpp"