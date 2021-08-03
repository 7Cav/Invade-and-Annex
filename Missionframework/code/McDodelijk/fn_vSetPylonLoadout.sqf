/*/
File: fn_vSetPylonLoadout.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Locality safe wrapper for setPylonLoadOut command
__________________________________________________/*/
scriptName "McD_fnc_vSetPylonLoadout";
params [
	["_veh", objNull, [objNull]],
	["_pylonIndex", nil, [0]],
	["_ammo", nil, [""]]
];

// Parameter check
if (isNull _veh || isNil "_pylonIndex" || isNil "_ammo" || {_pylonIndex < 1}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vSetPylonLoadout", _this] call McD_fnc_error;
};

private _pylonTurret = getArray(((configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons") select (_pylonIndex-1) >> "turret"));

// Local? Do it!
if(count _pylonTurret == 0 || _veh turretLocal _pylonTurret) exitWith {
	_veh setPylonLoadOut [_pylonIndex, _ammo, true, _pylonTurret];
};

// Server direct call to turret owner
if(isServer) exitWith {
	private _turretOwner = [_veh, _pylonTurret] call (missionNamespace getVariable "McD_fnc_turretOwner");
	_this remoteExecCall ["McD_fnc_vSetPylonLoadout", _turretOwner, false];
};

// Not local, not the server => report to server!
_this remoteExecCall ["McD_fnc_vSetPylonLoadout", 2, false];