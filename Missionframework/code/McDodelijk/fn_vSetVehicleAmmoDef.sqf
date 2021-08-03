/*/
File: fn_vSetVehicleAmmoDef.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Locality safe wrapper setVehicleAmmoDef with the
	ability to go for a selection of turrets only
	Do not use due to https://feedback.bistudio.com/T139484
__________________________________________________/*/
scriptName "McD_fnc_vSetVehicleAmmoDef";
params [
	["_veh", objNull, [objNull]],
	["_amount", 1, [1]],
	["_turrets", nil, [[[0]]]]
];

// Parameter check
if (isNull _veh || _amount > 1 || _amount < 0) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vSetVehicleAmmoDef", _this] call McD_fnc_error;
};

if(isNil "_turrets") then {
	_turrets = allTurrets _veh;
};

private _turretsForServer = [];
{
	if(_veh turretlocal _x) then {
		_veh setVehicleAmmoDef 1;
	} else {
		if(isServer) then {
			private _turretOwner = [_veh, _x] call (missionNamespace getVariable "McD_fnc_turretOwner");
			[_veh, _amount, [_x]] remoteExecCall ["McD_fnc_vSetVehicleAmmoDef", _turretOwner, false];
		} else {
			_turretsForServer pushBack _x;
		};
	};
} foreach _turrets;

if (!isServer && count _turretsForServer > 0) then {
	[_veh, _amount, _turretsForServer] remoteExecCall ["McD_fnc_vSetVehicleAmmoDef", 2, false];
};