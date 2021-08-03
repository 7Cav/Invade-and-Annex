/*/
File: fn_sCommandChannelMgr.sqf
Author:

	McDodelijk

Last modified:

	24/04/2020 by McDodelijk

Description:

__________________________________________________/*/
scriptName "McD_fnc_sCommandChannelMgr";

if !(isDedicated) exitWith {};

// Enviorment check
if (!canSuspend) exitWith {
	["Suspending not allowed in this context, but required for %1", "McD_fnc_sCommandChannelMgr"] call McD_fnc_error;
};

while {TRUE} do {
	sleep 5;
	
	private _all = allPlayers;
	// The side check introduced for players taking controll of csat caused dead players to lose command, because when incapacitated, you turn civilian
	//private _positive = _all select {side _x isEqualTo WEST && _x getVariable ["McD_commandChannel", FALSE]};
	private _positive = _all select {_x getVariable ["McD_commandChannel", FALSE]};

	1 radioChannelRemove (_all - _positive);
	1 radioChannelAdd _positive;
};