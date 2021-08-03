disableSerialization;
params["_mode","_params","_entity"];
private _filterIDCs = [
	24068,
	24069,
	24070,
	24071,
	24072,
	24073,
	24074,
	24075,
	24076,
	24077,
	24078,
	24079,
	24080
];

private _McD_fnc_getItemMass = {
	params ["_class"];
	switch true do {
		case (isclass (configfile >> "cfgweapons" >> _class)): {
			getnumber (configfile >> "cfgweapons" >> _class >> "WeaponSlotsInfo" >> "mass") +
			getnumber (configfile >> "cfgweapons" >> _class >> "ItemInfo" >> "mass");
		};
		case (isclass (configfile >> "cfgmagazines" >> _class)): {
			getnumber (configfile >> "cfgmagazines" >> _class >> "mass");
		};
		case (isclass (configfile >> "cfgvehicles" >> _class)): {
			getnumber (configfile >> "cfgvehicles" >> _class >> "mass");
		};
		default {0};
	};
};

_entity = missionNamespace getVariable ['BIS_fnc_initCuratorAttributes_target', objNull];
switch _mode do {
	case "preLoad": {
		_weaponAddons = [];
		_types = [
			["AssaultRifle","Shotgun","Rifle","SubmachineGun"],
			["MachineGun"],
			["SniperRifle"],
			["Launcher","MissileLauncher","RocketLauncher"],
			["Handgun"],
			["UnknownWeapon"],
			["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"],
			["Uniform"],
			["Vest"],
			["Backpack"],
			["Headgear","Glasses"],
			["Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal"]
		];
		_typeMagazine = _types find "Magazine";
		_list = [[],[],[],[],[],[],[],[],[],[],[],[]];
		_magazines = []; 
		{
			_addon = tolower _x;
			_addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
			_addonID = _weaponAddons find _addon;
			if (_addonID < 0) then {
				{
					_weapon = tolower _x;
					_weaponType = (_weapon call bis_fnc_itemType);
					_weaponTypeCategory = _weaponType select 0;
					_weaponTypeSpecific = _weaponType select 1;
					_weaponTypeID = -1;
					{
						if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;

					if (_weaponTypeCategory != "VehicleWeapon" && _weaponTypeID >= 0) then {
						_weaponCfg = configfile >> "cfgweapons" >> _weapon;
						_weaponPublic = getnumber (_weaponCfg >> "scope") == 2;
						_addonListType = _addonList select _weaponTypeID;
						if (_weaponPublic) then {
							_displayName = gettext (_weaponCfg >> "displayName");
							_picture = gettext (_weaponCfg >> "picture");
							{
								_item = gettext (_x >> "item");
								_itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
								_displayName = _displayName + " + " + _itemName;
							} foreach ((_weaponCfg >> "linkeditems") call bis_fnc_returnchildren);
							_displayNameShort = _displayName;
							_displayNameShortArray = toarray _displayNameShort;
							if (count _displayNameShortArray > 41) then { 
								_displayNameShortArray resize 41;
								_displayNameShort = tostring _displayNameShortArray + "...";
							};
							_type = if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) then {1} else {0};
							_addonListType pushback [_displayName,_displayNameShort,_weapon,_picture,_type,false];
						};

						if (_weaponPublic || _weapon in ["throw","put"]) then {
							{
								_muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
								_magazinesList = getarray (_muzzle >> "magazines");
								{
									{
										_magazinesList append (getArray _x);
									} foreach configproperties [configFile >> "CfgMagazineWells" >> _x,"isArray _x"];
								} foreach getArray (_muzzle >> "magazineWell");
								{
									_mag = tolower _x;
									if ({(_x select 2) == _mag} count _addonListType == 0) then {
										_magCfg = configfile >> "cfgmagazines" >> _mag;
										if (getnumber (_magCfg >> "scope") == 2) then {
											_displayName = gettext (_magCfg >> "displayName");
											_picture = gettext (_magCfg >> "picture");
											_addonListType pushback [_displayName,_displayName,_mag,_picture,2,_mag in _magazines];
											_magazines pushBackUnique _mag;
										};
									};
								} foreach _magazinesList;
							} foreach getarray (_weaponCfg >> "muzzles");
						};
					};
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
				{
					_weapon = tolower _x;
					_weaponType = _weapon call bis_fnc_itemType;
					_weaponTypeSpecific = _weaponType select 1;
					_weaponTypeID = -1;
					{
						if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;

					if (_weaponTypeID >= 0) then {
						_weaponCfg = configfile >> "cfgvehicles" >> _weapon;
						if (getnumber (_weaponCfg >> "scope") == 2) then {
							_displayName = gettext (_weaponCfg >> "displayName");
							_picture = gettext (_weaponCfg >> "picture");
							_addonListType = _addonList select _weaponTypeID;
							_addonListType pushback [_displayName,_displayName,_weapon,_picture,3,false];
						};
					};
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
				_weaponAddons set [count _weaponAddons,_addon];
				_weaponAddons set [count _weaponAddons,_addonList];
			} else {
				_addonList = _weaponAddons select (_addonID + 1);
			};
			{
				_current = _list select _foreachindex;
				_list set [_foreachindex,_current + (_x - _current)];
			} foreach _addonList;
		} foreach activatedAddons;

		{_x sort true;} foreach _list;

		missionNamespace setvariable ['McD_RscAttributeInventory_list', _list];
	};
	case "onLoad": {
		_cargo = [
			getweaponcargo _entity,
			getmagazinecargo _entity,
			getitemcargo _entity,
			getbackpackcargo _entity
		];
		/*
		_virtualCargo = [
			_entity call bis_fnc_getVirtualWeaponCargo,
			_entity call bis_fnc_getVirtualMagazineCargo,
			_entity call bis_fnc_getVirtualItemCargo,
			_entity call bis_fnc_getVirtualBackpackCargo
		];
		{
			_xCargo = _cargo select _foreachindex;
			{
				_index = (_xCargo select 0) find _x;
				if (_index < 0) then {
					(_xCargo select 0) set [count (_xCargo select 0),_x];
					(_xCargo select 1) set [count (_xCargo select 1),-1];
				} else {
					(_xCargo select 1) set [_index,-1];
				};
			} foreach _x;
		} foreach _virtualCargo;
		*/
		private _RscAttributeInventory_cargo = [[],[]];
		{
			_RscAttributeInventory_cargo set [0,(_RscAttributeInventory_cargo select 0) + (_x select 0)];
			_RscAttributeInventory_cargo set [1,(_RscAttributeInventory_cargo select 1) + (_x select 1)];
		} foreach _cargo;
		_classes = _RscAttributeInventory_cargo select 0;
		{_classes set [_foreachindex,tolower _x];} foreach _classes;
		uiNamespace setVariable ['RscAttributeInventory_cargo', _RscAttributeInventory_cargo];

		_display = _params select 0;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlRemoveAllEventHandlers "buttonclick";
			_ctrl ctrladdeventhandler [
			"buttonclick",
			format ["with uinamespace do {['filterChanged',[ctrlparent (_this select 0),%1],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};",_foreachindex]
			];
		} foreach _filterIDCs;
		uiNamespace setVariable ['RscAttributeInventory_selected', 0];
		["filterChanged",[_display],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');

		_ctrlList = _display displayctrl 			24368;
		_ctrlList ctrlRemoveAllEventHandlers "lbselchanged";
		_ctrlList ctrlRemoveAllEventHandlers "lbdblclick";
		_ctrlList ctrladdeventhandler ["lbselchanged",{with uinamespace do {["listSelect",[ctrlparent (_this select 0)],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];
		_ctrlList ctrladdeventhandler ["lbdblclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),+1],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];

		_ctrlArrowLeft = _display displayctrl 		24468;
		_ctrlArrowLeft ctrlsetstructuredtext parsetext "-";
		_ctrlArrowLeft ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),-1],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];
		_ctrlArrowRight = _display displayctrl 		24469;
		_ctrlArrowRight ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlArrowRight ctrladdeventhandler ["buttonclick",{with uinamespace do {['listModify',[ctrlparent (_this select 0),+1],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];

		_ctrlButtonCustom = _display displayctrl 	30004;
		_ctrlButtonCustom ctrlsettext localize "str_disp_arcmap_clear";
		_ctrlButtonCustom ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonCustom ctrladdeventhandler ["buttonclick",{with uinamespace do {["clear",[ctrlparent (_this select 0)],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];

		_ctrlButtonOk = _display displayctrl 1;
		_ctrlButtonOk ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonOk ctrladdeventhandler ["buttonclick",{with uinamespace do {["confirmed",[ctrlparent (_this select 0)],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');};}];

		_display displayAddEventHandler ["keyDown", {
			params ["_display", "_key", "_shift", "_ctrl", "_alt"];
			if(_shift) then {
				(_display displayctrl 24468) ctrlSetText "--";
				(_display displayctrl 24469) ctrlSetText "++";
				missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_shift', TRUE];
			} else {
				(_display displayctrl 24468) ctrlSetText "-";
				(_display displayctrl 24469) ctrlSetText "+";
				missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_shift', FALSE];
			};
		}];
		_display displayAddEventHandler ["keyUp", {
			params ["_display", "_key", "_shift", "_ctrl", "_alt"];
			if(_key == 42 || !_shift) then {
				(_display displayctrl 24468) ctrlSetText "-";
				(_display displayctrl 24469) ctrlSetText "+";
				missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_shift', FALSE];
			};
		}];

		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,15,-1,"Hold LShift and click to add or subtract in stacks of 10",[],-1,TRUE,'PRO TIP',TRUE];

		private _maxLoad = getNumber(configfile >> "cfgvehicles" >> typeof _entity >> "MaximumLoad");
		// Quickfix for Falcon(inv = 1000) and maybe others:
		if(_maxLoad == 0) then {
			_maxLoad = 1000;
		};
		private _load = 0;
		{
			private _count = (((uiNamespace getVariable 'RscAttributeInventory_cargo') # 1) # _foreachindex);
			if(_count > 0) then {
				private _mass = _x call _McD_fnc_getItemMass;
				_load = _load + _mass * _count;
			};
		} foreach ((uiNamespace getVariable 'RscAttributeInventory_cargo') # 0);
		missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_Load', _load];
		missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_MaxLoad', _maxLoad];

		_ctrlLoad = _display displayctrl 23868;
		_ctrlLoad progresssetposition (_load/_maxLoad);
	};
	case "filterChanged": {
		_display = _params select 0;

		_cursel = if (count _params > 1) then {_params select 1} else {uiNamespace getVariable ['RscAttributeInventory_selected', 0]};
		uiNamespace setVariable ['RscAttributeInventory_selected', _cursel];
		_ctrlList = _display displayctrl 24368;
		//_ctrlLoad = _display displayctrl 23868;
		_ctrlFilterBackground = _display displayctrl 23870;
		_list = missionNamespace getvariable ["McD_RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		_items = [];

		if (_cursel > 0) then {
			_items = _list select (_cursel - 1);
		} else {
			{_items = _items + _x;} foreach _list;
			_items sort true;
		};

		lnbclear _ctrlList;
		{
			_types = _x;
			{
				_x params ["_displayName","_displayNameShort","_class","_picture","_type","_isDuplicate"];

				if (_type in _types && (!_isDuplicate && _cursel >= 0)) then {
					_classes = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 0;
					_values = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 1;
					_index = _classes find _class;
					_value = if (_index < 0) then {
						_index = count _classes;
						_classes set [_index,_class];
						_values set [_index,0];
						uiNamespace setVariable ['RscAttributeInventory_cargo', [_classes, _values]];
						0
					} else {
						_values select _index
					};

					if ((_cursel == 0 && _value != 0) || (_cursel > 0)) then {
						_lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,if (_value < 0) then {""} else {str _value},""];
						_ctrlList lnbsetdata [[_lnbAdd,0],_class];
						_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
						_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
						_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
						_ctrlList lnbsetpicture [[_lnbAdd,3],if (_value < 0) then {	"\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\infinity_ca.paa"} else {	"#(argb,1,1,1)color(0,0,0,0)"}];
						_alpha = if (_value != 0) then {1} else {0.5};
						_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
						_ctrlList lnbsetcolor [[_lnbAdd,2],[1,1,1,_alpha]];
						//_ctrlList lbsettooltip [_lnbAdd,_displayName];
						_ctrlList lnbSetTooltip [[_lnbAdd, 0], _displayName];

					};
				};
			} foreach _items;
		} foreach [[0,1,3],[2]];
		_ctrlList lnbsetcurselrow 0;
		["listSelect",[_display],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');

		//_delay = if (isnil "_curator") then {0.1} else {0};
		_delay = 0;
		{
			_ctrl = _display displayctrl _x;
			_color = [1,1,1,0.5];
			_scale = 0.75;
			if (_foreachindex == _cursel) then {
			_color = [1,1,1,1];
			_scale = 1;
			};
			_ctrl ctrlsettextcolor _color;
			_pos = [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;

			if (_foreachindex == _cursel) then {
			_ctrlFilterBackground ctrlsetposition _pos;
			_ctrlFilterBackground ctrlcommit 0;
			};
		} foreach _filterIDCs;
	};
	case "listModify": {
		_display = _params select 0;
		_add = _params select 1;
		_multi = if(missionNamespace getvariable ['McD_fnc_RscDisplayAttributesInventory_shift', false]) then {10} else {1};
		_ctrlList = _display displayctrl 24368;
		_ctrlLoad = _display displayctrl 23868;
		_cursel = lnbcurselrow _ctrlList;
		_class = _ctrlList lnbdata [_cursel,0];
		_value = _ctrlList lbvalue (_cursel * 4); 
		_type = _ctrlList lbvalue (_cursel * 4 + 1); 

		_classes = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 0;
		_values = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 1;
		_index = _classes find _class;
		if (_index >= 0) then {

			private _weightChange = _add * (_class call _McD_fnc_getItemMass);
			for "_i" from 1 to _multi do {
				_value = _value + _add;

				_load = (missionNamespace getvariable ["McD_fnc_RscDisplayAttributesInventory_Load", 0]) + _weightChange;

				if ((_load <= (missionNamespace getvariable ["McD_fnc_RscDisplayAttributesInventory_MaxLoad", 0]) && _value >= 0) || _value == 0) then {

					_ctrlLoad progresssetposition (_load / (missionNamespace getvariable ["McD_fnc_RscDisplayAttributesInventory_MaxLoad", 0]));
					missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_Load', _load];					
					_values set [_index,_value];
					uiNamespace setVariable ['RscAttributeInventory_cargo', [_classes, _values]];
					_ctrlList lnbsetvalue [[_cursel,0],_value];
					_ctrlList lnbsettext [[_cursel,2],if (_value < 0) then {""} else {str _value}];
					_ctrlList lnbsetpicture [[_cursel,3],if (_value < 0) then {	"\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\infinity_ca.paa"} else {	"#(argb,1,1,1)color(0,0,0,0)"}];
					_alpha = if (_value != 0) then {1} else {0.5};
					_ctrlList lnbsetcolor [[_cursel,1],[1,1,1,_alpha]];
					_ctrlList lnbsetcolor [[_cursel,2],[1,1,1,_alpha]];
					["listSelect",[_display],objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');
				};
			};
		};
	};
	case "listSelect": {
		private ["_display","_ctrlList","_cursel","_value","_ctrlArrowLeft","_buttonText"];
		_display = _params select 0;
		_ctrlList = _display displayctrl 24368;
		_cursel = lnbcurselrow _ctrlList;
		_value = _ctrlList lbvalue (_cursel * 4); 

		_ctrlArrowLeft = _display displayctrl 24468;
		//_buttonText = if (_value <= 0) then {format ["<img image='%1' size='0.7' />",	"\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\infinity_ca.paa"]} else {"-"};
		//_ctrlArrowLeft ctrlsetstructuredtext parsetext _buttonText;
		//_ctrlArrowLeft ctrlenable (_value > -1);
		_ctrlArrowLeft ctrlenable (_value > 0);
	};
	case "clear": {
		private _cargo = (uiNamespace getVariable 'RscAttributeInventory_cargo');
		_values = _cargo select 1;
		{
			_values set [_foreachindex,0];
		} foreach _values;
		_cargo set [1, _values];
		uiNamespace setVariable ['RscAttributeInventory_cargo', _cargo];
		["filterChanged",_params,objnull] call (missionNamespace getvariable 'McD_fnc_RscDisplayAttributesInventory');

		_display = _params select 0;
		_ctrlLoad = _display displayctrl 23868;
		_ctrlLoad progresssetposition 0;
		missionNamespace setvariable ['McD_fnc_RscDisplayAttributesInventory_Load', 0];
	};
	case "confirmed": {
		_display = _params select 0;

		clearweaponcargoglobal _entity;
		clearmagazinecargoglobal _entity;
		clearbackpackcargoglobal _entity;
		clearitemcargoglobal _entity;

		_entity call bis_fnc_removeVirtualItemCargo;
		_entity call bis_fnc_removeVirtualWeaponCargo;
		_entity call bis_fnc_removeVirtualMagazineCargo;
		_entity call bis_fnc_removeVirtualBackpackCargo;

		_classes = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 0;
		_values = (uiNamespace getVariable 'RscAttributeInventory_cargo') select 1;
		_items = [];
		_weapons = [];
		_magazines = [];
		_backpacks = [];
		{
			if (_x != 0) then {
				_class = _classes select _foreachindex;
				switch true do {
					case (getnumber (configfile >> "cfgweapons" >> _class >> "type") in [4096,131072]): {
						if (_x < 0) then {
							_items set [count _items,_class];
						} else {
							_entity additemcargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgweapons" >> _class)): {
						if (_x < 0) then {
							_weapons set [count _weapons,_class];
						} else {
							_entity addweaponcargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgmagazines" >> _class)): {
						if (_x < 0) then {
							_magazines set [count _magazines,_class];
						} else {
							_entity addmagazinecargoglobal [_class,abs _x];
						};
					};
					case (isclass (configfile >> "cfgvehicles" >> _class)): {
						if (_x < 0) then {
							_backpacks set [count _backpacks,_class];
						} else {
							_entity addbackpackcargoglobal [_class,abs _x];
						};
					};
				};
			};
		} foreach _values;
		/* Do not allow Arsenal to be created
		[_entity,_items,true] call bis_fnc_addVirtualItemCargo;
		[_entity,_weapons,true] call bis_fnc_addVirtualWeaponCargo;
		[_entity,_magazines,true] call bis_fnc_addVirtualMagazineCargo;
		[_entity,_backpacks,true] call bis_fnc_addVirtualBackpackCargo;
		*/
	};
	case "onUnload": {
		with uiNamespace do {
			RscAttributeInventory_cargo = nil;
			RscAttributeInventory_selected = nil;
		};
	};
};