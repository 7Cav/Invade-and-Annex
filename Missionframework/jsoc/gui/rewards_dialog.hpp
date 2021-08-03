class NL_MissionRewards_Dialog {
  idd = 7720;
  movingEnabled = false;

  class controls {
    class rscPictureBackgroundBottem: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.1;
    	y = 0.96;
    	w = 0.8;
    	h = 0.04;
    };
    class rscPictureBackground: RscPicture
    {
    	idc = 1203;

    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = 0.1;
    	y = 0.04;
    	w = 0.8;
    	h = 0.92;
    };
    class rscPictureBackgroundTop: RscPicture
    {
    	idc = 1204;

    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
    	x = 0.1;
    	y = 0.04;
    	w = 0.8;
    	h = 0.01;
    };
    class rscPictureIconBackground: RscPicture
    {
    	idc = 1201;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.6;
    	y = 0.28;
    	w = 0.275;
    	h = 0.26;
    };
    class rscListboxBackground: RscPicture
    {
    	idc = 1206;

    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.125;
    	y = 0.28;
    	w = 0.45;
    	h = 0.06;
    };
    class rscPictureIcon: RscPicture
    {
    	idc = 1205;

    	text = "#(argb,8,8,3)color(0.482,0.518,0.506,1)";
    	x = 0.60625;
    	y = 0.33;
    	w = 0.2625;
    	h = 0.2;
    };
    class rscLogo: RscPicture
    {
    	idc = 1200;

    	text = "jsoc\images\77th_logo.paa";
    	x = 0.125;
    	y = 0.08;
    	w = 0.125;
    	h = 0.16;
    };
    class rscButtonPurchase: RscButton
    {
    	idc = 1600;
    	shadow = 0;
    	font = "PuristaMedium";
    	action = "[] spawn NL_fnc_purchaseButton";
    	colorFocused[] = {0.855,0.741,0,1};
    	colorDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundDisabled[] = {0.855,0.741,0,1};
    	colorBackgroundActive[] = {0.992,0.843,0,1};

    	text = "PURCHASE"; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.84;
    	w = 0.275;
    	h = 0.08;
    	colorBackground[] = {0.855,0.741,0,1};
    };
    class rscButtonClose: RscButton
    {
    	idc = 1601;
    	size = 2;
    	action = "closeDialog 0";
    	shadow = 0;
    	font = "PuristaMedium";
    	colorFocused[] = {0.051,0.051,0.051,1};
    	colorDisabled[] = {0.051,0.051,0.051,1};
    	colorBackgroundDisabled[] = {0.051,0.051,0.051,1};
    	colorBackgroundActive[] = {1,0,0,1};

    	text = "X"; //--- ToDo: Localize;
    	x = 0.825;
    	y = 0.08;
    	w = 0.0500003;
    	h = 0.06;
    	colorBackground[] = {0.051,0.051,0.051,1};
    };
    class rscListboxVehicles: RscListBox
    {
    	idc = 1500;
    	type = 102;
    	font = "PuristaMedium";
    	drawSideArrows = 1;
    	idcLeft = -1;
    	idcRight = -1;

      x = 0.1125;
    	y = 0.36;
    	w = 0.4625;
    	h = 0.56;

      class ListScrollBar {
        width = 0;																// width of ListScrollBar
        height = 0;																// height of ListScrollBar
        scrollSpeed = 0.01; 													// scroll speed of ListScrollBar
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; 		// Arrow
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";   		// Arrow when clicked on
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";		  		// Slider background (stretched vertically)
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";			  		// Dragging element (stretched vertically)
        color[] = {1, 1, 1, 1}; // Scrollbar color
      };
    };
    class rscStructuredTextBox: RscStructuredText
    {
    	idc = 1100;

    	text = "<t size='0.7' align='left'>RADIO TOWER DESTROYED</t>  <t size='0.7' color='#FDD700'align='right'>40</t><br /><t size='0.7' align='left'>ENEMY COMMANDER KILLED</t>  <t size='0.7' color='#FDD700'align='right'>40</t><br /><t size='0.7' align='left'>DEFENCE COMPLETE</t>  <t size='0.7' color='#FDD700'align='right'>70</t><br /><t size='0.7' align='left'>SIDE MISSION</t>  <t size='0.7' color='#FDD700'align='right'>70</t><br /><t size='0.7' align='left'>ENEMY AO ANNEXED</t>  <t size='0.7' color='#FDD700'align='right'>100</t><br /><t size='0.7' align='left'>PRIORITY TARGET</t>  <t size='0.7' color='#FDD700'align='right'>40</t><br />  "; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.56;
    	w = 0.275;
    	h = 0.16;
    	colorBackground[] = {-1,-1,-1,0};
    };
    class rscTextServerRewards: RscText
    {
    	idc = 1000;
    	shadow = 0;
    	font = "PuristaMedium";
      sizeEx = 0.07;
    	text = "Mission Rewards"; //--- ToDo: Localize;
    	x = 0.275;
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
    	x = 0.275;
    	y = 0.16;
    	w = 0.4625;
    	h = 0.04;
    	colorBackground[] = {-1,-1,-1,0};
    };
    class rscTextVehiclename: RscText
    {
    	idc = 1002;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "Vehiclename"; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.2748;
    	w = 0.25;
    	h = 0.06;
    };
    class rscTextPointstext: RscText
    {
    	idc = 1003;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "ASSET POINTS"; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.74;
    	w = 0.5;
    	h = 0.04;
    };
    class rscTextPointsCurrentPoints: RscText
    {
    	idc = 1004;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "0"; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.78;
    	w = 0.1;
    	h = 0.04;
    	colorText[] = {0.992,0.843,0,1};
    };
    class RscComboTypes: RscCombo
    {
    	idc = 2100;

    	x = 0.305;
    	y = 0.292;
    	w = 0.2625;
    	h = 0.04;
    };
    class rscTextVehicleType: RscText
    {
    	idc = 1000;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "Vehicle Type"; //--- ToDo: Localize;
    	x = 0.125;
    	y = 0.276;
    	w = 0.175;
    	h = 0.06;
    };
  };
};
