/*
	Function: anomaly_fnc_setLight

	Description:
        Function which will be remoteExeced to set up lights
		Made, because when battle eye is enabled it does not allow remoteExec of light commands without cfgremoteexec entry

    Parameter:
        _light - Light
        _brightness - setLightBrightness params
        _color - setLightColor params
        _attenuation - setLightAttenuation params
        _ambient - setLightAmbient params
        _daylight - setLightDayLight params
        _flare - setLightUseFlare params

    Returns:
        nil

	Author:
	diwako 2018-08-08
*/
params["_light",["_brightness",1],["_color",[1,1,1]],["_attenuation",[1,1,1,1,1,1]],["_ambient",[1,1,1]],["_daylight",false],["_flare",false]];

_light setLightBrightness _brightness;
_light setLightAttenuation _attenuation;
_light setLightAmbient _ambient;
_light setLightColor _color;
_light setLightDayLight _daylight;
_light setLightUseFlare _flare;
nil