/*
 * Author: xrufix
 * Initializes global variables.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example: [] call xru_hardkill_fnc_preInit
 *
 * Public: No 
 *
 */
#include "script_component.hpp"

GVAR(classHash) = [];


// Create ACE-Interactions

GVAR(interaction_root) = [QGVAR(interaction_root), "Hardkill System", "", {}, {
	params ["_target", "_player", ""];
	true //(_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

GVAR(interaction_enable) = [QGVAR(interaction_enable), "Enable Protection", "", {
	params ["_target", "", ""];
	_target call FUNC(activate)
}, {
	params ["_target", "_player", ""];
	!(_target getVariable [QGVAR(enabled), false])
	&& (_target getVariable [QGVAR(ammo), DEFAULT_CHARGES] > 0)
	&& (_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

GVAR(interaction_disable) = [QGVAR(interaction_disable), "Disable Protection", "", {
	params ["_target", "", ""];
	_target setVariable [QGVAR(enabled), false, true];
}, {
	params ["_target", "_player", ""];
	(_target getVariable [QGVAR(enabled), false]) && (_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

GVAR(interaction_checkAmmo) = [QGVAR(interaction_checkAmmo), "Check Remaining Charges", "", {
	params ["_target", "", ""];
	hint format ["%1 charges remaining.", _target getVariable [QGVAR(ammo),10]];
}, {
	params ["_target", "_player", ""];
	_player == commander _target
}] call ace_interact_menu_fnc_createAction;