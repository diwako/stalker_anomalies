class cfgVehicles {
	class Item_Base_F;

	class AnomalyDetector_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Anomaly Detector";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		editorPreview = "\diwako_anomalies\data\ui\AnomalyDetector.jpg";
        class TransportItems {
            MACRO_ADDITEM(AnomalyDetector,1);
        };
	};
	class BagOfBolts_Item: Item_Base_F {
        scope = 1;
        scopeCurator = 1;
        displayName = "Bag of Bolts (THIS ITEM IS DEPRECATED, DO NOT USE IT ANYMORE!)";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\SatchelCharge_F.jpg";
        class TransportItems {
            MACRO_ADDITEM(BagOfBolts,1);
        };
	};

    class Land_Balloon_01_air_F;
    class bolt_throw_dummy: Land_Balloon_01_air_F {
        scope = 1;
        scopeCurator = 1;
        hiddenSelectionsTextures[] = {""};
    };
};