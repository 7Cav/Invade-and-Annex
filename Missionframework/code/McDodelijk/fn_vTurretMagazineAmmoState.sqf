/*/
File: fn_vTurretMagazineAmmoState.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Returns the percentage [0..1] of the ammo for
	each magazine type in a vehicle.
	Filter for turret path and type of magazine
	can be applied.
	Return format:
	[[classname, percentage, amount, turretPath], ...]
	Return with magazine type filter is never empty:
	[classname, percentage, amount, turretPath]
__________________________________________________/*/
scriptName "McD_fnc_vTurretMagazineAmmoState";
params [
	["_veh", objNull, [objNull]],
	["_turretPath", nil, [[0]]],
	["_magType", nil, [""]]
];

// Parameter check
if (isNull _veh) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vTurretMagazineAmmoState", _this] call McD_fnc_error;
};

// Get mags
private _turretMags = magazinesAllTurrets _veh;
// Filter by turretPath if given
if!(isNil "_turretPath") then {
	_turretMags = _turretMags select {(_x # 1) isEqualTo _turretPath};
};

private _magList = [];
if !(isNil "_magType") then { _magList pushBack [_magType, 0, 0, _turretPath]; };
{
	_x params ["_className", "_turretPath", "_ammoCount"];
	// filter for magType if given
	if ( (isNil "_magType") || {_magType == _className}) then {
		private _maxAmmoCount = getNumber (configFile >> "CfgMagazines" >> _className >> "count");
		// overloaded mags count as fully loaded, not more
		private _fill = 1 min (_ammoCount / _maxAmmoCount);
		private _index = _magList findIf {(_x # 0) == _className};
		if(_index < 0) then {
			_index = _magList pushback [_classname, 0, 0, _turretPath];
		};
		private _entry = _magList # _index;
		_entry set [1, (_entry # 1) + _fill];
		_entry set [2, (_entry # 2) + 1];
	};
} foreach _turretMags;

// calculate overall percentage for each mag type over all available mags of that type
{
	if (_x # 2 > 0) then {
		_x set [1, (_x # 1) / (_x # 2)];
	};
} foreach _magList;

if(count _magList > 0 && !isNil "_magType") then {
	_magList # 0;
} else {
	_magList;
};