# Blowout Emission

A blowout, also known as an emission, is a map-wide event. All players experience it at the same time and it is almost fully synchronized across clients. A massive surge of psy energy is released, announced by harsh winds, thunderstorms, orange waves in the sky, and ultimately a wave-like energy burst that kills anyone not in shelter.

## Blowout Stages

A blowout consists of five distinct stages.

### Stage 0

This stage represents normal gameplay. Either no blowout is currently happening or one has just concluded. Nothing unusual is occurring, which is why this stage is referred to as stage zero.

### Stage 1

This is the warm-up stage, marking the beginning of a blowout. Environmental sounds fade, the world becomes eerily quiet, and is eventually followed by a groan and what sounds like an explosion in the air.  
This stage lasts 60 seconds.

### Stage 2

This is the holding stage, intended to give players time to reach a safe location. The duration of this stage is defined by the mission maker, Zeus, or the script that initiated the blowout.

During this stage, strong winds shake the trees, lightning bolts strike frequently, psy lines form across the horizon, and a constant background rumble can be heard.

### Stage 3

This stage lasts 30 seconds and is the final warning before the blowout fully strikes. Winds become extreme, lightning intensifies, and psy effects grow stronger. During this stage, the first psy wave appears. It does not kill or knock players unconscious, but serves as a clear warning that time is running out.

If you are not in a safe location by this point, you are in serious danger.

### Stage 4

This is the lethal stage where the deadly psy wave arrives. If the player is not in cover, they will first be thrown to the ground shortly before the wave hits. When the wave strikes, it kills instantly with no way to survive unless the player is in shelter.

There are additional options available for mission makers, which are described below.

## Starting a Blowout

### Zeus

The most common way to start a blowout is through the Zeus interface. To use this method, the mod [ZEN](https://steamcommunity.com/workshop/filedetails/?id=1779063631) must be enabled for the blowout module to appear in the Zeus modules tab.

### 3DEN Module

A dedicated module is available in the 3DEN Editor for starting a blowout. Be aware that the blowout will activate immediately unless the module is synchronized to a trigger.

By syncing the module to a trigger, activation can be delayed until the trigger conditions are met.

### Scripting

A coordinator function exists for controlling blowouts via script. This function is server-only and will not work if called on a non-server machine.

Function name:  
`diwako_anomalies_main_fnc_blowoutCoordinator`

Parameters:

| Index | Name                         | Description                                                                | Default |
| ----: | ---------------------------- | -------------------------------------------------------------------------- | ------- |
|     1 | \_time                       | Time until the deadly psy wave hits. Must be at least 102 or it will abort | 400     |
|     2 | \_direction                  | Direction the wave approaches, in bearing degrees                          | 0       |
|     3 | \_useSirens                  | Whether sirens should be audible                                           | true    |
|     4 | \_onlyPlayers                | If false, AI are also affected. May impact performance with many AI        | true    |
|     5 | \_isLethal                   | Whether the final wave is lethal                                           | true    |
|     6 | \_environmentParticleEffects | Enables wind-blown leaves, dust, and similar effects                       | true    |

There is also a CBA server event named `diwako_anomalies_main_startBlowout`. It forwards its parameters directly to the coordinator function, allowing you to avoid dealing with locality.

Example:

```sqf
["diwako_anomalies_main_startBlowout", [_time, _direction, _useSirens, _onlyPlayers, _isLethal, _environmentParticleEffects]] call CBA_fnc_serverEvent;
```

## How Is a Player Safe From a Blowout?

By default, when the psy wave hits, a check is performed to determine whether the affected unit is safe. There are two mechanisms used to determine safety.

### The Automatic Way

A basic check determines whether a unit is indoors using Arma’s vanilla `insideBuilding` command, which was introduced in Arma 3 version 2.12.

This command can be unreliable, as it depends on buildings being properly configured. As a result, some modded buildings may not be recognized as indoor spaces by the engine.

In Arma terms, being indoors is determined using sound shaders. If you have played Arma for a while, you may have noticed that gunfire sounds more echo-like when fired inside buildings. Properly configured buildings apply an indoor sound shader to units inside them.

The `insideBuilding` command checks for this shader to determine whether a unit is indoors. This approach is fast and efficient, as the engine already applies these shaders internally.

Additional ray casts are used to verify that a roof is present above the unit, preventing edge cases such as standing in a doorway from being considered safe.

The downside of this method is that not all buildings are considered safe. Relying solely on ray casts would be expensive and error-prone. For example, standing under a tree might be considered safe, random props could interfere with checks, large warehouses might fail due to distant walls, or broken roof windows could expose the player.

### The Mission Maker Way

The [Functions and Variables](functions_variables.md) section documents variables that mission makers can use to define custom safe areas.

The primary variable for this purpose is `blowout_safe`. When set on an object or unit, it marks that location as safe from blowouts.

This variable can be set using Zeus, triggers, or global events to designate safe zones anywhere on the map.

Example using a trigger:

Condition:
` this && (player in thisList)`

Activation:
`player setVariable ["blowout_safe", true];`

Deactivation:
` player setVariable ["blowout_safe", false];`
