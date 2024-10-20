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
};
