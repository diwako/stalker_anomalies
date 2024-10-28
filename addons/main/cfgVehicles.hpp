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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class anomalyId: Edit {
                displayName = "$STR_anomaly_teleport_id";
                tooltip = "$STR_anomaly_teleport_id_desc";
                typeName = "NUMBER";
                validate = "number";
                property = QGVAR(moduleTeleport_anomalyId);
                defaultValue = 0;
            };
            class ModuleDescription: ModuleDescription {};
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
        class Attributes: AttributesBase {
            class springboards: Edit {
                displayName = "$STR_anomaly_anomaly_field_spingboard";
                tooltip = "$STR_anomaly_anomaly_field_spingboard_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 20;
                property = QGVAR(moduleCreateAnomalyField_springboards);
            };
            class meatgrinders: Edit {
                displayName = "$STR_anomaly_anomaly_field_meatgrinder";
                tooltip = "$STR_anomaly_anomaly_field_meatgrinder_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 10;
                property = QGVAR(moduleCreateAnomalyField_meatgrinders);
            };
            class electras: Edit {
                displayName = "$STR_anomaly_anomaly_field_electra";
                tooltip = "$STR_anomaly_anomaly_field_electra_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 0;
                property = QGVAR(moduleCreateAnomalyField_electras);
            };
            class burners: Edit {
                displayName = "$STR_anomaly_anomaly_field_burner";
                tooltip = "$STR_anomaly_anomaly_field_burner_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 0;
                property = QGVAR(moduleCreateAnomalyField_burners);
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
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
        class Attributes: AttributesBase {
            class marker: Edit {
                displayName = "$STR_anomaly_comet_marker";
                tooltip = "$STR_anomaly_comet_marker_desc";
                typeName = "STRING";
                defaultValue = "";
                property = QGVAR(moduleComet_marker);
            };
            class speed: Edit {
                displayName = "$STR_anomaly_comet_speed";
                tooltip = "$STR_anomaly_comet_speed_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 6;
                property = QGVAR(moduleComet_speed);
            };
            class smooth: Checkbox {
                displayName = "$STR_anomaly_comet_smooth";
                tooltip = "$STR_anomaly_comet_smooth_desc";
                typeName = "BOOL";
                defaultValue = 1;
                property = QGVAR(moduleComet_smooth);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_comet_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleBlowout): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_blowout";
        function = QFUNC(blowoutCoordinator);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        //icon = QPATHTOF(UI\Icon_Module_Make_Unit_Handcuffed_ca.paa);
        class Attributes: AttributesBase {
            class wavetime: Edit {
                displayName = "$STR_anomaly_zeus_start_blowout_time";
                tooltip = "$STR_anomaly_zeus_start_blowout_time_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 400;
                property = QGVAR(wavetime);
            };
            class direction: Edit {
                displayName = "$STR_anomaly_zeus_start_blowout_direction";
                tooltip = "$STR_anomaly_zeus_start_blowout_direction_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 0;
                property = QGVAR(direction);
            };
            class sirens: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_sirens";
                tooltip = "$STR_anomaly_zeus_start_blowout_sirens_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(sirens);
            };
            class onlyPlayers: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_only_players";
                tooltip = "$STR_anomaly_zeus_start_blowout_only_players_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(onlyPlayers);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_blowout_desc";
            sync[] = {};
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
    class GVAR(blowoutWave): GVAR(soundComet) {
        sound = QGVAR(blowoutWave);
    };
};
