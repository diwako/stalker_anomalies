# Editing Medical System Support

This mod has out of the box support for a few medical systems. That is Vanilla medical, [ACE3 Medical](https://steamcommunity.com/workshop/filedetails/?id=463939057) and [Armor Plates System](https://steamcommunity.com/sharedfiles/filedetails/?id=2523439183).

But if you want to add your own support for another medical system or just want to handle the damage done by most anomalies on your own, you can set this as a mission maker or mod maker on your own.

(or you can make a PR to support your mod medical system)

## Custom Medical (aka DIY) system

In order to implement your own damage handling you can set this mod to use a predefined custom function name.

First you will need to set the variable `diwako_anomalies_main_medicalSystem` to value `custom` any time after pre-init, then when ever an anomaly is to deal damage, the function named `anomaly_custom_fnc_addUnitDamage` will be called.

This function is undefined by default and you as a mission- or mod maker will need to implement this one.

The function will be given two parameters:
|Param Name| Type | Description|
|-|-|-|
|\_anomalyType|string|Which anomaly is dealing damage|
|\_unit|object| The unit which is to receive the damage|

`_anomalyType` will have one of these values:

- burner
- comet
- clicker
- electra
- fog
- fruitpunch
- razor
- springboard
- psydischarge
