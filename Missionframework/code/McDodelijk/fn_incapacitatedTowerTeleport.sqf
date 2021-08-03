/*/
File: fn_incapacitatedTowerTeleport.sqf
Author:

	McDodelijk

Last modified:

	27/04/2021 by McDodelijk

Description:

	Checks if player is on a destroyed small tower
	and moves him down  to be able to get revived
__________________________________________________/*/
scriptName "McD_fnc_incapacitatedTowerTeleport";

private _ruinTypes = ["Land_Cargo_Patrol_V1_ruins_F", "Land_Cargo_Patrol_V2_ruins_F", "Land_Cargo_Patrol_V3_ruins_F", "Land_Cargo_Patrol_V3_derelict_F", "Land_Cargo_Patrol_V4_ruins_F"];
private _playerPosALS = getPosASL player;
private _playerPosAGL = ASLToAGL _playerPosALS;
// Intesect method has a big problem: The model has a hole on which you can stand, so bounding box is used
//private _intersects = lineIntersectsWith [ _playerPosALS vectorAdd [0, 0, 1], _playerPosALS vectorDiff [0, 0, 2], player, objNull, FALSE];
//private _buildings = (nearestObjects [_playerPosAGL, _ruinTypes, 20]) select {_x in _intersects};
private _buildings = (nearestObjects [_playerPosAGL, _ruinTypes, 10]) select {
	private _boundingCube = (0 boundingBoxReal _x);
	private _relLocation = (_x worldToModel (_playerPosAGL));
	(
		_relLocation # 0 > (_boundingCube # 0 # 0 min _boundingCube # 1 # 0 ) && 
		{_relLocation # 0 < (_boundingCube # 0 # 0 max _boundingCube # 1 # 0 )} && 
		{_relLocation # 1 > (_boundingCube # 0 # 1 min _boundingCube # 1 # 1 )} && 
		{_relLocation # 1 < (_boundingCube # 0 # 1 max _boundingCube # 1 # 1 )} && 
		{_relLocation # 2 > (_boundingCube # 0 # 2 min _boundingCube # 1 # 2 )} && 
		{_relLocation # 2 < (_boundingCube # 0 # 2 max _boundingCube # 1 # 2 )}
	)
};
{
	private _building = _x;
	private _relHeight = (_building worldToModel _playerPosAGL) # 2;
	if (_relHeight > -0.4 && _relHeight < 3.6) then {
		player setPosASL AGLToASL (_building buildingPos 0);
	};		
} foreach _buildings;