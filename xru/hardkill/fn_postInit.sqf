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

// Create CBA EventHandlers

[QGVAR(enablePFH), {
	[{_this call FUNC(PFH)}, 0, _this] call CBA_fnc_addPerFrameHandler; 
}] call CBA_fnc_addEventHandler;

// Initialize classes
// Custom settings from description.ext
private _config = getArray (missionConfigFile >> "xru_hardkill");
{_x call FUNC(initClass)} forEach _config;
// Default settings (wont apply if class was initialised before)
{_x call FUNC(initClass)} forEach [
	["B_MBT_01_base_F", 12, true, true],
	["I_MBT_03_cannon_F", 12, true, false]
];
