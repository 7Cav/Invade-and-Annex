/*/
File: fn_artySwap.sqf
Author:

	McDodelijk

Last modified:

	25/04/2020 by McDodelijk

Description:

	Spawns or swaps artillery
__________________________________________________/*/
scriptName "McD_fnc_artySwap";
params [
	["_artyClass", nil, [""]]
];

// Parameter check
if (isNil "_artyClass") exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_artySwap", _this] call McD_fnc_error;
};

// Enviorment check
if (!isServer) exitWith {
	["%1 is only allowed to run on the server", "McD_fnc_artySwap"] call McD_fnc_error;
};
if (!canSuspend) exitWith {
	["Suspending not allowed in this context, but required for %1", "McD_fnc_artySwap"] call McD_fnc_error;
};

// If arty already spawned, save data
if ((!isNil {missionNamespace getVariable 'QS_arty'}) && (!isNull (missionNamespace getVariable 'QS_arty'))) then {
	// store artillery status for later swaps
	private _arty = (missionNamespace getVariable 'QS_arty');
	private _artyType = typeOf _arty;
	private _bought = _arty getVariable ["McD_arty_mags_bought", []];
	private _loaded = ((magazinesAllTurrets _arty) apply {
		_x params ["_mag", "_turret", "_ammo"];
		if (_turret isEqualTo [0] && {_ammo > 0}) then {
			[_mag, _ammo];
		} else {
			nil;
		};
	}) select {!isNil "_x"};
	private _swapedArty = missionNamespace getVariable ["McD_swapedArtyArray", []];
	private _index = _swapedArty findIf {((_x isEqualType []) && {(_x # 0) isEqualTo _artyType})};
	if (_index < 0) then {
		_swapedArty pushBack [_artyType, _loaded, _bought];
	} else {
		_swapedArty set [_index, [_artyType, _loaded, _bought]];
	};
	missionNamespace setVariable ["McD_swapedArtyArray", _swapedArty, FALSE];
	// Delete
	(missionNamespace getVariable 'QS_arty') remoteExec ["deleteVehicle", (missionNamespace getVariable 'QS_arty'), FALSE];
	waitUntil {isNull (missionNamespace getVariable 'QS_arty')};
	missionNamespace setVariable [
		'QS_analytics_entities_deleted',
		((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
		FALSE
	];
};

// Spawn new arty
[_artyClass] call (missionNamespace getVariable 'McD_fnc_artySetup');

// Double check the arty
private _arty = (missionNamespace getVariable 'QS_arty');
if (isNull _arty) exitWith {
	["Script %1 failed to get a new arty spawned: %2", "McD_fnc_artySwap", _this] call McD_fnc_error;
};

// load old ammo for artillery
private _swapedArty = missionNamespace getVariable ["McD_swapedArtyArray", []];
private _index = _swapedArty findIf {((_x isEqualType []) && {(_x # 0) isEqualTo _artyClass})};
if (_index < 0) then { // Load inital loadout
	private _loadout = (missionNamespace getVariable 'McD_missionConfig_arty_freeLoadout') select { _artyClass in (_x # 0) };
	if(count _loadout > 0) then {
		_loadout = _loadout # 0 # 1;
	};
	[_arty, _loadout] call (missionNamespace getVariable 'McD_fnc_artyFreeReload');
} else { // Load privious loadout
	_arty setVariable ["McD_arty_mags_bought", (_swapedArty # _index # 2)];
	/*
	{
		_x params ["_mag", "_ammo"];
		[_arty, [0], _mag, "add", _ammo] call (missionNamespace getVariable "McD_fnc_vTurretMagazine");
	} foreach (_swapedArty # _index # 1);
	*/
	[_arty, TRUE, (_swapedArty # _index # 1)] call (missionNamespace getVariable "McD_fnc_artyRestackAmmo");
};
