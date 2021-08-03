/*/
File: fn_vToolkitRefuel.sqf
Author:

	McDodelijk

Last modified:

	21/04/2020 by McDodelijk

Description:

	Refuel action and functionality for engineers
__________________________________________________/*/
scriptName "McD_fnc_vToolkitRefuel";

private _mode = param [0, -1, [0]];
if(_mode < 0) exitWith {};

switch (_mode) do {
	// Conditions; Returns bool
	case 0: {
		private _vic = param [1, cursorObject, [objNull]];
		(player getUnitTrait 'engineer' && {
			'ToolKit' in (items player) && {
				alive _vic && {
					player distance2D _vic < 7 && {
						(_vic isKindOf 'Air' || _vic isKindOf 'Ship' || _vic isKindOf 'LandVehicle')
					}
				}
			}
		});
	};
	// Add action; return action id
	case 1: {
		player addAction ["Refuel vehicle (consumes toolkit)",{[3] call McD_fnc_vToolkitRefuel;},nil,-98,FALSE,TRUE,'',"TRUE",-1,FALSE];
	};
	// unused at this time
	case 2: {
	};
	// Execute client
	case 3: {
		0 spawn {
			scriptName "McD_fnc_vToolkitRefuel_Client";
			private _vic = cursorObject;
			if([0, _vic] call McD_fnc_vToolkitRefuel) then {
				player removeItem "ToolKit";
				// Play animation
				private _currentWeapon = currentWeapon player;
				private _stance = stance player;
				private _animation = 'ainvpknlmstpslaywnondnon_medicother';
				if (_stance isEqualTo 'CROUCH' || _stance isEqualTo 'STAND') then {
					if (_currentWeapon isEqualTo '') then {
						_animation = 'ainvpknlmstpslaywnondnon_medicother';
					} else {
						if (_currentWeapon isEqualTo (primaryWeapon player)) then {
							_animation = 'ainvpknlmstpslaywrfldnon_medicother';
						} else {
							if (_currentWeapon isEqualTo (handgunWeapon player)) then {
								_animation = 'ainvpknlmstpslaywpstdnon_medicother';
							} else {
								if (_currentWeapon isEqualTo (secondaryWeapon player)) then {
									_animation = 'ainvpknlmstpslaywlnrdnon_medicother';
								};
							};
						}
					};
				} else {
					if (_stance isEqualTo 'PRONE') then {
						if (_currentWeapon isEqualTo '') then {
							_animation = 'ainvppnemstpslaywnondnon_medicother';
						} else {
							if (_currentWeapon isEqualTo (primaryWeapon player)) then {
								_animation = 'ainvppnemstpslaywrfldnon_medicother';
							} else {
								if (_currentWeapon isEqualTo (handgunWeapon player)) then {
									_animation = 'ainvppnemstpslaywpstdnon_medicother';
								};
							}
						};
					};
				};
				player playMoveNow _animation;
				// wait for animation to start
				waitUntil {
					uiSleep 0.1;
					((animationState player) in [
						'ainvpknlmstpslaywnondnon_medicother','ainvpknlmstpslaywrfldnon_medicother','ainvpknlmstpslaywpstdnon_medicother','ainvpknlmstpslaywlnrdnon_medicother',
						'ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywpstdnon_medicother'
					])
				};
				// wait for animation to cancel or complete
				private _c = false;
				waitUntil {
					uiSleep 0.2;
					_c = ((!alive player) || (!((lifeState player) in ['HEALTHY','INJURED'])) || !(player distance2D _vic < 7) || (!alive _vic));
					(!((animationState player) in [
						'ainvpknlmstpslaywnondnon_medicother','ainvpknlmstpslaywrfldnon_medicother','ainvpknlmstpslaywpstdnon_medicother','ainvpknlmstpslaywlnrdnon_medicother',
						'ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywpstdnon_medicother'
					])) || _c
				};
				if(_c) then {
					systemChat "Aborting refuel";
					player addItem "ToolKit";
				} else {
					[4, _vic] remoteExecCall ["McD_fnc_vToolkitRefuel", _vic, FALSE];
				};
			};
		};
	};
	// Execute refuel
	case 4: {
		private _vic = param [1, objNull, [objNull]];
		if(isNull _vic || !local _vic) exitWith {};
		_vic setFuel (fuel _vic) + 0.05;
	};
	default { };
};