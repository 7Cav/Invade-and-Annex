/*/
File: fn_checkServiceVehicles.sqf
Author:

	McDodelijk

Last modified:

	07/02/2020 A3 1.82 by McDodelijk

Description:

	Check for service vehicles or crates in the area
	to rearm, refuel or repair
__________________________________________________/*/

params [["_service", "", [""]], ["_position", objNull, [objNull, []]], ["_radius", 20, [0]]];
if(isNull _position || (_position isEqualType [] && {!(_position isEqualTypeArray [0,0,0])}) ) exitWith {};
private _check = [];
private _fuel = ["B_Slingload_01_Fuel_F","Land_Pod_Heli_Transport_04_fuel_F","B_Truck_01_fuel_F"];
private _repair = ["B_Slingload_01_Repair_F","Land_Pod_Heli_Transport_04_repair_F","B_Truck_01_Repair_F"];
private _rearm = ["B_Slingload_01_Ammo_F","Land_Pod_Heli_Transport_04_ammo_F","B_Truck_01_ammo_F"];

_check = switch (_service) do {
	case "all": { _fuel + _repair + _rearm };
	case "refuel": {_fuel};
	case "repair": {_repair};
	case "rearm": {_rearm};
	default {[]};
};

if(count _check == 0) exitWith { FALSE };

if(_position isEqualType objNull) then {
	_position = position _position;
};

({!(_x getVariable ['QS_repairdepot_disable',FALSE])} count (_position nearEntities [_check, _radius])) > 0