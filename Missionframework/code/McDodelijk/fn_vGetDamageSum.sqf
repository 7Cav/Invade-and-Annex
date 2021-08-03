/*/
File: fn_vGetDamageSum.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Returns the sum of damage of all hit points of a vehicle
__________________________________________________/*/
scriptName "McD_fnc_vGetDamageSum";
params [["_veh", objNull, [objNull]]];
if(isNull _veh) exitWith { 
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vGetDamageSum", _this] call McD_fnc_error;
	0
};
private _sum = 0;
{_sum = _sum + _x} foreach ((getAllHitPointsDamage _veh) # 2);
_sum;