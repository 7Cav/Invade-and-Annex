/*/
File: fn_clientInGameUIAction.sqf
Aut1r:

	Quiksilver

Last modified:

	2020 by Noilliz

Description:

	inGameUISetEventHandler ['Action', 'hint str _this; false']; //hints your current action
__________________________________________________________________________/*/

if (_this isEqualTo []) exitWith {TRUE};
if (!(diag_tickTime > (player getVariable 'QS_client_uiLastAction'))) exitWith {TRUE};
player setVariable ['QS_client_uiLastAction',(diag_tickTime + 1),FALSE];
params ['_QS_actionTarget','_QS_player','_QS_actionIndex','_QS_actionName','_QS_actionText','_QS_actionPriority','_QS_actionShownWindow','_QS_actionHiddenOnUse','_QS_actionShortcutName','_QS_actionVisibility','_QS_actionEventName'];
private _QS_c = FALSE;
private _text = '';
private _base = getMarkerPos 'QS_marker_base_marker';
private _getIn = ['GetInCargo', 'GetInCommander', 'GetInDriver', 'GetInGunner', 'GetInPilot', 'GetInTurret'];
private _moveTo = ['MoveToCargo', 'MoveToCommander', 'MoveToDriver', 'MoveToGunner', 'MoveToPilot', 'MoveToTurret'];
private _baseProtection = ['SetTimer', 'TouchOff', 'UseWeapon', 'StartTimer', 'TouchOffMines', 'UseMagazine', 'UseContainerMagazine'];
private _allowedAssembleUAVBackpacks = ['b_uav_06_medical_backpack_f','b_uav_06_backpack_f','b_uav_01_backpack_f','b_ugv_02_demining_backpack_f','b_ugv_02_science_backpack_f'];

/* scroll wheel action check */
_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
if (_QS_actionName isEqualTo 'User') then {
	if (!(_QS_actionText isEqualTo '')) then {
		if (_QS_module_opsec) then {
			if (!((getPlayerUID player) in (['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist')))) then {
				_whitelistedActions = [] call (missionNamespace getVariable 'QS_data_actions');
				if ((!(_QS_actionText in _whitelistedActions)) && (!(['ROBOCOP',_QS_actionText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) && (!(['Put Explosive Charge',_QS_actionText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))) then {
					_QS_c = TRUE;
					[
						40,
						[
							time,
							serverTime,
							(name player),
							profileName,
							profileNameSteam,
							(getPlayerUID player),
							2,
							(format ['Non-whitelisted scroll action text: "%1"',_QS_actionText]),
							player,
							productVersion
						]
					] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					removeAllActions player;
				};
			};
		};
	};
};
if (_QS_c) exitWith {_QS_c;};

/* Busy checks */
if (((animationState player) in [
	'ainvpknlmstpslaywrfldnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywnondnon_medicother','ainvpknlmstpslaywnondnon_medicother',
	'ainvpknlmstpslaywnondnon_medic','ainvpknlmstpslaywrfldnon_medic','ainvpknlmstpslaywpstdnon_medic','ainvppnemstpslaywnondnon_medic','ainvppnemstpslaywrfldnon_medic',
	'ainvppnemstpslaywpstdnon_medic'
]) && (!((toLower _QS_actionText) in ['cancel']))) exitWith {
	50 cutText ['Busy','PLAIN DOWN',0.333];
	_QS_c = TRUE;
	_QS_c;
};
if (player getVariable ['NL_interact_busy', FALSE]) exitWith {
	2 cutText ['Press [Space] to place sandbag, [Ctrl+Space] to cancel your action. [Ctrl+Scrollwheel] to switch sandbag type, [Scrollwheel] to rotate','PLAIN',2];
	TRUE
};
/* Alive? */
if (!((lifeState player) in ['HEALTHY','INJURED'])) exitWith {
	50 cutText ['Incapacitated','PLAIN DOWN',0.333];
	_QS_c = TRUE;
	_QS_c;
};
/* Dragging / carrying stuff? */
if (_QS_actionName in _getIn && { (player getVariable ['QS_RD_dragging',FALSE] || player getVariable ['QS_RD_carrying',FALSE])}) exitWith {
	_text = 'Release anything you are dragging/carrying before entering a vehicle!';
	50 cutText [_text,'PLAIN',0.5];
	_QS_c = TRUE;
	_QS_c;
};
/*
if (['GetIn',_QS_actionName,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if (!((attachedObjects player) isEqualTo [])) then {
		if (!(((attachedObjects player) findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)) then {
			50 cutText ['Release / Load before getting in','PLAIN DOWN',0.75];
			_QS_c = TRUE;
		};
	};
};
*/
if ((!(((attachedObjects player) findIf {((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))}) isEqualTo -1)) && (!((toLower _QS_actionText) in [
	'release','load','retract cargo ropes','extend cargo ropes','shorten cargo ropes','release cargo','deploy cargo ropes','attach to cargo ropes','drop cargo ropes','pickup cargo ropes'
])) && (!(_QS_actionName in ['OpenParachute']))) exitWith {
	50 cutText ['Busy','PLAIN DOWN',0.333];
	_QS_c = TRUE;
	_QS_c;
};

/* QS-Healing */
if (_QS_actionName isEqualTo 'HealSoldier') exitWith {
	if (!(((attachedObjects player) findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)) then {
		50 cutText ['Cannot heal at this time','PLAIN DOWN'];
		_QS_c = TRUE;
	};
	if ((lifeState _QS_actionTarget) isEqualTo 'INCAPACITATED') then {
		_QS_c = TRUE;
		50 cutText [(format ['%1 must be revived. Treatment failed!',(name _QS_actionTarget)]),'PLAIN DOWN'];
	};
	if (!isNil {_QS_actionTarget getVariable 'QS_noHeal'}) then {
		_QS_c = TRUE;
		50 cutText ['He cannot be treated','PLAIN DOWN'];
	};
	if (!(_QS_c)) then {
		_QS_c = TRUE;
		if (isPlayer _QS_actionTarget) then {
			[63,[5,[(format ['Being treated by %1',profileName]),'PLAIN DOWN',0.5]]] remoteExec ['QS_fnc_remoteExec',_QS_actionTarget,FALSE];
		};
		player setVariable ['QS_treat_entryAnim',(animationState player),FALSE];
		player setVariable ['QS_treat_target',_QS_actionTarget,FALSE];
		_animEvent = player addEventHandler [
			'AnimDone',
			{
				params ['_unit','_anim'];
				if (['medicdummyend',_anim,false] call (missionNamespace getVariable 'QS_fnc_inString')) then {
					if ((lifeState _unit) in ['HEALTHY','INJURED']) then {
						_target = _unit getVariable ['QS_treat_target',objNull];
						if (!isNull _target) then {
							if (((_target distance _unit) <= 2.5) && (isNull (objectParent _target)) && ((lifeState _target) in ['HEALTHY','INJURED'])) then {
								_unit removeItem 'FirstAidKit';
								_target setDamage [([0.25,0] select (_unit getUnitTrait 'medic')),TRUE];
							};
						};
					};
					if (!isNull (_unit getVariable ['QS_treat_target',objNull])) then {
						_unit setVariable ['QS_treat_target',objNull,FALSE];
					};
				};
			}
		];
		player playActionNow 'MedicOther';
		[_QS_actionTarget,_animEvent] spawn {
			params ['_injured','_animEvent'];
			_timeout = diag_tickTime + 10;
			uiSleep 0.5;
			waitUntil {
				uiSleep 0.05;
				((isNull (player getVariable 'QS_treat_target')) || {(!((lifeState player) in ['HEALTHY','INJURED']))} || {(diag_tickTime > _timeout)} || {((_injured distance player) > 2.5)})
			};
			if ((_injured distance player) > 2.5) then {
				player setVariable ['QS_treat_target',objNull,FALSE];
				if ((lifeState player) in ['HEALTHY','INJURED']) then {
					_nearbyPlayers = allPlayers inAreaArray [(getPos player),100,100,0,FALSE,-1];
					['switchMove',player,(player getVariable ['QS_treat_entryAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',_nearbyPlayers,FALSE];
				};
			};
			if (!isNull (player getVariable 'QS_treat_target')) then {
				player setVariable ['QS_treat_target',objNull,FALSE];
			};
			player removeEventHandler ['AnimDone',_animEvent];
		};
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* QS-Repair */
if (_QS_actionName isEqualTo 'RepairVehicle') exitWith {
	if (!(((crew _QS_actionTarget) findIf {(alive _x)}) isEqualTo -1)) then {
		{
			if ((side _x) in ([player] call (missionNamespace getVariable 'QS_fnc_enemySides'))) exitWith {
				_QS_c = TRUE;
				50 cutText ['Cannot repair active enemy vehicle','PLAIN',0.5];
			};
		} count (crew _QS_actionTarget);
	};
	if (!(_QS_c)) then {
		if (!isNil {_QS_actionTarget getVariable 'QS_RD_noRepair'}) then {
			_QS_c = TRUE;
			50 cutText ['Cannot repair this vehicle','PLAIN DOWN'];
		} else {
			if (!isNull (effectiveCommander _QS_actionTarget)) then {
				if (isPlayer _QS_actionTarget) then {
					if (alive _QS_actionTarget) then {
						if (!(_QS_actionTarget isEqualTo (vehicle player))) then {
							[63,[5,[(format ['Your vehicle is being repaired by %1',profileName]),'PLAIN DOWN',0.5]]] remoteExec ['QS_fnc_remoteExec',(effectiveCommander _QS_actionTarget),FALSE];
						};
					};
				};
			};
			/*
			if ((fuel (_this select 0)) isEqualTo 0) then {
				0 = [_this select 0] spawn {
					_v = _this select 0;
					uiSleep 5;
					if (local _v) then {
						_v setFuel (0.03 + (random 0.03));
					} else {
						['setFuel',_v,(0.03 + (random 0.03))] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
					};
					_dn = getText (configFile >> 'CfgVehicles' >> (typeOf (_this select 0)) >> 'displayName');
					50 cutText [(format ['%1 refueled',_dn]),'PLAIN DOWN',0.75];
				};
			};
			*/
			/*
			if ((_this select 0) isKindOf 'Helicopter') then {
				(_this select 0) setHit ['tail_rotor_hit',0];
			};
			*/
		};
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* roles */
private _iamUAV = player getUnitTrait 'uavhacker';
private _iamPilot = ((player getUnitTrait 'QS_trait_pilot') || (player getUnitTrait 'QS_trait_fighterPilot'));
private _iamBasePlayer = _iamUAV || _iamPilot || (player getUnitTrait 'QS_trait_HQ');
private _role = (['GET_ROLE_DISPLAYNAME',(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable ['QS_fnc_roles',{'rifleman'}]));

/* UAV Terminal for uav only */
if (_QS_actionName isEqualTo 'UAVTerminalOpen') then {
	if (!(_iamUAV)) then {
		_text = 'You need to be an UAV operator to use the UAV Terminal';
		50 cutText [_text,'PLAIN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* Vehicle locked by variable */
if (_QS_actionName in _getIn) then {
	_t = cursorTarget;
	_u = _t getVariable 'NL_lockAllowed';
	if ((_u select 1) == 0) then {
		_text = 'This vehicle is locked';
		50 cutText [_text,'PLAIN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* Prohibit actions at base like putting explosives and so on */
if (_QS_actionName in _baseProtection) then {
	if (((position player) distance _base) < 500) then {
		_text = 'You can not do that at base!';
		50 cutText [_text,'PLAIN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* Only allow drones to be deployed at base */
if (_QS_actionName isEqualTo 'Assemble') then {
	if !((_QS_actionTarget == player) && ((toLower (backpack player)) in _allowedAssembleUAVBackpacks)) then {
		if (((position player) distance _base) < 500) then {
			_text = 'You can not assemble this at base.';
			50 cutText [_text,'PLAIN',0.5];
			_QS_c = TRUE;
		};
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

/* Only pilots can get in as pilot or take piloting controls */
if ((_QS_actionName isEqualTo 'GetInPilot') || (_QS_actionName isEqualTo 'TakeVehicleControl') || (_QS_actionName isEqualTo 'MoveToPilot')) exitWith {
	if (!_iamPilot && ((cameraOn getVariable ['QS_unit_side', (side cameraOn)]) isEqualTo WEST)) then {
		_text = format ['ROBOCOP: Only pilots can fly! You are a(n) ***** %1 *****. Play your role or re-assign!',_role];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,FALSE,8,-1,_text,[],-1];
		_QS_c = TRUE;
	};
	if ((!isNil {player getVariable 'QS_tto'}) && ((player getVariable 'QS_tto') > 3)) then {
		_text = 'Please relog. If the problem persists, contact an admin with the following error code: 44886';
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,FALSE,8,-1,_text,[],-1];
		_QS_c = TRUE;
	};
	_QS_c;
};

/* Autohover enabled */
if (_QS_actionName isEqualTo 'AutoHover') then { // Check double message? see clientEventKeyDown
	_v = vehicle player;
	if (_v isKindOf 'Helicopter' && local _v) then {
		if (!(isAutoHoverOn _v)) then {
			if (((count (crew _v))) > 1) then {
				if (diag_tickTime > (player getVariable ['QS_client_lastAutoHoverMsg',-1])) then {
					player setVariable ['QS_client_lastAutoHoverMsg',(diag_tickTime + 5),FALSE];
					_arrayToSend = (crew _v) select {((!(_x isEqualTo player)) && (alive _x) && (isPlayer _x))};
					if (!(_arrayToSend isEqualTo [])) then {
						[63,[5,[(format ['Your pilot ( %1 ) has turned on autohover!',profileName]),'PLAIN DOWN',0.3]]] remoteExec ['QS_fnc_remoteExec',_arrayToSend,FALSE];
					};
				};
			};
		};
	};
};
if (_QS_c) exitWith {_QS_c;};

/* Unloading unconscious */
if (_QS_actionName isEqualTo 'UnloadUnconsciousUnits') then { // TODO fix fcking zoom bug
	if (isNull (objectParent player)) then {
		50 cutText ['Unconscious units unloaded','PLAIN DOWN',0.5];
	} else {
		50 cutText ['Must be on foot','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	if (!isNull (isVehicleCargo _QS_actionTarget)) then {
		50 cutText ['Cannot do that at this time','PLAIN DOWN',0.5];
		_QS_c = TRUE;
		
	};
	if (surfaceIsWater (getPosWorld _QS_actionTarget)) then {
		50 cutText ['Cannot do that here','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	if (!isNull (ropeAttachedTo _QS_actionTarget)) then {
		50 cutText ['Cannot do that at this time','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};

if (_QS_actionName in (_getIn + _moveTo)) exitWith {
	// stop lonewolfs from entering vehicles at base
	private _playerPos = (position player);
	if (!_iamBasePlayer && 
		{
			(_playerPos distance2D _base) < 500 || 
			{(_playerPos distance2D (getmarkerpos "RewardTank")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardShip")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardCar")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardHelicopter")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardContainer")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardUAV")) < 150} ||
			{(_playerPos distance2D (getmarkerpos "RewardPlane")) < 150}
		}) then {
		private _isAdmin = (getPlayerUID player) in (['ADMIN'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]));
		if (!_isAdmin) then {
			private _groupunits = units group player;
			private _numPilotsInSquad = {(_x getUnitTrait 'QS_trait_pilot')} count _groupunits;
			private _minSquadSize = if (_QS_actionTarget isKindOf "Tank" || _QS_actionTarget isKindOf "Wheeled_APC_F") then {
										if (_QS_actionTarget isKindOf "LT_01_base_F") then {
											2;
										} else {
											3;
										};
									} else {
										6;
									};
			if ((count _groupunits) < _minSquadSize && _numPilotsInSquad == 0) then {
				_text = 'Please move to the squad assignment area and join a squad!';
				50 cutText [_text,'PLAIN',0.5];
				_QS_c = TRUE;
			};
		};
	};
	if ((!isNil { _QS_actionTarget getVariable 'NL_vehicle_base' })) then {
		if (!(_iamBasePlayer && _QS_actionName isEqualTo 'GetInDriver')) then {
			_text = 'You are not allowed to use this vehicle!';
			50 cutText [_text,'PLAIN',0.5];
			_QS_c = TRUE;
		};
	};
	if ((!isNil { _QS_actionTarget getVariable 'NL_vehicle_baseAA' }) || 
		((_QS_actionTarget) isEqualTo (missionNamespace getVariable 'QS_arty')) 
		) then {
		if (!(_iamBasePlayer && _QS_actionName isEqualTo 'GetInTurret')) then {
			_text = "You are not allowed to use this vehicle's turret.";
			50 cutText [_text,'PLAIN',0.5];
			_QS_c = TRUE;
		} else {
			if!(_QS_actionTarget lockedTurret [0,0]) then {
				_QS_c = TRUE;
				// move to gunner regardless of commander or gunner was selected
				player moveInTurret [_QS_actionTarget, [0]];
			}
		};
	};
	_QS_c;
};

/* Trigger gear check after taking stuff */
if (_QS_actionName in ['TakeWeapon', 'TakeItem', 'TakeMagazine', 'Rearm']) exitWith {
	0 spawn {
		scriptName 'Delayed gear check after take action';
		uisleep 2;
		if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
			missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
		};
	};
	_QS_c;
};

/* Pilot Blackfish eject fix & 'seatbealt sign' */
if (
	_QS_actionName isEqualTo 'Eject' &&
	{(vehicle player) isKindOf "Air"} &&
	{
		(
			(vehicle player) isKindOf 'VTOL_01_base_F' &&
			{(currentPilot (vehicle player)) == player}
		) ||
		{
			((vehicle player) distance2D (markerPos 'QS_marker_base_marker')) < 500 &&
			{!((vehicle player) getVariable ["McD_vehicleIsTouchingGround", TRUE])}
		}
	}
) exitWith {
	_QS_c = TRUE;
	_text = ["Don't try to leave this expensive asset mid flight!", "Please remain seated until the airplane reaches it's final parking position"] select !((currentPilot (vehicle player)) == player);
	50 cutText [_text,'PLAIN',0.5];
	_QS_c;
};

/* Load & unload stomper into blackfish remove stretcher models to prevent explosions */
if (
	_QS_actionName isEqualTo 'LoadVehicle' &&
	!_QS_c &&
	_QS_actionTarget isKindOf 'VTOL_01_base_F'
) exitWith {
	[getVehicleCargo _QS_actionTarget, _QS_actionTarget] spawn {
		params ['_preLoadCargo', '_cargoVehicle'];
		waitUntil {count _preLoadCargo != count getVehicleCargo _cargoVehicle};
		private _QS_action_ugv_stretcherModel = 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d';
		{
			private _vehicle = _x;
			if (!(((attachedObjects _vehicle) findIf {(((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) && (!(isObjectHidden _x)))}) isEqualTo -1)) then {
				{
					if ((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) then {
						if (!(isObjectHidden _x)) then {
							[71,_x,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				} forEach (attachedObjects _vehicle);
			};
		} foreach ((getVehicleCargo _cargoVehicle) - _preLoadCargo);
	};
	_QS_c;
};
if (
	_QS_actionName isEqualTo 'UnloadVehicle' &&
	!_QS_c &&
	_QS_actionTarget isKindOf 'UGV_01_base_F'
) exitWith {
	[_QS_actionTarget] spawn {
		params ['_vehicle'];
		waitUntil {isNull (isVehicleCargo _vehicle)};
		private _QS_action_ugv_stretcherModel = 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d';
		if (!(((attachedObjects _vehicle) findIf {(((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) && (isObjectHidden _x))}) isEqualTo -1)) then {
			{
				if ((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) then {
					if (isObjectHidden _x) then {
						[71,_x,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
				};
			} forEach (attachedObjects _vehicle);
		};
	};
	_QS_c;
};
if (
	_QS_actionName isEqualTo 'UnloadAllVehicles' &&
	!_QS_c &&
	_QS_actionTarget isKindOf 'VTOL_01_base_F'
) exitWith {
	[getVehicleCargo _QS_actionTarget, _QS_actionTarget] spawn {
		params ['_preLoadCargo', '_cargoVehicle'];
		waitUntil {0 == count getVehicleCargo _cargoVehicle};
		private _QS_action_ugv_stretcherModel = 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d';
		{
			private _vehicle = _x;
			if (!(((attachedObjects _vehicle) findIf {(((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) && (isObjectHidden _x))}) isEqualTo -1)) then {
				{
					if ((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) then {
						if (isObjectHidden _x) then {
							[71,_x,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				} forEach (attachedObjects _vehicle);
			};
		} foreach _preLoadCargo;
	};
	_QS_c;
};

/* QS Manual Fire in base */
if (_QS_actionName isEqualTo 'ManualFire') then {
	if ((cameraOn distance2D (markerPos 'QS_marker_base_marker')) < 600) then {
		50 cutText ['Manual Fire disabled near base','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
};

_QS_c;
