/*/
File: QS_vehicleTextures.sqf
Author:

	Quiksilver
	
Last Modified:

	24/03/2018 A3 1.82 by Quiksilver
	
Description:

	Vehicle Skins
	
Data Structure:

	[0,'Dahoman',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],

	[ <just put number 0 here> , <ingame menu title> , <texture application logic (see next line) , <menu mouse-hover tooltip> , <list of classnames (case sensitive)> , <author text> ]
	
	For vehicle application logic, it plugs into this function:
	
		https://community.bistudio.com/wiki/setObjectTextureGlobal
		
	So for the above example, it looks like this:
		
		[
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']
		]
	
	And then in the menu script, it is executed like this:
	
		{
			<vehicle> setObjectTextureGlobal _x;
		} forEach [
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']
		];
		
	Which can also appear like this (but this is messier):
	
		<vehicle> setObjectTextureGlobal [0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'];
		<vehicle> setObjectTextureGlobal [1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'];
		<vehicle> setObjectTextureGlobal [2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa'];
		
	To see exactly where its executed (in v1.0.5):
	
		"code\functions\fn_clientMenuVTexture.sqf" line 104
		
	At the bottom of this file is a commented-out storage section where you can see some examples of custom skins in the correct data structure.
	
__________________________________________________________________________/*/

[
	[0,'Reset',[[0,'']],'',[''],''],
	[
		0,'MH-9 Hummingbird - Digital',
		[
			[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa']
		],'MH-9 Hummingbird (Heli)', ['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'MH-9 Hummingbird - Vrana',
		[
			[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa']
		],'MH-9 Hummingbird (Heli)', ['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'MH-9 Hummingbird - Wasp',
		[
			[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa']
		],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'MH-9 Hummingbird - Indep',
		[
			[0,'A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa']
		],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'MH-9 Hummingbird - Ion',
		[
			[0,'A3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa']
		],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'CH-49 Mohawk - Dahoman',
		[
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']
		],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'
	],
	[
		0,'CH-49 Mohawk - Ion',
		[
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa']
		],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'
	],
	[
		0,'CH-49 Mohawk - Merlin',
		[
			[0,'jsoc\patreon\vehicles\mohawk_merlin\mh_green_0.paa'],
			[1,'jsoc\patreon\vehicles\mohawk_merlin\mh_green_1.paa'],
			[2,'jsoc\patreon\vehicles\mohawk_merlin\mh_green_2.paa']
		],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Thefatgerbil'
	],
	[
		0,'CH-49 Mohawk - SeaHorse',
		[
			[0,'jsoc\patreon\vehicles\mohawk_seahorse\mh_grey_0.paa'],
			[1,'jsoc\patreon\vehicles\mohawk_seahorse\mh_grey_1.paa'],
			[2,'jsoc\patreon\vehicles\mohawk_seahorse\mh_grey_2.paa']
		],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Thefatgerbil'
	],
	[
		0,'CH-49 Mohawk - Desert',
		[
			[0,'jsoc\patreon\vehicles\mohawk_desert\mh_desert_0.paa'],
			[1,'jsoc\patreon\vehicles\mohawk_desert\mh_desert_1.paa'],
			[2,'jsoc\patreon\vehicles\mohawk_desert\mh_desert_2.paa']
		],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Thefatgerbil'
	],
	[
		0,'PO-30 Orca - Wave 2',
		[
			[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa']
		],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'
	],
	[
		0,'PO-30 Orca - Indep',
		[
			[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa']
		],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'
	],	
	[
		0,'PO-30 Orca - Black',
		[
			[0,'A3\air_f\Heli_Light_02\Data\Heli_light_02_ext_co.paa']
		],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'
	],
	[
		0,'AH-99 Blackfoot - Green',
		[
			[0,'A3\Air_F\Heli_Light_02\Data\heli_light_02_common_co.paa']
		],'AH-99 Blackfoot',['B_Heli_Attack_01_F','B_Heli_Attack_01_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'WY-55 Hellcat - LDF',
		[
			[0,'A3\Air_F_Enoch\Heli_Light_03\data\Heli_Light_03_base_EAF_CO.paa']
		],'WY-55 Hellcat',['I_Heli_light_03_F','I_Heli_light_03_unarmed_F','I_Heli_light_03_dynamicLoadout_F'],'Bohemia Interactive'
	],
	[
		0,'UH-80 Ghost Hawk - Black',
		[
			[0,'A3\air_f_beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_CO.paa'],
			[1,'A3\air_f_beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_CO.paa']
		],'UH-80 Ghost Hawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Bohemia Interactive'
	],
	[
		0,'UH-80 Ghost Hawk - Sand',
		[
			[0,'A3\air_f_exp\Heli_Transport_01\Data\Heli_Transport_01_ext01_sand_CO.paa'],
			[1,'A3\air_f_exp\Heli_Transport_01\Data\Heli_Transport_01_ext02_sand_CO.paa']
		],'UH-80 Ghost Hawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Bohemia Interactive'
	],
	[
		0,'UH-80 Ghost Hawk - Tropic',
		[
			[0,'A3\air_f_exp\Heli_Transport_01\Data\Heli_Transport_01_ext01_tropic_CO.paa'],
			[1,'A3\air_f_exp\Heli_Transport_01\Data\Heli_Transport_01_ext02_tropic_CO.paa']
		],'UH-80 Ghost Hawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Bohemia Interactive'
	],
	[
		0,'UH-80 Ghost Hawk - Green',
		[
			[0,'A3\air_f_beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_BLUFOR_CO.paa'],
			[1,'A3\air_f_beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_BLUFOR_CO.paa']
		],'UH-80 Ghost Hawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Bohemia Interactive'
	],
		[
		0,'UH-80 Ghost Hawk - Desert',
		[
			[0,'jsoc\patreon\vehicles\ghosthawk_desert\gh_desert_0.paa'],
			[1,'jsoc\patreon\vehicles\ghosthawk_desert\gh_desert_1.paa']
		],'UH-80 Ghost Hawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Fritz'
	],
	[
		0,'CH-67 Huron - Black',
		[
			[0,'A3\air_f_heli\Heli_Transport_03\Data\Heli_Transport_03_ext01_black_CO.paa'],
			[1,'A3\air_f_heli\Heli_Transport_03\Data\Heli_Transport_03_ext02_black_CO.paa']
		],'CH-67 Huron',['B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_black_F','B_Heli_Transport_03_unarmed_green_F'],'Bohemia Interactive'
	],
		[
		0,'CH-67 Huron - Desert',
		[
			[0,'jsoc\patreon\vehicles\huron_desert\hu_desert_0.paa'],
			[1,'jsoc\patreon\vehicles\huron_desert\hu_desert_1.paa']
		],'CH-67 Huron',['B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_black_F','B_Heli_Transport_03_unarmed_green_F'],'Fritz'
	],
	[
		0,'A-149 Gryphon',
		[
			[0,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_gray_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_gray_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_04\data\fighter_04_misc_01_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[4,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[5,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_08_ca.paa"]
		],'A-149 Gryphon (Plane)',['I_Plane_Fighter_04_F'],'Bohemia Interactive'
	],
	[
		0,'A-164 Wipeout - Lancaster',
		[
			[0,"jsoc\patreon\vehicles\wipeout_lancaster\wipeout_lancaster_0.paa"],
			[1,"jsoc\patreon\vehicles\wipeout_lancaster\wipeout_lancaster_1.paa"]
		],'A-164 Wipeout (Plane)',['B_Plane_CAS_01_F','B_Plane_CAS_01_dynamicLoadout_F','B_Plane_CAS_01_Cluster_F'],'Constant Deluge'
	],
	[
		0,'To-199 Neophron - Grey',
		[
			[0,"jsoc\patreon\vehicles\neophron_grey\neophron_grey_0.paa"],
			[1,"jsoc\patreon\vehicles\neophron_grey\neophron_grey_1.paa"]
		],'To-199 Neophron (Plane)',['O_Plane_CAS_02_F','O_Plane_CAS_02_dynamicLoadout_F','O_Plane_CAS_02_Cluster_F'],'Constant Deluge'
	],
	[
		0,'To-201 Shikra - Grey / Hex',
		[
			[0,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_02_Grey_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_02_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_00_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_01_co.paa"]
		],'To-201 Shikra (Plane)',['O_Plane_Fighter_02_F','O_Plane_Fighter_02_Stealth_F'],'Bohemia Interactive'
	],	
	[
		0,'To-201 Shikra - Blue',
		[
			[0,"A3\air_f_jets\plane_fighter_02\data\fighter_02_fuselage_01_blue_co.paa"],
			[1,"A3\air_f_jets\plane_fighter_02\data\fighter_02_fuselage_02_blue_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_blue_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_02_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_00_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_01_co.paa"]
		],'To-201 Shikra (Plane)',['O_Plane_Fighter_02_F','O_Plane_Fighter_02_Stealth_F'],'Bohemia Interactive'
	],
	[
		0,'F/A-181 Black Wasp II',
		[
			[0,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_01_Camo_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_02_Camo_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_01\data\fighter_01_glass_01_ca.paa"],
			[3,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_01_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_02_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_05_co.paa"]
		],'F/A-181 Black Wasp II (Plane)',['B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F'],'Bohemia Interactive'
	],
	[
		0,'Prowler - Dazzle',
		[
			[0,"a3\soft_f_exp\lsv_01\data\nato_lsv_01_dazzle_co.paa"],
			[1,"a3\soft_f_exp\lsv_01\data\nato_lsv_02_olive_co.paa"],
			[2,"a3\soft_f_exp\lsv_01\data\nato_lsv_03_olive_co.paa"],
			[3,"a3\soft_f_exp\lsv_01\data\nato_lsv_adds_olive_co.paa"]
		],
		'Prowler (LSV)',["B_LSV_01_armed_black_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_F","B_LSV_01_unarmed_olive_F","B_LSV_01_unarmed_sand_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"],'Bohemia Interactive'
	],
	[
		0,'Prowler - Olive',
		[
			[0,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_olive_CO.paa"],
			[1,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_olive_CO.paa"],
			[2,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_olive_CO.paa"],
			[3,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_olive_CO.paa"]
		],
		'Prowler (LSV)',["B_LSV_01_armed_black_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_F","B_LSV_01_unarmed_olive_F","B_LSV_01_unarmed_sand_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"],'Bohemia Interactive'
	],
	[
		0,'Prowler - Black',
		[
			[0,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_black_CO.paa"],
			[1,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_black_CO.paa"],
			[2,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_black_CO.paa"],
			[3,"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_black_CO.paa"]
		],
		'Prowler (LSV)',["B_LSV_01_armed_black_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_F","B_LSV_01_unarmed_olive_F","B_LSV_01_unarmed_sand_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"],'Bohemia Interactive'
	],
	[
		0,'Hunter MRAP - Blac Camo',
		[
			[0,"jsoc\patreon\vehicles\hunter\hunter_blackcamo_0.paa"],
			[1,"jsoc\patreon\vehicles\hunter\hunter_blackcamo_1.paa"],
			[2,"jsoc\patreon\vehicles\hunter\hunter_blackcamo_2.paa"]
		],
		'Hunter MRAP',["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_T_MRAP_01_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F"],'Bohemia Interactive'
	],
	[
		0,'Hunter MRAP - Olive',
		[
			[0,"\A3\soft_F_Exp\MRAP_01\data\MRAP_01_base_olive_CO.paa"],
			[1,"\A3\soft_F_Exp\MRAP_01\data\MRAP_01_adds_olive_CO.paa"],
			[2,"\A3\Data_F_Exp\Vehicles\Turret_olive_CO.paa"]
		],
		'Hunter MRAP',["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_T_MRAP_01_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F"],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 2',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_02_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_02_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_02_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_02_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 1',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_03_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_03_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_03_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_03_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'AMV-7 Marshall - Sand',
		[
			[0,"A3\armor_f_beta\APC_Wheeled_01\Data\APC_Wheeled_01_base_CO.paa"],
			[1,"A3\Armor_F_Beta\APC_Wheeled_01\Data\APC_Wheeled_01_adds_CO.paa"],
			[2,"A3\Armor_F_Beta\APC_Wheeled_01\Data\APC_Wheeled_01_tows_CO.paa"],
			[3,"A3\Armor_F\Data\camonet_NATO_Desert_CO.paa"],
			[4,"A3\Armor_F\Data\cage_sand_CO.paa"]
		],'AMV-7 Marshall',['B_APC_Wheeled_01_cannon_F','B_T_APC_Wheeled_01_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'AMV-7 Marshall - Olive',
		[
			[0,"A3\Armor_F_exp\APC_Wheeled_01\Data\APC_Wheeled_01_base_olive_CO.paa"],
			[1,"A3\Armor_F_exp\APC_Wheeled_01\Data\APC_Wheeled_01_adds_olive_CO.paa"],
			[2,"A3\Armor_F_exp\APC_Wheeled_01\Data\APC_Wheeled_01_tows_olive_CO.paa"],
			[3,"A3\Armor_F\Data\camonet_NATO_Green_CO.paa"],
			[4,"A3\Armor_F\Data\cage_olive_CO.paa"]
		],'AMV-7 Marshall',['B_APC_Wheeled_01_cannon_F','B_T_APC_Wheeled_01_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'BTR-K Kamysh - HexArid',
		[
			[0,"A3\Armor_f_beta\APC_Tracked_02\Data\APC_Tracked_02_ext_01_HEXARID_CO.paa"],
			[1,"A3\Armor_f_beta\APC_Tracked_02\Data\APC_Tracked_02_ext_02_HEXARID_CO.paa"],
			[2,"A3\Armor_f_beta\APC_Tracked_02\Data\RCWS30_OPFOR_CO.paa"],
			[3,"A3\Armor_F\Data\camonet_CSAT_HEX_Desert_CO.paa"],
			[4,"A3\Armor_F\Data\cage_csat_CO.paa"]
		],'BTR-K Kamysh',['O_APC_Tracked_02_cannon_F','O_T_APC_Tracked_02_cannon_ghex_F'],'Bohemia Interactive'
	],
	[
		0,'BTR-K Kamysh - HexGreen',
		[
			[0,"A3\Armor_f_exp\APC_Tracked_02\Data\APC_Tracked_02_ext_01_ghex_CO.paa"],
			[1,"A3\Armor_f_exp\APC_Tracked_02\Data\APC_Tracked_02_ext_02_ghex_CO.paa"],
			[2,"A3\Armor_f_exp\APC_Tracked_02\Data\RCWS30_ghex_CO.paa"],
			[3,"A3\Armor_F\Data\camonet_CSAT_HEX_Green_CO.paa"],
			[4,"A3\Armor_F\Data\cage_csat_green_CO.paa"]
		],'BTR-K Kamysh',['O_APC_Tracked_02_cannon_F','O_T_APC_Tracked_02_cannon_ghex_F'],'Bohemia Interactive'
	],
	[
		0,'T-140 Angara - HexArid',
		[
			[0,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_brown_hex_1_CO.paa"],
			[1,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_brown_hex_2_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_CSAT_HEX_Desert_CO.paa"]
		],'T-140 Angara',['O_MBT_04_cannon_F','O_T_MBT_04_cannon_F','O_MBT_04_command_F','O_T_MBT_04_command_F'],'Bohemia Interactive'
	],
	[
		0,'T-140 Angara - HexGreen',
		[
			[0,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_green_hex_1_CO.paa"],
			[1,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_green_hex_2_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_CSAT_HEX_Green_CO.paa"]
		],'T-140 Angara',['O_MBT_04_cannon_F','O_T_MBT_04_cannon_F','O_MBT_04_command_F','O_T_MBT_04_command_F'],'Bohemia Interactive'
	],
	[
		0,'T-140 Angara - Jungle',
		[
			[0,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_jungle_1_CO.paa"],
			[1,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_jungle_2_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_CSAT_Stripe_Green_CO.paa"]
		],'T-140 Angara',['O_MBT_04_cannon_F','O_T_MBT_04_cannon_F','O_MBT_04_command_F','O_T_MBT_04_command_F'],'Bohemia Interactive'
	],
	[
		0,'T-140 Angara - Grey',
		[
			[0,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_1_CO.paa"],
			[1,"A3\Armor_f_tank\MBT_04\Data\MBT_04_exterior_2_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_CSAT_Stripe_Desert_CO.paa"]
		],'T-140 Angara',['O_MBT_04_cannon_F','O_T_MBT_04_cannon_F','O_MBT_04_command_F','O_T_MBT_04_command_F'],'Bohemia Interactive'
	],
	[
		0,'AWC 303 Nyx (Recon)',
		[
			[0,"A3\Armor_f_tank\LT_01\Data\LT_01_Main_Olive_CO.paa"],
			[1,"A3\Armor_f_tank\LT_01\Data\LT_01_Main_Olive_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_AAF_Digi_Green_CO.paa"],
			[3,"A3\Armor_F\Data\cage_olive_CO.paa"]
		],'AWC 303 Nyx',['I_LT_01_scout_F'],'Bohemia Interactive'
	],
	[
		0,'AWC 304 Nyx (Autocannon)',
		[
			[0,"A3\Armor_f_tank\LT_01\Data\LT_01_Main_Olive_CO.paa"],
			[1,"A3\Armor_f_tank\LT_01\Data\LT_01_Cannon_Olive_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_AAF_Digi_Green_CO.paa"],
			[3,"A3\Armor_F\Data\cage_olive_CO.paa"]
		],'AWC 304 Nyx',['I_LT_01_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'AWC 301/302 Nyx (AT/AA)',
		[
			[0,"A3\Armor_f_tank\LT_01\Data\LT_01_Main_Olive_CO.paa"],
			[1,"A3\Armor_f_tank\LT_01\Data\LT_01_AT_Olive_CO.paa"],
			[2,"A3\Armor_F\Data\camonet_AAF_Digi_Green_CO.paa"],
			[3,"A3\Armor_F\Data\cage_olive_CO.paa"]
		],'AWC 301/302 Nyx',['I_LT_01_AA_F','I_LT_01_AT_F'],'Bohemia Interactive'
	],
	[
		0,'FV-720 Mora - LDF',
		[
			[0,"A3\Armor_F_Enoch\apc_tracked_03\data\apc_tracked_03_ext_eaf_co.paa"],
			[1,"A3\Armor_F_Enoch\apc_tracked_03\data\apc_tracked_03_ext2_eaf_co.paa"],
			[2,"A3\Armor_F_Enoch\apc_tracked_03\Data\camonet_EAF_green_CO.paa"],
			[3,"A3\Armor_F_Enoch\apc_tracked_03\data\cage_EAF_CO.paa"]
		],'FV-720 Mora',['I_APC_tracked_03_cannon_F','I_E_APC_tracked_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'M2A1 Slammer - Olive',
		[
			[0,"A3\Armor_F_Enoch\apc_tracked_03\data\apc_tracked_03_ext_eaf_co.paa"],
			[1,"A3\Armor_F_Enoch\apc_tracked_03\data\apc_tracked_03_ext2_eaf_co.paa"],
			[2,"A3\Armor_F_Enoch\apc_tracked_03\Data\camonet_EAF_green_CO.paa"],
			[3,"A3\Armor_F_Enoch\apc_tracked_03\data\cage_EAF_CO.paa"]
		],'M2A1 Slammer',['B_MBT_01_cannon_F','B_MBT_01_TUSK_F','B_T_MBT_01_cannon_F','B_T_MBT_01_TUSK_F'],'Bohemia Interactive'
	],
	[
		0,'T-100 Varsuk - Pacific',
		[
			[0,"a3\Armor_F_Exp\MBT_02\Data\MBT_02_body_ghex_CO.paa"],
			[1,"a3\Armor_F_Exp\MBT_02\Data\MBT_02_turret_ghex_CO.paa"],
			[2,"a3\Armor_F_Exp\MBT_02\Data\MBT_02_ghex_CO.paa"],
			[3,"A3\Armor_F\Data\camonet_CSAT_HEX_Green_CO.paa"]
		],'T-100 Varsuk',['O_MBT_02_cannon_F','O_T_MBT_02_cannon_ghex_F'],'Bohemia Interactive'
	],
	[
		0,'T-100 Varsuk - NATO',
		[
			[0,"jsoc\patreon\vehicles\t100_nato\t100_nato_0.paa"],
			[1,"jsoc\patreon\vehicles\t100_nato\t100_nato_1.paa"],
			[2,"jsoc\patreon\vehicles\t100_nato\t100_nato_2.paa"],
			[3,"a3\Armor_F\Data\camonet_NATO_Desert_CO.paa"]
		],'T-100 Varsuk',['O_MBT_02_cannon_F','O_T_MBT_02_cannon_ghex_F'],'Thefatgerbil'
	]
]