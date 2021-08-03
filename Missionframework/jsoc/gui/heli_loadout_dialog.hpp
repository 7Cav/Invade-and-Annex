class NL_dynamicHeliLoadouts_Dialog {
  idd = 7750;
  movingEnabled = false;

  class controls {
    class rscPictureBackground: RscPicture {
    	idc = 1200;
    	text = "#(argb,8,8,3)color(0.118,0.11,0.114,1)";
    	x = -0.2;
    	y = 0;
    	w = 1.3875;
    	h = 0.98;
    };

    class rscPictureBackgroundBottem: RscPicture {
    	idc = 1201;
    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = -0.2;
    	y = 0.98;
    	w = 1.3875;
    	h = 0.04;
    };

    class rscPictureBackgroundTop: RscPicture {
    	idc = 1202;
    	text = "#(argb,8,8,3)color(0.992,0.843,0,1)";
    	x = -0.2;
    	y = 0;
    	w = 1.3875;
    	h = 0.01;
    };

    class RscPictureHeli: RscPicture {
    	idc = 1204;
    	text = "#(argb,8,8,3)color(1,1,1,0)";
    	x = -0.090;
    	y = 0.02;
    	w = 1.125;
    	h = 0.82;
    };

    class rscPictureVehicleNameBackground: RscPicture {
    	idc = 1203;
    	text = "#(argb,8,8,3)color(0.067,0.067,0.067,1)";
    	x = -0.175;
    	y = 0.06;
    	w = 0.3625;
    	h = 0.04;
    };

    class rscTextNameHeli: RscText {
    	idc = 1000;
    	text = "Name of helicopter"; //--- ToDo: Localize;
    	x = -0.175;
    	y = 0.06;
    	w = 0.405305;
    	h = 0.04;
    };

    class rscComboHardpoint04: RscCombo {
    	idc = 2100;
    	x = -0.0375;
    	y = 0.64;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint05: RscCombo {
    	idc = 2101;
    	x = 0.1375;
    	y = 0.64;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint04: RscText {
    	idc = 1001;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = -0.0375;
    	y = 0.6;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint05: RscText {
    	idc = 1002;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.1375;
    	y = 0.6;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint01: RscCombo {
    	idc = 2102;
    	x = -0.0375;
    	y = 0.4;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint01: RscText {
    	idc = 1003;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = -0.0375;
    	y = 0.36;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint03: RscCombo {
    	idc = 2103;
    	x = 0.05;
    	y = 0.52;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint03: RscText {
    	idc = 1004;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.05;
    	y = 0.48;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint02: RscCombo {
    	idc = 2104;
    	x = 0.1375;
    	y = 0.4;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint02: RscText {
    	idc = 1005;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.1375;
    	y = 0.36;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint10: RscCombo {
    	idc = 2105;
    	x = 0.9;
    	y = 0.64;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint10: RscText {
    	idc = 1006;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.9;
    	y = 0.6;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint09: RscCombo {
    	idc = 2106;
    	x = 0.725;
    	y = 0.64;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint09: RscText {
    	idc = 1007;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.725;
    	y = 0.6;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint08: RscCombo {
    	idc = 2107;
    	x = 0.8125;
    	y = 0.52;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint08: RscText {
    	idc = 1008;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.8125;
    	y = 0.48;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint07: RscCombo {
    	idc = 2108;
    	x = 0.9;
    	y = 0.4;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint07: RscText {
    	idc = 1009;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.9;
    	y = 0.36;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboHardpoint06: RscCombo {
    	idc = 2109;
    	x = 0.725;
    	y = 0.4;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscTextHardpoint06: RscText {
    	idc = 1010;
    	text = "Hitpoint"; //--- ToDo: Localize;
    	x = 0.725;
    	y = 0.36;
    	w = 0.1375;
    	h = 0.04;
    };

    class RscButtonRearm: RscButton {
    	idc = 1600;
    	text = "Rearm"; //--- ToDo: Localize;
    	x = 0.25;
    	y = 0.86;
    	w = 0.15;
    	h = 0.1;
		action = "[] spawn NL_fnc_btnWeaponDynDlg";
	};

    class rscButtonRefuel: RscButton {
    	idc = 1601;
    	text = "Refuel"; //--- ToDo: Localize;
    	x = 0.425;
    	y = 0.86;
    	w = 0.15;
    	h = 0.1;
		action = "[] spawn NL_fnc_btnRefuelDynDlg";
	};

    class rscButtonRepair: RscButton {
    	idc = 1602;
    	text = "Repair"; //--- ToDo: Localize;
    	x = 0.6;
    	y = 0.86;
    	w = 0.15;
    	h = 0.1;
		action = "[] spawn NL_fnc_btnRepairDynDlg";
	};

    class rscButtonClose: RscButton {
    	idc = 1603;
    	action = "closeDialog 0";
    	text = "x"; //--- ToDo: Localize;
    	x = 1.1125;
    	y = 0.04;
    	w = 0.0375;
    	h = 0.06;
    	colorBackground[] = {0.6,0,0,1};
    };

    class rscTextLoadout: RscText {
    	idc = 1025;
    	text = "Loadout"; //--- ToDo: Localize;
    	x = -0.175;
    	y = 0.12;
    	w = 0.1375;
    	h = 0.04;
    };

    class rscComboLoadout: RscCombo {
    	idc = 2125;
    	x = -0.175;
    	y = 0.16;
    	w = 0.1375;
    	h = 0.04;
    };

    class RscButtonSelect: RscButton {
    	idc = 1604;
    	text = "SELECT"; //--- ToDo: Localize;
    	x = -0.025;
    	y = 0.16;
    	w = 0.075;
    	h = 0.04;
    };

    class RscButtonEngine: RscButton {
      idc = 1605;
      text = "Toggle Engine"; //--- ToDo: Localize;
      x = -0.1875;
      y = 0.92;
      w = 0.15;
      h = 0.04;
      action = "cameraOn engineOn !(isEngineOn cameraOn);";
    };
  };
};
