/*/
File: fn_uavOperator2.sqf
Author:

	Quiksilver

Last modified:

	4/06/2019 A3 1.94 by Quiksilver

Description:

	UAV Operator
__________________________________________________/*/
scriptName 'QS - Script - UAV';
private _role_check = diag_tickTime + 15;
for '_x' from 0 to 1 step 0 do {
	if (!(isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull]))) then {
		waitUntil {
			uiSleep 0.1;
			((isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) || (!(player getUnitTrait 'uavhacker')))
		};
		_role_check = diag_tickTime + 15;
	};
	if (!(player getUnitTrait 'uavhacker')) exitWith {};
	if (diag_tickTime > _role_check) exitWith {};
	uiSleep 0.1;
};
if (!(player getUnitTrait 'uavhacker')) exitWith {};
private _casEnabled = (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [2]) || (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [1,3]) && ((getPlayerUID player) in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist')))));
_QS_module_safezone_pos = markerPos 'QS_marker_base_marker';
_isOwnedApex = 395180 in (getDLCs 1);
_isOwnedJets = 601670 in (getDLCs 1);
_worldName = worldName;
_worldSize = worldSize;
createCenter WEST;
private _carrierEnabled = (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0));
private _uavData = missionNamespace getVariable ['QS_uav_Monitor',[]];
private _uavLoiterPosition = [0,0,0];
private _uavRespawnDelay = uiNamespace getVariable ['QS_uavRespawnDelay',-1];
private _cfgVehicles = configFile >> 'CfgVehicles';
if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 0)) then {
		_turrets = (missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]];
		if (!(_turrets isEqualTo [])) then {
			private _turret = objNull;
			{
				_turret = _x;
				['setOwner',_turret,clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
				['setGroupOwner',(group (gunner _turret)),clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
				_turret addEventHandler [
					'Fired',
					{
						params ['','','','','','','_projectile',''];
						missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
						missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
					}
				];
				_turret addEventHandler [
					'Local',
					{
						params ['_entity','_isLocal'];
						if (_isLocal) then {
							_entity removeAllEventHandlers 'Fired';
							_entity addEventHandler [
								'Fired',
								{
									params ['','','','','','','_projectile',''];
									missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
									missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
								}
							];
						};
					}
				];
			} forEach _turrets;
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 1) then {
	if (_worldName isEqualTo 'Altis') then {
		_uavLoiterPosition = [0,3000,500];
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [14156.311,16339.652,0.2]),128.481,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [14159.575,16343.695,0.2]),129.675,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [14249,16224.1,0]),305.479,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.6,'b_uav_05_f',0.4])] select _isOwnedJets),[15103.388,17257.938,0.405],132.812,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.6,'b_uav_05_f',0.4])] select _isOwnedJets),[15080.717,17235.36,0.405],133.595,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Tanoa') then {
		_uavLoiterPosition = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [6851.85,7436.02,0]),137.086,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [6845.19,7443.85,0]),138.766,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [6902.32,7400.82,4.22622]),76.2204,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.6,'b_uav_05_f',0.4])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Malden') then {
		_uavLoiterPosition = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [8195.94,10101.6,0]),268.097,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [8196.02,10096.1,0]),270.973,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [8108.06,10183.9,0]),267.806,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.6,'b_uav_05_f',0.4])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	_NL_baseLocation = trim markerText "nl_marker_baselocation";
	if (_NL_baseLocation == "noillizDefault") then {
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [14156.311,16339.652,0.3]),129,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [14159.575,16343.695,0.3]),129,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [14249,16224.1,0]),305.479,[],{},TRUE,_uavRespawnDelay],
			[objNull,'b_uav_02_dynamicloadout_f',[15103.388,17257.938,0.405],132.812,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f','b_uav_05_f'] select _isOwnedJets),[15080.717,17235.36,0.405],133.595,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_NL_baseLocation == "pavauDefault") then {
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [14716,16694,0.1]),45.755,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [14721,16699,0.1]),223.376,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [14820.9,16570.2,0]),312.871,[],{},TRUE,_uavRespawnDelay],
			[objNull,'b_uav_02_dynamicloadout_f',[15103.388,17257.938,0.405],132.812,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f','b_uav_05_f'] select _isOwnedJets),[15080.717,17235.36,0.405],133.595,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_NL_baseLocation == "knightDefault") then {
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [11575.8,11658.4,0.2]),121.4,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [11578.1,11662.2,0.2]),121.4,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [11563.5,11642.3,0]),301.9,[],{},TRUE,_uavRespawnDelay],
			[objNull,'b_uav_02_dynamicloadout_f',[11494,11545.2,0],125.7,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f','b_uav_05_f'] select _isOwnedJets),[11507.3,11564.3,0],125.7,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_NL_baseLocation == "AlxTuvanaka") then {
		_uavData = [
			[objNull,'b_ugv_01_f',(AGLToASL [2247.357,13433.08,0.2]),141,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [2242.122,13429.288,0.2]),141,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [2044,13263,0.1]),141.772,[],{},TRUE,_uavRespawnDelay],
			[objNull,'b_uav_02_dynamicloadout_f',[2138.07,13346.7,0],141.772,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f','b_uav_05_f'] select _isOwnedJets),[2156.28,13361.2,0],141.772,[],{},TRUE,_uavRespawnDelay]
		];
	};
};

if ( (!((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0)) && {(_uavData isEqualTo [])}) exitWith {};
if (_carrierEnabled) then {
	_uavLoiterPosition = [(((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) select 0) + 300),(((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) select 1) + 300),500];
	// Remove excess Falcon drones when Aircraft Carrier is enabled (only 1 can spawn without more config work).
	private _heliDroneCount = 0;
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isKindOf ['uav_03_base_f',(configFile >> 'CfgVehicles')]) then {
			_heliDroneCount = _heliDroneCount + 1;
			if (_heliDroneCount > 1) then {
				_uavData set [_forEachIndex,0];
			} else {
				_uavData set [_forEachIndex,[_uavEntity,'b_t_uav_03_dynamicloadout_f',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [35.0972,150.09,24.5]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -129.826),_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
			};
		};
	} forEach _uavData;
	_uavData = _uavData select {(_x isEqualType [])};
};
// If player doesnt own Apex DLC, filter out Apex UAVs
if (!(_isOwnedApex)) then {
	_uavData = _uavData select {(!((_x select 1) in ['b_t_uav_03_dynamicloadout_f','b_t_uav_03_f']))};
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isEqualTo 'o_t_uav_04_cas_f') then {
			_uavData set [_forEachIndex,[_uavEntity,'b_uav_02_dynamicloadout_f',_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
		};
	} forEach _uavData;
};
// If player doesnt own Jets DLC, filter out Jets UAVs
if (!(_isOwnedJets)) then {
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isEqualTo 'b_uav_05_f') then {
			_uavData set [_forEachIndex,[_uavEntity,'b_uav_02_dynamicloadout_f',_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
		};
	} forEach _uavData;
};
/*
// Modifys respawntime values, overriding the config from above
{
	_x params [
		'_uavEntity',
		'_uavType',
		'_uavSpawnPosition',
		'_uavSpawnDirection',
		'_uavSpawnVectors',
		'_uavInitCode',
		'_uavIsRespawning',
		'_uavCanRespawnAfter'
	];
	if ((_uavType isKindOf ['uav_02_base_f',_cfgVehicles]) || {(_uavType isKindOf ['uav_03_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_04_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_05_base_f',_cfgVehicles])}) then {
		_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,TRUE,_uavRespawnDelay]];
	} else {
		_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,TRUE,-1]];
	};
} forEach _uavData;
*/
private _uavElement = [];
private _uiTime = diag_tickTime;
private _ugvRespawnDelay = 120;
private _ugvRespawnFOB = FALSE;
private _operatorAtFOB = FALSE;
_uavRespawnDelay = 720;
_uavInitCodeGeneric = {
	params ['_uavEntity'];
	_grp = createVehicleCrew _uavEntity;
	_grp setVariable ['QS_HComm_grp',FALSE,TRUE];
	{
		_x disableAI 'LIGHTS';
	} forEach (units _grp);
	_uavEntity setPilotLight TRUE;
	_uavEntity setCollisionLight TRUE;
	if (_uavEntity isKindOf 'Plane') then {
		//_text = format ['A(n) %1 is available at grid %2',(getText (configFile >> 'CfgVehicles' >> (typeOf _uavEntity) >> 'displayName')),(mapGridPosition _uavEntity),worldName];
		//(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7,-1,_text,[],-1];
		_uavEntity allowDamage FALSE;
		_uavEntity animate ["wing_fold_l", 1, true];
		_uavEntity animate ["wing_fold_l_arm", 1, true];
		_uavEntity animate ["wing_fold_r", 1, true];
		_uavEntity animate ["wing_fold_r_arm", 1, true];
		_uavEntity setVariable ['QS_ropeAttached',FALSE,TRUE];
		_uavEntity enableRopeAttach TRUE;
		_uavEntity enableVehicleCargo TRUE;
		[57,_uavEntity] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		//[_uavEntity,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_uavEntity setVehicleReportRemoteTargets FALSE;
		_uavEntity engineOn FALSE;
		//_uavEntity flyInHeightASL [500,500,500];
		['setFeatureType',_uavEntity,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_uavEntity];
		_uavEntity setPylonLoadOut [1, '',true, [0]];
		_uavEntity setPylonLoadOut [2, '',true, [0]];
		sleep 5;
		_uavEntity allowDamage TRUE;
		/* _uavEntity spawn {
			_uavEntity = _this;
			for '_x' from 0 to 49 step 1 do {
				_uavEntity setVelocity [
					((velocity _uavEntity) select 0),
					((velocity _uavEntity) select 1),
					((((velocity _uavEntity) select 2) max 0) + 5)
				];
				uiSleep 0.05;
			};
		}; */
		//_uavPosition = getPosWorld _uavEntity;
		//_uavPosition set [2,500];
		//_wp = _grp addWaypoint [_uavPosition,100];
		//_wp setWaypointType 'LOITER';
		/* Gets set dynamically later
		_uavEntity addEventHandler [
			'Fired',
			{
				params ['','','','','_ammo','','_projectile',''];
				if ((toLower _ammo) in [
					'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
				]) then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
			}
		];
		*/
	};
	if ((toLower (typeOf _uavEntity)) in ['b_t_uav_03_dynamicloadout_f','b_t_uav_03_f']) then {
		_uavEntity setVelocity [0,0,0];
		_uavEntity spawn {
			for '_x' from 0 to 9 step 1 do {
				_this setVectorUp [0,0,1];
				uiSleep 1;
			};
			_this setDamage 0;
		};
		_uavEntity setVariable ['QS_ropeAttached',FALSE,TRUE];
		[_uavEntity,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_uavEntity removeWeapon 'missiles_SCALPEL';
		['setFeatureType',_uavEntity,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_uavEntity];
		/* Gets set dynamically later
		_uavEntity addEventHandler ['Fired',
			{
				params ['_vehicle','','','','','','_projectile',''];
				if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
					deleteVehicle _projectile;
				};
				if (alive (getAttackTarget _vehicle)) then {
					_assignedTarget = getAttackTarget _vehicle;
					if (!isNull (effectiveCommander _assignedTarget)) then {
						if (isPlayer (effectiveCommander _assignedTarget)) then {
							[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				};
			}
		];
		*/
	};
	if ((_uavEntity isKindOf 'ugv_01_base_f') && (!(_uavEntity isKindOf 'ugv_01_rcws_base_f'))) then {
		//_uavEntity addBackpackCargoGlobal ['b_uav_06_medical_backpack_f',2];
		_uavEntity enableVehicleCargo TRUE;
		_uavEntity enableRopeAttach TRUE;
		_uavEntity addRating (0 - (rating _uavEntity));
		{
			_x addRating (0 - (rating _x));
		} forEach (crew _uavEntity);
		_uavEntity addEventHandler ['HandleDamage',{_this call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
		_uavEntity setVariable ['QS_ropeAttached',FALSE,TRUE];
		_uavEntity setVariable ['QS_tow_veh',2,TRUE];
		_uavEntity addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				if (!((attachedObjects _entity) isEqualTo [])) then {
					{
						if (isSimpleObject _x) then {
							deleteVehicle _x;
						};
					} forEach (attachedObjects _entity);
				};
			}
		];
		_uavEntity addEventHandler [
			'Killed',
			{
				params ['_entity'];
				if (!((attachedObjects _entity) isEqualTo [])) then {
					{
						detach _x;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _entity);
				};
			}
		];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher1 attachTo [_uavEntity,[0,-0.75,-0.7]];
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher2 attachTo [_uavEntity,[0.85,-0.75,-0.7]];
	};
	if (_uavEntity isKindOf 'ugv_01_rcws_base_f') then {
		//_uavEntity addBackpackCargoGlobal ['b_uav_01_backpack_f',2];
		_uavEntity setVariable ['QS_ropeAttached',FALSE,TRUE];
		_uavEntity enableVehicleCargo TRUE;
		_uavEntity enableRopeAttach TRUE;
		_uavEntity addEventHandler ['Fired',
			{
				params ['_vehicle','','','','','','_projectile',''];
				if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
					deleteVehicle _projectile;
				};
				if (alive (getAttackTarget _vehicle)) then {
					_assignedTarget = getAttackTarget _vehicle;
					if (!isNull (effectiveCommander _assignedTarget)) then {
						if (isPlayer (effectiveCommander _assignedTarget)) then {
							[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				};
			}
		];
		_uavEntity addEventHandler ['HandleDamage',{_this call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
	};
};
_fn_isPosSafe = {
	params ['_position','_radius'];
	private _return = TRUE;
	_list1 = (_position select [0,2]) nearEntities ['All',_radius];
	if (!(_list1 isEqualTo [])) exitWith {FALSE};
	{
		if (!isNull _x) then {
			if (isSimpleObject _x) then {
				if (!(['helipad',((getModelInfo _x) select 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_return = FALSE;
				};
			};
		};
	} count (nearestObjects [_position,[],_radius,TRUE]);
	_return;
};
_fn_findSafePos = missionNamespace getVariable 'QS_fnc_findSafePos';
private _grp = grpNull;
private _safePos = [0,0,0];
for '_i' from 0 to 1 step 0 do {
	uiSleep 3;
	_uiTime = diag_tickTime;
	if ((player distance2D (markerPos 'QS_marker_module_fob')) < 300) then {
		if (!(_ugvRespawnFOB)) then {
			_ugvRespawnFOB = TRUE;
		};
	} else {
		if (_ugvRespawnFOB) then {
			_ugvRespawnFOB = FALSE;
		};
	};
	if (!(player getUnitTrait 'uavhacker')) exitWith {
		{
			_uavEntity = _x;
			if (!(_uavEntity getVariable ['QS_uav_protected',FALSE])) then {
				if !(isNull (isVehicleCargo _uavEntity)) then {
					objNull setVehicleCargo _uavEntity;
					sleep 0.1;
				};
				if (local _uavEntity) then {
					if (!((crew _uavEntity) isEqualTo [])) then {
						_grp = group (effectiveCommander _uavEntity);
						{
							_uavEntity deleteVehicleCrew _x;
						} forEach (crew _uavEntity);
						deleteGroup _grp;
					};
					deleteVehicle _uavEntity;
				} else {
					// tell the server to tell the owner to delete, if server checked it's not protected (preotection might only be active on server)
					[[_uavEntity], {
						params ['_uavEntity'];
						if (!(_uavEntity getVariable ['QS_uav_protected',FALSE])) then {
							if (local _uavEntity) then {
								if (!((crew _uavEntity) isEqualTo [])) then {
									_grp = group (effectiveCommander _uavEntity);
									{
										_uavEntity deleteVehicleCrew _x;
									} forEach (crew _uavEntity);
									deleteGroup _grp;
								};
								deleteVehicle _uavEntity;
							} else {
								[[_uavEntity], {
									params ['_uavEntity'];
									if (!((crew _uavEntity) isEqualTo [])) then {
										_grp = group (effectiveCommander _uavEntity);
										{
											_uavEntity deleteVehicleCrew _x;
										} forEach (crew _uavEntity);
										deleteGroup _grp;
									};
									deleteVehicle _uavEntity;
								}] remoteExec ['call', _uavEntity, false];
							};
						};
					}] remoteExec ['call', 2, false];
				};
			};
		} forEach allUnitsUav;
	};
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (!alive _uavEntity) then {
			if (!(_uavIsRespawning)) then {
				_uavCanRespawnAfter = _uiTime + ([_ugvRespawnDelay,_uavRespawnDelay] select (_uavType isKindOf ['Air',_cfgVehicles]));
				if ((_uavType isKindOf ['uav_02_base_f',_cfgVehicles]) || {(_uavType isKindOf ['uav_03_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_04_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_05_base_f',_cfgVehicles])}) then {
					_uavIsRespawning = missionNamespace getVariable ['QS_uavCanSpawn',FALSE];
					uiNamespace setVariable ['QS_uavRespawnDelay',_uavCanRespawnAfter];
				} else {
					_uavIsRespawning = TRUE;
				};
				_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
			} else {
				if (_uiTime > _uavCanRespawnAfter) then {
					if ([_uavSpawnPosition,4] call _fn_isPosSafe) then {
						if (!isNull _uavEntity) then {
							if (!((attachedObjects _uavEntity) isEqualTo [])) then {
								{
									deleteVehicle _x;
								} count (attachedObjects _uavEntity);
							};
							deleteVehicle _uavEntity;
							uiSleep 0.1;
						};
						if (_uavType isKindOf ['Plane',_cfgVehicles]) then {
							// UCav + Greyhawk
							//_uavEntity = createVehicle [_uavType,_uavLoiterPosition,[],50,'FLY'];
							_uavEntity = createVehicle [_uavType,_uavSpawnPosition,[],50,'NONE'];
							_uavEntity setDir _uavSpawnDirection;
							_uavEntity setPos _uavSpawnPosition;
						} else {
							if ((_ugvRespawnFOB) && (_uavType isKindOf ['ugv_01_base_f',_cfgVehicles]) && ((missionNamespace getVariable ['QS_module_fob_side',sideUnknown]) isEqualTo (player getVariable ['QS_unit_side',WEST]))) then {
								_safePos = [(markerPos 'QS_marker_module_fob'),0,70,5,0,5,0] call _fn_findSafePos;
								_uavEntity = createVehicle [_uavType,_safePos,[],0,'NONE'];
								_uavEntity setDir (random 360);
								_uavEntity setVehiclePosition [_safePos,[],0,'NONE'];
							} else {
								_uavEntity = createVehicle [_uavType,(ASLToAGL _uavSpawnPosition),[],0,'NONE'];
								if (_uavSpawnVectors isEqualTo []) then {
									_uavEntity setDir _uavSpawnDirection;
								} else {
									_uavEntity setVectorDirAndUp _uavSpawnVectors;
								};
								_uavEntity setPosASL _uavSpawnPosition;
							};
						};
						_uavEntity setVariable ['NL_vehicle_baseUAV',TRUE,TRUE];
						_uavEntity call _uavInitCodeGeneric;
						if (!(_uavInitCode isEqualTo {})) then {
							_uavEntity call _uavInitCode;
						};
						_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,FALSE,_uavCanRespawnAfter]];
					};
				};
			};
		} else {
			if ((_uavEntity isKindOf 'ugv_01_base_f') && (!(_uavEntity isKindOf 'ugv_01_rcws_base_f'))) then {
				if (!((rating _uavEntity) isEqualTo 0)) then {
					_uavEntity addRating (0 - (rating _uavEntity));
				};
				{
					if (!((rating _x) isEqualTo 0)) then {
						_x addRating (0 - (rating _x));
					};
				} forEach (crew _uavEntity);
			};
			// UAV is still alive, handle various situations
			if (((getPosASL _uavEntity) # 2) < -1.5) then {
				_uavEntity setDamage [1,FALSE];
			};
		};
	} forEach _uavData;
	{
		_uavEntity = _x;
		if (local _uavEntity) then {
			_uavEntity enableAI 'TEAMSWITCH';
			if ((!isNull (attachedTo _uavEntity)) || {(!isNull (isVehicleCargo _uavEntity))} || {(!isNull (ropeAttachedTo _uavEntity))}) then {
				if (!(_uavEntity getVariable ['QS_uav_disabledAI',FALSE])) then {
					_uavEntity setVariable ['QS_uav_disabledAI',TRUE,FALSE];
					_uavEntity disableAI 'ALL';
					{
						_x disableAI 'ALL';
					} forEach (crew _uavEntity);
				};
			} else {
				if (_uavEntity getVariable ['QS_uav_disabledAI',FALSE]) then {
					_uavEntity setVariable ['QS_uav_disabledAI',FALSE,FALSE];
					_uavEntity enableAI 'ALL';
					{
						_x enableAI 'ALL';
					} forEach (crew _uavEntity);
				};
			};
			if (isLaserOn _uavEntity) then {
				if (!isNull (laserTarget _uavEntity)) then {
					if (((laserTarget _uavEntity) distance2D _QS_module_safezone_pos) < 500) then {
						deleteVehicle (laserTarget _uavEntity);
					};
				};
			};

			// McDodelijk fix fired eventhandler for bought drones, extended for all
			if!(_uavEntity getVariable ["QS_uav_EHisSet", false]) then {
				//systemChat format["found lonly drone without eventhandler: %1 (%2)", typeOf _uavEntity, _uavEntity];
				_uavEntity addEventHandler [
					'Fired',
					{
						params ['','','','','_ammo','','_projectile',''];
						if ((toLower _ammo) in [
							'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
						]) then {
							missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
							missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
						};
					}
				];
				_uavEntity addEventHandler ['Fired',
					{
						params ['_vehicle','','','','','','_projectile',''];
						if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
							deleteVehicle _projectile;
						};
						if (!isNull (assignedTarget _vehicle)) then {
							if (alive (assignedTarget _vehicle)) then {
								_assignedTarget = assignedTarget _vehicle;
								if (!isNull (effectiveCommander _assignedTarget)) then {
									if (isPlayer (effectiveCommander _assignedTarget)) then {
										[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
									};
								};
							};
						};
					}
				];
				// mark for your self and only for you, that the eventhandlers are set
				_uavEntity setVariable ["QS_uav_EHisSet", true, false];
			};

			/* Obsolete since service menu changes
			// Setup Service Menu
			if(isNil {_uavEntity getVariable "ServiceMenuSetup"}) then {
				private _idSM = _uavEntity addAction ["Service Menu", NL_fnc_showUAVFWLoadout, [], 15, TRUE, TRUE, "", "[] call NL_fnc_isUAVFWServiceOk"];
				player setUserActionText [_idSM, "Service Menu", "<t size='3'>Service Menu</t>"];
				_uavEntity setVariable ["ServiceMenuSetup", true, false];
			};
			*/

			if (alive (driver _uavEntity)) then {
				if (((side (group (driver _uavEntity))) isEqualTo sideEnemy) || {(((side (group (driver _uavEntity))) getFriend WEST) < 0.6)}) then {
					[17,_x] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		} else { // Nonlocal drone
			if( !((getConnectedUAV player) isEqualTo objNull) && {(getConnectedUAV player) == _uavEntity} ) then {
				private _requestVehicleControl = FALSE;
				private _controlInfo = UAVControl _uavEntity;
				private _ownInterestInUAV = FALSE;
				private _otherInterestInUAV = FALSE;
				for "_i" from 0 to (count _controlInfo) step 2 do {
					if(player isEqualTo (_controlInfo # _i)) then {
						if("DRIVER" isEqualTo (_controlInfo # (_i + 1 ))) exitWith {
							_requestVehicleControl = TRUE;
						};
						_ownInterestInUAV = TRUE;
					} else {
						_otherInterestInUAV = TRUE;
					};
				};
				if (!_requestVehicleControl && {!_otherInterestInUAV}) then {
					_requestVehicleControl = _ownInterestInUAV;
				};
				if(_requestVehicleControl && !(_uavEntity getVariable ["McD_pendingLocalityRequest", false])) then {
					//titleText [format ["Requesting controls for %1. Stand by...", getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")], "PLAIN"];
					_uavEntity setVariable ["McD_pendingLocalityRequest", true, false];
					[[_uavEntity, player],
					{
						params ["_uav", "_player"];
						private _localityChanged = (group _uav) setGroupOwner (owner _player);
						// Yes, the following line creates a log on the server, but thx to bohemia, it's needed and works as of Feb. 2020
						private _localityChangedVic =  _uav setOwner (owner _player);
						[[[_localityChanged, _localityChangedVic], _uav],
						{
							params ["_changed", "_uav"];
							/*
							if( ({_x} count _changed) > 0) then {
								titleText [format ["Control for %1 transferred to you.", getText(configFile >> "CfgVehicles" >> typeOf _uav >> "displayName")], "PLAIN"];
							} else {
								titleText [format ["Control request for %1 expired.", getText(configFile >> "CfgVehicles" >> typeOf _uav >> "displayName")], "PLAIN"];
							};
							*/
							_uav setVariable ["McD_pendingLocalityRequest", nil, false];
						}] remoteExecCall ["call", _player];
					}] remoteExecCall ["call", 2];
				};
			};
		};
		uiSleep 0.1;
	} foreach allUnitsUav;
};
