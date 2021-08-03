/*/
File: fn_aoMinefield.sqf
Author:

	Quiksilver

Last modified:

	13/08/2016 A3 1.62 by Quiksilver

Description:

	Spawn a radial minefield with some razorwire around it
___________________________________________/*/

private ['_centralPos','_objectsArray','_mineTypes','_mine','_mineType','_distanceFence','_maxDistanceMines','_clearDistance','_barriers','_angle','_signPos','_pos','_minePos'];
_centralPos = getPosATL (missionNamespace getVariable 'QS_radioTower');
_objectsArray = [];
_mineTypes = [	'APERSBoundingMine', 0.4,
				'APERSMine', 0.4,
				'ATMine', 0.2
			];
if (worldName isEqualTo 'Tanoa') then {
	_distanceFence = 25;
	_maxDistanceMines = 27;
	_clearDistance = 10;
	_barriers = 15;
	_angle = 30;
} else {
	_distanceFence = 42;
	_maxDistanceMines = 35;
	_clearDistance = 13;
	_barriers = 23;
	_angle = 15;
};

private _mineDistanceRange = _maxDistanceMines - _clearDistance;

for '_x' from 0 to (round (33 + (random 22))) step 1 do {
	_mineType = selectRandomWeighted _mineTypes;
	_minePos = _centralPos getPos [_clearDistance + (_mineDistanceRange * (sqrt (random 1))),(random 360)];
    _mine = createMine [_mineType,_minePos,[],0];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	//_mine enableDynamicSimulation TRUE;
	_mine setVectorUp (surfaceNormal (getPosWorld _mine));
	{
		_x revealMine _mine;
	} forEach [EAST,RESISTANCE];
	if (surfaceIsWater (getPosWorld _mine)) then {
		deleteVehicle _mine;
	} else {
		0 = _objectsArray pushBack _mine;
	};
};
_dir = 180;
private ['_configClass','_model'];
_configClass = configFile >> 'CfgVehicles' >> 'Land_Razorwire_F';
_model = getText (_configClass >> 'model');
if ((_model select [0,1]) isEqualTo '\') then {
	_model = _model select [1];
};
if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
	_model = _model + '.p3d';
};
for '_c' from 0 to _barriers step 1 do {
	_pos = _centralPos getPos [_distanceFence,_dir];
	_pos set [2,0];
	_pos set [2,(getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset'))];
	_pos = ATLToASL _pos;
	_sign = createSimpleObject [_model,_pos];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
    _sign setDir _dir;
	_sign setVectorUp (surfaceNormal _pos);
    _dir = _dir + _angle;
	0 = _objectsArray pushBack _sign;
};
_objectsArray;
