class RscPicture;
class RscTitles {
    class GVAR(RscHealthTextures) {
        idd = -1;
        duration = 9.9999998e+10;
        fadein = 0;
        fadeout =  1;
        onload = QUOTE(with uiNamespace do { GVAR(RscHealthTextures)  =  _this select 0 };);
        class controls {
            class Blood_1: RscPicture {
                idc = 1211;
                text = "A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_lower_ca.paa";
                x = QUOTE(((0 * safeZoneW) + safeZoneX) + ((safeZoneW - (2.125 * safeZoneW * 3/4)) / 2));
                y = QUOTE((-0.0625 * safeZoneH) + safeZoneY);
                w = QUOTE(2.125 * safeZoneW * 3/4);
                h = QUOTE(1.125 * safeZoneH);
            };
            class Blood_2: Blood_1 {
                idc = 1212;
                text = "A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_middle_ca.paa";
            };
            class Blood_3: Blood_1 {
                idc = 1213;
                text = "A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_upper_ca.paa";
            };
            // class Dust_1: Blood_1 {
            //     idc = 1214;
            //     text = "A3\Ui_f\data\igui\rsctitles\HealthTextures\dust_lower_ca.paa";
            // };
            // class Dust_2: Blood_1 {
            //     idc = 1215;
            //     text = "A3\Ui_f\data\igui\rsctitles\HealthTextures\dust_upper_ca.paa";
            // };
        };
    };
};
