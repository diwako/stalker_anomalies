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
            QPATHTOF(sounds\anomalies\fireball_idle.ogg), 2, 1, 50, 1, 0, 0, 0
        };
    };
    class GVAR(soundBurner): GVAR(base) {
        sounds[] = {
            "fire_idle",
            "fire_idle2"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        fire_idle[] = {
            QPATHTOF(sounds\anomalies\fire_idle.ogg), 2, 1, 50, 1, 0, 0, 0
        };
        fire_idle2[] = {
            QPATHTOF(sounds\anomalies\fire_idle2.ogg), 4, 1, 50, 1, 0, 0, 0
        };
    };
    class GVAR(soundElectra): GVAR(base) {
        sounds[] = {
            "electra_idle1"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        electra_idle1[] = {
            QPATHTOF(sounds\anomalies\electra_idle1.ogg), 2, 1, 100, 1, 0, 0, 0
        };
    };
    class GVAR(soundFruitpunch): GVAR(base) {
        sounds[] = {
            "buzz_idle"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        buzz_idle[] = {
            QPATHTOF(sounds\anomalies\buzz_idle.ogg), 2, 1, 25, 1, 0, 0, 0
        };
    };
    class GVAR(soundTeleport): GVAR(base) {
        sounds[] = {
            "teleport_idle"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        teleport_idle[] = {
            QPATHTOF(sounds\anomalies\teleport_idle.ogg), 2, 1, 25, 1, 0, 0, 0
        };
    };
    class GVAR(soundSpringboard): GVAR(base) {
        sounds[] = {
            "gravi_idle00",
            "gravi_idle01",
            "gravi_idle02"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        gravi_idle00[] = {
            QPATHTOF(sounds\anomalies\gravi_idle00.ogg), 2, 1, 50, 1, 5, 15, 25
        };
        gravi_idle01[] = {
            QPATHTOF(sounds\anomalies\gravi_idle01.ogg), 2, 1, 50, 1, 5, 15, 25
        };
        gravi_idle02[] = {
            QPATHTOF(sounds\anomalies\gravi_idle02.ogg), 8, 1, 50, 0.75, 0, 5, 10
        };
    };
    class GVAR(blowoutWave): GVAR(base) {
        sounds[] = {
            "blowout_particle_wave"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        blowout_particle_wave[] = {
            QPATHTOF(sounds\blowout\blowout_particle_wave.ogg), 20, 1, 2500, 1, 0, 0, 0
        };
    };
};
