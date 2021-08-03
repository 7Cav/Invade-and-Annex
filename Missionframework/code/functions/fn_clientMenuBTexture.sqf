/*
File: fn_clientMenuBTexture.sqf
Author:

	Quiksilver

Last Modified:

	03/05/2020 A3 1.98 by Knight

Description:

	Cliet Menu Backpack Textures
__________________________________________________________*/

disableSerialization;

params ['_type','_display'];
private [
	'_supporterLevel','_list','_supporterAccess','_displayName','_texture','_index','_toolTip','_validUniforms_1','_validUniforms','_validUniform_2',
	'_validUniform_3','_validUniform_4','_author','_patch'
];

_supporterLevel = [] call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel');
_list = [] call (missionNamespace getVariable 'QS_BTextures');
if (_type isEqualTo 'onLoad') then {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);

	{
		_supporterAccess = _x select 0;
		_displayName = _x select 1;
		_texture = _x select 2;
		_toolTip = _x select 3;
		lbAdd [1804, _displayName];
		lbSetPicture [1804, _forEachIndex, _texture];
		lbSetTooltip [1804, _forEachIndex, _toolTip];
		if (_supporterAccess > _supporterLevel) then {
			lbSetColor [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
			lbSetPictureColor [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
			lbSetPictureColorSelected [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
		};
	} forEach _list;
	lbSetCurSel [1804,0];
};

private _text = '';
if (_type isEqualTo 'Select') then {
	_index = lbCurSel 1804;
	if (!(_index isEqualTo -1)) then {
		_supporterAccess = (_list select _index) select 0;
		_displayName = (_list select _index) select 1;
		_texture = (_list select _index) select 2;
		_tooltip = (_list select _index) select 3;
		_validBackpacks = (_list select _index) select 4;
		_author = (_list select _index) select 5;

		if (_supporterAccess <= _supporterLevel) then {
			if ((backpack player) in _validBackpacks) then {
				if ((player distance (markerPos 'QS_marker_base_marker')) < 500) then {
					unitBackpack player setObjectTextureGlobal [0, _texture];
					player setVariable ['QS_ClientBTexture2', _texture, FALSE];
					player setVariable ['QS_ClientBTexture2_Backpacks2', _validBackpacks, FALSE];
					profileNamespace setVariable ['QS_ClientBTexture2', _texture];
					profileNamespace setVariable ['QS_ClientBTexture2_Backpacks2', _validBackpacks];
					saveProfileNamespace;
					_text = parseText format ['Backpack Texture Set: %1<br/>by %2', _displayName, _author];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5, FALSE, 5, -1, _text, [], -1];
				} else {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5, FALSE, 5, -1, 'You must be at base to re-skin your backpack!', [], -1];
				};

			} else {
				if (_index isEqualTo 0) then {
					player addBackpack (backpack player);
					player setVariable ['QS_ClientBTexture2','',FALSE];
					player setVariable ['QS_ClientBTexture2_Backpacks2',[],FALSE];
					profileNamespace setVariable ['QS_ClientBTexture2',''];
					profileNamespace setVariable ['QS_ClientBTexture2_Backpacks2',[]];
					saveProfileNamespace;
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5, FALSE, 5, -1, 'Backpack Texture Reset', [], -1];
				} else {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5, FALSE, 8, -1, 'Unsupported backpack for selected skin. Please select correct backpack type.', [], -1];
				};
			};

		} else {
			_text = parseText format ['Supporter level required: %1<br/>Your supporter level: %2<br/>Backpack Texture not set.', _supporterAccess, _supporterLevel];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5, FALSE, 10, -1, _text, [], -1];
		};
	};
};

if (_type isEqualTo 'Back') then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_supporters';
	};
};

if (_type isEqualTo 'onUnload') then {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};