class CfgSFX {
    class GVAR(base) {
        sounds[] = {};
        empty[] = {
            "", 0, 0, 0, 0, 0, 0, 0
        };
    };
    class GVAR(soundComet): GVAR(base) {
        sounds[] = {
            "fire"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        fire[] = {
            QPATHTOF(sounds\anomalies\fireball_idle.ogg), 2, 1, 50, 1, 1, 1, 0
        };
    };
};
