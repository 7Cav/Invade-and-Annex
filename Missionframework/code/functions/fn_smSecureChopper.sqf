/*
Author:

	Quiksilver

Last modified:

	25/04/2014

Description:

	Destroy chopper

Notes:

	Deprecated mission
____________________________________*/

scriptName 'Side Mission - Secure Chopper';

private [
	"_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray",
	"_briefing","_fuzzyPos","_unitsArray","_dummy","_object",'_chopperType','_chopperTypes','_c4Message',
	'_c4Messages','_researchTable','_dummyTypes','_dummyType','_objectTypes','_objectType'
];
_c4Messages = [
	"Chopper data secured. The charge has been set! 15 seconds until detonation.",
	"Heli data secured. The explosives have been set! 15 seconds until detonation.",
	"Chopper intel secured. The charge is planted! 15 seconds until detonation."
];
_c4Message = selectRandom _c4Messages;
_chopperTypes = ["O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Light_02_unarmed_F","B_Heli_Attack_01_dynamicLoadout_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_box_F"];
_chopperType = selectRandom _chopperTypes;

/*/-------------------- FIND SAFE POSITION FOR OBJECTIVE/*/

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_flatPos = ['WORLD',-1,-1,'LAND',[5,0,0.2,(sizeOf 'Land_TentHangar_V1_F'),0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance (markerPos 'QS_marker_base_marker')) > 1700) then {
		if ((_flatPos distance (markerPos 'QS_marker_Almyra_blacklist_area')) > 2000) then {
			if (missionNamespace getVariable 'QS_module_fob_enabled') then {
				if ((_flatPos distance (markerPos 'QS_marker_module_fob')) < 4000) then {
					if ((_flatPos distance (markerPos 'QS_marker_module_fob')) > 1000) then {
						_accepted = TRUE;
					};
				};
			} else {
				_accepted = TRUE;
			};
		};
	};
	if (_accepted) exitWith {};
};

_objPos = [_flatPos,20,45,7.5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');

/*/------------------- SPAWN OBJECTIVE/*/

_randomDir = (random 360);
_hangar = createVehicle ['Land_TentHangar_V1_F',[_flatPos select 0,_flatPos select 1,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_hangar setPosWorld [((getPosWorld _hangar) select 0), ((getPosWorld _hangar) select 1), (((getPosWorld _hangar) select 2) - 0.75)];
_hangar setDir _randomDir;
QS_sideObj = createVehicle [_chopperType,[0,0,10],[],0,'CAN_COLLIDE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
QS_sideObj setDir _randomDir;
QS_sideObj setPos [_flatPos select 0,_flatPos select 1,0];
QS_sideObj lock 3;
_house = createVehicle [(['Land_Cargo_House_V3_F','Land_Cargo_House_V4_F'] select (worldName isEqualTo 'Tanoa')),[_objPos select 0,_objPos select 1,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_house setDir (random 360);
_house allowDamage FALSE;
_researchTable = createVehicle ['Land_CampingTable_small_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
sleep 0.3;
_researchTable attachTo [_house,[0,3,0.45]];
sleep 0.3;
_dummyTypes = ['Box_East_AmmoOrd_F','Box_IND_AmmoOrd_F'];
_dummyType = selectRandom _dummyTypes;
_objectTypes = ['Land_Laptop_03_black_F','Land_Laptop_device_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_object enableSimulationGlobal TRUE;
sleep 0.1;
_object attachTo [_house,[0,3,1]];
for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [QS_sideObj] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');

/*/-------------------- BRIEF/*/

_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

{
	_x setMarkerPos _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1Secure Chopper',(toString [32,32,32])]);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		'Secure the enemy helicopter! CSAT is experimenting with new radar-defeating technology. Get over there and steal the schematics. It will be located in a nearby building! Once secured, the helicopter will self-destruct, so be sure to clear the area. This objective is not accurately marked.',
		'Secure Chopper',
		'Secure Chopper'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');

_briefing = parseText "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Enemy Chopper</t><br/>____________________<br/>OPFOR forces have been provided with a new prototype attack chopper and they're keeping it in a hangar somewhere on the island.<br/><br/>We've marked the suspected location on your map; head to the hangar, get the data and destroy the helicopter.</t>";
//['hint',_briefing] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['NewSideMission',['Secure Enemy Chopper']] remoteExec ['QS_fnc_showNotification',-2,FALSE];

missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];


for '_x' from 0 to 1 step 0 do {

	if (!alive QS_sideObj) exitWith {

		/*/-------------------- DE-BRIEFING/*/

		//['sideChat',[WEST,'HQ'],'Prototype intel lost, mission FAILED!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[2,"Prototype intel lost",0,0] remoteExec ['NL_fnc_objPopup', -2, FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];

		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];

		/*/-------------------- DELETE/*/

		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [_object,_researchTable];			/*/ hide objective pieces/*/
		sleep 120;
		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [QS_sideObj,_house,_hangar];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};

	if (missionNamespace getVariable 'QS_smSuccess') exitWith {

		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];

		/*/-------------------- BOOM!/*/

		_dummy = createVehicle [_dummyType,[0,0,0],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_dummy setPosWorld [((getPosWorld QS_sideObj) select 0), (((getPosWorld QS_sideObj) select 1) +3), (((getPosWorld QS_sideObj) select 2) + 0.5)];
		sleep 0.1;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _object;
		uiSleep 14;											/*/ ghetto bomb timer/*/
		'Bo_GBU12_LGB' createVehicle (getPos _dummy); 		/*/ default "Bo_Mk82"/*/
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _dummy;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _researchTable;
		sleep 0.1;

		/*/-------------------- DE-BRIEFING/*/

		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		[1,"Side mission accomplished",0,70] remoteExec ['NL_fnc_objPopup', -2, FALSE];
		[70] call NL_fnc_addScore;

		/*/-------------------- DELETE/*/
		sleep 120;
		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [QS_sideObj,_house,_hangar];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};
