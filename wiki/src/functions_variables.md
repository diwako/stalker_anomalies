# Functions and Variables

While the anomaly functions are inside the anomaly page, there are a few more functions and variables mission makers and scripters can utilize.

## Functions

### blowoutWave

Shows an approaching wave of psy energy used in the blowout event. The wave is none damaging, merely an effect. Wave is only shown on machines this function is run on.

```
Function: diwako_anomalies_main_fnc_blowoutWave

Parameter:
    _time - seconds when it makes contact with the player (default: 10)

Returns:
    nothing
```

### createAnomalyField

Helper function to create a bunch of anomalies in the specified area. The placement of the anomalies will be random, but within the given area of the module.

With this module you can create 4 types of anomalies, springboards, burners, electras and meatgrinders. If you need others supported, let me know!

This function is also available as module in 3den!

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createAnomalyField

Parameter:
    _posParams - array containing parameters for the function CBA_fnc_randPosArea, See dokumentation here:http://cbateam.github.io/CBA_A3/docs/files/common/fnc_randPosArea-sqf.html (default: [])
    _springboard    - how many anomalies of the type springboard should be created (default: 0)
    _burner         - how many anomalies of the type burner should be created (default: 0)
    _electra        - how many anomalies of the type electra should be created (default: 0)
    _meatgrinder    - how many anomalies of the type meatgrinder should be created (default: 0)

Returns:
    array of all crated anomalies
```

### createLocalLightningBolt

Shows a none destructive local only lightning bolt at given position. Uses the map's configured thunder sounds. \
Only appears on the machine this function is run on.

```
Function: diwako_anomalies_main_fnc_createLocalLightningBolt

Parameters:
    _pos - PositionAGL, can be left empty for effect to show randomly around the player (default: [])

Returns:
    nothing
```

### deleteAnomalies

Deletes anomalies and removes the effects for players. Valid anomalies can be found in the holder array named `diwako_anomalies_main_holder` or by checking if a trigger has set the variable named `diwako_anomalies_main_anomalyType`.

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_deleteAnomalies

Parameter:
    _anomalies - array containing anomaly triggers (default: [])

Returns:
    nothing
```

### grenadeBolt

As mentioned in the bolt page, grenades do not do anything on their own when thrown into an anomaly, this function attaches the “balloon” to the projectile to make the magic happen.

The function will automatically clean up the balloon object after 10 seconds so no litter will be produced.

Use this function if you want to make other projectiles trigger the anomalies.

Execute where the projectile is local, there is no local check inside this function!

```
Function: diwako_anomalies_main_fnc_grenadeBolt

Parameters:
    _projectile - the thrown grenade, or any other projectile, really (no default value!)

Returns:
    nothing
```

### hasItem

Function to check if an item exists in a player’s inventory.

```
Function: diwako_anomalies_main_fnc_hasItem

Parameters:
    _unit - Unit to check. will be player if variable is objNull and is called on a client machine (default: objNull)
    _itemClass - Itemclass to search for (default: "")

Returns:
    true or false, if item is in inventory or empty string is given
```

### isInShelter

Checks if the given unit is considered in shelter from a blowout.

```
Function: diwako_anomalies_main_fnc_isInShelter

Parameter:
    _unit - unit to check if in shelter (default: objNull)

Returns:
    boolean, true if safe
```

### minceCorpse

Want to see big fleshy bits fly around? This is the function for you! Turns any object, be it organic or otherwise, into red paste and hides the body.

Must be executed on all machines! There is however also the CBA event named `diwako_anomalies_main_minceCorpse` which takes the same parameters as the function, simply use `CBA_fnc_globalEvent` on that one for ease of use.

```
Function: diwako_anomalies_main_fnc_minceCorpse

Parameter:
    _body - Object that is about to be minced (default: objNull)

Returns:
    nothing
```

### psyEffect

Hear psy voices, shake the screen slightly and tint the screen increasingly orange.

Has 4 different strength settings ranging from 0 to 3. 0 being no effect and 3 being highest effect.

The ID given to the function add the psy effect to a pool. The effect with the matching ID will be removed if the ID and strength value of 0 is given. The psy effect will always draw the highest strength value from the pool until it is empty.

```
Function: diwako_anomalies_main_fnc_psyEffect

Parameters:
    _strength - Integer Number as strength of the effects, 0 for off and max of 3 for maximum effect (default: 0)
    _id - String ID to identify the source of the psy effect (default: "mission")

Returns:
    nothing
```

### showPsyWavesInSky

Shows orange psy lines in the sky. Takes two minutes to fully show, five minutes to fully disappear.

```
Function: diwako_anomalies_main_fnc_showPsyWavesInSky

Parameter:
    _show - boolean, show sky waves (default: false)

Returns:
    nothing
```

### bloodEffect

Shows a bloody screens, so real, for a given amount of seconds. Can be called multiple times, time to show will be updated to the highest value. \
This function has only local effect!

```
Function: diwako_anomalies_main_fnc_bloodEffect

Parameters:
    _time - Bleeding time in seconds, could be <5;90>
            Can be called multiple times, time for blood on screen will update

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
