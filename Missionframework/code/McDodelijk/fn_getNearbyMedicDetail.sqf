/*/
File: fn_getNearbyMedicDetail.sqf
Author:

	McDodelijk

Last modified:

	04/04/2020 by McDodelijk

Description:

	-
__________________________________________________/*/
scriptName "McD_fnc_getNearbyMedicDetail";
params [
	["_p", objNull, [objNull]],
	["_distance", 500, [0]],
	["_sorted", false, [false]]
];

// Parameter check
if (isNull _p) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_getNearbyMedicDetail", _this] call McD_fnc_error;
};

private _pos = getPosATL _p;
private _nearMan = _pos nearEntities [['Man'],_distance];
{
	_nearMan = _nearMan + crew _x;
} forEach (_pos nearEntities [['LandVehicle','Ship','Air'],_distance]);

private _medicDetail = [];
{
	_medicDetail pushBack [_x, (vehicle _x) distance _pos];
} foreach (_nearMan select {
	(!(captive _x)) &&
	{(side _x) in [WEST,CIVILIAN]} &&
	{lifeState _x in ["HEALTHY", "INJURED"]} &&
	{isPlayer _x} &&
	{_x getUnitTrait 'medic'}
});

if(_sorted) then {
	_medicDetail sort true;
};

_medicDetail;