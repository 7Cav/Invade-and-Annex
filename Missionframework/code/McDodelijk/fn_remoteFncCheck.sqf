/*/
File: fn_remoteFncCheck.sqf
Author:

	McDodelijk

Last modified:

	02/11/2020 by McDodelijk

Description:

	Check connection by making sure all 
	remote scripts have been transmitted
__________________________________________________/*/
scriptName "McD_fnc_remoteFncCheck";
if (!canSuspend) exitWith {
	["Suspending not allowed in this context, but required for %1", "McD_fnc_remoteFncCheck"] call McD_fnc_error;
};

scopeName "remoteFncCheckMain";
for "_i" from 4 to 0 step -1 do {
	private _functionsToCheck = missionNameSpace getVariable ["McD_remoteFunctionNames", []];
	if ((_functionsToCheck isEqualType []) && {(count _functionsToCheck > 0)}) then {
		_functionsToCheck = _functionsToCheck + ["QS_data_arsenal"];
	
		private _numMissingFunctions = {
			if (not ((missionNamespace getVariable [_x, FALSE]) isEqualType {})) then {
				diag_log format["Error: Missing remote script: %1", _x];
				TRUE
			} else {
				FALSE
			};
		} count _functionsToCheck;

		if(_numMissingFunctions == 0) then {
			breakTo "remoteFncCheckMain";
		};
	};
	if(_i == 0) exitWith {
		if (hasInterface) then {
			if (userInputDisabled) then {
				disableUserInput FALSE;
			};
		};
		endMission 'QS_RD_end_2';
	};
	uiSleep 5;
};