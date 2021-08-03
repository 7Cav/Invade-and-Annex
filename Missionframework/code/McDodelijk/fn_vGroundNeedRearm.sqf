/*/
File: fn_vGroundNeedRearm.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Return true when all default magazines are
	present	and 100% loaded
__________________________________________________/*/
scriptname "McD_fnc_vGroundNeedRearm";
params [
	["_veh", objNull, [objNull]]
];

// Parameter check
if (isNull _veh) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_vGroundNeedRearm", _this] call McD_fnc_error;
};

private _rearmNeeded = FALSE;

private _aps_params = _veh getVariable ['QS_aps_params',[]];
if (_aps_params isEqualType []) then {
	private _aps_ammo_max = _aps_params param [2, -1, [0]];
	if (_aps_ammo_max isEqualTo -1) then {
		_rearmNeeded = (['APS_VEHICLE', _veh] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams'))
	} else {
		private _aps_ammo_cur = _veh getVariable ['QS_aps_ammo',0];
		if (_aps_ammo_cur < _aps_ammo_max) then {
			_rearmNeeded = TRUE;
		};
	};
};
if (_rearmNeeded) exitWith { TRUE };

private _mags = magazinesAllTurrets _veh;
private _turrets = [];
private _fullMags = [];
{
	private _maxAmmoCount = getNumber (configFile >> "CfgMagazines" >> (_x # 0) >> "count");
	if( _maxAmmoCount == (_x # 2) ) then {
		_fullMags pushBack (_x # 0);
	};
	_turrets pushBackUnique (_x # 1);
} foreach _mags;
if!(count _fullMags == count _mags) exitWith { TRUE };
private _maxMags = [];
{
	_maxMags append getArray(([_veh, _x] call BIS_fnc_turretConfig) >> 'magazines');
} foreach _turrets;
if(count _fullMags == count _maxMags) exitWith { FALSE };
TRUE;