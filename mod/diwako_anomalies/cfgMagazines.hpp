class cfgMagazines {
    class HandGrenade_Stone;

    class bolts_infinite_mag : HandGrenade_Stone {
        ammo = "bolt_ammo";
        scope = 2;
        count = 9999;
        mass = 20;
        descriptionShort = "$STR_anomaly_bolt_bag_desc";
        displayName = "$STR_anomaly_bolt_bag";
        displayNameShort = "$STR_anomaly_bolt_bag";
        model = "\A3\weapons_F\ammo\mag_univ.p3d";
        /*picture = "\diwako_anomalies\data\ui\bolts.paa";*/
        picture = "\A3\Weapons_f\data\UI\gear_satchel_CA.paa";
        author = "diwako";
    };

    class bolts_one_mag : bolts_infinite_mag {
        scope = 2;
        mass = 1;
        displayName = "$STR_anomaly_bolt";
        displayNameShort = "$STR_anomaly_bolt";
        descriptionShort = "$STR_anomaly_bolt_desc";
        picture = "\diwako_anomalies\data\ui\bolts.paa";
        model = "\diwako_anomalies\data\models\bolt.p3d";
        count = 1;
        ammo = "bolt_ammo";
        author = "diwako";
    };
};