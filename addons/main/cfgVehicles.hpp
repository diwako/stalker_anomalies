class cfgVehicles {
    class Item_Base_F;

    class GVAR(anomalyDetector): Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_anomaly_detector";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
        // editorPreview = "\diwako_anomalies\data\ui\AnomalyDetector.jpg";
        editorPreview = QPATHTOF(data\ui\AnomalyDetector.jpg);
        class TransportItems {
            MACRO_ADDITEM(AnomalyDetector,1);
        };
    };

    class Land_Balloon_01_air_F;
    class GVAR(boltThrowDummy): Land_Balloon_01_air_F {
        scope = 1;
        scopeCurator = 1;
        hiddenSelectionsTextures[] = {""};
    };

    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;
            class EditMulti5;
            class Combo;
            class Checkbox;
            class ModuleDescription;
        };
        class ArgumentsBaseUnits {};
        class ModuleDescription {};
    };
    class Sound;

    class GVAR(moduleSpringboard): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_springboard";
        function = QFUNC(createSpringboard);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_springboard_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleElectra): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_electra";
        function = QFUNC(createElectra);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_electra_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleBurner): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_burner";
        function = QFUNC(createBurner);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_burner_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleMeatgrinder): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_meatgrinder";
        function = QFUNC(createMeatgrinder);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_meatgrinder_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleTeleport): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_teleport";
        function = QFUNC(createTeleport);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        // class Arguments {
        //     class anomalyId {
        //         displayName = "ID";
        //         description = "$STR_anomaly_teleport_id_desc";
        //         typeName = "NUMBER";
        //         defaultValue = 0;
        //     };
        // };
        class Attributes: AttributesBase {
            class anomalyId: Edit {
                displayName = "ID";
                tooltip = "$STR_anomaly_teleport_id_desc";
                property = QGVAR(teleport_id);
                defaultValue = "0";
            };

            class onEnterCode {
                control = "EditCodeMulti5";
                displayName = "On Enter Code";
                property = QGVAR(teleport_enterCode);
                tooltip = "$STR_anomaly_teleport_onEnter_desc";
                expression = "_this setVariable ['%s',_value,true];";
                typeName = "STRING";
                defaultValue = "";
            };

            class onExitCode {
                control = "EditCodeMulti5";
                displayName = "On Exit Code";
                property = QGVAR(teleport_exitCode);
                tooltip = "$STR_anomaly_teleport_onExit_desc";
                expression = "_this setVariable ['%s',_value,true];";
                typeName = "STRING";
                defaultValue = "";
            };
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_teleport_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleCreateAnomalyField): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_anomaly_field";
        function = QFUNC(createAnomalyField);
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        class AttributeValues {
            size3[] = {100, 100, -1};
            isRectangle = 0;
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_anomaly_field_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleCreateFog): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_fog";
        function = QFUNC(createFog);
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {
        };
        class AttributeValues {
            size3[] = {10, 10, -1};
            isRectangle = 0;
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

    class GVAR(moduleFruitPunch): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_fruitpunch";
        function = QFUNC(createFruitPunch);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_fruitpunch_desc";
            sync[] = {};
        };
    };

    class GVAR(modulePsyDischarge): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_psy_discharge";
        function = QFUNC(createPsyDischarge);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 1; //run on everyone
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Arguments {};
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_psy_discharge_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleComet): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_comet";
        function = QFUNC(createComet);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_comet_desc";
            sync[] = {};
        };
        class Arguments {
            class marker {
                displayName = "$STR_anomaly_comet_marker";
                description = "$STR_anomaly_comet_marker_desc";
				typeName="STRING";
				defaultValue="";
            };
            class speed {
                displayName = "$STR_anomaly_comet_speed";
                description = "$STR_anomaly_comet_speed_desc";
                typeName = "NUMBER";
                defaultValue = 6;
            };
            class smooth {
                displayName = "$STR_anomaly_comet_smooth";
                description = "$STR_anomaly_comet_smooth_desc";
                typeName = "BOOL";
                defaultValue = 1;
            };
        };
    };

    class GVAR(soundComet): Sound {
        author = "diwako";
        sound = QGVAR(soundComet);
    };
    class GVAR(soundBurner): GVAR(soundComet) {
        sound = QGVAR(soundBurner);
    };
    class GVAR(soundElectra): GVAR(soundComet) {
        sound = QGVAR(soundElectra);
    };
    class GVAR(soundFruitpunch): GVAR(soundComet) {
        sound = QGVAR(soundFruitpunch);
    };
    class GVAR(soundSpringboard): GVAR(soundComet) {
        sound = QGVAR(soundSpringboard);
    };
    class GVAR(soundTeleport): GVAR(soundComet) {
        sound = QGVAR(soundTeleport);
    };
};
