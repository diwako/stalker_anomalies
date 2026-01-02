// anomalies
SUBPREP(anomalies,createSpringboard);
SUBPREP(anomalies,activateSpringboard);
SUBPREP(anomalies,createMeatgrinder);
SUBPREP(anomalies,activateMeatgrinder);
SUBPREP(anomalies,createElectra);
SUBPREP(anomalies,activateElectra);
SUBPREP(anomalies,createBurner);
SUBPREP(anomalies,activateBurner);
SUBPREP(anomalies,createTeleport);
SUBPREP(anomalies,activateTeleport);
SUBPREP(anomalies,teleportFlash);
SUBPREP(anomalies,minceCorpse);
SUBPREP(anomalies,suckToLocation);
SUBPREP(anomalies,hasItem);
SUBPREP(anomalies,deleteParticleSource);
SUBPREP(anomalies,deleteAnomalies);
SUBPREP(anomalies,createAnomalyField);
SUBPREP(anomalies,getLocationFromModule);
SUBPREP(anomalies,createFog);
SUBPREP(anomalies,activateFog);
SUBPREP(anomalies,createFruitPunch);
SUBPREP(anomalies,activateFruitPunch);
SUBPREP(anomalies,setTrigger);
SUBPREP(anomalies,setLight);
SUBPREP(anomalies,createPsyDischarge);
SUBPREP(anomalies,createComet);
SUBPREP(anomalies,movementTick);
SUBPREP(anomalies,createCometLocal);
SUBPREP(anomalies,activateComet);
SUBPREP(anomalies,createClicker);
SUBPREP(anomalies,activateClicker);
SUBPREP(anomalies,createRazor);
SUBPREP(anomalies,activateRazor);
SUBPREP(anomalies,createWillowisp);
SUBPREP(anomalies,createPsyField);
SUBPREP(anomalies,findAndDeleteAnomalies);

SUBPREP(anomalies,addUnitDamage);

// effects
SUBPREP(effects,springboardEffect);
SUBPREP(effects,meatgrinderEffect);
SUBPREP(effects,electraEffect);
SUBPREP(effects,burnerEffect);
SUBPREP(effects,teleportEffect);
SUBPREP(effects,fogEffect);
SUBPREP(effects,fruitPunchEffect);
SUBPREP(effects,razorEffect);
SUBPREP(effects,blockerEffect);
SUBPREP(effects,bloodEffect);
SUBPREP(effects,willowispEffect);

// detector
SUBPREP(detector,detector);

// bolt
SUBPREP(bolt,grenadeBolt);

// blowout
if (isServer) then {
    SUBPREP(blowout,blowout);
    SUBPREP(blowout,blowoutCoordinator);
    SUBPREP(blowout,blowoutSystem);
};

SUBPREP(blowout,blowoutRumble);
SUBPREP(blowout,blowoutSirens);
SUBPREP(blowout,blowoutWave);
SUBPREP(blowout,chromatic);
SUBPREP(blowout,createLocalLightningBolt);
SUBPREP(blowout,psyEffect);
SUBPREP(blowout,showPsyWavesInSky);
SUBPREP(blowout,isInShelter);

// zeus
SUBPREP(zeus,zeusDraw3D);

// procedural anomaly fields
if (isServer) then {
    SUBPREP(procedural,proceduralInit);
    SUBPREP(procedural,proceduralLoop);
    SUBPREP(procedural,proceduralActivateCell);
    SUBPREP(procedural,proceduralExclusionModule);
};

// event handler
SUBPREP(eventHandler,blockerHitPart);

// ZEN context menu
SUBPREP(contextMenu,setIgnore);
SUBPREP(contextMenu,showOptionIgnore);
