#include "\z\diwako_anomalies\addons\main\script_component.hpp"
/*
    Function: diwako_anomalies_main_fnc_hasItem

    Description:
        Function to check if a specific item is in players inventory

    Parameters:
        _unit - Unit to check. Defaults to the player if objNull is passed and the function is called on a client machine (default: objNull)
        _itemClass - Item class name to search for (default: "")

    Returns:
        true or false, depending on whether the item is present or an empty string is given

    Author:
    diwako 2017-12-29
*/
if (!params [["_unit", objNull], ["_itemClass", ""]]) exitWith {false};

if (_itemClass == "") exitWith {true};
if (!isDedicated && isNull _unit) exitWith {false};
if (isNull _unit) then {_unit = player;};

(_itemClass in (vestItems _unit + uniformItems _unit + backpackItems _unit + assignedItems _unit))
