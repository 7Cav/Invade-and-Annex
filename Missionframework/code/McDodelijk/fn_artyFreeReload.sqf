/*/
File: fn_artyFreeReload.sqf
Author:

	McDodelijk

Last modified:

	25/04/2020 by McDodelijk

Description:

	Gives the arty a free refill while keeping bought rounds
__________________________________________________/*/
scriptName "McD_fnc_artyFreeReload";
params [
	["_veh", objNull, [objNull]],
	["_freeShells", [], [[]]]
];

// Parameter check
if (isNull _veh) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_artyFreeReload", _this] call McD_fnc_error;
};

private _boughtTotal = 0;
{_boughtTotal = _boughtTotal + ( _x # 1);} foreach (_veh getVariable ["McD_arty_mags_bought", []]);
private _numAllowedShells = (missionNamespace getVariable ["McD_missionConfig_arty_maximumShells", 0]) - _boughtTotal;

{
	[_veh, [0], _x, "remove"] call (missionNamespace getVariable "McD_fnc_vTurretMagazine");
} forEach (_veh magazinesTurret [0]);

{
	_x params ["_mag", "_num"];
	private _i = _freeShells findIf { (_x # 0) == _mag};
	private _freeNum = if(_i < 0) then { 0 } else { ((_freeShells # _i) # 1) };
	_freeNum = _numAllowedShells min _freeNum;
	_numAllowedShells = _numAllowedShells - (_numAllowedShells min _freeNum);
	private _totalShells = _freeNum + _num;
	private _numPerMag = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
	while {_totalShells > 0} do {
		[_veh, [0], _mag, "add", _numPerMag min _totalShells] call (missionNamespace getVariable "McD_fnc_vTurretMagazine");
		_totalShells = _totalShells - (_numPerMag min _totalShells);
	};
} foreach (_veh getVariable ["McD_arty_mags_bought", []]);