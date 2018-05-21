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

    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits {};
        class ModuleDescription {};
    };

    class anoamly_moduleSpringboard: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Springboard";
        function = "anomaly_fnc_createSpringboard";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "Spawn a springboard anomaly at module location";
            sync[] = {};
        };
    };
    
    class anoamly_moduleElectra: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Electra";
        function = "anomaly_fnc_createElectra";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "Spawn an electra anomaly at module location";
            sync[] = {};
        };
    };
    
    class anoamly_moduleBurner: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Burner";
        function = "anomaly_fnc_createBurner";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "Spawn a burner anomaly at module location";
            sync[] = {};
        };
    };

    class anoamly_moduleMeatgrinder: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Meatgrinder";
        function = "anomaly_fnc_createMeatgrinder";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "Spawn a meatgrinder anomaly at module location";
            sync[] = {};
        };
    };

    class anoamly_moduleTeleport: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Teleporter";
        function = "anomaly_fnc_createTeleport";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {
            class anomalyId {
                displayName = "ID";
                description = "Teleporters need the same ID to work together. It is only allowed to have the same ID twice!";
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };
        class ModuleDescription: ModuleDescription {
            description = "Spawn a teleport anomaly at module location";
            sync[] = {};
        };
    };

    class anoamly_moduleCreateAnomalyField: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "Anomaly field";
        function = "anomaly_fnc_createAnomalyField";
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        functionPriority = 0;
        class Arguments {
            class springboards {
                displayName = "Springboards";
                description = "How many springboards shall be placed within the zone?";
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class meatgrinders {
                displayName = "Meatgrinderss";
                description = "How many meatgrinderss shall be placed within the zone?";
                typeName = "NUMBER";
                defaultValue = 10;
            };
            class electras {
                displayName = "Electras";
                description = "How many electras shall be placed within the zone?";
                typeName = "NUMBER";
                defaultValue = 0;
            };
            class burners {
                displayName = "Burners";
                description = "How many burners shall be placed within the zone?";
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };
        class ModuleDescription: ModuleDescription {
            description = "Spawn an anomaly field at module location";
            sync[] = {};
        };
    };
};