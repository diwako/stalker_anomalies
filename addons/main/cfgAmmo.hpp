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
        explosionType = "";
        timeToLive = 20;
        explosionTime = 25;
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
