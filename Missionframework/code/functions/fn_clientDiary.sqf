/*/
File: fn_clientDiary.sqf
Author:

	Quiksilver

Last Modified:

	29/10/201720 A3 2.00 by Alx/Quiksilver

Description:

	-

License Notes:

	Part of the EULA for this framework is to ensure this file executes as normal.

__________________________________________________________/*/

/*/========== Create Diary Subjects (this is the order they appear in the map tabs)/*/

{
	player createDiarySubject _x;
} forEach [
	['QS_diary_rules','Rules (Read Me)'],
	['QS_diary_feature','Mission Features'],
	['QS_diary_roles','Roles'],
	['QS_diary_mods','Mods'],
	['QS_diary_teamspeak','Teamspeak'],
	['QS_diary_donate','Donate']
	//['QS_diary_hotkeys','Key Bindings'], //sum
	//['QS_diary_leaderboards','Leaderboards'], //sum
	//['QS_diary_gitmo','Gitmo'], //sum
	//['QS_diary_fobs','FOBs'], //sum
	//['QS_diary_revive','Revive'], //sum
	//['QS_diary_inventory','Inventory'], //sum
	//['QS_diary_radio','Radio Channels'], //sum
];

/*/========== Create Diary Records/*/

if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'CLASSIC') then {
	_description = format [
	"
	<br/>                <img image='jsoc\images\77th_logo.paa'/>
	<br/>
	<br/><br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Welcome to the 77th JSOC %1 Invade and Annex</font>
	<br/>
	<br/>NATO is at war with CSAT and all their allies. They are trying to establish Areas of Operations (AOs) all over %1. To further assist their goals they are also creating smaller bases and operations (Side Missions). They call upon all the help they can get. Be that AAF, local rebels and bandits or even stray LDF and Spetznaz forces.
	<br/>The goal of this gamemode is to go to the various missions and defeat CSAT and their allies. Killing the enemy is only part of the struggle. There are many smaller objectives that need to be achieved in order to succeed the missions. Make sure to read the mission tasks to know what needs to be done! Accomplishing the various missions will give access to Reward Points which can be used to buy additional assets to assist the fight.
	<br/>
	<br/>Remember, no matter what anyone says we are the good guys! So while fighting the enemy make sure to protect civilians and bring back peace to %1.
	<br/>
	<br/>Please be aware that this server puts a heavy emphasize on teamwork not just in between a squad, but also in conjunction with the other squads.
	<br/>
	<br/><font size= '16' color='#ff5455' face='RobotoCondensedBold'>This is not a gamemode for players who want to play for themselves and have no interest in cooperation!</font>
	",worldName];
	player createDiaryRecord [
		'Diary',
		[
			(format ['%1 Invade And Annex',worldName]),
			_description
		]
	];
};
/*/================================= Features Start/*/

/*/================================= RADIO CHANNELS/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'Custom Radio Channels',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Overview</font>
		<br/>
		<br/>A number of custom radio channels are available for use in-game.
		<br/>
		<br/>To access: Press [Home] >> [Comm-Link] >> [Radio Management]
		<br/>
		<br/>A Radio inventory item is required to transmit voice communications!
		<br/>
		<br/><font size='16' color='#ff5455'>Spamming, Verbal Abuse and generally annoying other players using Voice communications will lead to administrative action!</font>
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Side Channel</font>
		<br/>
		<br/>Voice communication is currently <font color='#ff5455'>disabled</font> on Side channel.
		<br/>
		<br/>Type messages to communicate to all players on the server!
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Command Channel</font>
		<br/>
		<br/>The new custom Command Channel is available only for Squadleads / Pilots / UAV and HQ. If a Squadlead dies he keeps his acecess to the channel.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Platoon Channel</font>
		<br/>
		<br/>Join a Platoon channel (Alpha, Bravo, Charlie, Delta, Echo and Foxtrot) for inter-squad communications.
		<br/>You can only be subscribed to one Platoon channel at a time!
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Primary AO and Secondary AO Channels</font>
		<br/>
		<br/>If you are subscribed to these channels, you will automatically be added to these channels when within the necessary Radius of the mission.
		<br/>
		<br/>Radius of the Primary AO is currently 4 km
		<br/>Radius of the Secondary AO (Side Mission) is currently 2 km
		<br/>
		<br/>When you leave this area, you will no longer be able to receive or transmit on it!
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Aircraft Channel</font>
		<br/>
		<br/>Pilots and UAV Operator are active on this channel. Currently only Pilots and UAV Operator can transmit voice on this channel.
		<br/>
		<br/>If you are not Pilot or UAV Operator, you can still listen to this channel, if you are in the Air Traffic Control tower or the TOC (map marker at base) - <font color='#ff5455'>currently not active</font>.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Tip</font>
		<br/>
		<br/>Sometimes people have problems dealing with multiple channels and end up transmitting on the wrong one. While you cannot bind a hotkey to the new custom command channel you can bind all the vanilla radio channels (Group, Vehicle and Direct).
		<br/>Press ESC and navigate to [Configure] >> [Controls] >> [Multiplayer] to be able to bind the vanilla channels to hotkeys and be able to use the new custom command channel and e.g. group channel more easily!
		<br/>
		"
	]
];

/*/================================= Gitmo/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'Capture Enemies',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Capture Enemies</font>
		<br/>
		<br/>It is possible to capture enemies!
		<br/>
		<br/>To capture an enemy soldier, you must get within 5m and aim at him. You may get a Command Surrender action on your scroll wheel. To receive full reward, bring the captive back to the Gitmo area at base. To incarcerate a prisoner into Gitmo, move him into the prison area.
		<br/>
		<br/>Capturing the enemy Commander in an AO and bringing him successfully back to the Gitmo area at base will prevent a potential Defend Mission!
		<br/>
		<br/>Good hunting!
		"
	]
];

/*/================================= INVENTORY/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'Inventory Editing',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Inventory Editing</font>
		<br/>
		<br/>Near the Crate Area and Inventory markers at base, you are able to easily customize the inventory of vehicles and ammo crates.
		<br/>Please be aware that you can put almost any item into a vehicles / crate and therefore be careful not to put in equipment that might be restricted as people will not be able to use it in the field!
		<br/>You can add/subract stacks of 10 Items at a time while using Left Shift while editing the Inventory.
		"
	]
];

/*/================================= REVIVE/*/

player createDiaryRecord [
	'QS_diary_feature',
	[

		'Medical System',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Respawning</font>
		<br/>
		<br/>Respawning should always be the last resort action. To that end we have tweaked the medical system on our servers.
		<br/>
		<br/>If you are dead and a medic is nearby you will not be able to respawn. However, that radius in which respawning it is prevented will shrink over time - in case a medic is unable to get to you.
		<br/>
		<br/>If you are dead inside a non-medical vehicle your timer will not run out but be refreshed to 1 minute so you can be transported to a medic / medical area.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Act of God - Random Revives (Only Medics)</font>
		<br/>
		<br/>If a medic dies in the field he has a chance to get randomly revived if no other medics are nearby. If the medic has not been revived after 1 Minute you can assume luck is not on your side in that moment.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Medical Vehicles</font>
		<br/>
		<br/>Load incapacitated soldiers into a Medical vehicle (HEMTT Medical, Taru Medical Pod, etc) to revive them.
		<br/>
		<br/>- The vehicle must have sufficient Revive Tickets.
		<br/>- Reviving a player consumes a Revive Ticket.
		<br/>- Revive tickets can be replenished at the Base Service markers.
		<br/>- Revive tickets correspond to number of cargo seats in the vehicle.
		"
	]
];

/*/================================= FOBs/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'FOBs',
		(format[
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>General Information</font>
		<br/>
		<br/>Forward Operating Bases are scattered around %1.
		<br/>
		<br/>Some services are available from these FOBs, and they are also locations of interest to the enemy.
		<br/>To interact with the FOBs, you can use the Laptop inside the Main Building or if you bring certain types of vehicles/crates within a radius of the FOB you can activate certain services.
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>Be aware that the FOB system is currently under Review/Rework</font>
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Radar Services - Currently not active</font>
		<br/>
		<br/>When the FOB is active and held by your faction, enemy map data and radar data will be available
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Respawning</font>
		<br/>
		<br/>Respawning is available at FOBs if several conditions are met:
		<br/>- The FOB must be online and held by your faction
		<br/>- HQ must allow you to respawn at the FOB via the HQ Base Laptop.
		<br/>- You must enable your personal FOB respawn. This can be done at the FOB terminal located inside the FOB HQ building.
		<br/>- You are NOT a pilot
		<br/>- The FOB has more than 0 Respawn Tickets
		<br/>- You have not respawned there in the past 3 minutes'
		<br/>
		<br/>Bring Medical Vehicles and Crates to the FOB to replenish and add new Respawn Tickets!
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Vehicle Services</font>
		<br/>
		<br/>Several vehicle services are available at the FOBs for Aircraft and Land Vehicles:
		<br/>- Repair - Bring a repair truck or crate to the FOB to activate Repair Services
		<br/>- Fuel - Bring a fuel truck or crate to the FOB to bring Refueling Services online
		<br/>- Ammo - Bring an Ammo truck or crate to the FOB to bring Ammo Services online
		",worldName])
	]
];

/*/================================= Leaderboards/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'Leaderboards',
		format [
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>General Information</font>
		<br/>
		<br/>To maintain performance and FPS, the leaderboards are synchronized every 5-10 minutes instead of continuously, and saved to database every 10-15 minutes. For this reason, points accumulated just prior to server restart may not be saved.
		<br/>Thanks for your patience, %1!
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>Be aware that the Leaderboard system is currently under Review/Rework and might therefore not funtion</font>
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Prisoners / Gitmo</font>
		<br/>
		<br/>Earn points by imprisoning enemies in 'Gitmo'.
		<br/>Gitmo is marked on your map at base. See 'Gitmo' diary tab for further details.
		<br/>Multipliers: n/a
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Tower Rangers</font>
		<br/>
		<br/>Earn points as an infantryman by destroying the radiotower (pilots not eligible).
		<br/>Multipliers: n/a
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Berets</font>
		<br/>
		<br/>Earn points by collecting Berets from dead enemies.
		<br/>Multipliers: n/a
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Dog Tags</font>
		<br/>
		<br/>Earn points by collecting Dog Tags from dead enemies.
		<br/>Multipliers: n/a
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Revivalist</font>
		<br/>
		<br/>Earn points as a Medic by reviving fallen soldiers.
		<br/>Multipliers: Stamina
		<br/>
		<br/>Top 3 medics of the week (ending Sunday 23:59h) added to whitelisted medic slot for following week - <font color='#ff5455'>currently not active</font>.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Transporters</font>
		<br/>
		<br/>Earn points as a Pilot by safely transporting soldiers to and from missions in helicopters.
		<br/>Multipliers: Advanced Flight Model
		<br/>
		<br/>Top 3 pilots of the week (ending Sunday 23:59h) added to whitelisted pilot slot for following week - <font color='#ff5455'>currently not active</font>.
		<br/>
		<br/>Sling loading is not currently supported.
		<br/>Vehicle cargo is not currently supported.
		<br/>
		<br/>
		",profileName]
	]
];

/*/================================= Gear/*/

player createDiaryRecord [
	'QS_diary_feature',
	[
		'Magazine and Backblast',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Magazine Restrictions</font>
		<br/>
		<br/>In an effort to foster cooperation in between the players and their selected roles the 77th Servers run with a restriction on high capacity magazines.
		<br/>That means that any only the actual Autorifle variants of the weapons are capable of using the high capacity magazines. Any other weapon will jam after a few shots and will need to be reloaded with a new magazine.
		<br/>For example: The MX rifle will not be able to use the 100 Round Magazine, but the MX SW rifle available for the Autorifleman and Heavy Gunner roles will be capable of using the 100 Round Magazine.
		<br/>Generally, only the Autorifleman and Heavy Gunner roles are capable of using any high capacity magazine, because they can equip the fitting rifles.
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Backblast</font>
		<br/>
		<br/>Rocket Launchers on our server will create backblast when fired which is capable of killing other players. So be careful when using them and always make sure your backblast zone is clear of friendlies!

		"
	]
];

/*/================================= Keybinds/*/

player createDiaryRecord [
    'QS_diary_feature',
    [
        'Key Bindings',
        (format ["
				<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Key Bindings</font>
				<br/>
        <br/>- Client Menu - [Home]
				<br/>
        <br/>- Earplugs - [End
				<br/>
        <br/>- Show/Hide HUD - [P]
				<br/>
        <br/>- Holster Weapon - [0]
				<br/>
        <br/>- Magazine Repack - [L.Ctrl]+[%2]
				<br/>
        <br/>- Jump - [%5] while running
				<br/>
        <br/>- Group Manager - [%6]
				<br/>
        <br/>- Tasks - [%3]
				<br/>
        <br/>- Hints - [%4]
				<br/>
        <br/>- Gestures - [Ctrl]+[Numpad x]
				<br/>
        <br/>- Tactical Ping - Deactivated
				<br/>
        <br/>- Open and close doors - [Space]
        ",(actionKeysNames 'TacticalPing'),(actionKeysNames 'ReloadMagazine'),(actionKeysNames 'Diary'),(actionKeysNames 'Help'),(actionKeysNames 'GetOver'),(actionKeysNames 'Teamswitch')])
    ]
];

if ((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	player createDiaryRecord [
		'QS_diary_feature',
		[
			'Key Bindings - Staff',
			"
			<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Key Bindings - Staff</font>
			<br/>
			<br/>- Staff Menu Open - [Shift]+[F2]
			<br/>
			<br/>- Staff Menu Close - [Shift]+[F2]
			<br/>
			<br/>- Exit Spectate - [Shift]+[F2]
			"
		]
	];
	if ((getPlayerUID player) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		player createDiaryRecord [
			'QS_diary_feature',
			[
				'Key Bindings - Curator (Zeus)',
				"
				<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Key Bindings - Curator (Zeus)</font>
				<br/>
				<br/>- Sync Editable Objects - [Shift]+[F3]
				<br/>
				<br/>- (Selected Group) Garrison in Buildings - [Numpad 1]
				<br/>
				<br/>- (Selected Group) Patrol Area - [Numpad 2]
				<br/>
				<br/>- (Selected Group) Search Building - [Numpad 3]
				<br/>
				<br/>- (Selected Group) Stalk Target - [Numpad 4]
				<br/>
				<br/>- (Selected Group) Suppressive Fire - [Numpad 6]
				<br/>
				<br/>- (Selected Unit) Revive Player - [Numpad 7]
				<br/>
				<br/>- (All Players) View Directions - [Numpad 8]
				<br/>
				<br/>- (Selected Unit) Set unit Unconscious - [Numpad 9]
				"
			]
		];
	};
};
/*/================================= Features End/*/

/*/================================= Roles Start/*/
//QS_diary_roles
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Sniper',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Sniper</font>
		<br/>
		<br/>Snipers are no front line soldiers. They work in small groups (usually 2) together with a spotter to provide recon for other squads or eliminate key targets in accordance with the ROE. The sniper is responsible for taking the killshot and observing the target area. Some sniper rifles are powerful enough to pierce vehicle armor and cause not only damage to the vehicle and but also kill the crew inside.
		<br/>
		<br/>Snipers can use the rangefinder to provide better information about enemy positions and range targets if needed.
		<br/>They are one of two roles (together with the Marksman) that is able to use a variety of marksman rifles and scopes.
		<br/>They are the only role that is able to use a variety of sniper rifles and high powered scopes.
		<br/>They are one of two roles (together with the Spotter) that can use a limited variety of exlposives (Claymores and Tripwires).
		<br/>
		<br/><font size='14' color='#ff5455'>This role is currently not available on our servers</font>
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Spotter',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Spotter</font>
		<br/>
		<br/>Spotters are no front line soldiers. They work in small groups (usually 2) together with a sniper to provide recon for other squads or eliminate key targets in accordance with the ROE. The spotter is responsible for the safety of his sniper and their immediate surroundings.
		<br/>
		<br/>They are the only role that is able to use the ASP-1 to allow for effective protection on close range.
		<br/>They are one of two roles (together with the Sniper) that can use a limited variety of exlposives (Claymores and Tripwires).
		<br/>They are one of two roles (together with the Squadleader) that can use the Laser Designator to identify enemy positions and use it to mark targets for CAS.
		<br/>
		<br/><font size='14' color='#ff5455'>This role is currently not available on our servers</font>
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Squadleader',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Squadleader</font>
		<br/>
		<br/>Squadleaders are frontline soldiers, who ideally are also the leader of a squad. They have access to laser designators to allow them to lase targets and call for CAS in accordance with the ROE.
		<br/>
		<br/>They also have access to grenade launchers in order to make use of the smoke and flare rounds to assist their squad and/or mark targets for CAS if needed.
		<br/>They are one of two roles (together with the Spotter) that can use the Laser Designator to identify enemy positions and use it to mark targets for CAS.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Combat Life Saver',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Combat Life Saver</font>
		<br/>
		<br/>Medics are first and foremost front line soldiers with the added responsibility of providing First Aid and Medical services to friendly soldiers in the field.
		<br/>
		<br/>With first aid kits and a medkit medics are able to both revive and heal friendlies in the field if the need arises.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Grenadier',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Grenadier</font>
		<br/>
		<br/>Grenadiers are front line soldiers, who can use grenade launchers witht HE rounds to take down enemies. The added firepower of a grenade launcher allows them to engage enemies behind cover and concentrations of infantry with ease. They are also able to fight lightly armoured vehicles and use both flare and smoke grenades to assist their squad.
		<br/>
		<br/>They are the only role that is able to use HE rounds for the grenade launcher.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Marksman',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Marksman</font>
		<br/>
		<br/>Marksman are first and foremost frontline soldiers. They can select slightly more powerful scopes and weapons to increase their engagement range compared to other roles. This is to provide fire support for the squad against enemies outside the effective range of most other roles.
		<br/>
		<br/>Marksman can use the rangefinder to provide better information about enemy positions to their squads.
		<br/>They are one of two roles (together with the Sniper) that is able to use a variety of marksman rifles and scopes.
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>Contrary to rumors they are not snipers themselves, but are considered rifleman with a longer range and should stay close to their squad.</font>
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Heavy Gunner',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Heavy Gunner</font>
		<br/>
		<br/>Heavy Gunners are to provide cover fire and suppressive fire for their squad similiar to normal Autorifleman, but with a bigger caliber that allows them to do so on longer ranges. Their weapons are also capable of penetrating walls and lightly armoured vehicles. They also provide excellent options to decimate enemy infantry.
		<br/>
		<br/>They are one of two roles (together with the Autorifleman) who are able to equip a variety of LMGs.
		<br/>They are the only role that is able to use the heavy machineguns (SPMG and Navid). However, due to that they have to endure a more limited selection of scope available to them.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Autorifleman',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Autorifleman</font>
		<br/>
		<br/>Autorifleman are front line soldiers, who provide cover fire and suppressive fire for their squad during engagements and while their squad is moving. They also provide excellent options to decimate enemy infantry.
		<br/>
		<br/>They are one of two roles (together with the Heavy Gunner) who are able to equip a variety of LMGs.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Engineer',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Engineer</font>
		<br/>
		<br/>Engineers are frontline soldiers with the extra ability to use and disarm explosives as well as to repair and refuel vehicles in the field with a toolkit. They are usually being used to destroy key objectives like a radio tower or to repair vehicles in the field like crashed friendly helicopters.
		<br/>
		<br/>They are the only role that can disable the GPS Jammer (with the help of a toolkit). They also are able to create an emergency boat with their toolkit if they ever find themselves stranded in the ocean with their squad.
		<br/>They are the only role that is able to use a wide variety of explosives and other engineer equipment.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Rifleman (Anti-Air)',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Rifleman (Anti-Air) or AA</font>
		<br/>
		<br/>Rifleman (Anti-Air) or more commenly refered to as just AA are to provide fire support against enemy aircraft on short distances. They usually are most effective against enemy helicopters, but can also be used against low flying jets.
		<br/>
		<br/>They are the only role that is able to use a the Titan AA launchers.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Rifleman (Light Anti-Tank)',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Rifleman (Light Anti-Tank) or Light AT</font>
		<br/>
		<br/>Rifleman (Light Anti-Tank) or more commenly refered to as Light AT are to provide fire support against armored vehicles with light anti-tank launchers. Target prioritisation is important as heavy vehicles usually require a huge amount of hits by light AT launchers in order to be destroyed. Therefore Light ATs should be used to engage more lightly armoured vehicles and save the Heavy AT for the more heavily armoured targets.
		<br/>Certain launchers also allow the use of HE rockets, which are effective against concentrations of infantry.
		<br/>
		<br/>Light AT can use the rangefinder to provide better information about enemy positions to their squads and range targets if needed.
		<br/>They are one of two roles (together with the Heavy AT) that is able to use light anti-tank launchers.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Rifleman (Heavy Anti-Tank)',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Rifleman (Anti-Air) or AA</font>
		<br/>
		<br/>Rifleman (Heavy Anti-Tank) or more commenly refered to as Heavy AT are to provide fire support against armored vehicles with heavy launchers. There is only a limited amount of slots available and additional ammo is heavy so target prioritisation is important in order to not waste rockets on targets that are better be engaged with weaker launchers or even grenades/machine gun fire.
		<br/>
		<br/>They are one of two roles (together with the Light AT) that is able to use light anti-tank launchers.
		<br/>They are the only role that is able to use the Heavy AT Launchers (Titan AT and Vorona).
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Rifleman',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Rifleman</font>
		<br/>
		<br/>Rifleman are front line soldiers, who can use a wide array of weapons to take down enemies. They are also able to carry spare ammo (like rockets) for other classes if needed.
		<br/>
		<br/>They are the only role that is able to use the Shotgun Variant of the Promet for CQB environments and are able to equip large backpacks to assist their squad with supplies.
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'UAV',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>UAV</font>
		<br/>
		<br/>UAV main job is to provide Recon and CAS (if requested by a Squadleader and in accordance with the ROE) on missions. They are expected to have a good grasp of server standards and to organize the server in the absence of an HQ.
		<br/>
		<br/><font size= '14' color='#68ff54' face='RobotoCondensedBold'>Our servers are not a practice environment. If you need training use the editor! Incapable UAVs will be removed.</font>
		<br/>
		<br/><font size= '14' color='#26f0ff' face='RobotoCondensedBold'>- UAV is required to be on teamspeak.</font>
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>- Being a UAV requires knowledge of the server and is therefore not suited for new players.</font>
		<br/>
		<br/>Please make sure to read the UAV Handbook on the 77th Wiki for a in-depth role description!
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Pilot',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Pilot</font>
		<br/>
		<br/>Pilots main job is to provide timely and <font size= '14' color='#68ff54' face='RobotoCondensedBold'>safe</font> transport of squads and material from and to missions. They are expected to have a good grasp of server standards, to organize the server in the absence of an HQ and also be capable to sufficiently operate aircraft in a multiplayer environment.
		<br/>
		<br/><font size= '14' color='#68ff54' face='RobotoCondensedBold'>Our servers are not a practice environment. If you need training use the editor! Incapable pilots will be removed.</font>
		<br/>
		<br/><font size= '14' color='#26f0ff' face='RobotoCondensedBold'>- Pilots are required to be on teamspeak.</font>
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>- Being a Pilot requires knowledge of the server and is therefore not suited for new players.</font>
		<br/>
		<br/>Please make sure to read the Pilot Handbook on the 77th Wiki for a in-depth role description!
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'HQ',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Pilot</font>
		<br/>
		<br/>HQs job is to keep the squads and server organized. This involves checking that squads have the manpower and classes needed for the missions (Assignment of Ungrouped) and to keep the different classes balanced among the squads.
		<br/>
		<br/><font size= '14' color='#68ff54' face='RobotoCondensedBold'>Our servers are not a practice environment. Incapable HQs will be removed.</font>
		<br/>
		<br/><font size= '14' color='#26f0ff' face='RobotoCondensedBold'>- HQ is required to be on teamspeak and to have a working microphone.</font>
		<br/>
		<br/><font size= '14' color='#ff5455' face='RobotoCondensedBold'>- Being HQ requires in-depth knowledge of the server and its workings and is therefore not suited for new players.</font>
		<br/>
		<br/>Please make sure to read the HQ Handbook on the 77th Wiki for a in-depth role description!
		"
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		'Overview',
		"
		<br/><font size= '16' color='#ffdb14' face='RobotoCondensedBold'>Overview</font>
		<br/>
		<br/>There are currently 14 different roles players can choose from in the lobby (excluding Sniper and Spotter as they are currently deactivated). Each one has its own purpose and gear that only that role can equip. Down below you can short summaries of all the different roles.
		<br/>
		<br/>For example the marksman role gets to equip a number of marksman rifles that no one else can use and so on.
		<br/>
		<br/>If you want to change your role you currently will need to go back to the lobby and select a different one there.
		<br/>
		<br/>More information about the different roles and more in-depth handbooks on for example Pilots, UAV and HQ can be found on our wiki. You can find a link to the 77th Wiki <execute expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">here</execute>.
		"
	]
];
/*/================================= Roles End/*/

/*/================================= Rules Start/*/


player createDiaryRecord [
	'QS_diary_rules',
	[
		'Notes on Support Assets',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Notes on Support Assets (CAS / CAP / UAV / ARMOR / MORTAR and ARTILLERY / OTHER)</font>
		<br/>
		<br/> - Please make sure to read and understand the associated Handbooks (Pilot, UAV) and Entries on the Wiki to avoid unnecessary mistakes. You can find them in the 77th Wiki and a link to it <execute expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">here</execute>.
		<br/>
		<br/> - All support assets must be called in by squad leaders (Infantry Squads who are near the target).
		<br/>
		<br/> - Do not engage any objectives and/or enemies without being called in on that specific target by a Squadleader in the mission!
		<br/>
		<br/> - Do not ram targets and/or objectives.
		<br/>
		<br/> - Do not fly/drive near marked objectives unless necessary to complete a mission to avoid unnecessary loss of assets.
		<br/>
		<br/> - Failure to comply to the Rules of Engagement may result in administrative action without warning!
		"
	]
];

player createDiaryRecord [
	'QS_diary_rules',
	[
		'Notes on Pilot Role',
		"
		<br /><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Notes on Pilot Role</font>
		<br />
		<br /> - Pilots have their own specialized role, therefore they come with additional responsibilities. If you have any issues with any pilot, please report the player to an admin.
		<br />
		<br /> - Please make sure to read and understand the Pilot Handbook to avoid unnecessary mistakes. It is linked in the channel description of both Pilot channels on teamspeak or you can find it in the 77th Wiki!
		<br />
		<br /> - You MUST be on our Teamspeak server--in the correct channel--and communicable prior to taking any aircraft.
		<br />
		<br /> - You MUST be a pilot to fly an aircraft.
		<br />
		<br /> - If you are an inexperienced pilot, please consider the time and enjoyment of others. The editor is there for a reason.
		<br />
		<br /> - You must be able to plan a safe flightpath to a mission and back to base, if you are unable to so, you may be asked to leave the role.
		<br />
		<br /> - You must be able to fly and land any aircraft with reasonable competence, if you do not have experience in any aircraft, you may be asked to leave the role.
		<br />
		<br /> - This is a public server. Helicopters are not private/reserved transport. A Pilots primary role is to provide timely general transport to and from objectives.
		<br />
		<br /> - Pilots must not play infantry while in a pilot slot.
		<br />
		<br /> - Flying over/Landing or slinging objects/vehicles inside of infantry spawn may result in a warning or a kick for first offense.
		<br />
		<br /> - Ramming enemy or intentional crashing may result in a ban without warning, try to preserve assets.
		<br />
		<br /> - All the above is subject to discretion of the admins.
		<br />
		<br /> - If you see a player in violation of the above, contact an admin on the server or via Teamspeak.
		"
	]
];
player createDiaryRecord [
	'QS_diary_rules',
	[
		'77th JSOC Wiki',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>77th JSOC Wiki</font>
		<br/>
		<br/>More information about the different roles, rules and server workings can be found on our wiki. You can find a link to the 77th Wiki <execute expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">here</execute>.
		<br/>
		"
	]
];
player createDiaryRecord [
//(missionNamespace getVariable ['QS_missionConfig_splash_serverRules',''])
	'QS_diary_rules',
	[
		'Server Rules',
		"
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Server Rules</font>
		<br/> <font color='#ffdb14'>1.</font> Hacking and mission exploitation will not be tolerated.
		<br/> <font color='#ffdb14'>2.</font> Intentional team-killing will not be tolerated.
		<br/> <font color='#ffdb14'>3.</font> Unnecessary destruction of BLUFOR vehicles will not be tolerated.
		<br/> <font color='#ffdb14'>4.</font> Verbal abuse and bullying will not be tolerated.
		<br/> <font color='#ffdb14'>5.</font> Firing a weapon on base--unless at an enemy--may result in a Kick/Temp ban.
		<br/> <font color='#ffdb14'>6.</font> Griefing and obstructive play will not be tolerated.
		<br/> <font color='#ffdb14'>7.</font> Excessive mic spamming, especially of Side and Global channels, will not be tolerated.
		<br/> <font color='#ffdb14'>8.</font> Do not disobey admins or HQ (an admin’s word is final)
		<br/> <font color='#ffdb14'>9.</font> No lone wolfing (players must be in a squad)
		<br/> <font color='#ffdb14'>10.</font> Only HQ can allow vehicle usage (vehicles stay at base until permission is granted by HQ)
		<br/> <font color='#ffdb14'>11.</font> Side channel voice chat is reserved for admins and HQ only
		<br/> <font color='#ffdb14'>12.</font> HQ, pilots and UAV need to be on Teamspeak (microphone not required for pilots and UAV)
		<br/> <font color='#ffdb14'>13.</font> When there is no HQ, pilots are to sort out the squads
		<br/> <font color='#ffdb14'>14.</font> CAP/CAS/UAV/Artillery are not to take down any targets unless called in by squad leaders
		<br/> <font color='#ffdb14'>15.</font> Follow the Chain of Command: ADMINS → HQ → PILOTS → SQUAD LEADERS
		<br/> <font color='#ffdb14'>16.</font> Respect other players. If you are having issues with another player, contact an admin. If you have a complaint, post it on the 77th JSOC forums
		<br/> <font color='#ffdb14'>17.</font> Recruitment and/or Advertisment is not allowed on this server.
		<br/> <font color='#ffdb14'>18.</font> An infantry squad consists of minimum 6 players and maximum of 16 players.
		<br/> <font color='#ffdb14'>19.</font> No TS only squads, if a squad has teammate not on TS the squad is not allowed to exclude him.
		<br/> <font color='#ffdb14'>20.</font> Squad names are allowed to be only within the Phoenetic Alphabet. Alpha, Bravo, Charlie and etc.
		<br/> If you see a player in violation of the above, contact an Administrator or PR representative (TeamSpeak).
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>The aforementioned rules can only cover the basics. Therefore our admins will moderate or correct any situation they find to be in contradiction or not in line with our goals for the server. To get a better understanding please check out the 77th JSOC Wiki.</font>
		"
	]
];

/*/-------------------------------------------------- Mods/*/

// Enable or change this if you like
player createDiaryRecord [
	'QS_diary_mods',
	[
	'Mods Allowed',
	"
	<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>77th JSOC Public Server Mods</font>
	<br/>
	<br/>You can find a list of all Mods allowed here (subject to change without notice) on our forums. You can find a link to our website <execute expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">here</execute>.
	<br/>
	<br/>Alternatively you can search the Steam Workshop Collection under the following name yourself: <font color='#ffdb14'>77th JSOC | Public Servers Mod Collection (Official)</font> by Ateir
	"
	]
];

/*/================================= Rules End/*/

/*/================================= Teamspeak/*/

player createDiaryRecord [
	'QS_diary_teamspeak',
	[
		'77th JSOC Teamspeak Server',
		format ['
		<br/><font size= "14" color="#ffdb14" face="RobotoCondensedBold">77th JSOC Teamspeak Server</font>
		<br/>
		<br/>Address: <font color="#ffdb14">%1</font>
		<br/>
		<br/>Visitors and guests welcome!
		',(missionNamespace getVariable ['QS_missionConfig_commTS',''])]
	]
];

/*/================================= Donate/*/
/* <br />You can donate via Patreon. You can find our Patreon here: <execute expression='nul = [] spawn QS_fnc_clientDiaryLinks'>https://www.patreon.com/77th_jsoc</execute> */
player createDiaryRecord [
	'QS_diary_donate',
	[
		'Donate to the 77th JSOC',
		"
		                               <img width='180' image='jsoc\images\77th_logo.paa'/>
		<br />
		<br /><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Why donate to the 77th JSOC?</font>
		<br />
		<br />If you enjoy playing on our servers consider making a donation. All donations are being used to keep the public servers running and only donations will keep it running.
		<br />
		<br /><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Are there benefits for a player directly by donating?</font>
		<br />
		<br />The 77th JSOC offers certain perks like access to special skins for Donators depending on the amount of their donation. For more information please visit our Patreon page.
		<br />
		<br /><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Where and how do I donate?</font>
		<br />
		<br />You can donate via Patreon. You can find a link to our Patreon page <execute expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">here</execute>.
		"
	]
];


/*/================================= Credits/*/
player createDiarySubject ['QS_diary_credits','Credits'];				// EULA relevant line.

////////////////////////////////// EDIT BELOW ///////////////////////////////////////

player createDiaryRecord [
	'QS_diary_credits',
	[
		'77th JSOC Development Team',
		"
		                               <img width='180' image='jsoc\images\77th_logo.paa'/>
		<br/>
		<br/>This mission is based up the Apex Framework by Quicksilver and heavily modified by the 77th JSOC Development Team!
		<br/>
		<br/><font size= '14' color='#ffdb14' face='RobotoCondensedBold'>Main Developers:</font>
		<br/>
		<br/>Knight, Madtrap, Noilliz, Alxander and McDodelijk.
		<br/>
		<br/>Special Thanks to Ateir and Thefatgerbil!
		"
	]
];

////////////////////////////////// EDIT ABOVE ///////////////////////////////////////

////////////////////////////////// DO NOT EDIT BELOW ///////////////////////////////////////
/*/
Please do not tamper with the below lines.
Part of license for use of this framework is to maintain accessibility for players to donate to the Apex Framework developer.
Servers which have made it difficult or impossible for players to access this link are in violation of the EULA.
/*/
player createDiaryRecord [
	'QS_diary_credits',
	[
	"Developer",
	"<br/>
	<br/><font size='20'>Quiksilver</font>
	<br/>
	<br/>This framework is the product of many thousands of hours of doing battle in notepad++ over a number of years (2013-2017). We sincerely hope you enjoy your experience!
	<br/>
	<br/>If you would like to show your appreciation but do not know how, you can
	<br/>
	<br/><executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">Donate to Quiksilver (Patreon)</executeClose>
	<br/>
	<br/>Stay safe out there, soldier!"
	]
];
