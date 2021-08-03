/*/
File: fn_clientArsenal.sqf
Author:

	Quiksilver, McDodelijk

Last Modified:

	02/03/2020 by McDodelijk

Description:

	Setup Client Arsenal
	Call again when switching role!
____________________________________________________/*/

private _isBlacklisted = (missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 2;

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 0) exitWith {
	missionNamespace setVariable ['bis_addVirtualWeaponCargo_cargo',[["%ALL"],["%ALL"],["%ALL"],["%ALL"]],FALSE];
};

if ((_isBlacklisted)) then {
	// If using blacklist, we first have to add everything, so we can remove the blacklisted items.
	["Preload"] call BIS_fnc_arsenal;
	private _arsenalAll = missionnamespace getVariable "bis_fnc_arsenal_data";
	// 0 = weapon
	// 1 = launchers
	// 2 = handguns
	// 3 = uniform
	// 4 = vest
	// 5 = backpack
	// 6 = helmets
	// 7 = glasses
	// 8 = nvgs
	// 9 = binocular
	// 10 = map
	// 11 = terminals
	// 12 = radio
	// 13 = compass
	// 14 = watch
	// 22 = grenades
	// 23 = explosives
	// 24 = tools
	// 26 = magazines

	private _cfgItems = [];
	private _cfgWeapons = [];
	private _cfgMagazines = [];
	private _cfgBackpacks = [];

	_cfgItems append (_arsenalAll # 3);
	_cfgItems append (_arsenalAll # 4);
	_cfgItems append (_arsenalAll # 6);
	_cfgItems append (_arsenalAll # 7);
	_cfgItems append (_arsenalAll # 8);
	_cfgItems append (_arsenalAll # 10);
	_cfgItems append (_arsenalAll # 11);
	_cfgItems append (_arsenalAll # 12);
	_cfgItems append (_arsenalAll # 13);
	_cfgItems append (_arsenalAll # 14);
	_cfgItems append (_arsenalAll # 24);
	_cfgWeapons append (_arsenalAll # 0);
	_cfgWeapons append (_arsenalAll # 1);
	_cfgWeapons append (_arsenalAll # 2);
	_cfgWeapons append (_arsenalAll # 9);
	_cfgMagazines append (_arsenalAll # 22);
	_cfgMagazines append (_arsenalAll # 23);
	//_cfgMagazines append (_arsenalAll # 26);
	_cfgBackpacks append (_arsenalAll # 5);

	// Get compatible mags only. Bohemia...
	{
		{_cfgMagazines pushBackUnique _x} foreach ([_x, false] call bis_fnc_compatibleMagazines);
	} foreach _cfgWeapons;


	// Get weapon attachments
	{
		private _compatibleItems = _x call bis_fnc_compatibleItems;
		{
			private _item = _x;
			private _itemCfg = configfile >> "cfgweapons" >> _item;
			private _scope = if (isnumber (_itemCfg >> "scopeArsenal")) then {getnumber (_itemCfg >> "scopeArsenal")} else {getnumber (_itemCfg >> "scope")};
			if (_scope == 2) then {
				_cfgItems pushBackUnique _item;
			};
		} foreach _compatibleItems;
	} foreach _cfgWeapons;

	missionNamespace setVariable ['bis_addVirtualWeaponCargo_cargo',[_cfgItems,_cfgWeapons,_cfgMagazines,_cfgBackpacks],FALSE];
} else {
	missionNamespace setVariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]],FALSE];
};

private _data = [(player getVariable ['QS_unit_side',WEST]),(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_data_arsenal');
(_data select ([1,0] select _isBlacklisted)) params ['_items','_magazines','_backpacks','_weapons'];

{
	if (!((_x select 1) isEqualTo [])) then {
		[missionNamespace,(_x select 1),FALSE,FALSE] call (missionNamespace getVariable (_x select 0));
	};
} forEach [
	[(format ['BIS_fnc_%1VirtualItemCargo',(['add','remove'] select _isBlacklisted)]), _items],
	[(format ['BIS_fnc_%1VirtualMagazineCargo',(['add','remove'] select _isBlacklisted)]), _magazines],
	[(format ['BIS_fnc_%1VirtualBackpackCargo',(['add','remove'] select _isBlacklisted)]), _backpacks],
	[(format ['BIS_fnc_%1VirtualWeaponCargo',(['add','remove'] select _isBlacklisted)]), _weapons]
];