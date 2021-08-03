  class NL_Objective_Dialog {
  idd = 7770;
  movingEnabled = false;
  duration = 3;
  name = "NL_Objective_Dialog";
  onLoad = "with uiNameSpace do { NL_Objective_Dialog = _this select 0 }";
  class controls {
    /* #safezone is wierd
    $[
      1.063,
      ["Test",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
      [1200,"rscPictureBackground",[1,"#(argb,8,8,3)color(0.118,0.11,0.114,0.9)",["0.331081 * safezoneW + safezoneX","-0.00182001 * safezoneH + safezoneY","0.337825 * safezoneW","0.0643346 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
      [1201,"rscPictureBackgroundLeft",[1,"#(argb,8,8,3)color(0.992,0.843,0,0.9)",["0.331081 * safezoneW + safezoneX","-0.00182001 * safezoneH + safezoneY","0.00374387 * safezoneW","0.0643346 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
      [1000,"rscTextIntelObjective",[1,"OBJECTIVE COMPLETE",["0.337372 * safezoneW + safezoneX","-0.0181 * safezoneH + safezoneY","0.154349 * safezoneW","0.0643346 * safezoneH"],[0.6,0.6,0.6,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],["sizeEx = 0.04","font = |Puristalight|;"]],
      [1001,"rscTextObjectivePlace",[1,"KAVALA ANNEXED",["0.337372 * safezoneW + safezoneX","0.00764001 * safezoneH + safezoneY","0.400832 * safezoneW","0.0643346 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],["sizeEx = 0.06;","font = |PuristaMedium|;"]],
      [1002,"rscTextAP",[1,"AP",["0.64355 * safezoneW + safezoneX","-0.000279996 * safezoneH + safezoneY","0.0460762 * safezoneW","0.077202 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["size=0.04","font = |PuristaMedium|;"]],
      [1003,"rscTextPoints",[1,"+1000",["0.600372 * safezoneW + safezoneX","0.01446 * safezoneH + safezoneY","0.0492608 * safezoneW","0.077202 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["align = |right|","font = |PuristaMedium|;","size=0.06"]],
      [1202,"rscPictureIcon",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.634166 * safezoneW + safezoneX","0.01446 * safezoneH + safezoneY","0.0237188 * safezoneW","0.0385 * safezoneH"],[0.6,0.6,0.6,0.2],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
    ]
    */

    class rscPictureBackground: RscPicture
    {
    	idc = 1201;

    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,0.9)";
      /*
      x = 0.0905155;
    	y = -0.412385;
    	w = 0.818969;
    	h = 0.116972;
      */
      x = 0.331081 * safezoneW + safezoneX;
      y = -0.00182001 * safezoneH + safezoneY;
      w = 0.337825 * safezoneW;
      h = 0.0643346 * safezoneH;
    };
    class rscPictureBackgroundLeft: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.992,0.843,0,0.9)";
      /*
      x = 0.0905155;
    	y = -0.412385;
    	w = 0.00907604;
    	h = 0.116972;
      */
      x = 0.331081 * safezoneW + safezoneX;
      y = -0.00182001 * safezoneH + safezoneY;
      w = 0.00374387 * safezoneW;
      h = 0.0643346 * safezoneH;
    };
    class rscTextIntelObjective: RscText
    {
    	idc = 1000;
      sizeEx = 0.04;
      shadow = 0;
      font = "Puristalight";
    	text = "OBJECTIVE COMPLETE"; //--- ToDo: Localize;
      colorText[] = {0.6,0.6,0.6,1};
      /*
      x = 0.109424;
    	y = -0.44216;
    	w = 0.37418;
    	h = 0.116972;
      */
      x = 0.337372 * safezoneW + safezoneX;
      y = -0.0181 * safezoneH + safezoneY;
      w = 0.154349 * safezoneW;
      h = 0.0643346 * safezoneH;
    };
    class rscTextObjectivePlace: RscText
    {
    	idc = 1001;
      sizeEx = 0.06;
      shadow = 0;
      font = "PuristaMedium";
    	text = "KAVALA ANNEXED"; //--- ToDo: Localize;
      /*
      x = 0.105642;
    	y = -0.395371;
    	w = 0.971715;
    	h = 0.116972;
      */
      x = 0.337372 * safezoneW + safezoneX;
      y = 0.00764001 * safezoneH + safezoneY;
      w = 0.400832 * safezoneW;
      h = 0.0643346 * safezoneH;
    };
    class rscTextAP: RscText
    {
    	idc = 1002;
      size = 0.04;
      font = "PuristaMedium";
    	text = "AP"; //--- ToDo: Localize;
      /*
      x = 0.847915;
    	y = -0.409408;
    	w = 0.116996;
    	h = 0.140367;
      */
      x = 0.64355 * safezoneW + safezoneX;
      y = -0.000279996 * safezoneH + safezoneY;
      w = 0.0460762 * safezoneW;
      h = 0.077202 * safezoneH;
    };
    class rscTextPoints: RscStructuredText
    {
    	idc = 1003;
    	size = 0.06;

    	text = "+1000"; //--- ToDo: Localize;
      /*
      x = 0.74581;
    	y = -0.38261;
    	w = 0.116996;
    	h = 0.140367;
      */
      x = 0.600372 * safezoneW + safezoneX;
      y = 0.01446 * safezoneH + safezoneY;
      w = 0.0492608 * safezoneW;
      h = 0.077202 * safezoneH;
      class Attributes {
        align = "right";
        font = "PuristaMedium";
      };
    };
    class rscPictureIcon: RscPicture
    {
      idc = 1203;
      text = "";
      colorText[] = {0.6,0.6,0.6,0.2};
      /*
      x = 0.825225;
    	y = -0.395371;
    	w = 0.0575;
    	h = 0.07;
      */
      x = 0.634166 * safezoneW + safezoneX;
      y = 0.01446 * safezoneH + safezoneY;
      w = 0.0237188 * safezoneW;
      h = 0.0385 * safezoneH;
    };
  };
};

/*
class NL_Objective_Dialog
{
  idd = 7770;
  movingEnabled = false;
  duration = 3;
  name = "NL_Objective_Dialog";
  onLoad = "with uiNameSpace do { NL_Objective_Dialog = _this select 0 }";

  class controls
  {
    class rscPictureBackground: RscPicture
    {
    	idc = 1201;

    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,0.9)";
    	x = 0.0905155;
    	y = -0.412385;
    	w = 0.818969;
    	h = 0.116972;
    };
    class rscPictureBackgroundLeft: RscPicture
    {
    	idc = 1202;

    	text = "#(argb,8,8,3)color(0.992,0.843,0,0.9)";
    	x = 0.0905155;
    	y = -0.412385;
    	w = 0.00907604;
    	h = 0.116972;
    };
    class rscTextIntelObjective: RscText
    {
    	idc = 1000;
    	shadow = 0;
    	font = "Puristalight";

    	text = "OBJECTIVE COMPLETE"; //--- ToDo: Localize;
    	x = 0.109424;
    	y = -0.44216;
    	w = 0.37418;
    	h = 0.116972;
    	colorText[] = {0.6,0.6,0.6,1};
    };
    class rscTextObjectivePlace: RscText
    {
    	idc = 1001;
    	shadow = 0;
    	font = "PuristaMedium";

    	text = "KAVALA ANNEXED"; //--- ToDo: Localize;
    	x = 0.105642;
    	y = -0.395371;
    	w = 0.971715;
    	h = 0.116972;
    };
    class rscTextAP: RscText
    {
    	idc = 1002;
    	size = 0.04;
    	font = "PuristaMedium";

    	text = "AP"; //--- ToDo: Localize;
    	x = 0.847915;
    	y = -0.409408;
    	w = 0.116996;
    	h = 0.140367;
    };
    class rscTextPoints: RscStructuredText
    {
    	idc = 1003;
    	size = 0.06;

    	text = "+1000"; //--- ToDo: Localize;
    	x = 0.74581;
    	y = -0.38261;
    	w = 0.116996;
    	h = 0.140367;
    };
    class rscPictureIcon: RscPicture
    {
    	idc = 1203;

    	text = "#(argb,8,8,3)color(1,1,1,1)";
    	x = 0.825225;
    	y = -0.395371;
    	w = 0.0575;
    	h = 0.07;
    	colorText[] = {0.6,0.6,0.6,0.2};
    };
  };
}; */
