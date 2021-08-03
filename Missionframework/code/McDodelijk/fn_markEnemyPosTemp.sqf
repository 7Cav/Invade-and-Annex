/*/
File: fn_markEnemyPosTemp.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Non-JIP temporary map markers for enemy positions
__________________________________________________/*/
scriptName "McD_fnc_markEnemyPosTemp";
params [["_positions", [], [[]]], ["_duration", 90, [0]]];

if(isNil "McD_tempEnemyPosMarkerNames") then 
{
	McD_tempEnemyPosMarkerNames = [];
};

private _i = 0;
private _newMarkers = [];
private _n = "";
private _p = [];
// Making sure to use only unique names
while {count _positions > 0} do {
	_n = "McD_tmpPosMrk_" + str _i;
	if!(_n in McD_tempEnemyPosMarkerNames) then {
		McD_tempEnemyPosMarkerNames pushBack _n;
		_newMarkers pushBack _n;
		_p = _positions deleteAt 0;
		if(_p isEqualType objNull) then {
			_p = (position _p);
		};
		createMarkerLocal [_n, _p];
		_n setMarkerColorLocal "ColorEAST";
		_n setMarkerAlphaLocal 1;
		_n setMarkerTypeLocal "hd_dot";
	};
	_i = _i + 1;
};

(missionNamespace getVariable 'QS_managed_hints') pushBack [10,TRUE,10,-1,"Check your map. Last known enemy positions transfered into our GPS systems. Unfortunately CSAT noticed that and turned off their position transmission.",[],-1,TRUE,'Datalink hacked',FALSE];
// Fade markers over time and delete them
[_newMarkers, _duration] spawn {
	scriptName "McD_fnc_markEnemyPosTemp_Countdown";
	params ["_markers", "_duration"];
	for "_i" from 9 to 1 step -1 do {
		uiSleep (_duration / 10);
		{
			_x setMarkerAlphaLocal (_i/10);
		} foreach _markers;
	};
	uiSleep (_duration / 10);
	{
		deleteMarkerLocal _x;
	} foreach _markers;
	McD_tempEnemyPosMarkerNames = McD_tempEnemyPosMarkerNames - _markers;
};