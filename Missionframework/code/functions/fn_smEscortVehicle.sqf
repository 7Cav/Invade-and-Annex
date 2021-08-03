/*/
File: escortVehicle.sqf
Author:

	Quiksilver

Last Modified:

	27/07/2019 A3 1.94 by Quiksilver

Description:

	Get vehicle to its destination
___________________________________________________/*/

scriptName 'QS - SM - Convoy';
private [
	'_vehicle','_position','_destination','_enemyArray','_intensity',
	'_vehicleDir','_vehiclePos','_vehicleDirToDestination','_startPosition',
	'_distanceInFront_fixed','_distanceInFront_random','_vehicleIsOnRoad',
	'_vehiclePosInFront','_vehiclePosToDest','_vehicleSpeed','_roadsInFront',
	'_roadsToDestination','_vehicleDamage','_vehicleCanMove','_timeNow',
	'_updateState_delay','_updateState_checkDelay','_vehicleVectorUp',
	'_vehicleAlive','_sleepTime','_nearbyPlayers','_ambushInProgress',
	'_enemyGroupTypes','_enemyGroupType','_enemySpawnPos','_ambushRadius','_ambushTimeout',
	'_marker1','_marker2','_ambushPos','_ambushPos_candidate1','_ambushPos_candidate2','_ambushPos_candidate3',
	'_ambushPos_candidate4','_ambushPos_candidates','_randomRoadSegment','_marker3','_marker4',
	'_enabled_IED','_enabled_mech','_enabled_RPG','_vehicleTravelDirection','_vehicleRoadAt',
	'_timeOffRoad','_unit','_grp','_distanceToAmbush','_updateAttackPos_checkDelay',
	'_enemyGroupArray','_enemyGroupTypes_big','_hasHitLandmine','_landMine','_IED',
	'_QS_manage_convoy_vehicles','_QS_manage_convoy','_QS_manage_convoy_delay','_QS_manage_convoy_checkDelay',
	'_QS_manage_convoy_armorTypes','_nearbySpawnPos','_bto','_armoredVehicle','_vehicleDriver',
	'_vehicleDriverGroup','_safezone_radius','_QS_manage_convoy_radius','_enemyTurretType','_enemyTurret',
	'_vehicleTypes','_vehicleType','_startDir','_destinations','_armorTokenVehicle','_armoredVehicleVelocity',
	'_armoredVehicleDir','_groupSide','_fuctionNotification','_functionAttack','_spawnPos','_player',
	'_ambushCount','_posToMove','_dmgCount','_count','_nearestVillage','_nearestCity','_nearestCapital',
	'_updateMoveDelay','_centerPos','_moveToPos','_suppressTarget','_suppressTargets','_nearestLocation',
	'_suppressTarget_var','_suppressTarget_type','_base','_baseBufferDist','_spawnDoubleChance','_enemyGroupTypes_small',
	'_convoyVehicle','_QS_manage_convoy_var','_enemyFiredEvent','_vehSpawnPos','_veh','_QS_manage_convoy_vehicleClass',
	'_convoyVehicleType','_landMine2','_launch','_nearRoadsPositions','_grpLeader','_worldName','_technicalTypes','_enemyGroupTypes_reinf_small',
	'_enemyGroupTypes_reinf_big', '_startPosition2', '_startPosition3', '_startLocation', '_startLocation2', '_startLocation3', '_vehicleTypes2', '_startDir3', '_startDir2'
];

_NL_baseLocation = trim markerText "nl_marker_baselocation";
_ambushCount = 0;
_fuctionNotification = 'QS_fnc_showNotification';
_functionAttack = 'QS_fnc_taskAttack';
_base = markerPos 'QS_marker_base_marker';
_baseBufferDist = 1000;
_worldName = worldName;
if (!(_worldName in ['Altis','Malden','Tanoa','Enoch'])) exitWith {
	diag_log '***** ERROR * Truck side mission * terrain not supported (needs config) *****';
};
if (_worldName isEqualTo 'Tanoa') then {
	_startPosition = [5519.75,12394.4,0.2];
	_startDir = 275;
	_vehicleTypes = [		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_T_Truck_01_fuel_F','B_T_Truck_01_box_F'];

	if (_NL_baseLocation == "AlxTuvanaka") then {
		_startPosition = [5458.300,12412.878,0.2];
		_startPosition2 = [5458.992,12418.563,0.2];
		_startPosition3 = [5460.469,12426.782,0.2];
		_startLocation = [5618.246,12532.614,0.2];
		_startLocation2 = [5622.138,12527.639,0.2];
		_startLocation3 = [5625.765,12522.489,0.2];
		_startDir = 231;
		_startDir2 = 231;
		_startDir3 = 231;
		_vehicleTypes2 = [
			'B_MRAP_01_F', 'B_MRAP_01_hmg_F', 'B_LSV_01_unarmed_F', 'B_LSV_01_armed_F', 'B_Truck_01_transport_F', 'B_Truck_01_covered_F', 'I_MRAP_03_hmg_F', 'I_MRAP_03_F'
		];
	};
	_destinations = [
		[13017.836,2162.913,0],
		[12297.058,4029.896,0],
		[12194.883,8126.884,0],
		[13741.846,12244.418,0],
		[14260.075,11507.383,0],
		[7982.485,7421.529,0],
		[9405.992,7565.802,0],
		[14264.1,11510.7,0],
		[9370.354,4092.998,0],
		[11150.513,5155.982,0],
		[11050.8,11501.7,0],
		[10933.8,9856.77,0],
		[14364.5,8748.88,0],
		[12606.8,7592.73,0],
		[10826.3,6495.3,0],
		[11626.3,3002.23,0],
		[11695.7,2255.52,0]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Altis') then {
	_startPosition = [14450,16763.7,0];
	_startDir = 330;
	if (_NL_baseLocation == "noillizDefault") then {
		_startPosition = [14526,16843,0.1];
		_startPosition2 = [14540,16854,0.1];
		_startPosition3 = [14554,16868,0.1];
		_startLocation = [14143.7,16326,0.1];
		_startLocation2 = [14147,16329.9,0.1];
		_startLocation3 = [14150.3,16333.8,0.1];
		_startDir = 129;
		_startDir2 = 129;
		_startDir3 = 129;
		_vehicleTypes2 = [
			'B_MRAP_01_F', 'B_MRAP_01_hmg_F', 'B_LSV_01_unarmed_F', 'B_LSV_01_armed_F', 'B_Truck_01_transport_F', 'B_Truck_01_covered_F', 'I_MRAP_03_hmg_F', 'I_MRAP_03_F'
		];
	};
	if (_NL_baseLocation == "pavauDefault") then {
		_startPosition = [14526,16843,0.1];
		_startPosition2 = [14540,16854,0.1];
		_startPosition3 = [14554,16868,0.1];
		_startLocation = [14737.6,16602,0.1];
		_startLocation2 = [14740.8,16598.6,0.1];
		_startLocation3 = [14744.2,16595.2,0.1];
		_startDir = 43;
		_startDir2 = 43;
		_startDir3 = 43;
		_vehicleTypes2 = [
			'B_MRAP_01_F', 'B_MRAP_01_hmg_F', 'B_LSV_01_unarmed_F', 'B_LSV_01_armed_F', 'B_Truck_01_transport_F', 'B_Truck_01_covered_F', 'I_MRAP_03_hmg_F', 'I_MRAP_03_F'
		];
	};
	if (_NL_baseLocation == "knightDefault") then {
		_startPosition = [14526,16843,0.1];
		_startPosition2 = [14540,16854,0.1];
		_startPosition3 = [14554,16868,0.1];
		_startLocation = [11655,11982,0.1];
		_startLocation2 = [11650,11987,0.1];
		_startLocation3 = [11645,11992,0.1];
		_startDir = 226;
		_startDir2 = 226;
		_startDir3 = 226;
		_vehicleTypes2 = [
			'B_MRAP_01_F', 'B_MRAP_01_hmg_F', 'B_LSV_01_unarmed_F', 'B_LSV_01_armed_F', 'B_Truck_01_transport_F', 'B_Truck_01_covered_F', 'I_MRAP_03_hmg_F', 'I_MRAP_03_F'
		];
	};
	_vehicleTypes = [
		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_Truck_01_fuel_F','B_Truck_01_box_F'
	];
	_destinations = [
		[5769.33,20082.4,0],
		[23080.078,7299.161,0],
		[26700.523,23004.38,0],
		[22008.354,21065.047,0],
		[23881.78,20210.414,0],
		[3045.113,18469.803,0],
		[8479.83,18265,0],
		[9216.9,19281.8,0],
		[5768.62,20080.6,0],
		[20466.283,8889.569,0],
		[21233.4,7112.81,0],
		[21814,7508,0],
		[25697.2,21376.9,0],
		[24680.447,23148.883,0],
		[23366.9,24186.6,0],
		[26997.3,23260.3,0],
		[3765.76,13480.9,0],
		[4173.69,15045.1,0]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Malden') then {
	_startPosition = [8241.15,10087.8,0];
	_startDir = 170;
	_vehicleTypes = [
		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_Truck_01_fuel_F','B_Truck_01_box_F'
	];
	_destinations = [
		[1069.92,678.717,0],
		[5504.75,3496.67,0],
		[8047.61,4029.26,0],
		[7044.13,7051.86,0],
		[8147.69,3138.5,0],
		[3226.93,6286.52,0],
		[3779.3,3257.21,0],
		[7689.35,3309.53,0]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Enoch') then {
	_startPosition = [4268.87,10463.4,0];
	_startDir = 134;
	_vehicleTypes = ['B_T_Truck_01_fuel_F','B_T_Truck_01_box_F'];
	_destinations = [
		[11151.5,11434.7,0.00144577],
		[11436.9,9484.55,0.0016613],
		[11226.9,4360.06,0.00143433],
		[5946.78,4097.98,0.00137329],
		[4949.62,2143.18,0.00149536],
		[1664.64,3653.66,0.00143433],
		[11429.7,503.399,0.0014534],
		[7363.54,2856.99,0.00144196],
		[4906.16,5423.01,0.00140381],
		[9065.14,6668.31,0.00143433],
		[565.645,947.551,0.00146484],
		[565.645,947.551,0.00146484]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
_vehicleType = selectRandom _vehicleTypes;
_vehicle = createVehicle [_vehicleType,_startPosition,[],0,'NONE'];
_vehicle setDir _startDir;
_vehicle setPos _startLocation;
_vehicleType2 = selectRandom _vehicleTypes2;
_vehicle2 = createVehicle [_vehicleType2,_startPosition2,[],0,'NONE'];
_vehicle2 setDir _startDir2;
_vehicle2 setPos _startLocation2;
[_vehicle2] call (missionNamespace getVariable 'QS_fnc_vSetup');
_vehicleType3 = selectRandom _vehicleTypes2;
_vehicle3 = createVehicle [_vehicleType3,_startPosition3,[],0,'NONE'];
_vehicle3 setDir _startDir3;
_vehicle3 setPos _startLocation3;
[_vehicle3] call (missionNamespace getVariable 'QS_fnc_vSetup');
missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 3),FALSE];
_enabled_IED = FALSE;
_enabled_mech = FALSE;
_enabled_RPG = FALSE;
_timeNow = time;
_sleepTime = 3;
missionNamespace setVariable ['QS_sideMission_vehicle',_vehicle,TRUE];
_destination = selectRandom _destinations;
_nearestVillage = text (nearestLocation [_destination,'NameVillage']);
_nearestCity = text (nearestLocation [_destination,'NameCity']);
_nearestCapital = text (nearestLocation [_destination,'NameCityCapital']);
_nearestLocation = selectRandom [_nearestVillage,_nearestCity];
_enemyArray = [];
_enemyGroupArray = [];
_unit = objNull;
_grp = grpNull;
_player = objNull;
_intensity = 0;
_nearbyPlayers = 0;
_grpLeader = objNull;
_vehiclePos = _startPosition;
_vehicleDir = getDir _vehicle;
_vehicleTravelDirection = _vehicle getDir _destination;
_vehicleDirToDestination = _vehicle getDir _destination;
if (worldName isEqualTo 'Tanoa') then {
	_distanceInFront_fixed = 300;
	_distanceInFront_random = 500;
} else {
	_distanceInFront_fixed = 600;
	_distanceInFront_random = 1000;
};
_distanceToAmbush = 0;
_vehiclePosInFront = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleTravelDirection];
_vehiclePosToDest = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleDirToDestination];
_vehicleRoadAt = roadAt _vehicle;
_vehicleIsOnRoad = isOnRoad _vehicle;
_vehicleSpeed = (vectorMagnitude (velocity _vehicle)) * 3.6;
_vehicleDamage = damage _vehicle;
_vehicleCanMove = canMove _vehicle;
_vehicleAlive = alive _vehicle;
_vehicleDriver = driver _vehicle;
_vehicleDriverGroup = grpNull;
_vehicle forceFlagTexture '\A3\Data_F\Flags\Flag_red_CO.paa';
_roadsInFront = ((_vehiclePosInFront select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
_roadsToDestination = ((_vehiclePosToDest select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
_timeOffRoad = 0;
_dmgCount = 0;
_count = 0;
private _roadblockEntities = [];
private _roadblockPosition = [0,0,0];
private _roadblockData = [];
_vehicle setUnloadInCombat [FALSE,FALSE];
_vehicle allowCrewInImmobile TRUE;
_vehicle enableRopeAttach FALSE;
_vehicle enableVehicleCargo FALSE;
_vehicle setConvoySeparation 50;
_vehicle setRepairCargo 0;
_vehicle setFuelCargo 0;
_vehicle setAmmoCargo 0;
_vehicle forceFollowRoad TRUE;
_technicalTypes = [
	'O_G_Offroad_01_armed_F',3,
	'O_G_Offroad_01_AT_F',1,
	'I_C_Offroad_02_LMG_F',3,
	'I_C_Offroad_02_AT_F',1
];
_vehicle addEventHandler [
	'GetIn',
	{
		params ['_vehicle','_position','_unit','_turret'];
		if (_position == 'driver') then {
			if (isPlayer _unit) then {
				['vehicleChat',_vehicle,'Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
			};
		};
	}
];
_vehicle addEventHandler [
	'GetOut',
	{
		params ['_vehicle','_position','_unit','_turret'];
	}
];
_vehicle addEventHandler [
	'SeatSwitched',
	{
		params ['_vehicle','_unit1','_unit2'];
		if ('Driver' in (assignedVehicleRole _unit1)) then {
			if (isPlayer _unit1) then {
				['vehicleChat',_vehicle,'Mission: Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit1,FALSE];
			};
		};
		if ('Driver' in (assignedVehicleRole _unit2)) then {
			if (isPlayer _unit2) then {
				['vehicleChat',_vehicle,'Mission: Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit2,FALSE];
			};
		};
	}
];
_randomRoadSegment = objNull;
_hasHitLandmine = FALSE;
_landMine = objNull;
_landMine2 = objNull;
_IED = objNull;
_ambushInProgress = FALSE;
_ambushPos_candidates = [];
_ambushPos_candidate1 = [0,0,0];
_ambushPos_candidate2 = [0,0,0];
_ambushPos_candidate3 = [0,0,0];
_ambushPos_candidate4 = [0,0,0];
_ambushPos = [0,0,0];
_ambushRadius = [500,700] select (worldName isEqualTo 'Altis');
_ambushTimeout = _timeNow + 600;
_updateAttackPos_checkDelay = _timeNow + 20;
_spawnDoubleChance = 0;
if (worldName isEqualTo 'Tanoa') then {
	_groupSide = RESISTANCE;
	_enemyGroupTypes = ['IG_InfSentry','IG_ReconSentry','IG_ReconSentry','IG_InfSentry','IG_InfTeam','IG_InfTeam'];
	_enemyGroupTypes_big = ['IG_InfTeam','IG_InfSquad'];
	_enemyGroupTypes_small = ['IG_InfSentry','IG_ReconSentry'];
	_enemyGroupTypes_reinf_small = ['OG_InfAssaultTeam'];
	_enemyGroupTypes_reinf_big = ['OG_InfAssaultTeam'];
} else {
	_groupSide = EAST;
	_enemyGroupTypes = ['OG_InfSentry','OG_InfSentry','OG_ReconSentry','OG_InfSentry','OG_InfTeam','OG_InfTeam'];
	_enemyGroupTypes_big = ['OG_InfAssault','OG_InfTeam'];
	_enemyGroupTypes_small = ['OG_InfSentry','OG_ReconSentry'];
	_enemyGroupTypes_reinf_small = ['OG_InfAssaultTeam'];
	_enemyGroupTypes_reinf_big = ['OG_InfAssaultTeam'];
};
_enemyGroupType = '';
_enemySpawnPos = [0,0,0];
_enemyTurretType = '';
_enemyTurret = objNull;
_enemyFiredEvent = {
	_unit = _this select 0;
	_unit removeEventHandler ['Fired',_thisEventHandler];
	_unit suppressFor 5;
	if (alive (getAttackTarget _unit)) then {
		_unit doSuppressiveFire (aimPos (getAttackTarget _unit));
	};
};
_veh = objNull;
_vehSpawnPos = [0,0,0];
_nearRoadsPositions = [];
_updateState_delay = 2.5;
_updateState_checkDelay = _timeNow + _updateState_delay;
_QS_manage_convoy = TRUE;
_QS_manage_convoy_delay = 10;
_QS_manage_convoy_checkDelay = _timeNow + _QS_manage_convoy_delay;
_QS_manage_convoy_radius = 500;
_QS_manage_convoy_vehicles = [];
_QS_manage_convoy_armor = [];
_QS_manage_convoy_armorTypes = ["b_apc_tracked_01_aa_f","b_apc_wheeled_01_cannon_f","b_apc_tracked_01_crv_f","b_apc_tracked_01_rcws_f","b_mbt_01_arty_f","b_mbt_01_mlrs_f","b_mbt_01_cannon_f","b_mbt_01_tusk_f","b_t_apc_tracked_01_aa_f","b_t_apc_wheeled_01_cannon_f","b_t_apc_tracked_01_crv_f","b_t_apc_tracked_01_rcws_f","b_t_mbt_01_arty_f","b_t_mbt_01_mlrs_f","b_t_mbt_01_cannon_f","b_t_mbt_01_tusk_f","o_apc_tracked_02_aa_f","o_apc_tracked_02_cannon_f","o_apc_wheeled_02_rcws_v2_f","o_mbt_02_arty_f","o_mbt_02_cannon_f","o_t_apc_tracked_02_aa_ghex_f","o_t_apc_tracked_02_cannon_ghex_f","o_t_apc_wheeled_02_rcws_ghex_f","o_t_apc_wheeled_02_rcws_v2_ghex_f","o_t_mbt_02_arty_ghex_f","o_t_mbt_02_cannon_ghex_f","i_apc_wheeled_03_cannon_f","i_apc_tracked_03_cannon_f","i_mbt_03_cannon_f"];
_QS_manage_convoy_vehicleClass = 'armored';
_QS_manage_convoy_var = 'QS_truckmission_armortoken';
_armoredVehicle = objNull;
_convoyVehicle = objNull;
_convoyVehicleType = '';
_launch = FALSE;
_IEDtype = 'ATMine';
_armorTokenVehicle = [];
_bto = [
	'BUILDING','HOUSE','CHURCH','CHAPEL',
	'CROSS','ROCK','BUNKER','FORTRESS','FOUNTAIN','VIEW-TOWER',
	'LIGHTHOUSE','QUAY','FUELSTATION','HOSPITAL','FENCE','WALL',
	'BUSSTOP','ROAD','TRANSMITTER','STACK','RUIN',
	'TOURISM','WATERTOWER','ROCKS','POWER LINES','RAILWAY',
	'POWERSOLAR','POWERWAVE','POWERWIND','SHIPWRECK'
];
//comment '[_position,_bto] call _nearbySpawnPos';
_spawnPos = [0,0,0];
_nearbySpawnPos = {
	_position = _this select 0;
	_bto = _this select 1;
	private _position2 = [0,0,0];
	for '_x' from 0 to 49 step 1 do {
		_position2 = _position getPos [(10 + (random 15)),(random 360)];
		if (((((_position select [0,2]) nearRoads 15) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && ((nearestTerrainObjects [_position2,_bto,2,FALSE,TRUE]) isEqualTo [])) exitWith {};
	};
	if (!(_position2 isEqualTo [0,0,0])) exitWith {_position2;};
	_position;
};
_QS_manage_group = TRUE;
_QS_manage_group_delay = 10;
_QS_manage_group_checkDelay = _timeNow + _QS_manage_group_delay;
_grp = grpNull;
_markerName = 'QS_marker_escort_1';
_marker0 = createMarker [_markerName,[0,0,0]];
_marker0 setMarkerShape 'Icon';
_marker0 setMarkerType 'mil_dot';
_marker0 setMarkerColor 'ColorGreen';
_marker0 setMarkerAlpha 1;
_marker0 setMarkerText (format ['%1Side mission: Truck Destination',(toString [32,32,32])]);
_marker0 setMarkerPos _destination;
_distanceInFront_fixed = 250;
_distanceInFront_random = 500;
_ambushRadius = 751;
_safezone_radius = 400 + (random 400);
_updateMoveDelay = time + 10;
_moveToPos = [0,0,0];
_module_suppressTargets = FALSE;
_suppressTarget = objNull;
_suppressTargets = [];
_suppressTarget_checkDelay = time + 30;
_suppressTarget_var = 'QS_vehicle_suppressTarget';
_suppressTarget_type = 'SuppressTarget';
_suppressTarget = createVehicle [_suppressTarget_type,[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_suppressTarget attachTo [_vehicle,[0,(random 2),(random 1)]];
_vehicle setVariable [_suppressTarget_var,_suppressTarget,FALSE];
_suppressTargets pushBack _suppressTarget;
//comment 'Communicate to players';
[
	'QS_IA_TASK_SM_ESCORT',
	TRUE,
	[
		(format ['Get the vehicle to its destination near %1 (marked on map). It is strongly advised to stay on roads, and not to bring tanks or APCs, as this can disturb buried IEDs. It is suggested to keep moving even during contact, to prevent getting flanked and attacked by more heavily armed insurgents. Good luck, soldier!',_nearestVillage]),
		'Side Mission: Escort truck',
		'Side Mission: Escort truck'
	],
	[_vehicle,TRUE],
	'CREATED',
	5,
	FALSE,
	TRUE,
	'Truck',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
//['NewSideMission',['Escort truck']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	[0,"Side mission: Escort truck",0,70] remoteExec ['NL_fnc_objPopup', -2, FALSE];
'QS_marker_sideMarker' setMarkerText (format ['%1Escort truck',(toString [32,32,32])]);
waitUntil {
	sleep 3;
	(!alive _vehicle) ||
	(((getPosATL _vehicle) distance2D _startPosition) > _safezone_radius)
};
if (!alive _vehicle) exitWith {
	//comment 'Mission fail';
	deleteMarker _marker0;
	['QS_IA_TASK_SM_ESCORT'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
	//['TaskFailed',['','Truck destroyed!']] remoteExec [_fuctionNotification,-2,FALSE];
	[0,"Side mission: Escort truck",0,70] remoteExec ['NL_fnc_objPopup', -2, FALSE];
	sleep 5;
	[0,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
};
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	if (_timeNow > _updateState_checkDelay) then {
		//comment 'UPDATE SOME USEFUL VEHICLE DATA';
		_vehicleAlive = alive _vehicle;
		_vehicleCanMove = canMove _vehicle;
		_vehicleTravelDirection = _vehiclePos getDir (getPosATL _vehicle);
		_hasHitLandmine = FALSE;
		if (_vehicleAlive) then {
			if (_vehicleCanMove) then {
				if (!(_vehicleIsOnRoad)) then {
					if ( (((_vehiclePos select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
						if ((_vehiclePos distance2D (getPosATL _vehicle)) > 5) then {
							if ((_vehiclePos distance2D _startPosition) > _safezone_radius) then {
								_timeOffRoad = _timeOffRoad + 1;
								if (_timeOffRoad > 7) then {
									['sideChat',[WEST,'BLU'],'Side mission - The vehicle has struck a buried landmine!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									_hasHitLandmine = TRUE;
								};
							};
						};
					};
				};
			};
		};
		_vehiclePos = getPosATL _vehicle;
		_vehicleDir = getDir _vehicle;
		_vehicleVectorUp = vectorUp _vehicle;
		_vehicleIsOnRoad = isOnRoad _vehicle;
		_vehicleRoadAt = roadAt _vehicle;
		_vehicleSpeed = (vectorMagnitude (velocity _vehicle)) * 3.6;
		_vehicleDamage = damage _vehicle;
		_vehicleDriver = driver _vehicle;
		if (!isNull _vehicleDriver) then {
			if (alive _vehicleDriver) then {
				if (isPlayer _vehicleDriver) then {
					_vehicleDriverGroup = group _vehicleDriver;
				} else {
					_vehicleDriverGroup = grpNull;
				};
			} else {
				_vehicleDriverGroup = grpNull;
			};
		} else {
			_vehicleDriverGroup = grpNull;
		};
		_vehicleDirToDestination = _vehicle getDir _destination;
		_updateState_checkDelay = _timeNow + _updateState_delay;
	};
	if (!(_ambushInProgress)) then {
		//comment 'AMBUSH NOT IN PROGRESS, PREPARE IT';
		_ambushPos_candidates = [];
		//comment 'Clean up old ambush';
		if (!(_enemyArray isEqualTo [])) then {
			{
				if (!isNull _x) then {
					if (_x isKindOf 'Man') then {
						if (([(getPosATL _x),100,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						} else {
							_x setDamage 1;
						};
					} else {
						if (([(getPosATL _x),200,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						} else {
							_x setDamage 1;
						};
					};
				};
			} count _enemyArray;
		};
		if (!(_enemyGroupArray isEqualTo [])) then {
			{
				if (!isNull _x) then {
					deleteGroup _x;
				};
			} count _enemyGroupArray;
		};
		_enemyArray = [];
		_enemyGroupArray = [];
		//comment 'Get relevant positions';
		_vehiclePosInFront = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleTravelDirection];
		_vehiclePosToDest = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleDirToDestination];
		if (!surfaceIsWater _vehiclePosInFront) then {
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack _vehiclePosInFront;
			};
		};
		if (!surfaceIsWater _vehiclePosToDest) then {
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack _vehiclePosToDest;
			};
		};
		_roadsInFront = ((_vehiclePosInFront select [0,2]) nearRoads 200) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
		if (!(_roadsInFront isEqualTo [])) then {
			for '_x' from 0 to 9 step 1 do {
				_randomRoadSegment = selectRandom _roadsInFront;
				if (isOnRoad _randomRoadSegment) exitWith {};
			};
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack (getPosATL _randomRoadSegment);
			};
		};
		_roadsToDestination = ((_vehiclePosToDest select [0,2]) nearRoads 200) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
		if (!(_roadsToDestination isEqualTo [])) then {
			for '_x' from 0 to 9 step 1 do {
				_randomRoadSegment = selectRandom _roadsToDestination;
				if (isOnRoad _randomRoadSegment) exitWith {};
			};
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack (getPosATL _randomRoadSegment);
			};
		};
		//comment 'If position finding failed, exit';
		if (_ambushPos_candidates isEqualTo []) exitWith {};
		_ambushInProgress = TRUE;
		_ambushPos = selectRandom _ambushPos_candidates;
		_distanceToAmbush = _vehiclePos distance2D _ambushPos;
		//comment 'Prepare force protection';
		_nearbyPlayers = [_vehiclePos,500,[WEST],allUnits,1] call (missionNamespace getVariable 'QS_fnc_serverDetector');
		_intensity = 1;
		if (_nearbyPlayers > 0) then {
			_intensity = 1;
			if (_nearbyPlayers > 5) then {
				_intensity = 2;
				if (_nearbyPlayers > 10) then {
					_intensity = 3;
					if (_nearbyPlayers > 15) then {
						_intensity = 4;
						if (_nearbyPlayers > 20) then {
							_intensity = 5;
						};
					};
				};
			};
		};
		if (_enabled_IED) then {

		};
		if (_enabled_mech) then {

		};
		if (_enabled_RPG) then {

		};
		//comment 'Spawn force protection';
		_ambushCount = _ambushCount + 1;
		_spawnDoubleChance = 0;
		{
			_enemyGroupType = selectRandom _enemyGroupTypes;
			_spawnPos = [(_ambushPos_candidates select _forEachIndex),_bto] call _nearbySpawnPos;
			_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_enemyGroupArray pushBack _grp;
			_grp setSpeedMode 'FULL';
			{
				0 = _enemyArray pushBack _x;
				if ((random 1) > 0.5) then {
					_x addEventHandler ['Fired',_enemyFiredEvent];
				};
				if ((random 1) > 0.5) then {
					_x disableAI 'AUTOCOMBAT';
				};
				_x disableAI 'COVER';
				if ((random 1) > 0.9) then {
					_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
					[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
				};
				_x enableStamina FALSE;
				_x enableFatigue FALSE;
				_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			} forEach (units _grp);
			if ((random 1) > 0.666) then {
				if (_spawnDoubleChance isEqualTo 0) then {
					_spawnDoubleChance = 1;
					_enemyGroupType = selectRandom _enemyGroupTypes_small;
					_spawnPos = [(_ambushPos_candidates select _forEachIndex),_bto] call _nearbySpawnPos;
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x disableAI 'AUTOCOMBAT';
						};
						_x disableAI 'COVER';
						if ((random 1) > 0.9) then {
							_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
							[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
						};
						_x enableStamina FALSE;
						_x enableFatigue FALSE;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
			if (_intensity > 1) then {
				if ((_ambushPos_candidates select _forEachIndex) isEqualTo _ambushPos) then {
					if (_intensity > 2) then {
						_enemyGroupType = selectRandom _enemyGroupTypes_big;
					} else {
						_enemyGroupType = selectRandom _enemyGroupTypes;
					};
					_spawnPos = [_ambushPos,_bto] call _nearbySpawnPos;
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x disableAI 'AUTOCOMBAT';
						};
						if ((random 1) > 0.9) then {
							_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
							[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
						};
						_x disableAI 'COVER';
						_x enableStamina FALSE;
						_x enableFatigue FALSE;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
		} forEach _ambushPos_candidates;
		if (_ambushCount >= 2) then {
			_ambushCount = 0;
			_vehSpawnPos = [(getPosATL _vehicle),300,800,2.5,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if ((_vehSpawnPos distance2D _base) > 1500) then {
				_nearRoadsPositions = (((_vehSpawnPos select [0,2]) nearRoads 300) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) apply {(getPosATL _x)};
				if (!(_nearRoadsPositions isEqualTo [])) then {
					_nearRoadsPositions = _nearRoadsPositions select {((_x distance2D _vehiclePos) > 300)};
					if (!(_nearRoadsPositions isEqualTo [])) then {
						_vehSpawnPos = selectRandom _nearRoadsPositions;
					};
				};
				_veh = createVehicle [(selectRandomWeighted _technicalTypes),_vehSpawnPos,[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_veh lock 3;
				_veh setUnloadInCombat [FALSE,FALSE];
				_veh allowCrewInImmobile TRUE;
				_veh enableRopeAttach FALSE;
				_veh enableVehicleCargo FALSE;
				_veh setConvoySeparation 50;
				_veh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
				createVehicleCrew _veh;
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _veh))),
					FALSE
				];
				_grp = group ((crew _veh) select 0);
				[(units _grp),(selectRandom [1,2])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_enemyGroupArray pushBack _grp;
				_enemyArray pushBack _veh;
				{
					_x enableStamina FALSE;
					_x enableFatigue FALSE;
					_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
					0 = _enemyArray pushBack _x;
				} forEach (units _grp);
			};
		};
		//comment 'Configure force protection';
	} else {
		//comment 'AMBUSH IN PROGRESS, CHECK STATE';
		if (!(_enemyArray isEqualTo [])) then {
			if (({(alive _x)} count _enemyArray) < 6) then {
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = [_vehiclePos,200,400,3,0,0.7,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
					if (([_spawnPos,150,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) exitWith {};
				};
				if ((_spawnPos distance2D _vehiclePos) < 1000) then {
					if (_intensity > 2) then {
						_enemyGroupType = selectRandom _enemyGroupTypes_reinf_big;
					} else {
						_enemyGroupType = selectRandom _enemyGroupTypes_reinf_big;
					};
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x disableAI 'AUTOCOMBAT';
						};
						_x disableAI 'COVER';
						_x setAnimSpeedCoef 1.1;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
		};
		if (_timeNow > _updateAttackPos_checkDelay) then {
			if (!(_enemyGroupArray isEqualTo [])) then {
				{
					_grp = _x;
					if (!isNull _grp) then {
						if (!(((units _grp) findIf {(alive _x)}) isEqualTo -1)) then {
							_grpLeader = leader _grp;
							if ((_grpLeader distance2D _vehiclePos) > 100) then {
								//comment 'move ahead of vic';
								_posToMove = _vehiclePos getPos [(random 50),_vehicleTravelDirection];
							} else {
								//comment 'move right to vic';
								_posToMove = _vehiclePos;
							};
							_grp move _posToMove;
							{
								if (alive _x) then {
									doStop _x;
									_x doMove _posToMove;
								};
							} forEach (units _grp);
						};
					};
				} count _enemyGroupArray;
			};
			_updateAttackPos_checkDelay = _timeNow + 10;
		};
		if ((_vehicle distance2D _ambushPos) > (_distanceToAmbush * 1.2)) then {
			_ambushInProgress = FALSE;
		};
		if (_hasHitLandmine) then {
			_hasHitLandmine = FALSE;
			if ((random 1) > 0.5) then {
				_landMine = createMine ['ATMine',(getPosATL _vehicle),[],0];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_landMine setDamage [1,TRUE];
				// good place to use the new addForce/addTorque functions
				[35,_vehicle,[((velocity _vehicle) select 0) + (sin (getDir _vehicle) * 4), ((velocity _vehicle) select 1) + (cos (getDir _vehicle) * 4), ((velocity _vehicle) select 2) + 5 + random 10]] remoteExec ['QS_fnc_remoteExec',_vehicle,FALSE];
			} else {
				_landMine = createMine ['APERSMine',(getPosATL _vehicle),[],0];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_landMine setDamage 1;
				// good place to use the new addForce/addTorque functions
				[35,_vehicle,[((velocity _vehicle) select 0) + (sin (getDir _vehicle) * 4), ((velocity _vehicle) select 1) + (cos (getDir _vehicle) * 4), ((velocity _vehicle) select 2) + 3 + random 6]] remoteExec ['QS_fnc_remoteExec',_vehicle,FALSE];
				_dmgCount = ceil (random 3);
				_count = 0;
				//comment 'Set some wheels as fully damaged';
				{
					if (['wheel',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
						if ((random 1) > 0.5) then {
							_vehicle setHit [_x,1];
							_count = _count + 1;
						};
					};
					if (_count >= _dmgCount) exitWith {};
				} count ((getAllHitPointsDamage _vehicle) select 1);
			};
			_timeOffRoad = 0;
		};
		if (!(_enemyArray isEqualTo [])) then {
			{
				_unit = _x;
				if (!isNull _unit) then {
					if (alive _unit) then {
						if (_unit isKindOf 'Man') then {
							if (alive _unit) then {
								if ((_unit knowsAbout _vehicle) < 3) then {
									_unit reveal [_vehicle,3.1];
								};
							};
						};
					};
				};
			} count _enemyArray;

			if (time > _updateMoveDelay) then {
				{
					_unit = _x;
					if (alive _unit) then {
						if (_unit isEqualTo (leader (group _unit))) then {
							if ((_unit distance2D _vehiclePos) > 100) then {
								//comment 'move ahead of vic';
								_posToMove = _vehiclePos getPos [(random 50),_vehicleTravelDirection];
							} else {
								//comment 'move right to vic';
								_posToMove = _vehiclePos;
							};
							_grp move _posToMove;
							{
								if (alive _x) then {
									doStop _x;
									_x doMove _posToMove;
								};
							} forEach (units _grp);
						};
					};
				} count _enemyArray;
				_updateMoveDelay = time + 10;
			};
		};
		if ((_vehiclePos distance2D _startPosition) > 600) then {
			if (([(getPosATL _vehicle),500,[WEST],allUnits,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
				_vehicle setDamage [1,TRUE];
			};
		};
	};
	//comment 'Discourage use of heavy armor';
	if (_QS_manage_convoy) then {
		if (_timeNow > _QS_manage_convoy_checkDelay) then {
			_QS_manage_convoy_vehicles = _vehiclePos nearEntities ['LandVehicle',_QS_manage_convoy_radius];
			if (!(_QS_manage_convoy_vehicles isEqualTo [])) then {
				_QS_manage_convoy_armor = [];
				{
					_convoyVehicle = _x;
					_convoyVehicleType = toLower (typeOf _convoyVehicle);
					if ((_convoyVehicleType in _QS_manage_convoy_armorTypes) || {(_convoyVehicle isKindOf 'Tank')} || {(_convoyVehicle isKindOf 'Wheeled_APC_F')} || {(_QS_manage_convoy_vehicleClass isEqualTo (toLower (getText (configFile >> 'CfgVehicles' >> _convoyVehicleType >> 'vehicleClass'))))})  then {
						if (alive _convoyVehicle) then {
							if (canMove _convoyVehicle) then {
								0 = _QS_manage_convoy_armor pushBack _convoyVehicle;
							};
						};
					};
					if (isNil {_convoyVehicle getVariable _suppressTarget_var}) then {
						if (alive _convoyVehicle) then {
							_suppressTarget = createVehicle [_suppressTarget_type,[0,0,0],[],0,'NONE'];
							missionNamespace setVariable [
								'QS_analytics_entities_created',
								((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
								FALSE
							];
							_suppressTarget attachTo [_convoyVehicle,[0,(random 2),(random 1)]];
							_convoyVehicle setVariable [_suppressTarget_var,_suppressTarget,FALSE];
							0 = _suppressTargets pushBack _suppressTarget;
						};
					};
				} count _QS_manage_convoy_vehicles;
				if (!(_QS_manage_convoy_armor isEqualTo [])) then {
					{
						_launch = TRUE;
						_armoredVehicle = _x;
						if (isNil {_armoredVehicle getVariable _QS_manage_convoy_var}) then {
							0 = _armorTokenVehicle pushBackUnique _armoredVehicle;
							_armoredVehicle setVariable [_QS_manage_convoy_var,[0,(getPosATL _armoredVehicle),(500 + (random 500))],FALSE];
						} else {
							if (((_armoredVehicle getVariable _QS_manage_convoy_var) select 0) >= 3) then {
								_armoredVehicleVelocity = velocity _armoredVehicle;
								_armoredVehicleDir = getDir _armoredVehicle;
								if ((toLower (typeOf _armoredVehicle)) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
									if ((_armoredVehicle animationSourcePhase 'MovePlow') isEqualTo 1) then {
										_launch = FALSE;
										_landMine = createMine [_IEDtype,(_armoredVehicle getRelPos [15,0]),[],0];
										_landMine2 = createMine [_IEDtype,(_armoredVehicle getRelPos [15,0]),[],3];
									} else {
										_landMine = createMine [_IEDtype,(getPosATL _armoredVehicle),[],0];
										_landMine2 = createMine [_IEDtype,(getPosATL _armoredVehicle),[],3];
									};
								} else {
									_landMine = createMine [_IEDtype,(getPosATL _armoredVehicle),[],0];
									_landMine2 = createMine [_IEDtype,(getPosATL _armoredVehicle),[],3];
								};
								missionNamespace setVariable [
									'QS_analytics_entities_created',
									((missionNamespace getVariable 'QS_analytics_entities_created') + 2),
									FALSE
								];
								_landMine setDamage [1,TRUE];
								_landMine2 setDamage [1,TRUE];
								if (_launch) then {
									// good place to use the new addForce/addTorque functions
									[35,_armoredVehicle,[(_armoredVehicleVelocity select 0) + (sin _armoredVehicleDir * 4), (_armoredVehicleVelocity select 1) + (cos _armoredVehicleDir * 4), (_armoredVehicleVelocity select 2) + 4 + random 8]] remoteExec ['QS_fnc_remoteExec',_armoredVehicle,FALSE];
								};
								_armoredVehicle setVariable [_QS_manage_convoy_var,[0,(getPosATL _armoredVehicle),(350 + (random 250))],FALSE];
							} else {
								if ((((_armoredVehicle getVariable _QS_manage_convoy_var) select 1) distance2D (getPosATL _armoredVehicle)) > ((_armoredVehicle getVariable _QS_manage_convoy_var) select 2)) then {
									_armoredVehicle setVariable [
										_QS_manage_convoy_var,
										[
											(((_armoredVehicle getVariable _QS_manage_convoy_var) select 0) + 1),
											(getPosATL _armoredVehicle),
											(500 + (random 500))
										],
										FALSE
									];
								};
							};
						};
					} count _QS_manage_convoy_armor;
				};
			};
			_QS_manage_convoy_checkDelay = time + _QS_manage_convoy_delay;
		};
	};
	//comment 'Keep all players near vehicle in the same group';
	if (_QS_manage_group) then {
		if (_timeNow > _QS_manage_group_checkDelay) then {
			if ((_vehicle distance2D _base) > 1000) then {
				if (!isNull _vehicleDriverGroup) then {
					{
						_player = _x;
						if (alive _player) then {
							if (!(_player getUnitTrait 'QS_trait_pilot')) then {
								if (!(captive _player)) then {
									if ((_player distance2D _vehicle) < 150) then {
										if (((units (group _player)) findIf {(!isPlayer _x)}) isEqualTo -1) then {
											if (!((group _player) isEqualTo _vehicleDriverGroup)) then {
												[_player] joinSilent _vehicleDriverGroup;
											};
										};
									};
								};
							};
						};
					} count (allPlayers unitsBelowHeight 25);
				};
			};
			_QS_manage_group_checkDelay = _timeNow + _QS_manage_group_delay;
		};
	};
	if (!alive _vehicle) exitWith {
		//comment 'Mission fail';
		['SM_TRUCK',['Side mission','Truck mission failed!<br/>Truck destroyed']] remoteExec [_fuctionNotification,-2,FALSE];
		[2,"Truck mission failed!",0,0] remoteExec ['NL_fnc_objPopup', -2, FALSE];
		sleep 5;
		[0,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		sleep 60;
		deletevehicle _vehicle2;
		deletevehicle _vehicle3;
	};
	if ((_vehicle distance2D _destination) < 50) exitWith {
		//comment 'Mission success';
		['SM_TRUCK',['Side mission','Truck mission complete!<br/>Truck at destination']] remoteExec [_fuctionNotification,-2,FALSE];
		[1,"Truck mission complete!",0,70] remoteExec ['NL_fnc_objPopup', -2, FALSE];
		[70] call NL_fnc_addScore;
		sleep 5;
		[1,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		sleep 60;
		deletevehicle _vehicle2;
		deletevehicle _vehicle3;
	};
	sleep _sleepTime;
};
//comment 'Cleanup';
['QS_IA_TASK_SM_ESCORT'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
if (!(_suppressTargets isEqualTo [])) then {
	{
		if (!isNull _x) then {
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		};
	} count _suppressTargets;
};
if (!(_enemyArray isEqualTo [])) then {
	{
		if (!isNull _x) then {
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		};
	} count _enemyArray;
};
if (!(_armorTokenVehicle isEqualTo [])) then {
	{
		if (!isNull _x) then {
			if (alive _x) then {
				if (!isNil {_x getVariable _QS_manage_convoy_var}) then {
					_x setVariable [_QS_manage_convoy_var,nil];
				};
			};
		};
	} forEach _armorTokenVehicle;
};
deleteMarker _marker0;
deleteMarker 'QS_marker_escort_1';
if (alive _vehicle) then {
	0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_vehicle,'NOW_DISCREET',0];
};
deleteMarker 'QS_marker_escort_1';
missionNamespace setVariable ['QS_sideMission_vehicle',objNull,TRUE];
missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
