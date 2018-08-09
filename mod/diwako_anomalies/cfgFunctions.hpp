class cfgFunctions {
	class anomaly {
		tag="anomaly";
		class functions {
			file = "diwako_anomalies\functions\anomalies";
			class createSpringboard;
			class activateSpringboard;
			class createMeatgrinder;
			class activateMeatgrinder;
			class createElectra;
			class activateElectra;
			class createBurner;
			class activateBurner;
			class createTeleport;
			class activateTeleport;
			class teleportFlash;
			class minceCorpse;
			class suckToLocation;
			class init;
			class hasItem;
			class deleteParticleSource;
			class deleteAnomalies;
			class throwBolt;
			class createAnomalyField;
			class getLocationFromModule;
			class createFog;
			class activateFog;
			class createFruitPunch;
			class activateFruitPunch;
			class setTrigger;
			class setLight;
		};
	};
	class anomalyEffect {
		tag="anomalyEffect";
		class functions {
			file = "diwako_anomalies\functions\effects\anomalies";
			class springboard;
			class meatgrinder;
			class electra;
			class burner;
			class teleport;
			class fog;
			class fruitPunch;
		};
	};
	class anomalyDetector {
		tag="anomalyDetector";
		class functions{
			file = "diwako_anomalies\functions\detector";
			class detector;
		};
	};
	//functions added by Belbo:
	class added {
		tag="anomaly";
		class functions{
			file = "diwako_anomalies\functions\added";
			class autoInit {postInit = 1;};
			class throwEVH {postInit = 1;};
			class grenadeBolt;
			class registerSettings;
		};
	};
};