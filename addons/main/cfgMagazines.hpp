class cfgMagazines {
    class HandGrenade_Stone;

    class bolts_infinite: HandGrenade_Stone {
        ammo = QGVAR(boltAmmo);
        scope = 2;
        count = 9999;
        mass = 20;
        descriptionShort = "$STR_anomaly_bolt_bag_desc";
        displayName = "$STR_anomaly_bolt_bag";
        displayNameShort = "$STR_anomaly_bolt_bag";
        model = "\A3\weapons_F\ammo\mag_univ.p3d";
        /*picture = "\diwako_anomalies\data\ui\bolts.paa";*/
        picture = "\A3\Weapons_f\data\ui\gear_satchel_CA.paa";
        author = "diwako";
    };

    class bolts_single: bolts_infinite {
        scope = 2;
        mass = 0;
        displayName = "$STR_anomaly_bolt";
        displayNameShort = "$STR_anomaly_bolt";
        descriptionShort = "$STR_anomaly_bolt_desc";
        // picture = "\diwako_anomalies\data\ui\bolts.paa";
        picture = QPATHTOF(data\ui\bolts.paa);
        // model = "\diwako_anomalies\data\models\bolt.p3d";
        model = QPATHTOF(data\models\bolt.p3d);
        count = 1;
        ammo = QGVAR(boltAmmo);
        author = "diwako";
    };
};
