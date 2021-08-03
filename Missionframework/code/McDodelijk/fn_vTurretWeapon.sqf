/*/
File: fn_vTurretWeapon.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Locality safe wrapper for add-/remove-
	WeaponTurret command
__________________________________________________/*/
scriptName "McD_fnc_vTurretWeapon";
params [
	["_veh", objNull, [objNull]],
	["_turret", nil, [[0]]],
	["_weapon", nil, [""]],
	["_command", nil, [""]]
];

// Parameter check
if (isNull _veh || isNil "_turret" || isNil "_weapon" || isNil "_command" || {!(_command in ["add", "remove", "addWeaponTurret", "removeWeaponTurret"])}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vTurretWeapon", _this] call McD_fnc_error;
};

// Local? Do it!
if(_veh turretLocal _turret) exitWith {
	// Replace shortcuts
	switch (_command) do {
		case "add";
		case "addWeaponTurret": {_veh addWeaponTurret [_weapon, _turret];};
		case "remove";
		case "removeWeaponTurret": {_veh removeWeaponTurret [_weapon, _turret];};
	};
};

// Server direct call to turret owner
if(isServer) exitWith {
	private _turretOwner = [_veh, _turret] call (missionNamespace getVariable "McD_fnc_turretOwner");
	[_veh, _turret, _weapon, _command] remoteExecCall ["McD_fnc_vTurretWeapon", _turretOwner, false]; 
};

// Not local, not the server => report to server!
_this remoteExecCall ["McD_fnc_vTurretWeapon", 2, false];