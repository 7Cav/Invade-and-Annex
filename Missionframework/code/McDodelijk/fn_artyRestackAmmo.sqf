/*/
File: fn_artyRestackAmmo.sqf
Author:

	McDodelijk

Last modified:

	21/11/2020 by McDodelijk

Description:

	Restacks the current ammo of an arty in the
	most efficient way possible
__________________________________________________/*/
scriptName "McD_fnc_artyRestackAmmo";
params [
	["_veh", objNull, [objNull]],
	["_instantReload", TRUE, [TRUE]],
	["_loadout", nil, [[]]] // use to override current loadout
];

// Parameter check
if (isNull _veh) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_artyRestackAmmo", _this] call McD_fnc_error;
};

private _loaded = if (isNil "_loadout") then {
	((magazinesAllTurrets _veh) apply {
		_x params ["_mag", "_turret", "_ammo"];
		if (_turret isEqualTo [0] && {_ammo > 0}) then {
			[_mag, _ammo];
		} else {
			nil;
		};
	}) select {!isNil "_x"}
} else {
	_loadout
};

{
	[_veh, [0], _x, "remove"] call (missionNamespace getVariable "McD_fnc_vTurretMagazine");
} forEach (_veh magazinesTurret [0]);

private _weapons = (_veh weaponsTurret [0]);
if (_instantReload) then {
	{
		[_veh, [0], _x, "remove"] call (missionNamespace getVariable "McD_fnc_vTurretWeapon");
	} foreach _weapons;
};

{
	_x params ["_mag", ""];
	private _i = -1;
	private _count = 0;
	{
		if(_mag isEqualTo (_x # 0)) then {
			_count = _count + (_x # 1);
		};
	} foreach _loaded;
	if (_count > 0) then {
		private _numPerMag = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
		while { _count > 0 } do {
			[_veh, [0], _mag, "add", _numPerMag min _count] call (missionNamespace getVariable "McD_fnc_vTurretMagazine");
			_count = _count - (_numPerMag min _count);
		};
	};
} foreach (_veh getVariable ["McD_arty_mags_bought", []]);

if (_instantReload) then {
	{
		[_veh, [0], _x, "add"] call (missionNamespace getVariable "McD_fnc_vTurretWeapon");
	} foreach _weapons;
};