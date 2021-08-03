params [["_arty", objNull, [objNull]], ["_close", TRUE, [TRUE]]];
if(isNull _arty) exitWith {};
if(_arty turretLocal [0]) then {
	_arty lockTurret [[0], _close];
	// !second check!
	if!(_arty turretLocal [0]) then {
		[_arty, _close] remoteExec ["McD_fnc_artyLockTurret", if(isServer) then {_arty turretOwner [0]} else {2}, FALSE];
	};
} else {
	[_arty, _close] remoteExec ["McD_fnc_artyLockTurret", if(isServer) then {_arty turretOwner [0]} else {2}, FALSE];
};
