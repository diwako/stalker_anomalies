class CfgPatches
{
    class diwako_anomalies
    {
        units[] = {
			"AnomalyDetector_Item"
			,"BagOfBolts_Item"
		};
        weapons[] = {
			"AnomalyDetector"
			,"BagOfBolts"
		};
        requiredVersion = 1.82;
        requiredAddons[] = {
			"cba_xeh"
			,"cba_common"
		};
		version = "1.9.1";
		versionStr = "1.9.1";
		author = "diwako";
		authorUrl = "https://github.com/diwako/stalker_anomalies";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

#include "cfgFunctions.hpp"
#include "cfgSounds.hpp"

class Extended_PreInit_EventHandlers {
	class anomaly_settings {
		init = "call anomaly_fnc_registerSettings";
	};
};

class cfgWeapons {
	class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;
	
	class AnomalyDetector: CBA_MiscItem {
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 10;
		};
		scope = 2;
		displayName = "Anomaly Detector";
		descriptionShort = "Enables detection of anomalies";
		author = "[SeL] Belbo";
		model = "\A3\Structures_F\Items\Tools\MultiMeter_F.p3d";
		picture = "\diwako_anomalies\Data\UI\AnomalyDetector.paa";
	};	
	class BagOfBolts: CBA_MiscItem {
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 30;
		};
		scope = 2;
		displayName = "Bag of bolts";
		descriptionShort = "Throw a bolt to check for anomalies";
		author = "[SeL] Belbo";
		picture = "\A3\Weapons_f\data\UI\gear_satchel_CA.paa";
	};
};

class cfgVehicles {
	class Item_Base_F;
	
	class AnomalyDetector_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Anomaly detector";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_MultiMeter_F.jpg";
        class TransportItems {
            MACRO_ADDITEM(AnomalyDetector,1);
        };
	};	
	class BagOfBolts_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Bag of Bolts";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\SatchelCharge_F.jpg";
        class TransportItems {
            MACRO_ADDITEM(BagOfBolts,1);
        };
	};	
};