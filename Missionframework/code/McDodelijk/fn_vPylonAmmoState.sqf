/*/
File: fn_vPylonAmmoState.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Returns the percentage [0..1] of the ammo
	Might return >1 if overloaded
	Returns 0 for unarmed pylons
__________________________________________________/*/
scriptName "McD_fnc_vPylonAmmoState";
params [
	["_veh", objNull, [objNull]],
	["_pylonIndex", nil, [0]]
];

// Parameter check
if (isNull _veh || isNil "_pylonIndex" || {_pylonIndex < 1}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vPylonAmmoState", _this] call McD_fnc_error;
};

private _pylonMag = (getPylonMagazines _veh) # (_pylonIndex-1);
if(_pylonMag isEqualTo "") exitWith {
	-1
};

private _maxAmmoCount = getNumber (configFile >> "CfgMagazines" >> _pylonMag >> "count");

// return fill state [0..1]
((_veh ammoOnPylon _pylonIndex) / _maxAmmoCount)
