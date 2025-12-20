# CBA events for mission makers

The mod features some CBA events starting with version 2.1.0 which a mission maker can utilize for their own scripts.

## Anomaly events

### burnerOnDamage

Activates whenever something or someone gets damaged or killed by a burner anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_burnerOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### clickerOnDamage

Activates whenever something or someone gets flashbanged by a clicker anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_clickerOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### cometOnDamage

Whenever a comet anomaly burns something, this event is thrown

Locality: Where burned object is local

Full event name: diwako_anomalies_main_cometOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### electraOnDamage

Activates whenever something or someone gets damaged or killed by an electra anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_electraOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### fogOnDamage

Activates whenever something or someone gets damaged or killed by a fog anomaly.

Locality: Where suffocating object is local

Full event name: diwako_anomalies_main_fogOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### fruitpunchOnDamage

Activates whenever something or someone gets damaged or killed by a fruitpunch anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_fruitpunchOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### meatgrinderOnDamage

Activates whenever something or someone gets ripped apart (or damaged if it is a vehicle) by a meatgrinder anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_meatgrinderOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### razorOnDamage

Activates whenever something or someone gets cut by a razor anomaly.

Locality: Where object is local only

Full event name: diwako_anomalies_main_razorOnDamage

Parameters:

1. \_obj - object that got cut
1. \_trg - the anomaly trigger

### springboardOnDamage

Activates whenever something or someone gets flung or killed by a springboard anomaly.

Locality: Server only

Full event name: diwako_anomalies_main_springboardOnDamage

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the anomaly trigger

### teleportOnEnter

Activates whenever something or someone is about to be teleported.

Locality: Server only

Full event name: diwako_anomalies_main_teleportOnEnter

Parameters:

1. \_obj - object that is about to be teleported
1. \_trg - the entrance teleport trigger
1. \_exit - the exit teleport trigger

### teleportOnExit

Activates whenever something or someone has teleported.

Locality: Server only

Full event name: diwako_anomalies_main_teleportOnExit

Parameters:

1. \_obj - object that got damaged/killed
1. \_trg - the entrance teleport trigger
1. \_exit - the exit teleport trigger

## Blowout

The blowout is a zonewide (or rather map wide) event which has an event a mission maker can use to maybe add some more spice to things.

### blowOutStage

The blowout stage event is used by the server to set up the blowout event and direct what is happening for players.

A mission maker can add their own event handler in case they want to add additional things to the blowout, or just to see on which stage the blowout currently is.

#### CBA Event

Locality: Global

Full event name: diwako_anomalies_main_blowOutStage

Parameters:

1. \_stage - Integer, which stage of the blowout was just entered
1. \_args - arguments for the stage, only stage 1 is using this

#### Stages

There are five stages in a blowout.

##### Stage 0

This is the stage when no blowout is rolling in, basically normal play. This stage gets called after a blowout has concluded.

##### Stage 1

The so called warm up stage. A stage that takes **one minute** to set things up in the background, give the players a glimpse of what is about to happen.
Some effects are already shown at this stage.

This stage fills the argument parameter with an array which houses the time in seconds how long it takes to mute the environment sounds and then afterwards sets the `enableEnvironment` command to false.

##### Stage 2

The holding stage. This one is of **variable length**, but arguably the longest stage. Used as the main stage in which the players scramble and seek shelter.

##### Stage 3

Stage with the highest psy levels, the fastest winds, the most chaotic stage. It even features the first wave of the blowout, which does not harm the players, but should be alarming enough. \
This stage lasts for **30 seconds**.

##### Stage 4

The last stage of a blowout. The damaging psy wave is about to roll in. This wave will hit in **10 seconds**. But before that, unsheltered players will be flung to the ground roughly 7 seconds into the stage.

Once the final wave hits any unsheltered players, they are dead instantly if the blowout is set to be lethal.

### startBlowout

This is an event consumed by the server to start a blowout. Of course, a mission maker can add an event handler to that as well or raise the event themselves on server to trigger a blowout.

The time parameter is the time when the deadly wave should hit the players. Here it needs to be considered that there are multiple stages, that is stage 1, 3 and 4, to a blowout which combined are 100 seconds. As the hold stage (stage 2) should have some time of at least 2 seconds, the minimum number here is 102. Anything lower will not trigger a blowout!

Locality: Server only

Full event name: diwako_anomalies_main_startBlowout

Parameters:

1. \_time - number, how long until the deadly wave hits the players, minimum 102!
1. \_direction - number, from which bearing should the deadly wave approach?

Example:

```sqf
["diwako_anomalies_main_startBlowout", [400, random 360]] call CBA_fnc_serverEvent;
```
