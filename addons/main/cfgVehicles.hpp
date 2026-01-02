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
            // class Default;
            class Edit;
            // class EditMulti5;
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
        icon=QPATHTOF(data\ui\modules\springboard_ca.paa);
        portrait=QPATHTOF(data\ui\modules\springboard_ca.paa);
        function = QFUNC(createSpringboard);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\electra_ca.paa);
        portrait=QPATHTOF(data\ui\modules\electra_ca.paa);
        function = QFUNC(createElectra);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\burner_ca.paa);
        portrait=QPATHTOF(data\ui\modules\burner_ca.paa);
        function = QFUNC(createBurner);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\meatgrinder_ca.paa);
        portrait=QPATHTOF(data\ui\modules\meatgrinder_ca.paa);
        function = QFUNC(createMeatgrinder);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\teleport_ca.paa);
        portrait=QPATHTOF(data\ui\modules\teleport_ca.paa);
        function = QFUNC(createTeleport);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\fog_ca.paa);
        portrait=QPATHTOF(data\ui\modules\fog_ca.paa);
        function = QFUNC(createFog);
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 0;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        class Attributes: AttributesBase {
            class color: Combo {
                displayName="$STR_A3_CfgVehicles_ModuleCuratorAddIcon_F_Arguments_Color";
                tooltip = "";
                typeName = "STRING";
                property = QGVAR(color);
                defaultValue="ColorWhite";
                class Values {
                    class ColorWhite {
                        name="$STR_CFG_MARKERCOL_WHITE";
                        value="ColorWhite";
                        default=1;
                    };
                    class ColorYellow {
                        name="$STR_CFG_MARKERCOL_YELLOW";
                        value="ColorYellow";
                    };
                    class ColorOrange {
                        name="$STR_CFG_MARKERCOL_ORANGE";
                        value="ColorOrange";
                    };
                    class ColorRed {
                        name="$STR_CFG_MARKERCOL_RED";
                        value="ColorRed";
                    };
                    class ColorPink {
                        name="$STR_A3_CfgMarkerColors_ColorPink_0";
                        value="ColorPink";
                    };
                    class ColorBlue {
                        name="$STR_CFG_MARKERCOL_BLUE";
                        value="ColorBlue";
                    };
                    class ColorKhaki {
                        name="$STR_A3_CfgMarkerColors_ColorKhaki_0";
                        value="ColorKhaki";
                    };
                    class ColorGreen {
                        name="$STR_CFG_MARKERCOL_GREEN";
                        value="ColorGreen";
                    };
                    class ColorBrown {
                        name="$STR_A3_CfgMarkerColors_ColorBrown_0";
                        value="ColorBrown";
                    };
                    class ColorGrey {
                        name="$STR_A3_CfgMarkerColors_ColorGrey_0";
                        value="ColorGrey";
                    };
                    class ColorBlack {
                        name="$STR_CFG_MARKERCOL_BLACK";
                        value="ColorBlack";
                    };
                };
            };
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

    class GVAR(moduleClicker): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_clicker";
        icon=QPATHTOF(data\ui\modules\clicker_ca.paa);
        portrait=QPATHTOF(data\ui\modules\clicker_ca.paa);
        function = QFUNC(createClicker);
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 1;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
        class AttributeValues {
            size3[] = {10, 10, 8};
            isRectangle = 0;
        };
        class ModuleDescription : ModuleDescription{
            description = "$STR_anomaly_clicker_desc";
            direction = 1;
            sync[] = {"LocationArea_F"};
            class LocationArea_F {
                optional = 1;
                synced[] = {"Any"};
            };
        };
    };

    class GVAR(moduleFruitPunch): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_fruitpunch";
        icon=QPATHTOF(data\ui\modules\fruitpunch_ca.paa);
        portrait=QPATHTOF(data\ui\modules\fruitpunch_ca.paa);
        function = QFUNC(createFruitPunch);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\psydischarge_ca.paa);
        portrait=QPATHTOF(data\ui\modules\psydischarge_ca.paa);
        function = QFUNC(createPsyDischarge);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 1; //run on everyone
        isTriggerActivated = 1; //Wait for triggers
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
        icon=QPATHTOF(data\ui\modules\comet_ca.paa);
        portrait=QPATHTOF(data\ui\modules\comet_ca.paa);
        function = QFUNC(createComet);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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

    class GVAR(moduleWillowisp): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_willowisp";
        icon=QPATHTOF(data\ui\modules\willowisp_ca.paa);
        portrait=QPATHTOF(data\ui\modules\willowisp_ca.paa);
        function = QFUNC(createWillowisp);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        class Attributes: AttributesBase {
            class color: Combo {
                displayName="$STR_A3_CfgVehicles_ModuleCuratorAddIcon_F_Arguments_Color";
                tooltip = "";
                typeName = "STRING";
                property = QGVAR(color);
                defaultValue="randomColor";
                class Values {
                    class randomColor {
                        name="$STR_A3_RSCDISPLAYARSENAL_BUTTONRANDOM";
                        value="randomColor";
                        default=1;
                    };
                    class ColorWhite {
                        name="$STR_CFG_MARKERCOL_WHITE";
                        value="ColorWhite";
                    };
                    class ColorYellow {
                        name="$STR_CFG_MARKERCOL_YELLOW";
                        value="ColorYellow";
                    };
                    class ColorOrange {
                        name="$STR_CFG_MARKERCOL_ORANGE";
                        value="ColorOrange";
                    };
                    class ColorRed {
                        name="$STR_CFG_MARKERCOL_RED";
                        value="ColorRed";
                    };
                    class ColorPink {
                        name="$STR_A3_CfgMarkerColors_ColorPink_0";
                        value="ColorPink";
                    };
                    class ColorBlue {
                        name="$STR_CFG_MARKERCOL_BLUE";
                        value="ColorBlue";
                    };
                    class ColorKhaki {
                        name="$STR_A3_CfgMarkerColors_ColorKhaki_0";
                        value="ColorKhaki";
                    };
                    class ColorGreen {
                        name="$STR_CFG_MARKERCOL_GREEN";
                        value="ColorGreen";
                    };
                    class ColorBrown {
                        name="$STR_A3_CfgMarkerColors_ColorBrown_0";
                        value="ColorBrown";
                    };
                    class ColorGrey {
                        name="$STR_A3_CfgMarkerColors_ColorGrey_0";
                        value="ColorGrey";
                    };
                    class ColorBlack {
                        name="$STR_CFG_MARKERCOL_BLACK";
                        value="ColorBlack";
                    };
                };
            };
            class count: Edit {
                displayName = "$STR_a3_cfgvehicles_moduleanimals_f_arguments_count";
                tooltip = "";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 1;
                property = QGVAR(count);
            };
            class spread: Edit {
                displayName = "$STR_A3_TargetBootcampTable_maxdistance";
                tooltip = "";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 15;
                property = QGVAR(spread);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_willowisp_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleCreatePsy): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_psy";
        icon = QPATHTOF(data\ui\modules\psy_ca.paa);
        portrait = QPATHTOF(data\ui\modules\psy_ca.paa);
        function = QFUNC(createPsyField);
        functionPriority = 1;
        canSetArea = 1;
        canSetAreaHeight = 1;
        canSetAreaShape = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        class Attributes: AttributesBase {
            class strength: Edit {
                displayName = "$STR_anomaly_psy_strength";
                tooltip = "$STR_anomaly_psy_strength_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 1;
                property = QGVAR(strength);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class AttributeValues {
            size3[] = {10, 10, -1};
            isRectangle = 0;
        };
        class ModuleDescription : ModuleDescription{
            description = "$STR_anomaly_psy_desc";
            sync[] = {"LocationArea_F"};
            class LocationArea_F {
                description[] = {};
                optional = 1;
                synced[] = {"Any"};
            };
        };
    };

    class GVAR(moduleBlowout): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_blowout";
        icon=QPATHTOF(data\ui\modules\blowout_ca.paa);
        portrait=QPATHTOF(data\ui\modules\blowout_ca.paa);
        function = QFUNC(blowoutCoordinator);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
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
            class isLethal: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_is_lethal";
                tooltip = "$STR_anomaly_zeus_start_blowout_is_lethal_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(isLethal);
            };
            class environmentParticleEffects: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_env_particle_effect";
                tooltip = "$STR_anomaly_zeus_start_blowout_env_particle_effect_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(environmentParticleEffects);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_blowout_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleBlowoutSystem): GVAR(moduleBlowout) {
        displayName = "$STR_anomaly_blowoutSystem";
        function = QFUNC(blowoutSystem);

        class Attributes: AttributesBase {
            class minimalDelay: Edit {
                displayName = "$STR_anomaly_blowoutSystem_minimumDelay";
                tooltip = "$STR_anomaly_blowoutSystem_minimumDelay_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 30;
                property = QGVAR(minimalDelay);
            };
            class maximumDelay: Edit {
                displayName = "$STR_anomaly_blowoutSystem_maximumDelay";
                tooltip = "$STR_anomaly_blowoutSystem_maximumDelay_desc";
                typeName = "NUMBER";
                validate = "number";
                defaultValue = 60;
                property = QGVAR(maximumDelay);
            };
            class condition: Edit {
                displayName = "$STR_a3_modules_modulepatrolarea_f_attributes_condition0";
                tooltip = "$STR_anomaly_blowoutSystem_condition_desc";
                defaultValue = """true""";
                typeName = "STRING";
                property = QGVAR(condition);
                control = "EditCodeMulti3";
            };

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
            class isLethal: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_is_lethal";
                tooltip = "$STR_anomaly_zeus_start_blowout_is_lethal_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(isLethal);
            };
            class environmentParticleEffects: Checkbox {
                displayName = "$STR_anomaly_zeus_start_blowout_env_particle_effect";
                tooltip = "$STR_anomaly_zeus_start_blowout_env_particle_effect_desc";
                defaultValue = "true";
                typeName = "BOOL";
                property = QGVAR(environmentParticleEffects);
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_blowoutSystem_desc";
            sync[] = {};
        };
    };

    class GVAR(moduleProceduralExclusion): Module_F {
       author = "diwako";
       category = "DIW_ANOMALY";
       displayName = "$STR_anomaly_procedural_exclusion";
       function = QFUNC(proceduralExclusionModule);
       functionPriority = 1;
       canSetArea = 1;
       canSetAreaHeight = 0;
       canSetAreaShape = 1;
       scope = 2;  //show in editor
       isGlobal = 0; //run on server
       class Attributes: AttributesBase {
              class ModuleDescription: ModuleDescription {};
       };
       class AttributeValues {
              size3[] = {100, 100, -1};
              isRectangle = 0;
       };
       class ModuleDescription: ModuleDescription {
              description = "$STR_anomaly_procedural_exclusion_desc";
              sync[] = {};
       };
    };
    class GVAR(moduleRazor): Module_F {
        author = "diwako";
        category = "DIW_ANOMALY";
        displayName = "$STR_anomaly_razor";
        icon = QPATHTOF(data\ui\modules\razor_ca.paa);
        portrait = QPATHTOF(data\ui\modules\razor_ca.paa);
        function = QFUNC(createRazor);
        functionPriority = 1;
        scope = 2;  //show in editor
        isGlobal = 0; //run on server
        isTriggerActivated = 1; //Wait for triggers
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = "$STR_anomaly_razor_desc";
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
    class GVAR(soundRazorFar): GVAR(soundComet) {
        sound = QGVAR(soundRazorFar);
    };
    class GVAR(soundRazorClose): GVAR(soundComet) {
        sound = QGVAR(soundRazorClose);
    };

    class ProtectionZone_F;
    class GVAR(blocker): ProtectionZone_F {
        scope = 2;
        displayName = "Projectile Blocker";
        author = "Luca";
        model = QPATHTOF(data\models\blocker.p3d);
        class EventHandlers {
            class ADDON {
                HandleDamage = "0";
                HitPart = QUOTE(call FUNC(blockerHitPart));
            };
        };
    };
};
