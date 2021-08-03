/*/
File: fn_vGetFlareMagTypes.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	-
__________________________________________________/*/
scriptName "McD_fnc_vGetFlareMagTypes";
params [["_veh", objNull, [objNull]]];

// Parameter check
if (isNull _veh) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vGetFlareMagTypes", _this] call McD_fnc_error;
	[];
};

private _mags = getArray(configFile >> "CfgVehicles" >> typeOf _veh >> "magazines");
// Add additional magazines, that were added later and are not part of the config
{ 
	if((_x # 1) isEqualTo [-1]) then { 
		_mags pushBackUnique (_x # 0);
	}; 
} foreach (magazinesAllTurrets _veh);

private _weapons = getArray(configFile >> "CfgVehicles" >> typeOf _veh >> "weapons");
// Add additional weapons, that were added later and are not part of the config
{ 
	_weapons pushBackUnique _x;
} foreach (_veh weaponsTurret [-1]);

private _flareMags = [];
// Filter flare weapons and get mags
{
	if(_x isKindOf ["CMFlareLauncher", configFile >> "CfgWeapons"]) then {
		_flareMags = getArray(configFile >> "CfgWeapons" >> _x >> "magazines");
	};
} foreach _weapons;

// Filter config and loaded mags with the flare weapon compatible ones
private _returnMags = [];
{
	if(_x in _flareMags) then {
		_returnMags pushBackUnique _x;
	};
} foreach _mags;

_returnMags;