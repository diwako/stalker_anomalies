class cfgAmmo {
    class GrenadeHand_stone;

    class GVAR(boltAmmo): GrenadeHand_stone
    {
        model = QPATHTOF(data\models\bolt.p3d);
        SoundSetExplosion[] = {""};
        explosive = 0;
        explosionEffectsRadius = 0;
        explosionSoundEffect = "";
        CraterWaterEffects = "";
		typicalspeed = 15;
        explosionType = "";
		deflecting = 1;
        deflectionSlowDown=0.05;
        timeToLive = 30;
        explosionTime = 35;
    };

    class B_50BW_Ball_F;
    class GVAR(quarryProjectile): B_50BW_Ball_F {
        // model = "\A3\data_f\ParticleEffects\Universal\Mud";
        hit = 30;
        indirectHit = 5;
        indirectHitRange = 3;
        bulletFly[] = {};
        class SuperSonicCrack {};
    };
};
