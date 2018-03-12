/*
 * Author: xrufix
 * Lets given AI-Vehicle suppress a position or object.
 *
 * Arguments:
 * 0: Suppressing vehicle or list of vehicles. <OBJECT|ARRAY>
 * 1: Target(s) of Suppression <OBJECT|ARRAY|LOCATION>
 * 2: Radius arround target location <NUMBER> (default: 10)
 * 3: Number of dummy targets to create near target location <NUMBER> (default: 10)
 * 4: Height above ground level at which shall be aimed. Only used if positions are provided. <NUMBER> (default: 2)
 * 5: Time limit until shooting stops in seconds (true for unlimited) <NUMBER|BOOL> (default: 30)
 * 6: Time between switching targets. <NUMBER> (default: 1)
 * 7: Weapon index of Weapon to use. <NUMBER> (default: 1)
 *
 * Return Value:
 * Handle of PFH. Can be stopped with CBA_fnc_removePerFrameHandler manually. <NUMBER|ARRAY>
 *
 * Example:
 * [tankyMcTankface, [1,2,3], 10, 5, 1, 10, 1, 1] call xru_ai_fnc_suppressArea;
 *
 */

#include "script_component.hpp"
// #define DEBUG_MODE_FULL

#ifdef DEBUG_MODE_FULL
	#define DUMMYCLASS "Sign_Sphere100cm_F"
#else
	#define DUMMYCLASS "Helper_Base_F"
#endif

params [["_unit", objNull, [[], objNull]], ["_target", objNull, [objNull, []]], ["_distance", 10, [0]], ["_dummyCount", 10, [0]], ["_height", 2, [0]], ["_maxTime", 30, [0]], ["_switch", 1, [0]], ["_weapon", 1, [0]]];
TRACE_5("Params", _unit, _target, _distance, _dummyCount, _maxTime);

if (_unit isEqualType []) exitWith {
	_unit apply {[_x, _target] call FUNC(suppressArea)};
};
if (isNull _unit) exitWith {ERROR("Suppressing vehicle is invalid or was not found.")};
if (!local _unit) exitWith {};

private _dummyTargets = [];
if (_distance < 1) then {_distance = 1};
if (_dummyCount < 1) then {_dummyCount = 1};


if (_target isEqualType objNull) then {
	if (isNull _target) exitWith {ERROR("Target or target location is invalid or was not found")};
	_target = position _target;
};
if (_target isEqualType []) then {
	if (_target isEqualTypeAll objNull) then {
		_dummyTargets = _target;
	} else {
		if (_target isEqualTypeAll []) then {
			{
				private _position == _x;
				if !((count _position == 3) && {_position isEqualTypeAll 0}) exitWith {
					ERROR("Element in target array is not a position");
				};
				_position set [2, _height];
				private _dummy = DUMMYCLASS createVehicle [0, 0, 0];
				_dummy setPos _position;
				_dummyTargets pushBack _dummy;

			} forEach _target;
		};
		if ((count _target == 3) && (_target isEqualTypeAll 0) && !(_target isEqualTo [0,0,0])) then {
			for "_i" from 1 to _dummyCount do {
				private _position = [[_target, _distance, _distance, 0, false]] call CBA_fnc_randPosArea;
				_position set [2, _height];
				private _dummy = DUMMYCLASS createVehicle [0, 0, 0];
				_dummy setPos _position;
				_dummyTargets pushBack _dummy;
			};
		} else {
			throw "Invalid position provided as target";
		};
	};
};

private _startTime = time;
TRACE_2("Starting handle with", _dummyTargets, _startTime);

_handle = [{
	params ["_args", "_handle"];
	_args params ["_unit", "_dummyTargets", "_maxTime", "_startTime", "_weapon"];
	private _gunner = gunner _unit;

	#define EXIT_HANDLE [_handle] call CBA_fnc_removePerFrameHandler;{deleteVehicle _x} forEach (_dummyTargets select {typeOf _x == DUMMYCLASS})

	if ((_startTime + _maxTime) < time) exitWith {
		EXIT_HANDLE;
		TRACE_3("Exit - Time limit", _startTime, _maxTime, time);
	};
	if (!alive _unit) exitWith {
		EXIT_HANDLE;
		TRACE_1("Exit - Unit dead", _unit);
	};
	if (!alive _gunner) exitWith {
		EXIT_HANDLE;
		TRACE_1("Exit - Gunner dead", _gunner);
	};
	if (!(count (magazines _unit) > 1)) exitWith {
		EXIT_HANDLE;
		TRACE_1("Exit - Ammo empty", magazines _unit);
	};

	private _target = selectRandom _dummyTargets;
	_gunner doWatch objNull;
	_gunner doWatch _target;
	_gunner doTarget _target;
	_unit action ["useWeapon", _unit, _gunner, _weapon];
}, _switch, [_unit, _dummyTargets, _maxTime, _startTime, _weapon]] call CBA_fnc_addPerFrameHandler;

_handle;