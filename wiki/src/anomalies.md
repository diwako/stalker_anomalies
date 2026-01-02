# Anomalies

## Burner

A static field of superheated air. When ventured into, scorching flames suddenly manifest, burning and setting anyone who enters aflame.

### Setup

The 3den module will spawn a burner anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

Ever walked around a village, seeing no anomaly and your detector not going off, only for a bright light to suddenly appear in front of you, explode in your face, blind you, and set you on fire (if ACE fire is loaded)? That was a clicker anomaly. An anomaly that lies in wait for unsuspecting victims, occupies a larger area, and is generally a pain to deal with.

It is considered one of the worst anomalies out there, as you need to know it is there, or else it will surprise and possibly kill you.

### Setup

The 3den module will spawn a clicker anomaly area at the placed location. The area the module indicates will be the full activation area of the anomaly; therefore, it is advised to place it very carefully.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

The comet anomaly is a wandering anomaly; it does not stay in one place like many others. It burns, sets aflame, and kills anyone it touches. True to its game counterpart, it moves in a fixed looping path.

### Setup

This anomaly is a 3den editor based module only. Due to the advanced setup, it cannot be used in Zeus alone unless you use scripting.

It follows a set of markers that have a number appended at the end. It is recommended to use "Empty" markers for this. The anomaly will follow all three axes of the marker, including height.

For example, setting the "Marker" field in the module to `comet_path` means the comet will follow markers starting with `comet_path0`, then `comet_path1`, and so on.

That means with the following markers:

- `comet_path0`
- `comet_path1`
- `comet_path2`
- `comet_path3`
- `comet_path4`
- `comet_path5`
- `comet_path6`

The comet will start at `comet_path0`, move to `comet_path1`, and continue until it reaches `comet_path6`. From there, it will return to `comet_path0` to complete the loop and start a new cycle.

This path is smoothed using Bezier curves. If you notice the comet clipping through walls or terrain, you can either adjust the marker positions or disable smoothing, which will cause it to move directly from marker to marker.

**The first marker MUST end with a `0`!**

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

A field of static electricity buzzing around, shocking anyone who dares to enter. This anomaly also enjoys permanently fusing a vehicle's engine.

### Setup

The 3den module will spawn an electra anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

A large field filled with white fog. It seems harmless until you breathe it in; then it corrodes your lungs. Make sure to wear a gas mask!

### Setup

Place the module in 3den. You will see an area around it; modify this area to your liking. **Make sure the Size A and B attributes are the same**, as the module only uses the A attribute.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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
```

## Fruitpunch

Weird green goo on a surface that bubbles and emits green light. Whoever steps into it gets a nasty chemical burn on their feet. One may seem harmless, but they appear in numbers and are always blocking your path.

### Setup

The 3den module will spawn a fruitpunch anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

An anomaly that initially looks like whirling leaves, similar to a springboard, but once activated, it sucks everything in and minces it into fine dust, or if it was something living, into minced meat.

### Setup

The 3den module will spawn a meatgrinder anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

A ball shaped anomaly that suddenly appears in the sky. The sphere grows until it bursts, unleashing "psy energy" that damages anyone standing beneath it.

### Setup

The 3den module will fire upon mission preview or mission start. You can prevent this by using trigger logic. There are plenty of tutorials available on how to delay module activation.

Once activated, the anomaly's discharge time is **5 seconds**. During this time, players can attempt to escape its range or seek shelter beneath an object to shield themselves from the psy blast.

This is a **one time anomaly**. After activation, it will not trigger again.
If you want a location with recurring discharges, scripting is recommended.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

### Scripting

This function **MUST** be run on **ALL** machines!

```
Function: diwako_anomalies_main_fnc_createPsyDischarge

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Psy Field

Unlike the psy discharge, the psy field does not deal direct damage. Instead, it applies psy effects to any stalker entering the anomaly. While it can be considered harmless, it alters the stalker's vision and causes them to hear voices. Most stalkers feel paranoid while under the influence of psy, likely because whatever causes this effect can harm the mind and brain.

### Setup

The 3den module will spawn a psy field anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

An anomaly consisting of multiple hovering glass shards. The shards are razor sharp, hence the name, and touching them at sufficient velocity causes bleeding.

It is said that if you make yourself small and move slowly, it does nothing, allowing unharmed passage through the anomaly.

### Setup

The 3den module will spawn a razor anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

Often seen as whirling leaves, closer inspection reveals small refractions as objects are repulsed from entering. If anyone touches the anomaly, they are forcibly flung away from it.

### Setup

The 3den module will spawn a springboard anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

A large disc of pulsing energy that hums when approached. Touching it forcibly relocates you to one of its sister anomalies, enabling faster travel or access to hidden locations, or just death, who knows.

### Setup

The 3den module will spawn a teleport anomaly at the placed location.

You **MUST** set a teleport ID in the module. Any other teleport anomaly with the same ID will act as a sister anomaly.

You **CAN** have more than two teleport anomalies with the same ID.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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

Flickering, dancing lights in the distant darkness, only visible at night. They vanish when approached. Stalkers at the campfire claim they lure people into dangerous areas and traps, but otherwise they are harmless and somewhat pretty.

### Setup

The 3den module will spawn a Will-o'-wisp anomaly at the placed location.

_This anomaly is included for Zeus if you have the Zeus Enhanced mod enabled._

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
