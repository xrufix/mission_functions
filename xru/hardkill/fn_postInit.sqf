/*
 * Author: xrufix
 * Adds actions to commander to enable or disable the hardkill system, shows the current state of it when on commander position.
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

["MBT_01_base_F", "init", {

	params ["_tank"];

	_tank addAction ["Enable Hardkill protection", {
		params ["_target","","_id",""];
		_target setVariable [QGVAR(enabled), true, true];
		[{_this call FUNC(PFH)}, 0, [_target]] call CBA_fnc_addPerFrameHandler;
	}, nil, 1.5, false, true, "", QUOTE( !(_target getVariable [ARR_2(QQGVAR(enabled), false)]) && (player == commander _target))];

	_tank addAction ["Disable Hardkill protection", {
		params ["_target","","_id",""];
		_target setVariable [QGVAR(enabled), false, true];
	}, nil, 1.5, false, true, "", QUOTE( (_target getVariable [ARR_2(QQGVAR(enabled), false)]) && (player == commander _target))];

}, true, [], true] call CBA_fnc_addClassEventHandler;
