waitUntil { missionNamespace getVariable ["NL_compileFinalDone", FALSE] };

player addAction ["<t color='#ff0000'>Weapon jammed!</t>",{playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];},nil,-99,FALSE,TRUE,'DefaultAction','MD_exclusiveHighCapMags_jammed && ((currentWeapon player) == (primaryWeapon player))',-1,FALSE];

private _lockAction = player addAction ["Set lock state", NL_fnc_setLock, [], 15, TRUE, TRUE, "", "[] call NL_fnc_isLockOk"];
player setUserActionText [_lockAction, "Set lock state", "<t size='3'>Set lock state</t>"];
player setVariable ['QS_canLockVehicle', TRUE, FALSE];
