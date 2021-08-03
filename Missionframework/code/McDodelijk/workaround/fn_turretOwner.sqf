/*/
File: fn_turretOwner.sqf
Author:

	McDodelijk

Last modified:

	17/02/2021 by McDodelijk

Description:

	Workaround to fix turretOwner returning 0
	for driver turrets. See details:
	https://feedback.bistudio.com/T81189
__________________________________________________/*/
scriptName "McD_fnc_turretOwner";
params [
	["_veh", objNull, [objNull]],
	["_turret", nil, [[0]]]
];

// Environment check
if (!isServer) exitWith {
	["%1 is only allowed to run on the server", "McD_fnc_turretOwner"] call McD_fnc_error;
	abs nil;
};

// Parameter check
if (isNull _veh || isNil "_turret") exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_turretOwner", _this] call McD_fnc_error;
	abs nil;
};

private _ownerId = if (_turret isEqualTo [-1]) then {
	owner _veh;
} else {
	_veh turretOwner _turret;
};

if (_ownerId == 0) exitWith {
	["Script %1 fails to return a plausible value for %2", "McD_fnc_turretOwner", _this] call McD_fnc_error;
	abs nil;
};

_ownerId;