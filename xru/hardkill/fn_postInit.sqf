/*
 * Author: xrufix
 * Adds actions to commander to enable or disable the hardkill system, show the current state of it when on commander position.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example: [] call xru_hardkill_fnc_postInit
 *
 * Public: No 
 *
 */
#include "script_component.hpp"

[QGVAR(enablePFH), {
	[{_this call FUNC(PFH)}, 0, _this] call CBA_fnc_addPerFrameHandler; 
}] call CBA_fnc_addEventHandler;

private _rootAction = [QGVAR(root), "Hardkill System", "", {}, {
	params ["_target", "_player", ""];
	true //(_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

private _enableAction = [QGVAR(enable), "Enable Protection", "", {
	params ["_target", "", ""];
	_target setVariable [QGVAR(enabled), true, true];
	[QGVAR(enablePFH), [_target]] call CBA_fnc_serverEvent;
	//[{_this call FUNC(PFH)}, 0, [_target]] remoteExecCall ["CBA_fnc_addPerFrameHandler", 2];
}, {
	params ["_target", "_player", ""];
	!(_target getVariable [QGVAR(enabled), false])
	&& (_target getVariable [QGVAR(ammo), HARDKILL_CHARGES] > 0)
	&& (_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

private _disableAction = [QGVAR(disable), "Disable Protection", "", {
	params ["_target", "", ""];
	_target setVariable [QGVAR(enabled), false, true];
}, {
	params ["_target", "_player", ""];
	(_target getVariable [QGVAR(enabled), false]) && (_player == commander _target)
}] call ace_interact_menu_fnc_createAction;

private _checkAmmoAction = [QGVAR(checkAmmo), "Check Remaining Charges", "", {
	params ["_target", "", ""];
	hint format ["%1 charges remaining.", _target getVariable [QGVAR(ammo),10]];
}, {
	params ["_target", "_player", ""];
	_player == commander _target
}] call ace_interact_menu_fnc_createAction;

["MBT_01_base_f", 1, ["ACE_SelfActions"], _rootAction, true] call ace_interact_menu_fnc_addActionToClass;
["MBT_01_base_f", 1, ["ACE_SelfActions", QGVAR(root)], _enableAction, true] call ace_interact_menu_fnc_addActionToClass;
["MBT_01_base_f", 1, ["ACE_SelfActions", QGVAR(root)], _disableAction, true] call ace_interact_menu_fnc_addActionToClass;
["MBT_01_base_f", 1, ["ACE_SelfActions", QGVAR(root)], _checkAmmoAction, true] call ace_interact_menu_fnc_addActionToClass;
