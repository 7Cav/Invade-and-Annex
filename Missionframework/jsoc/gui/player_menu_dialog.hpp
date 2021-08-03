
class NL_Player_Menu_Dialog {
  idd = 7760
  movingEnabled = false;

  class controls {

    class rscPictureBackground: RscPicture
    {
    	idc = 1203;

    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = 0.225;
    	y = 0.06;
    	w = 0.55;
    	h = 1.06;
    };
    class rscPictureBackgroundBottem: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.225;
    	y = 1.12;
    	w = 0.55;
    	h = 0.02;
    };
    class rscPictureBackgroundTop: RscPicture
    {
    	idc = 1204;

    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
    	x = 0.225;
    	y = 0.06;
    	w = 0.55;
    	h = 0.01;
    };
    class RscPictureTextVehicleManifestInfo: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.248864;
    	y = 0.731784;
    	w = 0.444;
    	h = 0.06;
    };
    class RscPictureTextCompassInfo: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.25;
    	y = 0.611111;
    	w = 0.444;
    	h = 0.06;
    };
    class RscPictureTextJumpInfo: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.25;
    	y = 0.490101;
    	w = 0.444;
    	h = 0.06;
    };
    class RscPictureTextEarplugsInfo: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.249874;
    	y = 0.370101;
    	w = 0.444;
    	h = 0.06;
    };
    class RscPictureTextHUDInfo: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.249874;
    	y = 0.253267;
    	w = 0.444;
    	h = 0.06;
    };
    class RscPictureTextPoints: RscPicture
    {
      idc = 1202;

      text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
      x = 0.25;
      y = 0.82;
      w = 0.5;
      h = 0.18;
    };
    class RscPictureTextPointsBox: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.051,0.051,0.051,1)";
    	x = 0.54;
    	y = 0.8832;
    	w = 0.21;
    	h = 0.06;
    };
    class rscTextHUD: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Player HUD"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.2;
    	w = 0.1375;
    	h = 0.04;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextPlayerMenu: RscText
    {
    	idc = 1001;
      sizeEx = 0.07;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Player Menu"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.1;
    	w = 0.2125;
    	h = 0.08;
    };
    class rscButtonClose: RscButton
    {
    	idc = 1601;
    	action = "closeDialog 0";
      shadow = 0;
      font = "PuristaMedium";
    	text = "X"; //--- ToDo: Localize;
    	x = 0.7125;
    	y = 0.12;
    	w = 0.0375;
    	h = 0.04;
    };
    class rscButtonTAWVD: RscButton
    {
    	idc = 1602;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Viewing Distance"; //--- ToDo: Localize;
    	x = 0.53144;
    	y = 0.12;
    	w = 0.1625;
    	h = 0.04;
      action = "closeDialog 0; [] spawn TAWVD_fnc_openMenu";
    	colorBackground[] = {0.067,0.067,0.067,1};
    };
    class rscTextHUDInfo: RscText
    {
    	idc = 1000;
      sizeEx = 0.03;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Interface displaying player health, stamina and armour."; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.26;
    	w = 0.625;
    	h = 0.04;
    	colorText[] = {0.4,0.4,0.4,1};
    };
    class rscTextEarplugs: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Earplugs"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.32;
    	w = 0.1375;
    	h = 0.04;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextEarplugsInfo: RscText
    {
    	idc = 1000;
      sizeEx = 0.03;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Once enabled, use the scroll wheel to put on/off earplugs."; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.38;
    	w = 0.625;
    	h = 0.04;
    	colorText[] = {0.4,0.4,0.4,1};
    };
    class rscTextJump: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Jump"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.44;
    	w = 0.1375;
    	h = 0.04;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextJumpInfo: RscText
    {
    	idc = 1000;
      sizeEx = 0.03;
      shadow = 0;
      font = "PuristaMedium";
    	text = "When sprinting, press V to jump when enabled."; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.5;
    	w = 0.625;
    	h = 0.04;
    	colorText[] = {0.4,0.4,0.4,1};
    };
    class rscTextCompass: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Compass"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.56;
    	w = 0.1375;
    	h = 0.04;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextCompassInfo: RscText
    {
    	idc = 1000;
      sizeEx = 0.03;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Displays compass at top of screen when enabled."; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.62;
    	w = 0.625;
    	h = 0.04;
    	colorText[] = {0.4,0.4,0.4,1};
    };
    class rscTextVehicleManifest: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Vehicle Manifest"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.68;
    	w = 0.1875;
    	h = 0.04;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextVehicleManifestInfo: RscText
    {
    	idc = 1000;
      sizeEx = 0.03;
      shadow = 0;
      font = "PuristaMedium";
    	text = "Interface displaying players in your vehicle (small FPS cost)."; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.74;
    	w = 0.625;
    	h = 0.04;
    	colorText[] = {0.4,0.4,0.4,1};
    };
    class RscCheckboxHUD: RscCheckBox
    {
    	idc = 2800;

    	x = 0.7;
    	y = 0.24;
    	w = 0.0625;
    	h = 0.08;
    };
    class rscCheckboxEarplugs: RscCheckBox
    {
    	idc = 2801;

    	x = 0.7;
    	y = 0.36;
    	w = 0.0625;
    	h = 0.08;
    };
    class rscCheckboxJump: RscCheckBox
    {
    	idc = 2802;

    	x = 0.7;
    	y = 0.48;
    	w = 0.0625;
    	h = 0.08;
    };
    class rscCheckboxCompass: RscCheckBox
    {
    	idc = 2803;

    	x = 0.7;
    	y = 0.6;
    	w = 0.0625;
    	h = 0.08;
    };
    class rscCheckboxVehicleManifest: RscCheckBox
    {
    	idc = 2804;

    	x = 0.7;
    	y = 0.72;
    	w = 0.0625;
    	h = 0.08;
    };
    class rscStructuredTextForum: RscStructuredText
    {
    	idc = 1100;

    	text = "<t font='PuristaMedium' size='1.35'><a href='http://77th-jsoc.com/forum/index.php'><img image='jsoc\images\forumbutton.jpg'/></a></t>"; //--- ToDo: Localize;
      x = 0.242551;
    	y = 1.03;
    	w = 0.2625;
    	h = 0.06;
    };
    class rscStructuredTextWIKI: RscStructuredText
    {
    	idc = 1100;

    	text = "<t font='PuristaMedium' size='1.35'><a href='http://www.77th-jsoc.com/wiki1/77th_JSOC'><img image='jsoc\images\wikibutton.jpg'/></a></t>"; //--- ToDo: Localize;
      x = 0.511364;
    	y = 1.03;
    	w = 0.275;
    	h = 0.06;
    };
    class rscStructuredTextPoints: RscStructuredText
    {
    	idc = 1100;

    	text = "<t font='PuristaMedium' size='0.7' color='#999999' align='left'>RADIO TOWER DESTROYED</t>  <t size='0.7' color='#FDD700'align='right'>25</t><br /><t size='0.7' color='#999999' align='left'>ENEMY COMMANDER KILLED</t>  <t size='0.7' color='#FDD700'align='right'>25</t><br /><t size='0.7' color='#999999' align='left'>DEFENCE COMPLETE</t>  <t size='0.8' color='#FDD700'align='right'>25</t><br /><t size='0.7' color='#999999' align='left'>SIDE MISSION</t>  <t size='0.7' color='#FDD700'align='right'>150</t><br /><t size='0.7' color='#999999' align='left'>ENEMY AO ANNEXED</t><t size='0.7' color='#FDD700'align='right'>150</t><br />"; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.839;
    	w = 0.2375;
    	h = 0.16;
    };
    class rscTextPointstext: RscText
    {
    	idc = 1001;
      sizeEx = 0.04
      colorText[] = {0.6,0.6,0.6,1};
      shadow = 0;
      font = "PuristaMedium";
    	text = "ASSET POINTS"; //--- ToDo: Localize;
    	x = 0.542525;
    	y = 0.871784;
    	w = 0.2;
    	h = 0.08;
    };
    class rscTextPointsCurrentPoints: RscText
    {
    	idc = 1001;
      sizeEx = 0.045
      shadow = 0;
      font = "PuristaMedium";
    	text = "1350"; //--- ToDo: Localize;
    	x = 0.680737;
    	y = 0.871784;
    	w = 0.2125;
    	h = 0.08;
    	colorText[] = {0.992,0.843,0,1};
    };
  };
};
