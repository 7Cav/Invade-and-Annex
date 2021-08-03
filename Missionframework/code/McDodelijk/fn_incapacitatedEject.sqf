/*/
File: fn_incapacitatedEject.sqf
Author:

	McDodelijk

Last modified:

	23/10/2020 by McDodelijk

Description:

	Ejectes unit out of vehicle. In case of a dead
	vehicle, simulate explosive ejection effect on unit
	Does not check for lifeState, but was designed
	with incapacitateted units in mind.
__________________________________________________/*/

scriptName "McD_fnc_incapacitatedEject";
params [
	["_unit", objNull, [objNull]],
	["_vehicle", objNull, [objNull]] // optional, defaults to units vehicle later
];

// Parameter check
if (isNull _unit) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_incapacitatedEject", _this] call McD_fnc_error;
};

// Enviorment check
if (!canSuspend) exitWith {
	["Suspending not allowed in this context, but required for %1", "McD_fnc_incapacitatedEject"] call McD_fnc_error;
};

// Locality check
if (!local _unit) exitWith {
	[_unit] remoteExec ["McD_fnc_incapacitatedEject", _unit, false];
};

// Abort when on foot
if (isNull objectParent _unit) exitWith {};

// No vehicle provided, default to current vehicle
if (isNull _vehicle) then {
	_vehicle = objectParent _unit;
};

// Abort if unit is not in the vehicle
if !(_vehicle == (objectParent _unit)) exitWith {};

private _wasIncapacitated = (lifeState _unit) isEqualTo "INCAPACITATED";
private _isDriver = ((driver _vehicle) == _unit);
private _vehicleDead = !alive _vehicle;
private _vel = velocity _vehicle;
private _engine = isEngineOn _vehicle;

moveOut _unit;
unassignVehicle _unit;
if (_wasIncapacitated) then {
	_unit setUnconscious FALSE;
};
waitUntil {(isNull (objectParent _unit))};
uiSleep 0.01;

// If vehicle is dead, simulate explosive ejection effect on unit
private _ejectDirection = if(_vehicleDead) then {random 360} else {_vehicle getDir _unit};
private _ejectSpeed = if(_vehicleDead) then {(3 + random 12)} else {3};
private _ejectVelocityVertical = if(_vehicleDead) then {(2 + random 8)} else {2};

_unit setDir _ejectDirection;
_unit setVelocity [
	(_vel select 0) + ((sin (_vehicle getDir _unit)) * _ejectSpeed),
	(_vel select 1) + ((cos (_vehicle getDir _unit)) * _ejectSpeed),
	(_vel select 2) + _ejectVelocityVertical
];

if (_wasIncapacitated) then {
	uiSleep 0.1;
	_unit setUnconscious TRUE;
};

if(!_vehicleDead && _isDriver) then {
	_vehicle engineOn _engine;
	//_vehicle setVelocity _vel; // Does not work, due to missing driver causing the emergency breaking
};