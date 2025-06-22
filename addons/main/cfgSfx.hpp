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
            QPATHTOF(sounds\anomalies\fire_idle.ogg), 2, 1, 50, 0.5, 0, 0, 0
        };
        fire_idle2[] = {
            QPATHTOF(sounds\anomalies\fire_idle2.ogg), 4, 1, 50, 0.5, 0, 0, 0
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
            QPATHTOF(sounds\anomalies\gravi_idle00.ogg), 2, 1, 50, 0.75, 5, 15, 25
        };
        gravi_idle01[] = {
            QPATHTOF(sounds\anomalies\gravi_idle01.ogg), 2, 1, 50, 0.75, 5, 15, 25
        };
        gravi_idle02[] = {
            QPATHTOF(sounds\anomalies\gravi_idle02.ogg), 8, 1, 50, 0.5, 0, 5, 10
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
    class GVAR(soundRazorFar): GVAR(base) {
        sounds[] = {
            "razor_far_idle_1",
            "razor_far_idle_2"
        };
        razor_far_idle_1[] = {
            QPATHTOF(sounds\anomalies\razor_far_idle_1.ogg), 1.5, 1, 50, 0.5, 0, 0, 0
        };
        razor_far_idle_2[] = {
            QPATHTOF(sounds\anomalies\razor_far_idle_2.ogg), 1.5, 1, 50, 0.5, 0, 0, 0
        };
    };
    class GVAR(soundRazorClose): GVAR(base) {
        sounds[] = {
            "razor_close_idle_1",
            "razor_close_idle_2",
            "razor_close_idle_3",
            "razor_close_idle_4",
            "razor_close_idle_5",
            "razor_close_idle_6",
            "razor_close_idle_7",
            "razor_close_idle_8",
            "razor_close_idle_9",
            "razor_close_idle_10",
            "razor_close_idle_11"
        };
        // {soundPath, soundVolume, soundPitch, maxDistance, probability, minDelay, midDelay, maxDelay}
        razor_close_idle_1[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_1.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_2[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_2.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_3[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_3.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_4[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_4.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_5[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_5.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_6[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_6.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_7[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_7.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_8[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_8.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_9[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_9.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_10[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_10.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
        razor_close_idle_11[] = {
            QPATHTOF(sounds\anomalies\razor_close_idle_11.ogg), 3, 1, 15, 0.09, 2, 5, 10
        };
    };
};
