/*/
File: fn_uniformBug.sqf
Author:

	McDodelijk

Last modified:

	31/10/2020 by McDodelijk

Description:

	Check if uniform is vissible for others.
	If so, replace it.
__________________________________________________/*/
scriptName "McD_fnc_uniformBug";
params [
	["_unit", objNull, [objNull]],
	["_uniformSeen", nil, [""]]
];

// Parameter check
if (isNull _unit) exitWith {
	["Script %1 missing or wrong parameter value: %2", "McD_fnc_uniformBug", _this] call McD_fnc_error;
};

// Local? Do it!
if (local _unit && !isNil "_uniformSeen") exitWith {
	private _uniform = (uniform _unit);
	if !(_uniform isEqualTo _uniformSeen) then {
		private _oldLoadout = getUnitLoadout [_unit, FALSE];
		if !((_oldLoadout # 3 # 0) isEqualTo _uniform) then {
			(_oldLoadout # 3) set [0, _uniform];
			"Message for McDodelijk: getUnitLoadout does not see the same uniform" remoteExec ["diag_log", 2, FALSE];
		} else {
			"Message for McDodelijk: getUnitLoadout does see the same uniform" remoteExec ["diag_log", 2, FALSE];
		};
		removeUniform _unit;
		_unit setUnitLoadout _oldLoadout;
		systemChat "Uniform was bugged";
	} else {
		systemChat "Uniform is ok";
	};
};

// Server direct call to turret owner
if(isServer) exitWith {
	[_unit, uniform _unit] remoteExecCall ["McD_fnc_uniformBug", _unit, false]; 
};

// Not local, not the server => report to server!
// But to a spam check first
if (_unit == player && {(localNamespace getVariable ["McD_uniformBug_lastCheck", 0]) > (diag_tickTime - 10)}) exitWith {
	systemChat "Spam protection: Please wait at least 10 seconds between uniform check requests.";
};
localNamespace setVariable ["McD_uniformBug_lastCheck", diag_tickTime];

[_unit] remoteExecCall ["McD_fnc_uniformBug", 2, false];
systemChat "Initializing uniform check";