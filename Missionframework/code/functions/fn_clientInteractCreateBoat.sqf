/*/
File: fn_clientInteractCreateBoat.sqf
Author:

	Quiksilver
	
Last modified:
	
	13/09/2017 A3 1.76 by Quiksilver
	
Description:

	Engineer creates a boat and consumes a toolkit
_______________________________________________________/*/

if (!isNull (objectParent player)) exitWith {};
if !([player, "ToolKit"] call BIS_fnc_hasItem) exitWith {2 cutText ["You need a toolkit to place the sandbags!",'PLAIN',2];};

if!( {!isNull _x} count NL_module_engineerObjects < NL_module_engineerObjectLimit ) exitWith {
  2 cutText ['Limit of sandbags and boats reached! Disassemble your old ones to place a new one.','PLAIN',2];
};

player removeItem 'ToolKit';
private _boatType = ['B_Lifeboat','B_T_Lifeboat'] select (worldName isEqualTo 'Tanoa');
if ((!underwater player) && (((eyePos player) select 2) > 0.25)) then {
	_boatType = ['B_Boat_Transport_01_F','B_T_Boat_Transport_01_F'] select (worldName isEqualTo 'Tanoa');
};
private _position = player modelToWorld [0,15,0];
_position set [2,1];

private _boat = createVehicle [_boatType,_position,[],0,'NONE'];
_boat setDir (getDir player);
if (surfaceIsWater _position) then {
	_boat setPosASL _position;
} else {
	_boat setPosATL _position;
};
NL_module_engineerObjects pushBack _boat;
_boat setVariable ['NL_object_boatEngineer', TRUE, TRUE];
_boat setVariable ['QS_RD_vehicleRespawnable', TRUE, TRUE];

private _text = format ['%1 has inflated a boat at grid %2', profileName, (mapGridPosition player)];
['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];

50 cutText [(format ['%1 inflated, toolkit removed',(getText (configFile >> 'CfgVehicles' >> _boatType >> 'displayName'))]),'PLAIN DOWN',0.75];