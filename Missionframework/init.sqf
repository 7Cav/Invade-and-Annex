diag_log '***** Init NL *****';

private ["_id1","_id2","_id3","_id4", "_RewardLaptop", "_Billbaord1", "_Billbaord2", "_Billbaord3", "_MedicalTable", "_a", "_v"];

// All the code in here should be client side only. To lazy to move, exit when server instead.
if (isServer) exitWith {};

// Wait till the player is ready
waitUntil { !isNull player && player == player };
waitUntil { missionNamespace getVariable ["NL_compileFinalDone", FALSE] };


_RewardLaptop = missionNamespace getVariable ['NL_rewardsMenu_laptop',objNull];
_id1 = _RewardLaptop addAction ["Rewards Menu", {[] call NL_fnc_showRewardDlg;}];
_RewardLaptop setUserActionText [_id1, "Rewards Menu", "<t size='3'>Rewards Menu</t>"];

_Billbaord1 = missionNamespace getVariable ['NL_Billboard_01',objNull];
_id2 = _Billbaord1 addAction ["Information", {[0] call KN_fnc_billboardInfo;}];
_Billbaord1 setObjectTextureGlobal [0, "jsoc\billboards\unit.jpg"];
_Billbaord1 setUserActionText [_id2, "Information", "<t size='3'>Information</t>"];

_Billbaord2 = missionNamespace getVariable ['NL_Billboard_02',objNull];
_id3 = _Billbaord2 addAction ["Information", {[1] call KN_fnc_billboardInfo;}];
_Billbaord2 setObjectTextureGlobal [0, "jsoc\billboards\armour.jpg"];
_Billbaord2 setUserActionText [_id3, "Information", "<t size='3'>Information</t>"];

_Billbaord3 = missionNamespace getVariable ['NL_Billboard_03',objNull];
_id4 = _Billbaord3 addAction ["Information", {[2] call KN_fnc_billboardInfo;}];
_Billbaord3 setObjectTextureGlobal [0, "jsoc\billboards\aviation.jpg"];
_Billbaord3 setUserActionText [_id4, "Information", "<t size='3'>Information</t>"];

_Billbaord4 = missionNamespace getVariable ['NL_Billboard_04',objNull];
_Billbaord4 setObjectTextureGlobal [0, "jsoc\billboards\getting_started.jpg"];

_Billbaord5 = missionNamespace getVariable ['NL_Billboard_05',objNull];
_Billbaord5 setObjectTextureGlobal [0, "jsoc\billboards\assignment.jpg"];

_MedicalTable = missionNamespace getVariable ['NL_MedicalTable',objNull];
_id5 = _MedicalTable addAction ["Treat yourself", {
  player playMove "AinvPknlMstpSlayWrflDnon_medic";
  uisleep 5;
  player setdamage 0;
  0 spawn {
    _a = selectRandom ["MedicalGarbage_01_1x1_v1_F", "MedicalGarbage_01_1x1_v3_F", "MedicalGarbage_01_1x1_v2_F"];
    _v = createVehicle [_a,[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'NONE'];
    _v setdir (floor random 360);
    _v setpos (getPos Player);
    uisleep 60;
    deletevehicle _V;
  };
  },nil, 1.5, true, true, "", "true", 12];
_MedicalTable setUserActionText [_id5, "Treat yourself", "<t size='3'>Treat yourself</t>"];

diag_log '***** Init NL complete *****';
