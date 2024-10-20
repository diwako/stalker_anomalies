class cfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class AnomalyDetector: CBA_MiscItem {
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 10;
        };
        scope = 2;
        displayName = "$STR_anomaly_detector";
        descriptionShort = "$STR_anomaly_detector_desc";
        author = "[SeL] Belbo";
        picture = QPATHTOF(data\ui\AnomalyDetector.paa);
        model = "\A3\Structures_F\Items\Tools\MultiMeter_F.p3d";
        ACE_isTool = 1;
    };

    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        class ThrowMuzzle;
        muzzles[] += {
            QGVAR(throwBolt),
            QGVAR(throwBoltLim)
        };
        class GVAR(throwBolt): ThrowMuzzle
        {
            magazinereloadtime = 0;
            magazines[] = {
                "bolts_infinite"
            };
        };
        class GVAR(throwBoltLim): ThrowMuzzle
        {
            magazinereloadtime = 0;
            magazines[] = {
                "bolts_single"
            };
        };
    };
};
