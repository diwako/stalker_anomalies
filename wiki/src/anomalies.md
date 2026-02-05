# Anomalies

## Burner

A static field of superheated air. When entered, scorching flames suddenly manifest, burning and igniting anyone who ventures inside.

### Setup

The 3DEN module will spawn a burner anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createBurner

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Clicker

Have you ever walked through a village with no visible anomaly and no detector warning, only for a sudden bright light to appear, explode in your face, blind you, and possibly set you on fire (if ACE fire is loaded)? That was a clicker anomaly.

The clicker is an anomaly that lies in wait for unsuspecting victims. It covers a larger area and is generally difficult to deal with. It is considered one of the most dangerous anomalies, as you must know it is there in advance or risk being surprised and potentially killed.

### Setup

The 3DEN module will spawn a clicker anomaly area at the placed location. The area shown by the module represents the full activation zone of the anomaly, so careful placement is strongly advised.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createClicker

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _radiusA - Radius A parameter of area anomaly (default: 10)
    _radiusB - Radius B parameter of area anomaly (default: 10)
    _isRectangle - Is this anomaly rectangular shaped (default: true)
    _angle - Angle the anomaly should have (default: 0)
    _height - Height of the area (default: 8)

Returns:
    Anomaly Trigger
```

## Comet

The comet anomaly is a wandering anomaly that does not remain in a fixed location like many others. It burns, ignites, and kills anything it touches. True to its game counterpart, it moves along a fixed, looping path.

### Setup

This anomaly is available only as a 3DEN Editor module. Due to its advanced setup, it cannot be used in Zeus alone unless scripting is used.

The comet follows a sequence of markers with an appended number. It is recommended to use "Empty" markers for this purpose. The anomaly follows all three axis of each marker, including height.

For example, setting the "Marker" field in the module to `comet_path` will cause the comet to follow markers named `comet_path0`, `comet_path1`, and so on.

With the following markers:

- `comet_path0`
- `comet_path1`
- `comet_path2`
- `comet_path3`
- `comet_path4`
- `comet_path5`
- `comet_path6`

The comet will start at `comet_path0`, move through each marker in sequence, and continue until it reaches `comet_path6`. It will then return to `comet_path0`, completing the loop and starting a new cycle.

The path is smoothed using Bezier curves. If the comet clips through walls or terrain, you can adjust the marker positions or disable smoothing, which will cause it to move directly from marker to marker.

**The first marker MUST end with `0`!**

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createComet

Parameter:
    _marker - Marker ID of path objects used to move the anomaly (default: "")
            - Alternatively, an array of objects, markers, or PositionASL entries used to create a path; order matters
    _speed - Movement speed in meters per second (default: 6)
    _smoothCurves - Interpolates path corners using Bezier curves (default: true)

Returns:
    Anomaly Trigger
```

## Electra

A field of static electricity that crackles and buzzes, shocking anyone who dares to enter. This anomaly is also known for permanently disabling vehicle engines.

### Setup

The 3DEN module will spawn an electra anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createElectra

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Fog

A large area filled with dense white fog. It may appear harmless at first, but inhaling it corrodes the lungs. Make sure to wear a gas mask.

### Setup

Place the module in 3DEN. An area indicator will appear around it; adjust this area to your liking.  
**Make sure the Size A and Size B attributes are the same**, as the module only uses the Size A value.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createFog

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _radius - Radius parameter of area anomaly (default: 10)
    _isRectangle - Is this anomaly rectangular shaped (default: true)

    Currently under construction and does not affect the area shape yet
    _angle - Angle the anomaly should have (default: 0)

    _color - Color of the fog as an RGB array (default: [249/255, 248/255, 242/255])
    _effectOnly - If true, the anomaly will only be harmless fog, no damage or blur (default: false)
```

## Fruitpunch

A strange green substance covering a surface, bubbling and emitting a faint green glow. Anyone who steps into it suffers painful chemical burns to their feet. A single patch may seem harmless, but they often appear in groups and tend to block your path.

### Setup

The 3DEN module will spawn a fruitpunch anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createFruitPunch

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Meatgrinder

An anomaly that initially appears as swirling leaves, similar to a springboard. Once activated, it pulls everything inward and grinds it into fine dust, or into minced flesh if the victim is a living being.

### Setup

The 3DEN module will spawn a meatgrinder anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createMeatgrinder

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Psy Discharge

A spherical anomaly that suddenly appears in the sky. The sphere expands and eventually bursts, releasing psy energy that damages anyone standing beneath it.

### Setup

The 3DEN module will activate on mission preview or mission start. This behavior can be prevented by using trigger logic. There are many tutorials available that explain how to delay module activation.

Once activated, the anomaly has a discharge time of **5 seconds**. During this period, players can attempt to escape its range or seek shelter under an object to shield themselves from the psy blast.

This is a **one-time anomaly**. After activation, it will not trigger again.
If you want a location with recurring discharges, scripting is recommended.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

This function **MUST** be run on **ALL** machines!

```
Function: diwako_anomalies_main_fnc_createPsyDischarge

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _psyEffect - Integer strength of the psy effect to apply to players affected by the discharge (0-3, default: 2)

Returns:
    Anomaly Trigger
```

## Psy Field

Unlike the psy discharge, the psy field does not deal direct damage. Instead, it applies psy effects to any stalker who enters the anomaly. While it may appear harmless, it alters the stalker’s vision and causes auditory hallucinations. Most stalkers report feelings of paranoia while under its influence, likely because whatever causes the effect directly affects the mind and brain.

### Setup

The 3DEN module will spawn a psy field anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createPsyField

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _strength - Strength of the anomaly, ranging from 1 to 3 (default: 1)
    _radiusA - Radius A parameter of area anomaly (default: 10)
    _radiusB - Radius B parameter of area anomaly (default: 10)
    _isRectangle - Is this anomaly rectangular shaped (default: true)
    _angle - Angle the anomaly should have (default: 0)
    _height - Height of the anomaly, -1 for infinite (default: -1)

Returns:
    Anomaly Trigger
```

## Razor

An anomaly composed of multiple hovering glass shards. The shards are razor sharp, hence the name, and contact at sufficient speed causes severe bleeding.

It is said that if you make yourself small and move slowly, the anomaly does nothing, allowing safe passage through it.

### Setup

The 3DEN module will spawn a razor anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createRazor

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Springboard

Often appearing as swirling leaves, closer inspection reveals subtle refractions as objects are repelled from entering. If anyone touches the anomaly, they are violently flung away from it.

### Setup

The 3DEN module will spawn a springboard anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createSpringboard

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Teleport

A large disc of pulsing energy that emits a low hum when approached. Touching it forcibly relocates you to one of its sister anomalies, enabling faster travel, access to hidden locations, or, potentially, an untimely death.

### Setup

The 3DEN module will spawn a teleport anomaly at the placed location.

You **MUST** assign a teleport ID in the module. Any other teleport anomaly using the same ID will function as a sister anomaly.

You **CAN** have more than two teleport anomalies sharing the same ID.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createTeleport

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _id - ID that links teleporters together

Returns:
    Anomaly Trigger
```

## Will-o'-wisp

Flickering, dancing lights that appear in the distance and are only visible at night. They vanish when approached. Campfire stories claim they lure stalkers into dangerous areas and traps, but in reality they are harmless, if somewhat eerie and beautiful.

### Setup

The 3DEN module will spawn a Will-o'-wisp anomaly at the placed location.

_This anomaly is available in Zeus when the Zeus Enhanced mod is enabled._

### Scripting

Must be executed on the server!

```
Function: diwako_anomalies_main_fnc_createWillowisp

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _color - Color of the lights as an RGB array, string "randomColor" for a random color, or a CfgMarker entry (default: "randomColor")
    _count - Number of lights (default: -1, random between 1 and 5)
    _spread - Maximum distance from the center point in meters (default: 15)

Returns:
    Anomaly Trigger
```
