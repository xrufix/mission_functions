/*
 * Author: xrufix
 * Checks for incoming missiles and destructs them.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 * 	  0: The tank for which the system is enabled. <OBJECT>
 * 1: ID of this PFH <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example: [tankymctankface, 2] call xru_hardkill_fnc_pfh
 *
 * Public: No 
 *
 */
#include "script_component.hpp"

params ["_args","_handle"];
_args params ["_tank"];

if (_tank getVariable [QGVAR(ammo), 10] <= 0) exitWith {
	_handle call CBA_fnc_removePerFrameHandler
};
if !(tank getVariable [QGVAR(enabled), false]) exitWith {
	_handle call CBA_fnc_removePerFrameHandler
};

private _projectiles = _tank nearObjects ["MissileBase", 5];
_projectiles append (_tank nearObjects ["RocketBase", 5]);

{
	_tank setVariable [QGVAR(ammo), (_tank getVariable [QGVAR(ammo), 10]) - 1, true];
	if (random 1 < 0.2) exitWith {};
	private _explosion = "SmallSecondary" createVehicle getPos _x;
	deleteVehicle _x;
	
} foreach _projectiles;