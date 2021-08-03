/*
File: fn_clientVehicleEventLocal.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/07/2016 A3 1.62 by Quiksilver

Description:

	Event Local
__________________________________________________________*/

params ['_vehicle','_isLocal'];

if (_vehicle isKindOf 'Air') then {
	if (_isLocal) then {
		_vehicle spawn {
			scriptName "McD_vehicleIsTouchingGround_Loop";
			params [["_vehicle", objNull, [objNull]]];
			while {local _vehicle} do {
				if(isTouchingGround _vehicle != _vehicle getVariable ["McD_vehicleIsTouchingGround", TRUE]) then {
					_vehicle setVariable ["McD_vehicleIsTouchingGround", isTouchingGround _vehicle, TRUE];
				};
				sleep 0.1;
			};
		};
	};
};