/*/
File: QS_backpackTextures.sqf
Author:

	Quiksilver

Last modified:

	03/05/2020 A3 1.98 by Knight

Description:

	Backpacks

Data structure:

	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive','media\images\uskins\bdu\bdu.paa'],

	[ <just put number 0 here> , <ingame menu list title> , <folder path to texture file> , <mouse-hover toolip> , <valid uniform type classnames> , <author text> , <optional backpack texture> ]

__________________________________________________________________________/*/

_kitbagBackpack = [
	'B_Kitbag_rgr','B_Kitbag_mcamo','B_Kitbag_sgg','B_Kitbag_cbr','B_Kitbag_tan'
];

_tacticalBackpack = [
	'B_TacticalPack_blk','B_TacticalPack_rgr','B_TacticalPack_mcamo','B_TacticalPack_oli',
	'I_G_HMG_02_high_weapon_F','I_G_HMG_02_weapon_F','B_HMG_01_high_weapon_F','B_HMG_01_weapon_F',
	'B_GMG_01_high_weapon_F','B_GMG_01_weapon_F','B_Mortar_01_support_F','B_Mortar_01_weapon_F',
	'B_HMG_01_support_high_F','B_HMG_01_support_F','I_G_HMG_02_support_high_F','I_C_HMG_02_support_F',
	'B_AA_01_weapon_F','B_AT_01_weapon_F'
];

_viperHarnessBackpack = [
	'B_ViperHarness_blk_F','B_ViperHarness_khk_F','B_ViperHarness_oli_F','B_ViperLightHarness_blk_F',
	'B_ViperLightHarness_khk_F','B_ViperLightHarness_oli_F'
];

_caryallBackpack = [
	'B_Carryall_cbr','B_Carryall_eaf_F','B_Carryall_ghex_F','B_Carryall_green_F','B_Carryall_ocamo',
	'B_Carryall_khk','B_Carryall_mcamo','B_Carryall_oli','B_Carryall_taiga_F','B_Carryall_oucamo','B_Carryall_wdl_F'
];

private _return = [];
_return = [
	[0,'<Empty>','','',[''],''],
	[0,'Kitbag (Black)','A3\weapons_f\ammoboxes\bags\data\backpack_fast_blk_co.paa', 'Black Kitbag', _kitbagBackpack, 'Bohemia Interactive'],
	[0,'Kitbag (Arid)','jsoc\patreon\backpacks\kitbag_arid.paa', 'Arid Kitbag', _kitbagBackpack, 'Thefatgerbil'],
	[0,'Kitbag (Tropic)','jsoc\patreon\backpacks\kitbag_tropic.paa', 'Tropic Kitbag', _kitbagBackpack, 'Thefatgerbil'],
	[0,'Kitbag (Woodland)','jsoc\patreon\backpacks\kitbag_woodland.paa', 'Woodland Kitbag', _kitbagBackpack, 'Thefatgerbil'],
	[0,'Tactical Backpack (Black)','\A3\weapons_f\ammoboxes\bags\data\backpack_small_blk_co.paa', 'Black Tactical', _tacticalBackpack, 'Bohemia Interactive'],
	[0,'Tactical Backpack (Green)','\A3\weapons_f\ammoboxes\bags\data\backpack_small_rgr_co.paa', 'Green Tactical', _tacticalBackpack, 'Bohemia Interactive'],
	[0,'Tactical Backpack (MTP)','\A3\weapons_f\ammoboxes\bags\data\backpack_small_mcamo_co.paa', 'MTP Tactical', _tacticalBackpack, 'Bohemia Interactive'],
	[0,'Tactical Backpack (Olive)','\A3\weapons_f\ammoboxes\bags\data\backpack_small_oli_co.paa', 'Olive Tactical', _tacticalBackpack, 'Bohemia Interactive'],
	[0,'Tactical Backpack (Arid)','jsoc\patreon\backpacks\tactical_arid.paa', 'Arid Tactical', _tacticalBackpack, 'Thefatgerbil'],
	[0,'Tactical Backpack (Tropic)','jsoc\patreon\backpacks\tactical_tropic.paa', 'Tropic Tactical', _tacticalBackpack, 'Thefatgerbil'],
	[0,'Tactical Backpack (Woodland)','jsoc\patreon\backpacks\tactical_woodland.paa', 'Woodland Tactical', _tacticalBackpack, 'Thefatgerbil'],
	[0,'Viper Harness (Tropic)','jsoc\patreon\backpacks\viper_tropic.paa', 'Tropic Harness', _viperHarnessBackpack, 'Thefatgerbil'],
	[0,'Black Caryall','A3\weapons_f\ammoboxes\bags\data\backpack_tortila_blk_co.paa', 'Black Caryall', _caryallBackpack, 'Bohemia Interactive']
];

_return;
