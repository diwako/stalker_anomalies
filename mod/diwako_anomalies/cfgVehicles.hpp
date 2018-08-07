class cfgVehicles {
	class Item_Base_F;

	class AnomalyDetector_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_anomaly_detector";
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
        displayName = "$STR_anomaly_springboard";
        function = "anomaly_fnc_createSpringboard";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_springboard_desc";
            sync[] = {};
        };
    };
    
    class anoamly_moduleElectra: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_electra";
        function = "anomaly_fnc_createElectra";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_electra_desc";
            sync[] = {};
        };
    };
    
    class anoamly_moduleBurner: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_burner";
        function = "anomaly_fnc_createBurner";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_burner_desc";
            sync[] = {};
        };
    };

    class anoamly_moduleMeatgrinder: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_meatgrinder";
        function = "anomaly_fnc_createMeatgrinder";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_meatgrinder_desc";
            sync[] = {};
        };
    };

    class anoamly_moduleTeleport: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_teleport";
        function = "anomaly_fnc_createTeleport";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {
            class anomalyId {
                displayName = "ID";
                description = "$STR_anomaly_teleport_id_desc";
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_teleport_desc";
            sync[] = {};
        };
    };

    class anoamly_moduleCreateAnomalyField: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_anomaly_field";
        function = "anomaly_fnc_createAnomalyField";
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {
            class springboards {
                displayName = "$STR_anomaly_anomaly_field_spingboard";
                description = "$STR_anomaly_anomaly_field_spingboard_desc";
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class meatgrinders {
                displayName = "$STR_anomaly_anomaly_field_meatgrinder";
                description = "$STR_anomaly_anomaly_field_meatgrinder_desc";
                typeName = "NUMBER";
                defaultValue = 10;
            };
            class electras {
                displayName = "$STR_anomaly_anomaly_field_electra";
                description = "$STR_anomaly_anomaly_field_electra_desc";
                typeName = "NUMBER";
                defaultValue = 0;
            };
            class burners {
                displayName = "$STR_anomaly_anomaly_field_burner";
                description = "$STR_anomaly_anomaly_field_burner_desc";
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_anomaly_field_desc";
            sync[] = {};
        };
    };

    class anoamly_moduleCreateFog: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_fog";
        function = "anomaly_fnc_createFog";
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {
        };
        class ModuleDescription : ModuleDescription{
            description = "$STR_anomaly_fog_desc";
            sync[] = {"LocationArea_F"};
            class LocationArea_F {
                description[] = {
                    "$STR_anomaly_fog_desc2",
                    "$STR_anomaly_fog_desc3"
                };
                optional = 1;
                synced[] = {"Any"};
            };
        };
    };
	
	class anoamly_moduleFruitPunch: Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_fruitpunch";
        function = "anomaly_fnc_createFruitPunch";
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated  = 0; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_fruitpunch_desc";
            sync[] = {};
        };
    };
};