
waitUntil {local player && {getClientStateNumber > 8}};
waitUntil { missionNamespace getVariable ["NL_compileFinalDone", FALSE] };
sleep 2;

//[] spawn NL_fnc_playerRestrict;

// Check connection by making sure all remote scripts have been transmitted
0 spawn (missionNamespace getVariable 'McD_fnc_remoteFncCheck');

// Play the intro
if (isNil 'KN_fnc_playerIntro') then { waitUntil {(!isNil 'KN_fnc_playerIntro')}; };
_intro = [] spawn KN_fnc_playerIntro;
waitUntil { (scriptDone _intro) };

[] spawn NL_fnc_clientCore;

//Weapon Jam for big magzines by McDo
// Define the "bad" magazines
_mxMags = ["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_khaki_mag","100Rnd_65x39_caseless_black_mag","100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_khaki_mag_tracer","100Rnd_65x39_caseless_black_mag_tracer"];
_sparMags = ["150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_556x45_Drum_Sand_Mag_F","150Rnd_556x45_Drum_Sand_Mag_Tracer_F","150Rnd_556x45_Drum_Green_Mag_F","150Rnd_556x45_Drum_Green_Mag_Tracer_F"];
_carMags = ["100Rnd_580x42_Mag_F","100Rnd_580x42_Mag_Tracer_F","100Rnd_580x42_hex_Mag_F","100Rnd_580x42_hex_Mag_Tracer_F","100Rnd_580x42_ghex_Mag_F","100Rnd_580x42_ghex_Mag_Tracer_F"];
_akMags = ["75rnd_762x39_AK12_Arid_Mag_Tracer_F","75rnd_762x39_AK12_Arid_Mag_F","75rnd_762x39_AK12_Lush_Mag_Tracer_F","75rnd_762x39_AK12_Lush_Mag_F","75rnd_762x39_AK12_Mag_Tracer_F","75rnd_762x39_AK12_Mag_F","75Rnd_762x39_Mag_Tracer_F","75Rnd_762x39_Mag_F"];
MD_exclusiveHighCapMags_greyMags = _mxMags + _sparMags + _carMags + _akMags;
 
// Define the "good" guns
_mxAutoRifle = ["arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F"];
_sparAutoRifle = ["arifle_SPAR_02_base_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F"];
_carAutoRifle = ["arifle_CTARS_base_F","arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F"];
_akAutoRifle = ["arifle_RPK12_base_F","arifle_RPK12_F","arifle_RPK12_lush_F","arifle_RPK12_arid_F"];
MD_exclusiveHighCapMags_whiteRifles = _mxAutoRifle + _sparAutoRifle + _carAutoRifle + _akAutoRifle;
 
// Chance and global indicator
MD_exclusiveHighCapMags_jamChance = 0.22;
MD_exclusiveHighCapMags_jammed = false;

_clientOwner = clientOwner;
player setVariable ['NL_data_clientOwner',_clientOwner,TRUE];
player setVariable ['NL_module_fob_client_respawnAllowed',TRUE,TRUE];
player setVariable ['QS_module_fob_client_respawnEnabled',FALSE,TRUE];

player addEventHandler ['FiredNear',{_this call (missionNamespace getVariable 'NL_fnc_clientEventHandlerFiredNear')}];

//Cycle main AO for all admins
_uid = getPlayerUID player;
_admins = ['ADMIN'] call (missionNamespace getVariable 'QS_fnc_whitelist'); //PR
if (_uid in _admins) then {
	if (!isNil {missionNamespace getVariable 'QS_airdefense_laptop'}) then {
		if (!isNull (missionNamespace getVariable 'QS_airdefense_laptop')) then {
			_laptop = missionNamespace getVariable 'QS_airdefense_laptop';
			_actionID3 = _laptop addAction [
				'Cycle primary mission',
				{
					params ['_actionTarget','','_actionID',''];
					private ['_result'];
					if (!((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'NONE')) then {
						if (!(missionNamespace getVariable ['QS_customAO_GT_active',FALSE])) then {
							if (diag_tickTime < (player getVariable ['QS_client_aoCycleCooldown',-1])) exitWith {
								50 cutText [(format ['Too soon, please wait %1s',(round((player getVariable ['QS_client_aoCycleCooldown',-1]) - diag_tickTime))]),'PLAIN',0.5];
							};
							player setVariable ['QS_client_aoCycleCooldown',(diag_tickTime + 60),FALSE];
							if (!(missionNamespace getVariable ['QS_aoSuspended',FALSE])) then {
								_result = ['Cycle primary mission','Primary missions','Cycle','Cancel',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
								if (_result) then {
									missionNamespace setVariable ['QS_aoCycleVar',TRUE,TRUE];
									['systemChat',(format ['%1 (staff) cycled primary missions',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									50 cutText ['Primary mission cycling ...','PLAIN DOWN',0.5];
								} else {
									50 cutText ['Cancelled cycle attempt','PLAIN DOWN',0.5];
								};
							} else {
								50 cutText ['Primary missions are suspended, cycle attempt failed','PLAIN DOWN',0.5];
							};
						} else {
							50 cutText ['Cannot suspend this mission','PLAIN DOWN',0.5];
						};
					} else {
						50 cutText ['Primary missions disabled in server config, cycle attempt failed','PLAIN DOWN',0.5];
					};
				},
				[],
				50,
				TRUE,
				TRUE,
				'',
				'',
				4,
				FALSE
			];
			_laptop setUserActionText [_actionID3,((_laptop actionParams _actionID3) select 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID3) select 0)])];
			_actionID4 = _laptop addAction [
				'Change region for primary mission',
				{
					params ['_actionTarget','','_actionID',''];
					private ['_result'];
					if (!((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'NONE')) then {
						if (!(missionNamespace getVariable ['QS_customAO_GT_active',FALSE])) then {
							if (diag_tickTime < (player getVariable ['QS_client_aoCycleCooldown2',-1])) exitWith {
								50 cutText [(format ['Too soon, please wait %1s',(round((player getVariable ['QS_client_aoCycleCooldown2',-1]) - diag_tickTime))]),'PLAIN',0.5];
							};
							player setVariable ['QS_client_aoCycleCooldown2',(diag_tickTime + 60),FALSE];
							if (!(missionNamespace getVariable ['QS_aoSuspended',FALSE])) then {
								_result = ['Change region for primary mission','Primary missions','Change','Cancel',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
								if (_result) then {
									missionNamespace setVariable ['McD_cycleAoRegion',TRUE,TRUE];
									['systemChat',(format ['%1 (staff) cycled region for primary missions',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									50 cutText ['Primary mission cycling ...','PLAIN DOWN',0.5];
								} else {
									50 cutText ['Cancelled cycle attempt','PLAIN DOWN',0.5];
								};
							} else {
								50 cutText ['Primary missions are suspended, cycle attempt failed','PLAIN DOWN',0.5];
							};
						} else {
							50 cutText ['Cannot suspend this mission','PLAIN DOWN',0.5];
						};
					} else {
						50 cutText ['Primary missions disabled in server config, cycle attempt failed','PLAIN DOWN',0.5];
					};
				},
				[],
				50,
				TRUE,
				TRUE,
				'',
				'',
				4,
				FALSE
			];
			_laptop setUserActionText [_actionID4,((_laptop actionParams _actionID4) select 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID4) select 0)])];
		};
	};
};
_zeus = ['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist');
if (_uid in _zeus) then {
	if (!isNil {missionNamespace getVariable 'QS_airdefense_laptop'}) then {
		if (!isNull (missionNamespace getVariable 'QS_airdefense_laptop')) then {
			_laptop = missionNamespace getVariable 'QS_airdefense_laptop';
			_actionID4 = _laptop addAction [
				'Zeus Reward Points',
				{
					0 spawn (missionNamespace getVariable 'NL_fnc_zeusPoints');
				},
				[],
				50,
				TRUE,
				TRUE,
				'',
				'',
				4,
				FALSE
			];
			_laptop setUserActionText [_actionID4,((_laptop actionParams _actionID4) select 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID4) select 0)])];
		};
	};
};

//Medic patch for medics
_medic = ["B_medic_F", "B_recon_medic_F" ];
_iamMedic = ({ ((typeOf player) isEqualTo _x) } count _Medic) > 0;
if (_iamMedic) then {
	['jsoc\patreon\insignia\red_cross.paa'] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
} else {
	[] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
};

_airDefenceLaptop = missionNamespace getVariable 'QS_airdefense_laptop';
_id6 = _airDefenceLaptop addAction ["FOB Menu", {[] call NL_fnc_fobRespawn;}];
_airDefenceLaptop setUserActionText [_id6, "FOB Menu", "<t size='3'>FOB Menu</t>"];

{
  _x addCuratorEditableObjects [[_this], TRUE];
} count allCurators;
