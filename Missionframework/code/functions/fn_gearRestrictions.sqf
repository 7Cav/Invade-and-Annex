/*/
File: fn_gearRestrictions.sqf
Author:

	Quiksilver, McDodelijk

Last Modified:

	01/03/2020 by McDodelijk

Description:
	Enforce Gear Restrictions
_____________________________________________________________________/*/

#define XOR(A,B) (!((A) isEqualTo (B)))

params ['_unit'];

private _arsenalType = (missionNamespace getVariable ['QS_missionConfig_Arsenal',0]);

private _isWhitelisted = (_arsenalType isEqualTo 1);

private _arsenalData = ([(player getVariable ['QS_unit_side',WEST]),(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_data_arsenal')) select _isWhitelisted;

private _fnc_getDisplayName = {
	_cfg_type = "";
	switch (true) do
    {
        case(isClass(configFile >> "CfgMagazines" >> _this)): {_cfg_type = "CfgMagazines"};
        case(isClass(configFile >> "CfgWeapons" >> _this)): {_cfg_type = "CfgWeapons"};
        case(isClass(configFile >> "CfgVehicles" >> _this)): {_cfg_type = "CfgVehicles"};
        case(isClass(configFile >> "CfgGlasses" >> _this)): {_cfg_type = "CfgGlasses"};
    };
	getText (configFile >> _cfg_type >> _this >> "displayName");
};

if (_arsenalType in [1,2] && !(_unit getVariable ["McD_GearRestrictionDisabled", FALSE])) then {

	private _uniform = toLower (uniform _unit);
	private _backpack = toLower (backpack _unit);
	private _vest = toLower (vest _unit);
	private _headgear = toLower (headgear _unit);
	private _goggles = toLower (goggles _unit);
	private _hmd = toLower (hmd _unit);
	private _weapons = (weapons _unit) apply {(toLower _x)};
	private _weaponAttachments = (primaryWeaponItems _unit) apply {(toLower _x)};
	private _weaponAttachments2 = (secondaryWeaponItems _unit) apply {(toLower _x)};
	private _weaponAttachments3 = (handgunItems _unit) apply {(toLower _x)};
	private _magazines = (magazines _unit) apply {(toLower _x)};
	private _items = (items _unit) apply {(toLower _x)};
	private _assignedItems = (assignedItems _unit) apply {(toLower _x)};

	private _all = [];
	{
		_all append _x;
	} forEach _arsenalData;
	_all = _all apply {(toLower _x)};

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removeWeapon _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _weapons;

	if ((!(_uniform isEqualTo "")) && {XOR(_uniform in _all, _isWhitelisted)} ) then {
		removeUniform _unit;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_uniform call _fnc_getDisplayName)], "PLAIN"];
	};

	if ((!(_backpack isEqualTo "")) && {XOR(_backpack in _all, _isWhitelisted)} ) then {
		removeBackpack _unit;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_backpack call _fnc_getDisplayName)], "PLAIN"];
	};

	if ((!(_vest isEqualTo "")) && {XOR(_vest in _all, _isWhitelisted)} ) then {
		removeVest _unit;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_vest call _fnc_getDisplayName)], "PLAIN"];
	};

	if ((!(_headgear isEqualTo "")) && {XOR(_headgear in _all, _isWhitelisted)} ) then {
		removeHeadgear _unit;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_headgear call _fnc_getDisplayName)], "PLAIN"];
	};

	if ((!(_goggles isEqualTo "")) && {XOR(_goggles in _all, _isWhitelisted)} ) then {
		removeGoggles _unit;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_goggles call _fnc_getDisplayName)], "PLAIN"];
	};

	if ((!(_hmd isEqualTo "")) && {XOR(_hmd in _all, _isWhitelisted)} ) then {
		_unit unlinkItem _hmd;
		titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_hmd call _fnc_getDisplayName)], "PLAIN"];
	};

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removePrimaryWeaponItem _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _weaponAttachments;

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removeSecondaryWeaponItem _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _weaponAttachments2;

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removeHandgunItem _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _weaponAttachments3;

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removeMagazine _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _magazines;

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit removeItem _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _items;

	{
		if ((!(_x isEqualTo "")) && {XOR(_x in _all, _isWhitelisted)} ) then {
			_unit unlinkItem _x;
			_unit unassignItem _x;
			_unit removeItem _x;
			titleText [format ["%1 is forbidden or not meant for your role. Therefore it got removed from your inventory.", (_x call _fnc_getDisplayName)], "PLAIN"];
		};
	} forEach _assignedItems;
};
