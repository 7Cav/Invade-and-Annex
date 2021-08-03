/*/
File: fn_clientMFindHealer.sqf
Author:

	Quiksilver
	
Last modified:

	9/12/2017 A3 1.80 by Quiksilver

Description:

	Allow injured to know if a valid medic is nearby, and how far away.
_________________________________________________________________________________________/*/

params [
	["_p", objNull, [objNull]],
	["_distance", 500, [0]]
];

if (isNull _p) exitWith {
	["Script %1 missing or wrong parameter value: %2", "QS_fnc_clientMFindHealer", _this] call McD_fnc_error;
	"ERROR";
};

private _md = [_p, _distance, true] call McD_fnc_getNearbyMedicDetail;
if(count _md > 0) then {
	format ['Nearest medic is %1 (%2m)',(name (_md # 0 # 0)),(round (_md # 0 # 1))];
} else {
	format ['No medics within %1m', _distance];
}