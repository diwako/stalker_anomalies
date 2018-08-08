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
		picture = "\diwako_anomalies\data\ui\AnomalyDetector.paa";
		model = "\A3\Structures_F\Items\Tools\MultiMeter_F.p3d";
	};
	class BagOfBolts: CBA_MiscItem {
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 30;
		};
		scope = 1;
		displayName = "Bag of Bolts  (THIS ITEM IS DEPRECATED, DO NOT USE IT ANYMORE!)";
		descriptionShort = "Throw a bolt to check for anomalies";
		author = "[SeL] Belbo";
		picture = "\A3\Weapons_f\data\UI\gear_satchel_CA.paa";
	};

	class GrenadeLauncher;

	class Throw: GrenadeLauncher {
		class ThrowMuzzle;
		muzzles[] += {
			"Throw_Bolt"
			,"Throw_Bolt_lim"
		};
		class Throw_Bolt : ThrowMuzzle
		{
			magazinereloadtime = 0;
			magazines[] = {
				"bolts_infinite_mag"
			};
		};
		class Throw_Bolt_lim : ThrowMuzzle
		{
			magazinereloadtime = 0;
			magazines[] = {
				"bolts_one_mag"
			};
		};
	};
};