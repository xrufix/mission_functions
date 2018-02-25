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

params ["_args", "_handle"];
_args params ["_tank"];

// Exit the PFH if ammo is empty or system was disabled.
if (_tank getVariable [QGVAR(ammo), DEFAULT_CHARGES] <= 0) exitWith {
	_handle call CBA_fnc_removePerFrameHandler;
	_tank setVariable [QGVAR(enabled), false, true];
};
if !(_tank getVariable [QGVAR(enabled), false]) exitWith {
	_handle call CBA_fnc_removePerFrameHandler;
};

// Detect incoming projectiles.
private _projectiles = _tank nearObjects ["MissileBase", 5];
_projectiles append (_tank nearObjects ["RocketBase", 5]);

// Delete incomming projectile and create destruction effect.
if (count _projectiles >= 1) then {
	private _target = selectRandom _projectiles;

	_tank setVariable [QGVAR(ammo), (_tank getVariable [QGVAR(ammo), DEFAULT_CHARGES]) - 1, true];
	if (random 1 < 0.2) exitWith {};
	private _explosion = "SmallSecondary" createVehicle getPos _target;
	deleteVehicle _target;

	// Remove this PFH and add it again after 2 second reload time.
	_handle call CBA_fnc_removePerFrameHandler;
	[CBA_fnc_addPerFrameHandler, [{_this call FUNC(PFH)}, 0, [_tank]], 2] call CBA_fnc_waitAndExecute;
};
