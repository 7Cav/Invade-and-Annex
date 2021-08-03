
class NL_fobRespawn_Dialog {
  idd = 7730;
  movingEnabled = false;

  class controls {
    class rscPictureBackgroundBottem: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.2;
    	y = 0.96;
    	w = 0.6;
    	h = 0.04;
    };
    class rscPictureBackground: RscPicture
    {
    	idc = 1203;

    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = 0.2;
    	y = 0.04;
    	w = 0.6;
    	h = 0.92;
    };
    class rscPictureBackgroundTop: RscPicture
    {
    	idc = 1204;

    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
      x = 0.2;
    	y = 0.03;
    	w = 0.6;
    	h = 0.01;
    };
    class rscLogo: RscPicture
    {
    	idc = 1200;

    	text = "jsoc\images\77th_logo.paa";
      x = 0.225;
    	y = 0.06;
    	w = 0.125;
    	h = 0.16;
    };
    class rscButtonSetState: RscButton
    {
    	idc = 1600;
    	shadow = 0;
    	font = "PuristaMedium";
      action = "[TRUE] spawn (missionNamespace getVariable 'NL_fnc_respawnSetState')";
    	colorFocused[] = {0.855,0.741,0,1};
    	colorDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundActive[] = {0.992,0.843,0,1};

    	text = "TOGGLE STATE"; //--- ToDo: Localize;
      x = 0.5125;
    	y = 0.84;
    	w = 0.2625;
    	h = 0.08;
    	colorBackground[] = {0.855,0.741,0,1};
    };
    class rscButtonAllowSquad: RscButton
    {
    	idc = 1601;
    	shadow = 0;
    	font = "PuristaMedium";
    	action = "[FALSE] spawn (missionNamespace getVariable 'NL_fnc_respawnSetState')";
    	colorFocused[] = {0.855,0.741,0,1};
    	colorDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundActive[] = {0.992,0.843,0,1};

    	text = "ALLOW SQUAD"; //--- ToDo: Localize;
    	x = 0.225;
    	y = 0.84;
    	w = 0.2625;
    	h = 0.08;
    	colorBackground[] = {0.855,0.741,0,1};
    };
    class rscButtonClose: RscButton
    {
    	idc = 1602;
    	size = 2;
    	action = "closeDialog 0";
    	shadow = 0;
    	font = "PuristaMedium";
    	colorFocused[] = {0.051,0.051,0.051,1};
    	colorDisabled[] = {0.051,0.051,0.051,1};
    	colorBackgroundDisabled[] = {0.051,0.051,0.051,1};
    	colorBackgroundActive[] = {1,0,0,1};

    	text = "X"; //--- ToDo: Localize;
    	x = 0.725;
    	y = 0.08;
    	w = 0.0500003;
    	h = 0.06;
    	colorBackground[] = {0.051,0.051,0.051,1};
    };
    class rscListboxPlayers: RscListBox
    {
    	idc = 1500;
    	type = 102;
    	font = "PuristaMedium";
    	drawSideArrows = 1;
    	idcLeft = -1;
    	idcRight = -1;

    	x = 0.2125;
    	y = 0.28;
    	w = 0.575;
    	h = 0.54;
    };
    class rscTextTopText: RscText
    {
    	idc = 1000;
    	shadow = 0;
    	font = "PuristaMedium";
      sizeEx = 0.07;
    	text = "FOB MENU"; //--- ToDo: Localize;
      x = 0.375;
    	y = 0.1;
    	w = 0.4625;
    	h = 0.06;
    };
    class rscTextWiki: RscStructuredText
    {
    	idc = 1001;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "<t colorLink='#4F4D4E'><a href='http://77th-JSOC.com/wiki1/'>77th-JSOC.com/WIKI</a></t>"; //--- ToDo: Localize;
      x = 0.375;
    	y = 0.16;
    	w = 0.4625;
    	h = 0.04;
    	colorBackground[] = {-1,-1,-1,0};
    };
    class rscTextSquad: RscText
    {
    	idc = 1002;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "Squad name"; //--- ToDo: Localize;
    	x = 0.4125;
    	y = 0.22;
    	w = 0.175;
    	h = 0.06;
    };
    class rscTextFOB: RscText
    {
    	idc = 1002;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "FOB respawn"; //--- ToDo: Localize;
    	x = 0.61;
    	y = 0.22;
    	w = 0.175;
    	h = 0.06;
    };
    class rscTextPlayer: RscText
    {
    	idc = 1002;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "Player name"; //--- ToDo: Localize;
    	x = 0.22;
    	y = 0.22;
    	w = 0.175;
    	h = 0.06;
    };
  };
};
