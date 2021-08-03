/*/
File: fn_clientInteractCustomizeInventory.sqf
Author:

	Quiksilver

Last Modified:

	2020 A3 1.70 by McDodelijk

Description:

	-
_____________________________________________________________/*/

_cursorObject = cursorObject;
if (isNull _cursorObject) exitWith {};
if ((player distance _cursorObject) > 10) exitWith {};
if (!alive _cursorObject) exitWith {};
if ((typeOf _cursorObject) in ['FlexibleTank_01_sand_F','FlexibleTank_01_forest_F']) exitWith {};
missionNamespace setVariable ['BIS_fnc_initCuratorAttributes_target',_cursorObject,FALSE];
//if (!isNull (getAssignedCuratorLogic player)) exitWith {};
// Prepare open menu empty
if (missionNamespace getVariable ['McD_emptyAddonInventoryList', 0] isEqualType 0) then {
	private _emptyList = [];
	{
		_emptyList pushBack _x;
		_emptyList pushBack [[],[],[],[],[],[],[],[],[],[],[],[]];
	} foreach activatedAddons;
	missionNamespace setVariable ['McD_emptyAddonInventoryList', _emptyList, FALSE];
};

0 spawn {
	if !((missionNamespace getvariable ['McD_RscAttributeInventory_list', 0]) isEqualType []) exitWith {
		if !(missionNamespace getVariable ['McD_loadingInventoryMenu', FALSE]) then {
			missionNamespace setVariable ['McD_loadingInventoryMenu', TRUE, FALSE];
			50 cutText ['Initializing menu. You will be notified when it is ready to be opened.','PLAIN',1];
			["preLoad"] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');
			waitUntil {((missionNamespace getvariable ['McD_RscAttributeInventory_list', 0]) isEqualType [])};
			50 cutText ['Initializing edit inventory is completed. You can now use this functionality.','PLAIN',1];
			missionNamespace setVariable ['McD_loadingInventoryMenu', FALSE, FALSE];
		} else {
			50 cutText ['Initializing menu still in progress. Please be patient.','PLAIN',1];
		};
	};

	50 cutText ['Please wait ...','PLAIN',1];

	if (!(userInputDisabled)) then {
		disableUserInput TRUE;
	};

	// Make sure menu opens empty
	missionnamespace setvariable ['RscAttrbuteInventory_weaponAddons_backup', missionNamespace getVariable 'RscAttrbuteInventory_weaponAddons'];
	missionnamespace setvariable ['RscAttrbuteInventory_weaponAddons', missionNamespace getVariable 'McD_emptyAddonInventoryList'];

	createDialog 'RscDisplayAttributesInventory';

	waitUntil {
		_display = findDisplay -1;
		(!isNil {uiNamespace getVariable 'RscAttributeInventory_list'}) &&
		if (isNull _display) then {
			FALSE
		} else {
			_ctrlButtonCustom = _display displayctrl 30004;
			!((ctrlText _ctrlButtonCustom) isEqualTo "")
		}
	};

	// Restore for zeus menu
	missionnamespace setvariable ['RscAttrbuteInventory_weaponAddons', missionNamespace getVariable 'RscAttrbuteInventory_weaponAddons_backup'];
	["onLoad", [(findDisplay -1)], objNull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');

	if (userInputDisabled) then {
		disableUserInput FALSE;
	};

	50 cutText ['Initialization complete, select tab above','PLAIN',1];
	titleFadeOut 3;

};
