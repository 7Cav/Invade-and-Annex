class NL_ZeusPoints_Dialog {
  idd = 7790;
  movingEnabled = false;

  class controls {

    class RscPictureBackgroundMain: RscPicture
    {
    	idc = 1200;
    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = 0.299998;
    	y = 0.5;
    	w = 0.35;
    	h = 0.24;
    };
    class RscPictureBackgroundBottom: RscPicture
    {
    	idc = 1201;
    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.3;
    	y = 0.74;
    	w = 0.35;
    	h = 0.02;
    };
    class RscTextPoints: RscText
    {
    	idc = 1000;
    	text = "Points:"; //--- ToDo: Localize;
    	x = 0.325;
    	y = 0.48;
    	w = 0.1;
    	h = 0.1;
    };
    class RscTextAddRemove: RscText
    {
    	idc = 1001;
    	text = "Add/Remove"; //--- ToDo: Localize;
    	x = 0.325;
    	y = 0.56;
    	w = 0.2;
    	h = 0.1;
    };
    class RscEditPoints: RscEdit
    {
    	idc = 1400;
    	x = 0.5625;
    	y = 0.52;
    	w = 0.0625;
    	h = 0.06;
    };
    class RscComboAddRemove: RscCombo
    {
    	idc = 2100;
    	x = 0.4875;
    	y = 0.6;
    	w = 0.1375;
    	h = 0.04;
    };
    class RscButtonOkey: RscButton
    {
    	idc = 1600;
    	text = "Ok"; //--- ToDo: Localize;
      action = "[TRUE] spawn (missionNamespace getVariable 'NL_fnc_pointsButton')";
    	x = 0.325;
    	y = 0.68;
    	w = 0.1375;
    	h = 0.04;
    };
    class RscButtonCancel: RscButton
    {
    	idc = 1601;
    	text = "Cancel"; //--- ToDo: Localize;
      action = "closeDialog 0";
    	x = 0.4875;
    	y = 0.68;
    	w = 0.1375;
    	h = 0.04;
    };
    class RscPictureBackgroundTop: RscPicture
    {
    	idc = 1205;
    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
    	x = 0.3;
    	y = 0.492;
    	w = 0.35;
    	h = 0.01;
    };
  };
};
