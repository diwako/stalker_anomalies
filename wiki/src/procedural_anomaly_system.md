# Procedural Anomaly Spawning System

## Description

This system is designed to populate the entire map with anomalies. Because spawning thousands of anomalies at once would be a major performance burden, the system spawns and despawns them intelligently.

It operates by dividing the map into grid-based "cells". When a player approaches a cell, anomalies are spawned within it. When no players are nearby, the cell is depopulated and the anomalies are removed.

Only anomalies spawned by this system are affected. Any anomalies placed manually by the mission maker or Zeus remain untouched.

Anomaly placements within each cell are generated once and then remembered. Leaving the area and returning will result in the same anomalies appearing in the same locations. After a blowout, this placement data is cleared and new anomalies, potentially of different types and positions, are generated. This behavior can be disabled via a setting.

## Activation

To enable this system, open the in-game `Addon Options` menu. Select the anomaly mod from the dropdown list, then navigate to the section dedicated to the procedural anomaly system and enable it. Be sure to apply the setting in the correct context, either server or mission.

This system is intentionally not provided as a 3DEN module. Some players may want to populate maps in missions downloaded from the Workshop without editing the mission itself.

## Performance

Several settings are available to fine-tune performance, including maximum anomaly count, grid size, activation range, and scan interval.

Mission makers should adjust these values carefully. Setting the maximum anomaly cap too high while players are spread across the map can result in thousands of active anomalies and significant performance degradation.

The same applies to grid size and activation range. Increasing these values causes more anomalies to spawn, as cells become larger or activate from greater distances. This may be desirable for fast-moving vehicles, large player counts, or to reduce noticeable pop-in, but performance considerations should always be kept in mind.

## Mission Makers

This system ignores any player who has the [`anomaly_ignore`](functions_variables.md#anomaly_ignore) variable set. It is recommended to apply this variable to Zeus players or any players intended to remain outside the playable area.

Additionally, a new 3DEN module is available to define exclusion zones. Within these zones, the system will not spawn anomalies. This is useful for safe areas such as hubs, bases, or hideouts.

Exclusion zones can also be defined via scripting. To do so, append an area definition or trigger object to the variable `diwako_anomalies_main_proceduralExclusionZones` at any point before postInit.

**Warning:** This variable exists on the server only.

Example:

```sqf
// initServer.sqf
private _area = [[_xPos, _yPos], _a, _b, _angle, _isRectangle, -1];
diwako_anomalies_main_proceduralExclusionZones pushBack _area;
```
