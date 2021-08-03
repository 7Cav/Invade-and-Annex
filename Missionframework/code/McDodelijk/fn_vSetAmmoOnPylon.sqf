/*/
File: fn_vSetAmmoOnPylon.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Locality safe wrapper for SetAmmoOnPylon command
	Rearms full capacity if not told otherwise
__________________________________________________/*/
scriptName "McD_fnc_vSetAmmoOnPylon";
params [
	["_veh", objNull, [objNull]],
	["_pylonIndex", nil, [0]],
	["_count", -1, [0]]
];

// Parameter check
if (isNull _veh || isNil "_pylonIndex" || {_pylonIndex < 1}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vSetAmmoOnPylon", _this] call McD_fnc_error;
};

private _pylonMag = (getPylonMagazines _veh) # (_pylonIndex-1);
if(_pylonMag isEqualTo "") exitWith {
	// No magazine loaded, do nothing
};

private _pylonTurret = getArray(((configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons") select (_pylonIndex-1) >> "turret"));

_count = if(_count < 0) then {
	getNumber (configFile >> "CfgMagazines" >> _pylonMag >> "count");
};

// Local? Do it!
if(count _pylonTurret == 0 || _veh turretLocal _pylonTurret) exitWith {
	_veh SetAmmoOnPylon [_pylonIndex, _count];
};

// Server direct call to turret owner
if(isServer) exitWith {
	private _turretOwner = [_veh, _pylonTurret] call (missionNamespace getVariable "McD_fnc_turretOwner");
	[_veh, [_pylonIndex, _count]] remoteExecCall ["SetAmmoOnPylon", _turretOwner, false];
};

// Not local, not the server => report to server!
_this remoteExecCall ["McD_fnc_vRearmPylon", 2, false];