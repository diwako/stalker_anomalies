/*
	Function: anomaly_fnc_hasItem

	Description:
        Function to check if a specific item is in players inventory

    Parameters:
        _unit - Unit to check. will be player if variable is objNull and is called on a client machine (default: objNull)
		_itemClass - Itemclass to search for (default: "")

    Returns:
        true or false, if item is in inventory or empty string is given

	Author:
	diwako 2017-12-29
*/
if (!params [["_unit", objNull], ["_itemClass", ""]]) exitWith {false};

if(_itemClass == "") exitWith {true};
if(!isDedicated && isNull _unit) exitWith {false};
if(isNull _unit) then {_unit = player;};

(_itemClass in (vestItems _unit + uniformItems _unit + backpackItems _unit + assignedItems _unit))