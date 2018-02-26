/*
 * Author: xrufix
 * Activates the protection system on a specific vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Activate (true) or deactivate (false) (Default: true) <BOOL><OPTIONAL>
 *
 * Return Value:
 * NONE
 *
 * Example: [tankymctankface] call xru_hardkill_fnc_activate
 *
 * Public: Yes
 *
 */
#include "script_component.hpp"

params [["_vehicle", objNull, [objNull]], ["_mode", true, [true]]];

_vehicle setVariable [QGVAR(enabled), _mode, true];
if (_mode) then {
	[QGVAR(enablePFH), [_vehicle]] call CBA_fnc_serverEvent;
};