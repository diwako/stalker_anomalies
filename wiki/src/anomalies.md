# Anomalies

## Burner

A static field of ever hot air. When ventured into the field scorching flames suddenly manifest burning and setting anyone who enters aflame.

### Setup

The 3den module will spawn a burner anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createBurner

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Clicker

Ever walked around a village, seeing no anomaly or your detector not going off, but then a bright light appears in front of you, explodes in your face, blinds you, and also sets you on fire (If ACE fire is loaded)? That was a clicker anomaly. An anomaly which lies in wait for unsuspecting victims, occupies a larger area, and is in general a pain to deal with.

Considered one of the worst anomalies out there, as you need to know it is there else it surprises, and possibly kills, you.

### Setup

The 3den module will spawn a clicker anomaly area at the placed location. The area the module indicates will be the full activation area of the anomaly; thus it is advised to place it very carefully.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createClicker

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _radiusA - Radius A parameter of area anomaly (default: 10)
    _radiusB - Radius B parameter of area anomaly (default: 10)
    _isRectangle - is this anomaly rectangular shaped (default: true)
    _angle - Angle the anomaly should have (default: 0)
    _height - Height of the area (default: 8)

Returns:
    Anomaly Trigger
```

## Comet

The comet anomaly is a wandering anomaly, it does not stay put in one place like many other. It burns, sets aflame, and kills anyone which it touches. True to its game counterpart it goes in a fixed path loop.

### Setup

This anomaly is an 3den editor-based module only. Due to the advanced setup, you cannot use it in Zeus alone, except if you use scripting.

It follows a set of markers which have a number appended at the end. Recommended are "Empty" markers for this. It will follow all 3 axes of the marker, that include height.

As example, setting the "Marker" field in the module to `comet_path` means the comet will follow along markers starting with the name `comet_path0` and then to the next increasing number that is `comet_path1`.

That means with this set of markers:

- `comet_path0`
- `comet_path1`
- `comet_path2`
- `comet_path3`
- `comet_path4`
- `comet_path5`
- `comet_path6`

The comet will start at marker `comet_path0` then to `comet_path1`... until it reaches marker `comet_path6`. From there it will go to `comet_path0` to complete the loop and start a new round.

This path gets smoothened using Bezier curves. If you see the comet clip through walls or the terrain, you can either adapt the marker positions or uncheck the smoothing, then it will go straight from marker to marker.

**The first marker MUST end with a 0!**

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createComet

Parameter:
    _marker - marker ID of path objects, will be used to move said path (default: "")
            - array of objects, makers, positionASL used to create a path from, order of entries is used for path
    _speed - measured in meters per second (default: 6)
    _smoothCurves - interpolates the path corners using bezier curves (default: true)

Returns:
    Anomaly Trigger
```

## Electra

A field of static electricity buzzing around, shocking anyone who dares to enter. This one also likes to permanently flash fuse any vehicle’s engine!

### Setup

The 3den module will spawn an electra anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createElectra

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Fog

A large field filled with white fog. It seems harmless until you breathe in the fog, then it corrodes your lungs. Make sure to wear a gas mask!

### Setup

Place the module in 3den, you see that it has an area around it. Modify the area to your liking, **make sure to have Size attribute A and B the same**, as the module will only use the A attribute!

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createFog

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _radius - Radius parameter of area anomaly (default: 10)
    _isRectangle - is this anomaly rectangular shaped (default: true)

    Currently under construction and does not work on effect right now
    _angle - Angle the anomaly should have (default: 0)

    _color - Color of the fog in RGB array (default: [249/255, 248/255, 242/255])
```

## Fruitpuch

Weird green goo on a surface that seems to bubble and emit green light. Whoever steps into that gets a nasty chemical burn on their feet. One is seemingly harmless, but they come in number and are always blocking your path...

### Setup

The 3den module will spawn a fruitpunch anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createFruitPunch

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Meatgrinder

An anomaly that looks at first like some whirling leaves, same as a springboard, but once it is activated it sucks anything in and then minces it into fine dust, or if it was something living, into minced meat.

### Setup

The 3den module will spawn a meatgrinder anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createMeatgrinder

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Psy Discharge

A ball shaped anomaly suddenly appeared in the sky. The shape grows until it bursts and unleashes "psy energy" which damages anyone standing beneath the sphere.

### Setup

The module in 3den will fire upon mission preview or start, you can prevent this by using trigger logic. I am sure there are tons of tutorials around to delay module activation until then.

Once the anomaly is activated its discharge time is **5 seconds**. During that time people can attempt to escape its range or seek shelter underneath an object to shield themself from the psy blast.

This is a one-time anomaly! After the activation is done, it will not activate once more! \
If you want a spot on the map that has regular discharges, I suggest scripting this.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

This function **MUST** be run on **ALL** machines!

```
Function: diwako_anomalies_main_fnc_createPsyDischarge

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Razor

An anomaly consisting out of multiple glass shards which are hovering around. The shards are razor sharp, hence its name, and touching them with too much velocity causes bleeding.

It is said if you make yourself small and move slowly it does nothing allowing unharmd passage through the anomaly.

### Setup

The 3den module will spawn a razor anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createRazor

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Springboard

Seen as whirling leaves, upon closer inspection you see small refraction of small things being repulsed from entering. If anyone touches the anomaly, they are forcibly flung away from it.

### Setup

The 3den module will spawn a springboard anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createSpringboard

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])

Returns:
    Anomaly Trigger
```

## Teleport

A large disc of pulsing energy, it hums when close. Touching it will forcibly relocate you to one of its sister anomalies enabling faster travel or access to hidden spots. Or just death, who knows.

### Setup

The 3den module will spawn a teleport anomaly at the placed location.

You **MUST** set a teleport ID in the module. Any other teleport anomaly with the same ID will act as its sister anomaly.

You **can** have more than two teleport anomalies with the same ID!

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createTeleport

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _id - ID which connects teleporters

Returns:
    Anomaly Trigger
```

## Will-o'-wisp

Flickering and dancing lights in the distant darkness, only around at night, they vanish when getting too close. Stalkers on the campfire say they lure people into potentially dangerous areas and traps, but otherwise they are harmless and somewhat pretty.

### Setup

The 3den module will spawn a Will-o'-wisp anomaly at the placed location.

_This anomaly is included for Zeus, if you have the Zeus Enhanced mod enabled._

### Scripting

Must be executed on server!

```
Function: diwako_anomalies_main_fnc_createWillowisp

Parameter:
    _pos - PositionASL where the anomaly should be (default: [0,0,0])
    _color - Color of the fog in RGB array, string "randomColor" for random color, or string of CfgMarker entry (default: "randomColor")
    _count - Number of lights (default: -1 (random between 1 and 5))
    _spread - Maximum of distance from center point in meters (default: 15)

Returns:
    Anomaly Trigger
```
