/*/
File: fn_clientInteractSurrender.sqf
Author:

	Quiksilver

Last Modified:

	4/02/2017 A3 1.80 by Quiksilver

Description:

	Command Surrender
__________________________________________________________/*/
_t = cursorTarget;
if (
	(!alive _t) ||
	{(!(_t isKindOf 'Man'))} ||
	{(!isNull (objectParent _t))} ||
	{(captive _t)} ||
	{(!(_t getVariable ['QS_surrenderable',FALSE]))} ||
	{(!((lineIntersectsSurfaces [(eyePos player),(aimPos _t),player,_t,TRUE,-1,'GEOM','VIEW',TRUE]) isEqualTo []))} ||
	{(uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE])}
) exitWith {};
playSound 'click';
if (!(_t getVariable ['QS_unit_enableMove',FALSE])) then {
	['enableAI',_t,'PATH'] remoteExecCall ['QS_fnc_remoteExecCmd',_t,FALSE];
	_t setVariable ['QS_unit_enableMove',TRUE,FALSE];
	_t setVariable ['QS_unitGarrisoned',FALSE,TRUE];
};
_onProgress = {
	FALSE
};
_onCancelled = {
	params ['_entity'];
	private _c = FALSE;
	if (!alive player) then {_c = TRUE;};
	if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_c = TRUE;};
	if (!isNull (objectParent player)) then {_c = TRUE;};
	if (!(_entity in [cursorTarget,cursorObject])) then {_c = TRUE;};
	if (!alive _entity) then {_c = TRUE;};
	if (captive _entity) then {_c = TRUE;};
	if (weaponLowered player) then {_c = TRUE;};
	if (!((stance player) in ['STAND','CROUCH'])) then {_c = TRUE;};
	if (!(_entity getVariable ['QS_surrenderable',FALSE])) then {_c = TRUE;};
	if (!((lineIntersectsSurfaces [(eyePos player),(aimPos _entity),player,_entity,TRUE,-1,'GEOM','VIEW',TRUE]) isEqualTo [])) then {_c = TRUE;};
	if (_c) then {
		playSound 'click';
	};
	_c;
};
_onCompleted = {
	params ['_entity'];
	if (isNil {_entity getVariable 'QS_surrenderable'}) exitWith {};
	if (!isNil {_entity getVariable 'QS_missionSurrender'}) exitWith {
		for '_x' from 0 to 2 step 1 do {
			_entity setVariable ['QS_surrenderable',nil,TRUE];
		};
		missionNamespace setVariable ['HE_SURRENDERS',TRUE,TRUE];
	};
	playSound 'click';
	if (_entity isEqualTo (missionNamespace getVariable 'QS_csatCommander')) then {
		[58,[profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
	if (_entity isEqualTo (missionNamespace getVariable 'QS_arrest_target')) then {
		['sideChat',[WEST,'HQ'],(format ['%1 arrested the HVT!',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		for '_x' from 0 to 1 step 1 do {
			missionNamespace setVariable ['QS_aoSmallTask_Arrested',TRUE,TRUE];
		};
	};
	if (local _entity) then {
		[21,_entity,(getPlayerUID player),profileName] call (missionNamespace getVariable 'QS_fnc_remoteExec');
	} else {
		[21,_entity,(getPlayerUID player),profileName] remoteExecCall ['QS_fnc_remoteExec',_entity,FALSE];
	};
	_text = format ['%1 has captured a unit at grid %2',profileName,(mapGridPosition player)];
	['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	50 cutText ['Captured!','PLAIN DOWN',0.75];
};
/*/
How hard should it be to capture the unit?
Maybe we could check how depleted the enemy units group is
/*/
private _timerRange = [3.5,4,4.35];
private _timerMin = 3;
private _duration = ((random _timerRange) + (morale _t) - (damage _t) - (needReload _t)) max _timerMin;
[
	'Capturing unit',
	_duration,
	0,
	[[_t],{FALSE}],
	[[_t],_onCancelled],
	[[_t],_onCompleted],
	[[],{FALSE}],
	FALSE
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
