# Procedural Anomaly Spawning System

## Description

This system aims to fill the entire map with anomalies. Since thousands of anomalies can be a resource hog and a performance nightmare, the system is designed to spawn and despawn them intelligently.

It works by populating so-called "cells" in a grid with anomalies if a player is nearby. Likewise, it will depopulate said cell if no player is close.

This only affects anomalies spawned by this system; any anomalies placed by the mission maker or Zeus will be unaffected.

The system generates anomaly placements within a cell and remembers them. Leaving the area and returning will result in the same anomalies appearing in the same spots. After a blowout, that placement information will be erased, and new spots, potentially with different anomalies, will fill the void. (There is a setting to disable this behavior.)

## Activation

To activate this system, go to the `Addon Options` menu in-game. Select the anomaly mod from the dropdown. Navigate to the subchapter named after the system and check the `Enable` setting. Make sure you do this in the correct tab, either server or mission.

This is intentionally not a module in 3den, as some players may want to populate the world in missions they’ve downloaded from the Workshop and might not want to, or be able to, edit them.

## Performance

There are several settings available to tweak this system, including maximum anomaly cap, grid size, activation range, and scan interval.

Mission makers need to be cautious with these settings. Setting the maximum cap too high while several players are spaced across the map might cause issues if thousands of anomalies are spawned.

The same applies to grid size and activation range. Increasing these values causes more anomalies to spawn, as the cells become larger or are triggered from farther away. This may be intentional, to account for faster vehicles, more players, or to reduce "pop-in", but keep performance in mind when changing these settings.

## Mission Makers

This system will ignore any player which have the [`anomaly_ignore`](https://github.com/diwako/stalker_anomalies/wiki/Functions-and-Variables#anomaly_ignore) variable set on them. It is recommended to have this set on Zeus players or players designed to stay outside the mission area.

In addition to these settings, a new module is included in 3den to add exclusion zones to the system. In these zones, the system will refrain from spawning anomalies. This can be used for safe zones, such as hideouts or hubs.

You can also add these zones via scripting. Simply append this variable with an area definition or trigger object any time before postInit: `diwako_anomalies_main_proceduralExclusionZones`.

**Warning:** This variable is only present on the server!

Example:

```sqf
// initServer.sqf
private _area = [[_xPos, _yPos], _a, _b, _angle, _isRectangle, -1];
diwako_anomalies_main_proceduralExclusionZones pushBack _area;
```