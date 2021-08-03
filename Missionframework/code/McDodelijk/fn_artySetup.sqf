/*/
File: fn_artySetup.sqf
Author:

	McDodelijk

Last modified:

	25/04/2020 by McDodelijk

Description:

	Setup (even spawn) the base artillery
__________________________________________________/*/
scriptName "McD_fnc_artySetup";
params [
	["_arty", objNull, [objNull, ""]]
];

// Parameter check
if (!(_arty isEqualType "") && {isNull _arty}) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_artySetup", _this] call McD_fnc_error;
};

// Enviorment check
if (!isServer) exitWith {
	["%1 is only allowed to run on the server", "McD_fnc_artySetup"] call McD_fnc_error;
};

// Classname => Spawn it
_arty = if (_arty isEqualType "") then {

	// spawn it
	missionNamespace setVariable [
		'QS_arty',
		(createVehicle [_arty,[0,0,1000],[],0,'NONE']),
		TRUE
	];

	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];

	(missionNamespace getVariable 'QS_arty')
};

// Check if spawning failed or the given vehicle is null
if (isNull _arty) exitWith {
	["Script %1 was unable to spawn artillery: %2", "McD_fnc_artySetup", _this] call McD_fnc_error;
};

// New artillery: set variable publicly, if not done already
if (!(isNull _arty) && !((missionNamespace getVariable ['QS_arty', objNull]) isEqualTo _arty)) then {
	missionNamespace setVariable ['QS_arty', _arty, TRUE];
};

// Position and orientation
private _pos = markerPos 'QS_marker_airbaseArtillery';
private _dir = markerDir 'QS_marker_airbaseArtillery';
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (worldName isEqualTo 'Altis') then {
		_dir = 134;
	};
	if (worldName isEqualTo 'Tanoa') then {
		_dir = 49.790;
	};
	if (worldName isEqualTo 'Malden') then {
		_dir = 269.346;
	}; 
};
_arty setDir _dir;
_arty setPos _pos;

// Make it fixed to it's location
private _fixPoint = (createGroup [sideLogic,TRUE]) createUnit ['Logic', _pos select [0,2] ,[],0,'CAN_COLLIDE'];
_fixPoint enableDynamicSimulation FALSE;
_fixPoint setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_fixPoint setVariable ['QS_cleanup_protected',TRUE,FALSE];
_fixPoint setDir _dir;
_arty attachTo [_fixPoint];

// arty is NOT allowed to service for rearm, fuel or repair
_arty setVariable ["McD_noService", TRUE, TRUE];
// emtpy the tank
if (local _arty) then {
	_arty setFuel 0;
} else {
	['setFuel',_arty,0] remoteExec ['QS_fnc_remoteExecCmd',_arty,FALSE];
};
// Damage disabled
_arty allowDamage FALSE;
// Garbage collector protection
_arty setVariable ['QS_cleanup_protected',TRUE,TRUE];
// Protect against zeus
_arty setVariable ['QS_curator_disableEditability',TRUE,FALSE];
// Disable the inventory
clearWeaponCargoGlobal _arty;
clearItemCargoGlobal _arty;
clearMagazineCargoGlobal _arty;
clearBackpackCargoGlobal _arty;
_arty setVariable ['QS_inventory_disabled',TRUE,TRUE];

// get available magazine types for this type of artillery
private _mags = [];
{
	_mags pushBackUnique [_x, 0];
} foreach getArray(configfile >> "CfgVehicles" >> typeOf _arty >> "Turrets" >> "MainTurret" >> "magazines");
// save buyable shells array [[magtype, 0], ...]
_arty setVariable ["McD_arty_mags_bought", _mags, TRUE];

// lock everything but the gunner and remove magazines
_arty lockDriver TRUE;
_arty lockCargo TRUE;
{
	_arty removeMagazineTurret [_x,[0]];
} forEach (_arty magazinesTurret [0]);

if (_arty isKindOf 'B_MBT_01_arty_F') then {
	_arty lockTurret [[0,0],TRUE];
	{
		_arty removeMagazineTurret [_x,[0,0]];
	} forEach (_arty magazinesTurret [0,0]);
};

// GetIn event handler
_arty addEventHandler ["GetIn", {
	params ["_arty", "_role", "_unit", "_turret"];
	[_arty, format ['Reward shell purchases left for this AO: %1', (missionNamespace getVariable 'McD_arty_rewardShellAllowance4AO')]] remoteExec ['vehicleChat',_unit,FALSE];
	[_arty, format ['Shots left for this AO: %1', (missionNamespace getVariable 'QS_artyShells')]] remoteExec ['vehicleChat',_unit,FALSE];
	private _magsInArty = (magazinesAllTurrets _arty);
	{
		_x params ["_magType", "_numBought"];
		private _magTypeShells = 0;
		{_magTypeShells = _magTypeShells + ( _x # 2);} foreach (_magsInArty select {(_x # 1) isEqualTo [0] && (_x # 0) == _magType});
		if (_magTypeShells > 0) then {
			[_arty, format ['%1: %2', getText(configFile >> "CfgMagazines" >> (_x # 0) >> "DisplayName"), _magTypeShells]] remoteExec ['vehicleChat',_unit,FALSE];
		};
	} foreach (_arty getVariable ["McD_arty_mags_bought", []]);
	// Kick players out of empty arty
	if((missionNamespace getVariable 'QS_artyShells') < 1) then {
		{
			[50, ['The artillery has depleted its allowed shells, no more can be fired until the AO is completed!','PLAIN DOWN',1]] remoteExec ['cutText',_x,FALSE];
			moveOut _x;
		} foreach (crew _arty);
	} else { // The following code is needed because the fired eh does not fire when the last shell is fired. Great, isn't it?!
		[_arty, _unit] spawn {
			params ["_arty", "_gunner"];
			private _lastNoticedMags = (_arty getVariable ["McD_arty_mags_bought", []]);
			while {(vehicle _gunner) == _arty} do {
				sleep 1;
				private _magazine = "";
				private _magsLoaded = (magazinesAllTurrets _arty);

				_lastNoticedMags = (_lastNoticedMags apply {
					_x params ["_m", "_last"];
					private _now = 0;
					{_now = _now + (_x # 2);} foreach (_magsLoaded select {(_x # 0) == _m});
					if(_now < _last) then {
						_magazine = _m;
					};
					[_m, _now];
				});
				
				if(_magazine != "") then { // following is copied code from the fired eh
					if ((missionNamespace getVariable ['QS_artyShells', 0]) > 0) then {
						if ((missionNamespace getVariable ['QS_artyShells', 0]) == 1) then {
							[_arty,TRUE] remoteExec ["McD_fnc_artyLockTurret", _arty, FALSE];
							{
								[50, ['The artillery has depleted its allowed shells, no more can be fired until the AO is completed!','PLAIN DOWN',1]] remoteExec ['cutText',_x,FALSE];
								moveOut _x;
							} foreach (crew _arty);
						};
						missionNamespace setVariable [
							'QS_artyShells',
							((missionNamespace getVariable 'QS_artyShells') - 1),
							TRUE
						];
						private _magsAllTurrets = (magazinesAllTurrets _arty);
						private _mags = ((_arty getVariable ["McD_arty_mags_bought", []]) apply {
							private _re = _x;
							_x params ["_m", "_nb"];
							if(_magazine == _m) then {
								if(_nb > 0) then {
									private _n = 0;
									{
										_x params ["_className", "_turretPath", "_ammoCount", "_id", "_creator"];
										if (_turretPath isEqualTo [0] && _magazine == _className) then {
											_n = _n + _ammoCount;
										};
									} foreach _magsAllTurrets;
									if (_n < _nb) then {
										_re = [_m, _nb - 1];
									};
								};
							};
							_re;
						});
						_arty setVariable ["McD_arty_mags_bought", _mags, TRUE];
						[_gunner, [1, format ['Artillery shell fired. Shots left for this AO: %1', (missionNamespace getVariable 'QS_artyShells')]]] remoteExec ['customChat',-2,FALSE];
					} else {
						[_gunner, [1, "You tricked the system to fire another shell, so we deleted it."]] remoteExec ['customChat',_gunner,FALSE];
						diag_log format ["Error/Warning: %1 fired a artillery shell with no shells left to be shoot", _gunner];
					};
				};
			};
		};
	};
}];

// Fired event handler
_arty addEventHandler [
	'Fired',
	{
		params ["_arty", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		if ((missionNamespace getVariable ['QS_artyShells', 0]) < 1) then {
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _projectile;
		/* //Rest is handled elsewhere, because fired event handler did not always fire when it was the last shell of a mag
			[_gunner, [1, "You tricked the system to fire another shell, so we deleted it."]] remoteExec ['customChat',_gunner,FALSE];
			diag_log format ["Error/Warning: %1 fired a artillery shell with no shells left to be shoot", _gunner];
		} else {
			if ((missionNamespace getVariable ['QS_artyShells', 0]) == 1) then {
				[_arty,TRUE] remoteExec ["McD_fnc_artyLockTurret", _arty, FALSE];
				{
					[50, ['The artillery has depleted its allowed shells, no more can be fired until the AO is completed!','PLAIN DOWN',1]] remoteExec ['cutText',_x,FALSE];
					moveOut _x;
				} foreach (crew _arty);
			};
			missionNamespace setVariable [
				'QS_artyShells',
				((missionNamespace getVariable 'QS_artyShells') - 1),
				TRUE
			];
			private _magsAllTurrets = (magazinesAllTurrets _arty);
			private _mags = ((_arty getVariable ["McD_arty_mags_bought", []]) apply {
				private _re = _x;
				_x params ["_m", "_nb"];
				if(_magazine == _m) then {
					if(_nb > 0) then {
						private _n = 0;
						{
							_x params ["_className", "_turretPath", "_ammoCount", "_id", "_creator"];
							if (_turretPath isEqualTo [0] && _magazine == _className) then {
								_n = _n + _ammoCount;
							};
						} foreach _magsAllTurrets;
						if (_n < _nb) then {
							_re = [_m, _nb - 1];
						};
					};
				};
				_re;
			});
			_arty setVariable ["McD_arty_mags_bought", _mags, TRUE];
			[_gunner, [1, format ['Artillery shell fired. Shots left for this AO: %1', (missionNamespace getVariable 'QS_artyShells')]]] remoteExec ['customChat',-2,FALSE];
		*/
		};
	}
];