diag_log "PreInit running";
//BIS_fnc_endmission = compileFinal format['%2 _this call %1;', BIS_fnc_endmission,

BIS_fnc_endmission  = compileFinal format['%1',
'
if !(remoteExecutedOwner == 0) then {
	[format ["(target: %1(UID: %2))", profileName, getPlayerUID player],
	{
		format ["HACKER WARNING: %1(UID: %2) initialized Bis_fnc_endMission on someone else%3", profileName, getPlayerUID player, _this] remoteExec ["diag_log", 2];
	}] remoteExec ["call", remoteExecutedOwner];
} else {
	format ["HACKER WARNING: %1(UID: %2) initialized Bis_fnc_endMission on his own maschine", profileName, getPlayerUID player] remoteExec ["diag_log", 2];
};
'
];

//BIS_fnc_endmissionServer = compileFinal format['%2 _this call %1;', BIS_fnc_endmissionServer,
BIS_fnc_endmissionServer = compileFinal format['%1',
'
if !(remoteExecutedOwner == 0) then {
	[format ["(target: %1(UID: %2))", profileName, getPlayerUID player],
	{
		format ["HACKER WARNING: %1(UID: %2) initialized BIS_fnc_endmissionServer on someone else%3", profileName, getPlayerUID player, _this] remoteExec ["diag_log", 2];
	}] remoteExec ["call", remoteExecutedOwner];
} else {
	format ["HACKER WARNING: %1(UID: %2) initialized BIS_fnc_endmissionServer on his own maschine", profileName, getPlayerUID player] remoteExec ["diag_log", 2];
};
'
];

BIS_fnc_dynamicGroups = compileFinal preprocessFileLineNumbers "code\McDodelijk\preinit\bis_fnc_dynamicGroups.sqf";

private _fnc_secureFNC = {
	params ["_cfgArray", "_tag", "_filePath"];
	if (isNil "_cfgArray" || isNil "_tag" || isNil "_filePath") exitWith {
		{
			[("true" configClasses(_x)), configName(_x), getText(_x >> "file")] call _fnc_secureFNC;
		} foreach ("true" configClasses(missionConfigFile >> "CfgFunctions"));
	};
	{
		private _subClasses = ("true" configClasses(_x));
		private _subFilePath = getText(_x >> "file");
		if (count _subClasses > 0) then {
			private _nextFilePath = if(_filePath == "" || _subFilePath != "") then {
				_subFilePath;
			} else {
				_filePath;
			};
			[_subClasses, _tag, _nextFilePath] call _fnc_secureFNC;
		} else {
			private _file = if(_subFilePath != "") then {
				_subFilePath;
			} else {
				format["%1\fn_%2.sqf", _filePath, configName(_x)];
			};
			if (_file select [0, 1] == "\") then {
				_file = _file select [1];
			};
			if("." in _file) then {
				call compile format['%1_fnc_%2 = compileFinal preprocessFileLineNumbers "%3";', _tag, configName(_x), _file]; 
			};
		};
	} foreach _cfgArray;
};
0 call _fnc_secureFNC;

{
	if(typeName (missionNamespace getVariable _x) == "CODE") then {
		_arr = _x splitString "_";
		if((count _arr > 2) && { (_arr # 0) in ["bis", "bin", "BIS", "BIN"] && (_arr # 1) in ["fnc", "FNC"] && !(_arr # 2 in ["endMission", "endMissionServer"])}) then {
			// fortmat only accepts < 13000 characters... wierd, isn't it? Wiki: The output of this command is limited to ~8Kb
			//missionNamespace setVariable [_x, compileFinal format ["_this call %1", missionNamespace getVariable _x]];
			missionNamespace setVariable [_x, compileFinal ("_this call " + str (missionNamespace getVariable _x))];
		};
	};
} foreach (allVariables missionNamespace);