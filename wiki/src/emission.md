# Blowout Emission

A blowout (also called an emission) is a map wide event. Every player will be experiencing this event at the same time, almost fully synced between everyone as well.
A large chunk of psy energy is being set free, which announces this by harsh winds, thunderstorms, orange waves in the sky, and ultimately a wave like energy burst that kills anyone not in shelter.

## Blowout stages

A blowout has 5 distinct stages.

### Stage 0

The first stage is that there is simply no blowout event happening, or it just concluded. Normal play as usual really.
Hence why it is dubbed the zero stage, as nothing is going on.

### Stage 1

This is the warmup stage, the blowout just started. Environmental sounds fade, it becomes quiet, until a groan and eventually what sounds like an explosion is heard in the air.
This stage lasts 60 seconds.

### Stage 2

This stage is the holding stage. Meant for the players to haul their asses into a safe spot. The length of this stage is determined by the mission maker, Zeus, or script that initiated the blowout.
During this stage, stronger winds are rocking the trees, lightning bolts rain down from the sky, the sky forms psy lines over the horizon while a constant background rumbling is going on.

### Stage 3

This stage lasts 30 seconds. It is the last stage before the blowout fully hits. The wind becomes extreme, the lightning bolts become very frequent, the psy effect becomes pronounced. And to top it all, the first psy wave arrives during this stage. It does not kill or knock players out, but it should sell the importance of hurrying up.
It is meant to be a sign, if you are not in a safe spot yet, your time is running out rapidly.

### Stage 4

The stage the deadly psy waves arrives. While you are not in cover, first the player will be thrown onto the ground right before the wave hits. When the wave hits it will kill the player instantly without any way to prevent this. Seeking shelter is the only way during normal play.
There are some more options for mission makers, but these are detailed below.

## Starting a blowout

### Zeus

The most common use case is most likely just through the Zeus interface. You will need to have the mod [ZEN](https://steamcommunity.com/workshop/filedetails/?id=1779063631) enabled for this option to show up in your modules tab.

### 3den module

There is a module in 3den which mission makers can use to start a blowout. Do mind it will instantly activate the blowout if it is not synced to a trigger.
When syncing the module to a trigger you can delay its activation until the used trigger is activated.

### Scripting

There is a coordinator script for the blowout. It is only available on the server, calling this on a none server will not work.
The function is named `diwako_anomalies_main_fnc_blowoutCoordinator`. Its parameters are as follows.
|Index|Name|Description|Default|
|-|-|-|-|
|1|\_time|Time until the deadly psy wave hits. Must me at least 102 else it will abort|400|
|2|\_direction|Direction the wave approaches, in bearing degrees|0|
|3|\_useSirens|Boolean value if there should be sirens be heard|true|
|4|\_onlyPlayers|Should only players be affected by this? Performance warning for setting this to false with many AI on the map|true|
|5|\_isLethal|The final blowout wave is lethal and kills those that are not in cover|true|
|6|\_environmentParticleEffects|When enabled causes leaves blowing in the wind, dust being kicked up and some other things|true|

There is a also a CBA event named `diwako_anomalies_main_startBlowout` registered on the server, that just pushes through the given parameter directly into the function. That means you can just do a CBA server event and do not have to deal with locality.

Example

```sqf
["diwako_anomalies_main_startBlowout", [_time, _direction, _useSirens, _onlyPlayers, _isLethal, _environmentParticleEffects]] call CBA_fnc_serverEvent;
```

## How is a player safe from a blowout?

By default, once the blowout wave hits, a check is done if the unit caught in the blowout is safe. There are two mechanisms to see if a unit is safe.

### The automatic way

There is a basic check if a unit is indoors. This check uses Arma’s vanilla command `insideBuilding` which was added with Arma 3 version 2.12.
This command however is a biiit flakey as it relies on properly set up buildings, meaning while staying inside modded buildings might simply not be considered being "indoors" according to Arma.

So, what does indoors mean in the Arma sense? If you are playing Arma for longer, you might have noticed that firing a gun indoors general sounds more echo-y, right? That is a sound shader, any properly set up building will apply this sound shader to the player. The command `insideBuilding` uses this to determine if a unit is inside or outside. Sound shaders like that are part of Arma since very very early, so it is not really a recent change.

Why is this the case, why does Arma do this? Simple, it is super-fast and efficient, there is already a background routine going on to assign the sound shader, so using it in scripting to figure out if it is applied, thus the unit being indoors, is really cheap.

This is the reason I am using this command as well, additionally with some ray casts to check if you have a roof above you and are not just standing in the doorway to the outside.

The main issue here is, not every building is considered safe then. Doing it the old way with using just ray casts is expensive, thus slow, and can have a ton of false positives. As in, standing beneath a tree might be considered safe, because you are "not in the open". Or random props around you might make you unsafe because the props are not configured as buildings. Or standing in a large warehouse is not safe because the walls around you are too far away and the ray casts are not hitting them, making them think you are in an open field. Or some buildings have windows on the roof, standing beneath a broken window will simply mean your head is in the open, thus unsafe, and so on, you get the gist.

### The mission maker way

Over in the [Functions and Variables](functions_variables.md) wiki section there are some variables that can be used by a mission maker to make any building or area safe from a blowout.

I am talking about the `blowout_safe` variable. Coupled that with setting it in Zeus or with a trigger, or global event, can make any spot on the map safe if the mission maker wills it.

As an example, using triggers. \
Condition:
` this && (player in thisList)`

Activation:
`player setVariable ["blowout_safe", true];`

Deactivation:
` player setVariable ["blowout_safe", false];`
