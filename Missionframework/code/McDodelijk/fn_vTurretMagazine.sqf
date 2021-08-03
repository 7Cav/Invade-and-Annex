/*/
File: fn_vTurretMagazine.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Locality safe wrapper for add-/remove-
	MagazineTurret command
__________________________________________________/*/
scriptName "McD_fnc_vTurretMagazine";
params [
	["_veh", objNull, [objNull]],
	["_turret", nil, [[0]]],
	["_ammo", nil, [""]],
	["_command", nil, [""]],
	["_count", -1, [0]]
];

// Parameter check
if (isNull _veh || isNil "_turret" || isNil "_ammo" || isNil "_command" || {!(_command in ["add", "remove", "addMagazineTurret", "removeMagazineTurret", "removeAll", "removeMagazinesTurret"])}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vTurretMagazine", _this] call McD_fnc_error;
};

// Local? Do it!
if(_veh turretLocal _turret) exitWith {
	switch (_command) do {
		case "add";
		case "addMagazineTurret": {
			_veh addMagazineTurret (if(_count < 0) then {[_ammo, _turret]} else {[_ammo, _turret, _count]});
		};
		case "remove";
		case "removeMagazinesTurret": {
			_veh removeMagazineTurret [_ammo, _turret];
		};
		case "removeAll";
		case "removeMagazinesTurret": {
			_veh removeMagazinesTurret [_ammo, _turret];
		};
	};
};

// Server direct call to turret owner
if (isServer) exitWith {
	private _turretOwner = [_veh, _turret] call (missionNamespace getVariable "McD_fnc_turretOwner");
	[_veh, _turret, _ammo, _command, _count] remoteExecCall ["McD_fnc_vTurretMagazine", _turretOwner, false]; 
};

// Not local, not the server => report to server!
_this remoteExecCall ["McD_fnc_vTurretMagazine", 2, false];