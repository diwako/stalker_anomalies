# Functions and Variables

While most anomaly-related functions are documented on the anomaly page, there are additional functions and variables that mission makers and scripters can use.

## Functions

### blowoutWave

Displays an approaching wave of psy energy used during the blowout event. The wave is non-damaging and purely visual. It is only shown on machines where this function is executed.

```
Function: diwako_anomalies_main_fnc_blowoutWave

Parameter:
    _time - Time in seconds until the wave reaches the player (default: 10)

Returns:
    nothing
```

### createAnomalyField

Helper function to create multiple anomalies within a specified area. Anomaly placement is randomized, but constrained to the area defined by the module.

Using this function, you can create four types of anomalies: springboards, burners, electras, and meatgrinders. If you need support for additional anomaly types, let me know.

This function is also available as a 3den editor module.

Must be executed on the server.

```
Function: diwako_anomalies_main_fnc_createAnomalyField

Parameter:
    _posParams - Array containing parameters for the function CBA_fnc_randPosArea. (default: [])
            See documentation here: http://cbateam.github.io/CBA_A3/docs/files/common/fnc_randPosArea-sqf.html
    _springboard - Number of springboard anomalies to create (default: 0)
    _burner - Number of burner anomalies to create (default: 0)
    _electra - Number of electra anomalies to create (default: 0)
    _meatgrinder - Number of meatgrinder anomalies to create (default: 0)

Returns:
    Array of all created anomalies
```

### createLocalLightningBolt

Displays a non-destructive, local-only lightning bolt at the given position. The effect uses the map’s configured thunder sounds.  
It is only visible on the machine where this function is executed.

```
Function: diwako_anomalies_main_fnc_createLocalLightningBolt

Parameters:
    _pos - PositionAGL. Can be left empty to display the effect randomly around the player (default: [])

Returns:
    nothing
```

### deleteAnomalies

Deletes anomalies and removes their effects for players. Valid anomalies can be obtained from the holder array `diwako_anomalies_main_holder`, or by checking whether a trigger has the variable `diwako_anomalies_main_anomalyType` set.

Must be executed on the server.

```
Function: diwako_anomalies_main_fnc_deleteAnomalies

Parameter:
    _anomalies - Array containing anomaly triggers (default: [])

Returns:
    nothing
```

### grenadeBolt

As mentioned on the bolt page, grenades have no effect on anomalies on their own when thrown. This function attaches the “balloon” object to the projectile to enable anomaly interaction.

The balloon object is automatically cleaned up after 10 seconds to prevent leftover objects.

Use this function if you want other projectiles to trigger anomalies as well.

Execute this function where the projectile is local. There is no locality check inside the function.

```
Function: diwako_anomalies_main_fnc_grenadeBolt

Parameters:
    _projectile - The thrown grenade, or any other projectile (no default value)

Returns:
    nothing
```

### hasItem

Checks whether a specific item exists in a unit’s inventory.

```
Function: diwako_anomalies_main_fnc_hasItem

Parameters:
    _unit - Unit to check. Defaults to the player if objNull is passed and the function is called on a client machine (default: objNull)
    _itemClass - Item class name to search for (default: "")

Returns:
    true or false, depending on whether the item is present or an empty string is given
```

### isInShelter

Checks whether the given unit is considered to be in shelter during a blowout.

```
Function: diwako_anomalies_main_fnc_isInShelter

Parameter:
    _unit - Unit to check for shelter status (default: objNull)

Returns:
    Boolean, true if the unit is considered safe
```

### minceCorpse

Want to see large fleshy chunks fly around? This function turns any object, organic or otherwise, into red paste and hides the body.

Must be executed on all machines. There is also a CBA event named `diwako_anomalies_main_minceCorpse` that uses the same parameters. For convenience, you can trigger it using `CBA_fnc_globalEvent`.

```
Function: diwako_anomalies_main_fnc_minceCorpse

Parameter:
    _body - Object that will be minced (default: objNull)

Returns:
    nothing
```

### psyEffect

Plays psy-related audio effects, applies a slight screen shake, and gradually tints the screen orange.

The function supports four strength levels ranging from 0 to 3. A strength of 0 disables the effect, while 3 represents the maximum intensity.

The ID passed to the function adds the psy effect to an internal pool. If the same ID is provided with a strength value of 0, the corresponding effect is removed. While multiple effects are active, the highest strength value in the pool is applied until the pool is empty.

```
Function: diwako_anomalies_main_fnc_psyEffect

Parameters:
    _strength - Integer representing the strength of the effect. 0 disables the effect, 3 is the maximum (default: 0)
    _id - String ID used to identify the source of the psy effect (default: "mission")

Returns:
    nothing
```

### showPsyWavesInSky

Displays orange psy wave lines in the sky. The effect takes two minutes to fully appear and five minutes to fully fade out.

```
Function: diwako_anomalies_main_fnc_showPsyWavesInSky

Parameter:
    _show - Boolean indicating whether to show the sky waves (default: false)

Returns:
    nothing
```

### bloodEffect

Displays a bloody screen effect, so real, ffor a specified duration. The function can be called multiple times, with the displayed time always updating to the highest value provided.  
This function only has a local effect.

```
Function: diwako_anomalies_main_fnc_bloodEffect

Parameters:
    _time - Duration of the bleeding effect in seconds. Example, could be 5 or 90.
            Can be called multiple times, the on-screen duration will update accordingly.

Returns:
    nothing
```

## Variables

### anomaly_ignore

Object namespace variable! \
`anomaly_ignore`

When zeusing, teleporting into your own placed anomalies might be a bit suboptimal. There is a variable you can set that most anomalies will leave you alone.

Simply set it to true and you are bueno. Just make sure that variable is synced as well. This variable will also ignore the bad effects of the blowout event and will exclude the player from checks in the procedural anomaly spawning system.

Examples: \
initPlayerLocal.sqf - `player setVariable ["anomaly_ignore", true, true];` \
3den init box - `this setVariable ["anomaly_ignore", true];`

### blowout_safe

Object namespace variable! \
`blowout_safe`

Extra object namespace variable for just the blowout event. It prevents being knocked over and killed by the blowout. Can be used to create your own little safe spaces in which players can take shelter in, in case the automatic check does not declare the hiding spot to be safe.

Does not need syncing to everyone else.

Examples: \
initPlayerLocal.sqf - `player setVariable ["blowout_safe", true];` \
3den init box - `this setVariable ["blowout_safe", true];`

### detectorActive

Mission namespace variable! \
`diwako_anomalies_main_detectorActive`

Variable to check if the anomaly detector is running. Right now, there is no CBA event when it is being turned on or off, not sure if that is needed.
When the variable is set to true, the detector is currently running, when it is set to false, then it is not running.

If you want to mess with your players, you can simply turn the detector off at random. Simply set the variable to false and the detector will shut down.

Turning on the detector via script is a bit trickier, but not hard.
First set the variable to true, then run the function `diwako_anomalies_main_fnc_detector` with no parameters on the target player machine.
