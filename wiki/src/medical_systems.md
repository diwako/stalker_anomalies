# Editing Medical System Support

This mod includes out-of-the-box support for several medical systems: Vanilla medical, [ACE3 Medical](https://steamcommunity.com/workshop/filedetails/?id=463939057), and the [Armor Plates System](https://steamcommunity.com/sharedfiles/filedetails/?id=2523439183).

If you want to add support for another medical system, or if you prefer to handle damage caused by most anomalies yourself, you can configure this as a mission maker or mod maker.

(Alternatively, you can submit a pull request to add support for your medical system.)

## Custom Medical (DIY) System

To implement your own damage handling, you can configure the mod to use a predefined custom function.

First, set the variable `diwako_anomalies_main_medicalSystem` to the value `custom` at any point after pre-init. Whenever an anomaly is about to deal damage, the function `anomaly_custom_fnc_addUnitDamage` will then be called.

This function is undefined by default and must be implemented by you as a mission maker or mod maker.

The function receives the following parameters:

| Param Name    | Type   | Description                             |
| ------------- | ------ | --------------------------------------- |
| \_anomalyType | string | The type of anomaly dealing the damage  |
| \_unit        | object | The unit that should receive the damage |

The `_anomalyType` parameter will have one of the following values:

- burner
- comet
- clicker
- electra
- fog
- fruitpunch
- razor
- springboard
- psydischarge
