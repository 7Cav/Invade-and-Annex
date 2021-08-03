/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver, McDodelijk

Last Modified:

	02/03/2020 by McDodelijk
	
Description:

	Arsenal
_____________________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 3) then {
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
} else {
	['Open',FALSE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};
if (isNil {player getVariable 'QS_arsenalAmmoPrompt'}) then {
	player setVariable ['QS_arsenalAmmoPrompt',TRUE,FALSE];
	50 cutText ['To add ammunition, open the container on the LEFT (uniform,vest,backpack) and add ammunition on the RIGHT.','PLAIN'];
};
TRUE;