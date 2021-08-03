
class NL_Intro_Dialog {
  idd = 7740;
  movingEnabled = false;

  class controls {

    class rscPictureBackgroundBottem: RscPicture {
    	idc = 1202;
    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = 0.2;
    	y = 0.96;
    	w = 0.6;
    	h = 0.04;
    };

    class rscPictureBackground: RscPicture {
    	idc = 1203;
    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = 0.2;
    	y = 0.02;
    	w = 0.6;
    	h = 0.94;
    };

    class rscPictureBackgroundTop: RscPicture {
    	idc = 1204;
    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
    	x = 0.2;
    	y = 0.02;
    	w = 0.6;
    	h = 0.01;
    };

    class rscLogo: RscPicture {
    	idc = 1200;
    	text = "jsoc\images\77th_logo.paa";
    	x = 0.25;
    	y = 0.06;
    	w = 0.125;
    	h = 0.16;
    };

    class rscStructuredTextBox: RscStructuredText {
    	idc = 1100;
    	text = "<br/><br/>  <t align='center'><t size='1.4'>     Rules and Guidelines</t></t><br/><br/>  <br/>  1) Team killing is not allowed on this server<br/>  2) Do not disobey admins or HQ (admin's word is final)<br/>  3) Do not shoot at base/spawn<br/>  4) Recruitment is not allowed on this server<br/>  5) HQ, pilots and UAV operator need to be on Teamspeak<br/>      (microphone for HQ is required, for the rest of the roles it's recommended)<br/>  <br/>  <a color='#FFD700'>For more in-depth look in the rules please check the</a><br/>  <a color='#FFD700'> rules on the map section or check our wiki.</a><br/>  <br/>  Website: <a color='#FFD700' http://77th-jsoc.com' > http://77th-jsoc.com </a><br/>  Wiki: <a color='#FFD700' http://77th-jsoc.com/wiki1' > http://77th-jsoc.com/wiki </a><br/>  TeamSpeak: <a color='#FFD700' http://www.teamspeak.com/?page=downloads' > http://ts.77th-jsoc.com </a><br/>"; //--- ToDo: Localize;
    	x = 0.2375;
    	y = 0.04;
    	w = 0.525;
    	h = 0.80;
    	colorBackground[] = {-1,-1,-1,0};
    };

    class rscButtonAgree: RscButton {
    	idc = 1600;
		action = "closeDialog 0";
		colorFocused[] = { 0.6, 0, 0, 1 };
		colorBackgroundActive[] = { 0.6, 0, 0, 1 };
		colorBackground[] = {0.6,0,0,1};
		text = "Agree"; //--- ToDo: Localize;
		x = 0.3025;
		y = 0.86;
		w = 0.175;
		h = 0.08;
    };

	class rscButtonDisagree: RscButton {
    	idc = 1601;
		action = "[] spawn KN_fnc_playerDisagree";
		colorFocused[] = { 0.6, 0, 0, 1 };
		colorBackgroundActive[] = { 0.6, 0, 0, 1 };
		colorBackground[] = {0.6,0,0,1};
		text = "Disagree"; //--- ToDo: Localize;
		x = 0.5225;
		y = 0.86;
		w = 0.175;
		h = 0.08;
    };
  };
};
