/*/
File: QS_uniformTextures.sqf
Author:

	Quiksilver

Last modified:

	6/12/2017 A3 1.78 by Quiksilver

Description:

	Uniforms

Data structure:

	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive','media\images\uskins\bdu\bdu.paa'],

	[ <just put number 0 here> , <ingame menu list title> , <folder path to texture file> , <mouse-hover toolip> , <valid uniform type classnames> , <author text> , <optional backpack texture> ]

__________________________________________________________________________/*/

_validUniforms_1 = [
	'U_B_CombatUniform_mcam','U_B_CombatUniform_mcam_tshirt','U_B_CombatUniform_mcam_vest','U_B_CombatUniform_mcam_worn',
	'U_B_CombatUniform_sgg','U_B_CombatUniform_sgg_tshirt','U_B_CombatUniform_sgg_vest',
	'U_B_CombatUniform_wdl','U_B_CombatUniform_wdl_tshirt','U_B_CombatUniform_wdl_vest',
	'U_B_CTRG_1','U_B_CTRG_2','U_B_CTRG_3','U_B_T_Soldier_SL_F','U_B_T_Soldier_F'
];
_validUniform_2 = [
	'U_C_WorkerCoveralls','U_B_HeliPilotCoveralls'	/*/ coveralls/*/
];
_validUniform_3 = [
	'U_BG_Guerilla1_1'			/*/Guerilla garment/*/
];
_validUniform_4 = [
	'U_O_CombatUniform_ocamo','U_O_CombatUniform_oucamo','U_O_SpecopsUniform_ocamo','U_O_OfficerUniform_ocamo'		/*/ CSAT combat uniforms/*/
];
_validUniform_5 = [
	'U_I_CombatUniform','U_I_CombatUniform_shortsleeve'
];

private _return = [];
_return = [
	[0,'<Empty>','','',[''],''],
	[0,'DCU','jsoc\patreon\uniforms\dcu_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'M98','jsoc\patreon\uniforms\m98_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Digital/Urban','jsoc\patreon\uniforms\digi_urban_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Digital/Desert','jsoc\patreon\uniforms\digi_desert_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Digital/Forest','jsoc\patreon\uniforms\digi_forest_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'AOR1','jsoc\patreon\uniforms\aor1_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'BlackOps','jsoc\patreon\uniforms\blackout_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'BlackOps/Arid','jsoc\patreon\uniforms\black_arid_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'BlackOps/Tropic','jsoc\patreon\uniforms\black_tropic_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Multicam/Arid','jsoc\patreon\uniforms\multi_arid_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Multicam/Arid/Tan','jsoc\patreon\uniforms\multi_arid_tan_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Multicam/Black','jsoc\patreon\uniforms\multi_black_black_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Multicam/Tan','jsoc\patreon\uniforms\multi_tan_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Multicam/Tropic','jsoc\patreon\uniforms\multi_tropic_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Green/Tropic','jsoc\patreon\uniforms\green_tropic.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Tropic/Green','jsoc\patreon\uniforms\tropic_green_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'Marpat/Black','jsoc\patreon\uniforms\marpat_black_co.paa','77th JSOC Custom Uniform',_validUniforms_1,'Ateir'],
	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive'],
	[0,'Sage','A3\characters_f\BLUFOR\Data\clothing_sage_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive'],
	[0,'Bandit','A3\characters_f\common\data\coveralls_bandit_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Black','A3\characters_f\common\data\coveralls_black_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Grey','A3\characters_f\common\data\coveralls_grey_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Urban','A3\characters_f\common\data\coveralls_urbancamo_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Wasp','A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive']
];

_return;
