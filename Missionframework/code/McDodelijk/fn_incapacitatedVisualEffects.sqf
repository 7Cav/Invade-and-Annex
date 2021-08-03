/*/
File: fn_incapacitatedVisualEffects.sqf
Author:

	McDodelijk

Last modified:

	29/10/2020 by McDodelijk

Description:

	Creates PP visual effects and overlays a blood
	texture (Parts from BIS_fnc_bloodEffect by
	Vladimir Hynek)
__________________________________________________/*/
scriptName "McD_fnc_incapacitatedVisualEffects";
params [["_activate", TRUE, [TRUE]]];

disableSerialization;

private _fnc_createPPEffect = {
	params ["_effectName", "_priority"];
	private _effectHandle = -1;
	while {_effectHandle < 0} do {
		_effectHandle = ppEffectCreate [_effectName, _priority]; 
		_priority = _priority + 1;  
	};
	_effectHandle ppEffectForceInNVG TRUE;
	_effectHandle
};

// Make sure blood texture is ready
if (isnil {uinamespace getvariable "RscHealthTextures"}) then {
	uinamespace setvariable ["RscHealthTextures",displaynull]
};
if (isnull (uinamespace getvariable "RscHealthTextures")) then {
	(["HealthPP_blood"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","plain"];
};
private _display = (uinamespace getvariable "RscHealthTextures");
if (isnil {uinamespace getvariable "McD_incapacitatedPP_texLower"} || {isNull (uinamespace getvariable "McD_incapacitatedPP_texLower")}) then {
	uiNamespace setVariable ["McD_incapacitatedPP_texLower", (_display displayctrl 1211)];
};
if (isnil {uinamespace getvariable "McD_incapacitatedPP_texMiddle"} || {isNull (uinamespace getvariable "McD_incapacitatedPP_texMiddle")}) then {
	uiNamespace setVariable ["McD_incapacitatedPP_texMiddle", (_display displayctrl 1212)];
};
if (isnil {uinamespace getvariable "McD_incapacitatedPP_texUpper"} || {isNull (uinamespace getvariable "McD_incapacitatedPP_texUpper")}) then {
	uiNamespace setVariable ["McD_incapacitatedPP_texUpper", (_display displayctrl 1213)];
};
private _texLower = (uinamespace getvariable "McD_incapacitatedPP_texLower");
private _texMiddle = (uinamespace getvariable "McD_incapacitatedPP_texMiddle");
private _texUpper = (uinamespace getvariable "McD_incapacitatedPP_texUpper");

// Make sure effects are ready
if (isNil "McD_incapacitatedPPColor") then {
	//McD_incapacitatedPPColor = ['ColorCorrections',1632] call _fnc_createPPEffect;
};
if (isNil "McD_incapacitatedPPVig") then {
	McD_incapacitatedPPVig = ['ColorCorrections',1633] call _fnc_createPPEffect;
};
if (isNil "McD_incapacitatedPPBlur") then {
	McD_incapacitatedPPBlur = ['DynamicBlur',525] call _fnc_createPPEffect;
};

if (_activate) then {
	if !(isNil "McD_incapacitatedPPEffectsLoopHandle") exitWith {};
	// Setup blood texture
	_texLower ctrlsetfade 1;
	_texLower ctrlcommit 0;
	
	_texMiddle ctrlsetfade 1;	
	_texMiddle ctrlcommit 0;
	
	_texUpper ctrlsetfade 1;	
	_texUpper ctrlcommit 0;

	private _x = ((0 * safezoneW) + safezoneX) + ((safezoneW - (2.125 * safezoneW * 3/4)) / 2);
	private _y = (-0.0625 * safezoneH) + safezoneY;
	private _w = 2.125 * safezoneW * 3/4;
	private _h = 1.125 * safezoneH;

	_texLower ctrlsetposition [_x, _y, _w, _h];
	_texMiddle ctrlsetposition [_x, _y, _w, _h];
	_texUpper ctrlsetposition [_x, _y, _w, _h];
	
	_texUpper ctrlShow TRUE;
	_texMiddle ctrlShow TRUE;
	_texLower ctrlShow TRUE;

	_texLower ctrlcommit 0;
	_texMiddle ctrlcommit 0;
	_texUpper ctrlcommit 0;

	// Setup PP effects
	//McD_incapacitatedPPColor ppEffectEnable TRUE;
	McD_incapacitatedPPBlur ppEffectEnable TRUE;
	McD_incapacitatedPPVig ppEffectEnable TRUE;

	//McD_incapacitatedPPColor ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299, 0.587, 0.114, 0]];
	McD_incapacitatedPPBlur ppEffectAdjust [0];
    McD_incapacitatedPPVig ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1]];

	//McD_incapacitatedPPColor ppEffectCommit 0;
    McD_incapacitatedPPBlur ppEffectCommit 0;
    McD_incapacitatedPPVig ppEffectCommit 0;

	// Start effects and texture
	//McD_incapacitatedPPColor ppEffectAdjust [1,1,0.15,[0.8,0.8,0.8,0.1],[0.1,0,0,0.1],[1,1,1,1]];
	McD_incapacitatedPPBlur ppEffectAdjust [1.5];
    McD_incapacitatedPPVig ppEffectAdjust [1, 1, 0, [0, 0, 0, 1], [0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1]];

	//McD_incapacitatedPPColor ppEffectCommit 6;
    McD_incapacitatedPPBlur ppEffectCommit 6;
    McD_incapacitatedPPVig ppEffectCommit 6;

	_texLower ctrlsetfade 0.2;
	_texMiddle ctrlsetfade 0.7;
	_texUpper ctrlsetfade 0.7;
	
	_texLower ctrlcommit 1;
	_texMiddle ctrlcommit 1;
	_texUpper ctrlcommit 1;

	McD_incapacitatedPPEffectsLoopHandle = [] spawn {
		scriptName "McD_fnc_incapacitatedVisualEffectLoop";
		for '_x' from 0 to 1 step 0 do {
			waitUntil {ppEffectCommitted McD_incapacitatedPPBlur};
			
			McD_incapacitatedPPBlur ppEffectAdjust [4];
			McD_incapacitatedPPVig ppEffectAdjust [1, 1, 0, [0, 0, 0, 1], [0, 0, 0, 1], [0, 0, 0, 0], [0.4, 0.15, 0, 0, 0, 0, 1]];
			McD_incapacitatedPPBlur ppEffectCommit 3;
			McD_incapacitatedPPVig ppEffectCommit 3;

			waitUntil {ppEffectCommitted McD_incapacitatedPPBlur};

			McD_incapacitatedPPBlur ppEffectAdjust [1.75];
			McD_incapacitatedPPVig ppEffectAdjust [1, 1, 0, [0, 0, 0, 1], [0, 0, 0, 1], [0, 0, 0, 0], [0.5, 0.35, 0, 0, 0, 0, 1]];
			McD_incapacitatedPPBlur ppEffectCommit 3;
			McD_incapacitatedPPVig ppEffectCommit 3;
		};
	};
} else {
	if (isNil "McD_incapacitatedPPEffectsLoopHandle") exitWith {};

	// Kill loop and wait for it to finish last animation
	terminate McD_incapacitatedPPEffectsLoopHandle;
	waitUntil {ppEffectCommitted McD_incapacitatedPPBlur};

	// Fade out all effects
	//McD_incapacitatedPPColor ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299, 0.587, 0.114, 0]];
	McD_incapacitatedPPBlur ppEffectAdjust [0];
    McD_incapacitatedPPVig ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1]];

	//McD_incapacitatedPPColor ppEffectCommit 5;
    McD_incapacitatedPPBlur ppEffectCommit 5;
    McD_incapacitatedPPVig ppEffectCommit 5;

	_texLower ctrlsetfade 1;
	_texMiddle ctrlsetfade 1;
	_texUpper ctrlsetfade 1;

	_texUpper ctrlcommit 5;
	_texMiddle ctrlcommit 5;
	_texLower ctrlcommit 5;

	// Wait for effects to finish, kill them afterwards
	waitUntil {ppEffectCommitted McD_incapacitatedPPBlur};

	//McD_incapacitatedPPColor ppEffectEnable FALSE;
	McD_incapacitatedPPVig ppEffectEnable FALSE;
	McD_incapacitatedPPBlur ppEffectEnable FALSE;
	McD_incapacitatedPPEffectsLoopHandle = nil;

	_texUpper ctrlShow FALSE;
	_texMiddle ctrlShow FALSE;
	_texLower ctrlShow FALSE;
};