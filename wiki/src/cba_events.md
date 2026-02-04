# CBA Events for Mission Makers

Starting with version **2.1.0**, the mod exposes several CBA events that mission makers can hook into for custom scripting.

All anomaly-related events are prefixed with:

`diwako_anomalies_main_`

## Anomaly Events

These events are fired whenever an anomaly interacts with an object or unit.

### burnerOnDamage

Triggered whenever an object or unit is damaged or killed by a **Burner** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_burnerOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Burner anomaly trigger

### clickerOnDamage

Triggered whenever an object or unit is flashbanged by a **Clicker** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_clickerOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or affected
2. `_trg` - Clicker anomaly trigger

### cometOnDamage

Triggered whenever a **Comet** anomaly burns an object or unit.

- **Locality:** Where the affected object is local
- **Event name:** `diwako_anomalies_main_cometOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Comet anomaly trigger

### electraOnDamage

Triggered whenever an object or unit is damaged or killed by an **Electra** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_electraOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Electra anomaly trigger

### fogOnDamage

Triggered whenever an object or unit takes suffocation damage from a **Fog** anomaly.

- **Locality:** Where the affected object is local
- **Event name:** `diwako_anomalies_main_fogOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Fog anomaly trigger

### fruitpunchOnDamage

Triggered whenever an object or unit is damaged or killed by a **Fruit Punch** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_fruitpunchOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Fruit Punch anomaly trigger

### meatgrinderOnDamage

Triggered whenever an object or unit is ripped apart (or damaged, in the case of vehicles) by a **Meatgrinder** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_meatgrinderOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Meatgrinder anomaly trigger

### psyFieldOnEnter

Triggered whenever a player controlled unit enters a **Psy Field** anomaly.

- **Locality:** Where the affected unit is local
- **Event name:** `diwako_anomalies_main_psyFieldOnEnter`

**Parameters**

1. `_trg` - Psy field anomaly trigger
2. `_strength` - Strength of the psy field
3. `_psyID` - ID used in the psyIDMap

Note: If you want the current applied psy strength you can use this snippet to get the highest current value. This might be from a psy field, an emission, or scripted behaviour.

```sqf
private _strength = selectMax values diwako_anomalies_main_psyIDMap;
if (isNil "_strength") then {
    _strength = 0;
};
```

### psyFieldOnLeave

Triggered whenever a player controlled unit leaves a **Psy Field** anomaly.

- **Locality:** Where the affected unit is local
- **Event name:** `diwako_anomalies_main_psyFieldOnLeave`

**Parameters**

1. `_trg` - Psy field anomaly trigger
2. `_strength` - Strength of the psy field
3. `_psyID` - ID used in the psyIDMap

### razorOnDamage

Triggered whenever an object or unit is cut by a **Razor** anomaly.

- **Locality:** Where the affected object is local
- **Event name:** `diwako_anomalies_main_razorOnDamage`

**Parameters**

1. `_obj` - Object that was cut
2. `_trg` - Razor anomaly trigger

### springboardOnDamage

Triggered whenever an object or unit is flung or killed by a **Springboard** anomaly.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_springboardOnDamage`

**Parameters**

1. `_obj` - Object that was damaged or killed
2. `_trg` - Springboard anomaly trigger

### teleportOnEnter

Triggered when an object or unit is about to be teleported.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_teleportOnEnter`

**Parameters**

1. `_obj` - Object that is about to be teleported
2. `_trg` - Entrance teleport trigger
3. `_exit` - Exit teleport trigger

### teleportOnExit

Triggered after an object or unit has been teleported.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_teleportOnExit`

**Parameters**

1. `_obj` - Object that was teleported
2. `_trg` - Entrance teleport trigger
3. `_exit` - Exit teleport trigger

## Blowout Events

Blowouts are map-wide events. The following CBA events allow mission makers to react to or extend blowout behavior.

### blowOutStage

Fired whenever the blowout enters a new stage.  
Mission makers can listen to this event to trigger additional effects or logic.

- **Locality:** Global
- **Event name:** `diwako_anomalies_main_blowOutStage`

**Parameters**

1. `_stage` - Integer representing the newly entered stage
2. `_args` - Additional arguments (used only by Stage 1)

### Blowout Stages

#### Stage 0 - Idle

No blowout active. Normal gameplay.  
This stage is also fired after a blowout concludes.

#### Stage 1 - Warm-up

Lasts **60 seconds**.  
Environmental sounds fade, effects begin, and preparation logic runs.

`_args` contains an array defining how long it takes to mute environment sounds before `enableEnvironment false` is applied.

#### Stage 2 - Holding Stage

Variable length.  
Main warning phase where players must seek shelter.

#### Stage 3 - Pre-Impact

Lasts **30 seconds**.  
Strong psy effects, intense wind, frequent lightning, and the first non-lethal psy wave.

#### Stage 4 - Impact

Final stage.

- Players outside cover are knocked down after ~7 seconds
- Deadly psy wave hits after **10 seconds**
- Unsheltered players die instantly if the blowout is lethal

### startBlowout

Event used by the server to initiate a blowout.  
Mission makers may also raise or listen to this event.

- **Locality:** Server only
- **Event name:** `diwako_anomalies_main_startBlowout`

**Parameters**

1. `_time` - Time (in seconds) until the deadly wave hits (**minimum: 102**)
2. `_direction` - Bearing (in degrees) from which the wave approaches

> **Note:**  
> Stages 1, 3, and 4 together take 100 seconds.  
> Stage 2 must be at least 2 seconds long, making 102 the absolute minimum.

**Example**

```sqf
["diwako_anomalies_main_startBlowout", [400, random 360]] call CBA_fnc_serverEvent;
```
