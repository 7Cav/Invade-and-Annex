/*/
File: fn_aoTaskIDAP.sqf
Author:

	Quiksilver

Last Modified:

	27/11/2017 A3 1.78 by Quiksilver

Description:

	IDAP Task
____________________________________________________________________________/*/
missionNamespace setVariable ['QS_grid_IDAP_taskActive',TRUE,FALSE];
params ['_centerPos'];
private _positionFound = FALSE;
private _findTimeout = diag_tickTime + 15;
private _testPos = [0,0,0];
private _incrementDir = (random 360);
private _increment = 15;
private _nearRoads = [];
private _allPlayers = allPlayers;
private _nearRoadsRadius = 150;
private _distanceFixed = 700;
private _distanceRandom = 400;
private _roadSegment = objNull;
private _roadSegmentPosition = [0,0,0];
_baseMarker = markerPos 'QS_marker_base_marker';
for '_x' from 0 to 1 step 0 do {
	_testPos = _centerPos getPos [(_distanceFixed + (random _distanceRandom)),_incrementDir];
	_incrementDir = _incrementDir + _increment;
	if ((_testPos distance2D _baseMarker) > 700) then {
		_nearRoads = ([_testPos select 0,_testPos select 1] nearRoads _nearRoadsRadius) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
		if (!(_nearRoads isEqualTo [])) then {
			_roadSegment = selectRandom _nearRoads;
			_roadSegmentPosition = position _roadSegment;
			if (!([_centerPos,_roadSegmentPosition,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
				if (([_roadSegmentPosition,300,[WEST],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
					_positionFound = TRUE;
				};
			};
		};
	};
	if (diag_tickTime > _findTimeout) exitWith {};
	if (_positionFound) exitWith {};
};
if (diag_tickTime > _findTimeout) exitWith {
	missionNamespace setVariable ['QS_grid_IDAP_taskActive',FALSE,FALSE];
};
private _entities = [];
private _missionEntities = [];
private _objectives = [];
private _objectiveCode = {};
private _onCompleted = {};
private _onFailed = {};
_connectedRoads = roadsConnectedTo _roadSegment;
_connectedRoad = _connectedRoads select 0;
_connectedRoadPos = position _connectedRoad;
_dirToConnectedRoad = _roadSegment getDir _connectedRoad;
_dirToOffset = if ((random 1) > 0.5) then {(_dirToConnectedRoad + (20 + (random 45)))} else {(_dirToConnectedRoad - (20 - (random 45)))};
_vehicleTypes = [
	'C_IDAP_Van_02_vehicle_F'
];
_vehicle = createVehicle [(selectRandom _vehicleTypes),[-1000,-1000,100],[],0,'NONE'];
uiSleep 0.1;
_vehicle setDamage [0.8,TRUE];
_vehicle setDir _dirToOffset;
_vehicle setVehiclePosition [_roadSegmentPosition,[],0,'NONE'];
{
	_vehicle animateDoor _x;
} forEach [
	['Door_1_source',1],
	['Door_2_source',(selectRandom [0,1])],
	['Door_3_source',1],
	['Door_4_source',1]
];
_vehicle setFuel 0;
uiSleep 0.5;
{
	if ((random 1) > 0.5) then {
		_vehicle setHit [_x,1];
	};
} forEach [
	'wheel_1_1_steering',
	'wheel_1_2_steering',
	'wheel_2_1_steering',
	'wheel_2_2_steering'
];
_vehicle allowDamage FALSE;
_vehicle setVariable ['QS_RD_noRepair',TRUE,TRUE];
_vehicle lock 2;
_vehicle enableRopeAttach FALSE;
_vehicle spawn {uiSleep 3;_this enableSimulationGlobal FALSE;};
_entities pushBack _vehicle;
if (isTouchingGround _vehicle) then {
	_boxTypes = [
		"land_paperbox_01_small_closed_brown_idap_f",
		"land_paperbox_01_small_closed_white_med_f"
	];
	_otherBoxTypes = [
		'Land_PaperBox_01_small_ransacked_brown_F',
		'Land_PaperBox_01_small_ransacked_brown_IDAP_F',
		'Land_PaperBox_01_small_ransacked_white_IDAP_F'
	];
	_junkData = [
		["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",0.052],
		["A3\Structures_F\Civ\Garbage\Garbage_square5_F.p3d",0.039]
	];
	_oilSpill = 'A3\Structures_F_Kart\Civ\SportsGrounds\Oil_spill.p3d';
	private _box = objNull;
	private _boxes = [];
	for '_x' from 0 to 1 step 1 do {
		_box = createVehicle [(selectRandom _boxTypes),[-100,-100,50],[],50,'NONE'];
		_box allowDamage FALSE;
		_box setVariable ['QS_cargoObject',TRUE,TRUE];
		_vehicle setVehicleCargo _box;
		_boxes pushBack _box;
		_missionEntities pushback _box;
		_entities pushBack _box;
	};
	_onCompleted = {
		params ['_boxes','_centerPos'];
		{
			_x setVariable ['QS_interaction_disabled',TRUE,TRUE];
		} forEach _boxes;
	};
	_onFailed = {};
	_objectiveCode = {
		params ['_boxes','_centerPos'];
		private _return = 0;
		if ((_boxes findIf {(((_x distance _centerPos) > 15) || (!isNull (attachedTo _x)) || (!isNull (objectParent _x)))}) isEqualTo -1) then {
			_return = 1;
		};
		_return;
	};
	_objectives pushBack ['LOGISTICS_RECOVER',0,[_boxes,_centerPos],_objectiveCode,_onCompleted,_onFailed];
	_vehicle enableVehicleCargo FALSE;
	_rearPos = _vehicle getRelPos [7,180];
	_oilPos = _vehicle getRelPos [3.5,(5 - (random 10))];
	_oilSpill = 'A3\Structures_F_Kart\Civ\SportsGrounds\Oil_spill.p3d';
	_oil = createSimpleObject [_oilSpill,(AGLToASL _oilPos)];
	_oil setDir (random 360);
	_oil setVectorUp (surfaceNormal _oilPos);
	_entities pushBack _oil;
	private _otherBox = objNull;
	private _otherBoxes = [];
	private _otherBoxPos = [0,0,0];
	private _boxDir = random 15;
	private _boxDist = 0.75;
	for '_x' from 0 to (1 + (random 3)) step 1 do {
		_otherBoxPos = _rearPos getPos [_boxDist,_boxDir];
		_otherBoxPos = AGLToASL _otherBoxPos;
		_otherBox = createSimpleObject [(selectRandom _otherBoxTypes),_otherBoxPos];
		_otherBox setDir (random 360);
		_otherBox setVectorUp (surfaceNormal _otherBoxPos);
		_entities pushBack _otherBox;
		_boxDist = _boxDist + (0.75 + (random 1));
		_boxDir = _boxDir + (15 + (random 45));
	};
	private _junk = objNull;
	private _junks = [];
	private _junkSpawnPos = [0,0,0];
	private _junkDir = random 15;
	private _junkDist = 0.5;
	{
		_junkSpawnPos = _rearPos getPos [_junkDist,_junkDir];
		_junkSpawnPos = AGLToASL _junkSpawnPos;
		_junkSpawnPos set [2,((_junkSpawnPos select 2) + (_x select 1))];
		_junk = createSimpleObject [(_x select 0),_junkSpawnPos];
		_junk setDir (random 360);
		_junk setVectorUp (surfaceNormal _junkSpawnPos);
		_junks pushBack _junk;
		_entities pushBack _junk;
		_junkDist = _junkDist + (0.5 + (random 1));
		_junkDir = _junkDir + ((360 / (count _junkData)) - 15);
	} forEach _junkData;
};
private _recoverUnit = FALSE;
if ((random 1) > 0.666) then {
	_recoverUnit = TRUE;
	_unitTypes = [
		'C_IDAP_Man_AidWorker_01_F',
		'C_IDAP_Man_AidWorker_07_F',
		'C_IDAP_Man_AidWorker_08_F',
		'C_IDAP_Man_AidWorker_09_F',
		'C_IDAP_Man_AidWorker_02_F',
		'C_IDAP_Man_AidWorker_05_F',
		'C_IDAP_Man_AidWorker_06_F',
		'C_IDAP_Man_AidWorker_04_F',
		'C_IDAP_Man_AidWorker_03_F'
	];
	_unit = createAgent [(selectRandom _unitTypes),_roadSegmentPosition,[],5,'NONE'];
	_unit allowDamage FALSE;
	_unit disableAI 'ALL';
	_unit setUnconscious TRUE;
	_unit setDamage [0.6,TRUE];
	if ((random 1) > 0.666) then {
		_unit spawn {
			uiSleep 3;
			_this setVariable ['QS_dead_prop',TRUE,TRUE];
			_this setDamage [1,TRUE];
		};
	} else {
		_unit setBleedingRemaining 600;
		{
			_unit setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_revive_disable',TRUE,TRUE],
			['QS_unit_needsStabilise',TRUE,TRUE],
			['QS_interact_stabilise',TRUE,TRUE],
			['QS_interact_stabilised',FALSE,TRUE],
			['QS_noHeal',TRUE,TRUE],
			['QS_curator_disableEditability',TRUE,FALSE]
		];
		_entities pushBack _unit;
		_missionEntities pushBack _unit;
		_onCompleted = {};
		_onFailed = {};
		_objectiveCode = {
			params ['_unit','_centerPos'];
			private _return = 0;
			if (((_unit distance _centerPos) < 15) && (isNull (attachedTo _unit)) && (isNull (objectParent _unit))) then {
				_return = 1;
			};
			if (!alive _unit) then {
				_return = 2;
			};
			_return;
		};
		_objectives pushBack ['MEDEVAC',0,[_unit,_centerPos],_objectiveCode,_onCompleted,_onFailed];
	};
};
private _enemyArray = [];
if ((random 1) > 0) then {
	_enemyVehicleTypesWeighted = [
		'O_G_Offroad_01_F',0.3,
		'O_G_Van_01_transport_F',0.1,
		'I_C_Van_01_transport_F',0.1,
		'I_C_Offroad_02_unarmed_F',0.3
	];
	_enemyVehicle = createVehicle [(selectRandomWeighted _enemyVehicleTypesWeighted),[-1000,-1000,150],[],50,'NONE'];
	_enemyVehicle setDir (random 360);
	_enemyVehicle setVehiclePosition [(AGLToASL _connectedRoadPos),[],0,'NONE'];
	_enemyVehicle setFuel (random [0.1,0.4,0.8]);
	_enemyVehicle addEventHandler [
		'GetIn',
		{
			(_this select 0) removeEventHandler ['GetIn',_thisEventHandler];
			(missionNamespace getVariable 'QS_garbageCollector') pushBack [(_this select 0),'DELAYED_DISCREET',300];
		}
	];
	_enemyVehicle addEventHandler [
		'Deleted',
		{
			{
				deleteVehicle _x;
			} forEach (attachedObjects (_this select 0));
		}
	];
	_enemyVehicle addEventHandler [
		'Killed',
		{
			{
				deleteVehicle _x;
			} forEach (attachedObjects (_this select 0));
		}
	];
	_enemyArray pushBack _enemyVehicle;
	_entities pushBack _enemyVehicle;
};
_enemyArray = [];
_enemyTypes = [
	"I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F",
	"I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F",
	"I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F"
];
private _enemyUnit = objNull;
_enemyGrp = createGroup [EAST,TRUE];
for '_x' from 0 to (2 + (round (random 2))) step 1 do {
	_enemyUnit = _enemyGrp createUnit [(selectRandom _enemyTypes),_connectedRoadPos,[],5,'NONE'];
	_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_enemyArray pushBack _enemyUnit;
	_entities pushBack _enemyUnit;
};
{
	_enemyUnit = _x;
	_enemyUnit setVariable ['QS_unit_assocUnits',_enemyArray,FALSE];
	_enemyUnit setVariable ['QS_unit_customEvent_fired',(
		_enemyUnit addEventHandler [
			'FiredMan',
			{
				missionNamespace setVariable ['QS_sm_enemy_reinforce',TRUE,FALSE];
				(_this select 0) removeEventHandler ['FiredMan',_thisEventHandler];
				{
					_x removeEventHandler ['FiredMan',(_x getVariable ['QS_unit_customEvent_fired',-1])];
				} forEach ((_this select 0) getVariable ['QS_unit_assocUnits',[]]);
			}
		]
	),FALSE
	];
} forEach (units _enemyGrp);
[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_enemyGrp setVariable ['QS_AI_GRP_disableBldgPtl',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',[_connectedRoadPos,_roadSegmentPosition],diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_enemyGrp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_enemyGrp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
private _serverTime = serverTime;
private _missionTimeout = _serverTime + 2100;
private _cargoAccessed = FALSE;
private _unitRecovered = FALSE;
private _objective = [];
private _objectiveUpdate = FALSE;
private _objectivesCompleted = FALSE;
private _evaluateObjectiveCompletion = FALSE;
private _objectiveReturn = 0;

private _enemyReinforceInit = FALSE;
private _reinforceSpawnPos = [0,0,0];
private _reinforceDistMin = 400;
private _reinforceDistMax = 800;
_positionFound = FALSE;
private _qrfGroup = grpNull;
missionNamespace setVariable ['QS_sm_enemy_reinforce',FALSE,FALSE];

private _taskID = 'QS_GRID_TASK_IDAP_1';
private _taskDescription = '<br/>- Investigate scene<br/>- Recover any medical supplies<br/>- Recover any casualties<br/>- Bring to IDAP field hospital before timer runs out.<br/><br/>An IDAP cargo truck carrying vital medical equipment failed to reach its destination. Get over there and see what you can do.<br/><br/>It would be helpful to have a vehicle to help carry cargo.';
[
	_taskID,
	TRUE,
	[
		_taskDescription,
		'IDAP Supplies',
		'IDAP Supplies'
	],
	_roadSegmentPosition,
	'CREATED',
	5,
	FALSE,
	TRUE,
	'box',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
[_taskID,TRUE,_missionTimeout] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
//['GRID_IDAP_UPDATE',['Side Task','IDAP Supplies']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
[6,"IDAP Supplies",0,40] remoteExec ['NL_fnc_objPopup', -2, FALSE];
for '_x' from 0 to 1 step 0 do {
	_serverTime = serverTime;
	{
		_objectiveReturn = 0;
		_objectiveUpdate = FALSE;
		_objective = _x;
		_objective params [
			'_objectiveType',
			'_objectiveState',
			'_objectiveArguments',
			'_objectiveCode',
			'_objectiveOnCompleted',
			'_objectiveOnFailed'
		];
		if (_objectiveState isEqualTo 0) then {
			_objectiveReturn = _objectiveArguments call _objectiveCode;
			if (!(_objectiveReturn isEqualTo _objectiveState)) then {
				_evaluateObjectiveCompletion = TRUE;
				_objectiveUpdate = TRUE;
				_objective set [1,_objectiveReturn];
				if (_objectiveType isEqualTo 'LOGISTICS_RECOVER') then {
					_objectiveArguments call _objectiveOnCompleted;
					//['GRID_IDAP_UPDATE',['Side Task Update','IDAP Supplies recovered']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
					[4,"IDAP Supplies recovered",0,40] remoteExec ['NL_fnc_objPopup', -2, FALSE];
				};
				if (_objectiveType isEqualTo 'MEDEVAC') then {
					//['GRID_IDAP_UPDATE',['Side Task Update','IDAP Medevac complete']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
					[4,"IDAP Medevac complete",0,40] remoteExec ['NL_fnc_objPopup', -2, FALSE];
				};
			};
		};
		if (_objectiveUpdate) then {
			_objectives set [_forEachIndex,_objective];
		};
	} forEach _objectives;
	if (_evaluateObjectiveCompletion) then {
		_evaluateObjectiveCompletion = FALSE;
		_objectivesCompleted = TRUE;
		{
			if ((_x select 1) isEqualTo 0) exitWith {
				_objectivesCompleted = FALSE;
			};
		} forEach _objectives;
	};
	if ((_objectivesCompleted) || {(_serverTime > _missionTimeout)}) exitWith {
		private _text = '';
		if (_serverTime > _missionTimeout) then {
			_text = 'Task expired';
			//['GRID_IDAP_UPDATE',['Side Task Complete',_text]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			[2,"Side task expired",0,0] remoteExec ['NL_fnc_objPopup', -2, FALSE];
		} else {
			{
				_objective = _x;
				_objective params [
					'_objectiveType',
					'_objectiveState',
					'_objectiveArguments',
					'_objectiveCode'
				];
				if (_objectiveState isEqualTo 1) then {
					if (_objectiveType isEqualTo 'LOGISTICS_RECOVER') then {
						_text = _text + 'Logistics task succeeded. ';
					};
					if (_objectiveType isEqualTo 'MEDEVAC') then {
						_text = _text + 'Aid worker task succeeded. ';
					};
				} else {
					if (_objectiveState isEqualTo 2) then {
						if (_objectiveType isEqualTo 'LOGISTICS_RECOVER') then {
							_text = _text + 'Logistics task failed. ';
						};
						if (_objectiveType isEqualTo 'MEDEVAC') then {
							_text = _text + 'Aid worker task failed. ';
						};
					};
				};
			} forEach _objectives;
			//['GRID_IDAP_UPDATE',['Side Task Complete',_text]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			[1,_text,0,20] remoteExec ['NL_fnc_objPopup', -2, FALSE];
			[20] call NL_fnc_addscore;
		};
	};
	if (!(_enemyReinforceInit)) then {
		if (missionNamespace getVariable ['QS_sm_enemy_reinforce',FALSE]) then {
			_enemyReinforceInit = TRUE;
			for '_x' from 0 to 19 step 1 do {
				_reinforceSpawnPos = [_connectedRoadPos,_reinforceDistMin,_reinforceDistMax,5,0,0.25,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
				if ((_reinforceSpawnPos distance2D _baseMarker) > 700) then {
					if (([_reinforceSpawnPos,300,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
						if (!([_reinforceSpawnPos,_connectedRoadPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
							_reinforceSpawnPos set [2,0];
							_positionFound = TRUE;
						};
					};
				};
				if (_positionFound) exitWith {};
				uiSleep 0.01;
			};
			_qrfGroup = [_reinforceSpawnPos,(_reinforceSpawnPos getDir _connectedRoadPos),EAST,'OG_InfSquad_Weapons',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			{
				_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
				_x enableStamina FALSE;
				_x enableFatigue FALSE;
				_x disableAI 'COVER';
				_x disableAI 'AUTOCOMBAT';
				_enemyArray pushBack _x;
				_entities pushBack _x;
			} forEach (units _qrfGroup);
			_grpGroup setCombatMode 'RED';
			_qrfGroup setBehaviour 'AWARE';
			_qrfGroup setSpeedMode 'FULL';
			[(units _qrfGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_qrfGroup setVariable ['QS_AI_GRP_TASK',['PATROL',[_connectedRoadPos,_roadSegmentPosition],diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_qrfGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_qrfGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _qrfGroup))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_qrfGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_qrfGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			{
				doStop _x;
				_x doMove _connectedRoadPos;
			} forEach (units _grpGroup);
		};
	};
	uiSleep 3;
};
[_taskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
private _toDelete = objNull;
{
	deleteVehicle _x;
} forEach _missionEntities;
{
	_toDelete = _x;
	if (!isNull _toDelete) then {
		if (_toDelete isKindOf 'LandVehicle') then {
			_toDelete addEventHandler [
				'GetOut',
				{
					params ['_vehicle'];
					if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
						deleteVehicle _vehicle;
					};
				}
			];
		};
		(missionNamespace getVariable 'QS_garbageCollector') pushBack [_toDelete,'NOW_DISCREET',0];
	};
} forEach _entities;
missionNamespace setVariable ['QS_grid_IDAPcomposition',_composition,FALSE];
if (!((missionNamespace getVariable ['QS_grid_IDAPcomposition',[]]) isEqualTo [])) then {
	{
		(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
	} forEach (missionNamespace getVariable ['QS_grid_IDAPcomposition',[]]);
};
missionNamespace setVariable ['QS_grid_IDAP_taskActive',FALSE,FALSE];
