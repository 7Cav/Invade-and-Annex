/*/
File: fn_artillery.sqf
Author:

	Quiksilver

Last modified:

	16/08/2018 A3 1.84 by Quiksilver

Description:

	-
__________________________________________________/*/

private ['_type','_pos','_dir','_v','_va','_dn'];
_type = _this select 0;
_va = [
	['B_MBT_01_arty_F'/*,'B_MBT_01_mlrs_F'*/],
	['B_T_MBT_01_arty_F'/*,'B_T_MBT_01_mlrs_F'*/]
] select (worldName in ['Tanoa','Enoch']);
if (_type isEqualTo 0) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_arty',0]) isEqualTo 0)) then {
		// spawn arty
		[selectRandom _va] call (missionNamespace getVariable 'McD_fnc_artySetup');
		// Trigger inital rearm
		[1] call (missionNamespace getVariable 'QS_fnc_artillery');
	};
};
if (_type isEqualTo 1) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_arty',0]) isEqualTo 0)) then {
		// Rearm Base AAs
		{
			_x call (missionNamespace getVariable 'McD_fnc_vSetVehicleAmmoDef');
			_x setVariable ['McD_rewardRefillsLeft4AO', (missionNamespace getVariable 'McD_missionConfig_baseAA_rewardRefillPerAO'), TRUE];
		} foreach (vehicles select { _x getVariable ['NL_vehicle_baseAA', FALSE] } );
		// Rearm Base Arty
		if (!isNull (missionNamespace getVariable 'QS_arty')) then {
			if (alive (missionNamespace getVariable 'QS_arty')) then {
				private _arty = (missionNamespace getVariable 'QS_arty');

				private _loadout = (missionNamespace getVariable 'McD_missionConfig_arty_freeLoadout') select { (typeOf _arty) in (_x # 0) };
				if(count _loadout > 0) then {
					_loadout = _loadout # 0 # 1;
				};
				[_arty, _loadout] call (missionNamespace getVariable 'McD_fnc_artyFreeReload');

				missionNamespace setVariable ['QS_artyShells',(missionNamespace getVariable 'McD_missionConfig_arty_shellFiringAllowancePerAO'),TRUE];
				missionNamespace setVariable ["McD_arty_rewardShellAllowance4AO", (missionNamespace getVariable 'McD_missionConfig_arty_rewardShellAllowancePerAO'), TRUE]; // earlier this was tied into the arty
				// unlock it
				[(missionNamespace getVariable 'QS_arty'),FALSE] remoteExec ["McD_fnc_artyLockTurret", (missionNamespace getVariable 'QS_arty'), FALSE];
			} else {
				[0] call (missionNamespace getVariable 'QS_fnc_artillery');
			};
		} else {
			[0] call (missionNamespace getVariable 'QS_fnc_artillery');	
		};
		// Announce the rearm
		['sideChat',[WEST,'HQ'],'The base equipment has been re-armed!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
		if (!((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 0)) then {
			_turrets = (missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]];
			if (!(_turrets isEqualTo [])) then {
				private _turret = objNull;
				{
					_turret = _x;
					['setVehicleAmmo',_turret,1] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				} forEach _turrets;
			};
		};
	};
};
