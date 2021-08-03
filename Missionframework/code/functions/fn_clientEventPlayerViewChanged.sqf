/*
File: fn_clientEventPlayerViewChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	2/12/2016 A3 1.66 by Quiksilver
	
Description:

	View Changed
___________________________________________________________________*/

params ['_oldBody','_newBody','_vehicleIn','_oldCameraOn','_newCameraOn','_uav'];
player setVariable ['QS_client_playerViewChanged',TRUE,FALSE];

if(unitIsUAV _uav) then {
    _uav spawn {
        _layer = "MD_UAVTargetGrid" cutFadeOut 0;
        _layer cutrsc ["rscDynamicText","plain"];
        _display = uinamespace getvariable "BIS_dynamicText";
        _ctrl = _display displayctrl 9999;
        _pos = ctrlposition _ctrl;
        _pos set [1,1];
        _ctrl ctrlsetposition _pos;
        _ctrl ctrlsetfade 0;
        _ctrl ctrlcommit 0;
        _ctrl ctrlsetstructuredtext parseText "";
        while {(alive _this) && {(cameraOn == _this) && {(UAVControl _this select 1 == "GUNNER")}}} do {
            if (cameraView == "GUNNER" && !visibleMap) then {
                _grid = (mapGridPosition (screenToWorld [0.5,0.5]));
                _ctrl ctrlsetstructuredtext parseText format ["<t size = '.6'>Target Grid: %1</t>", _grid];
                waitUntil { !(cameraView == "GUNNER") || visibleMap || !((mapGridPosition (screenToWorld [0.5,0.5])) isEqualTo _grid)};
            } else {
                _ctrl ctrlsetstructuredtext parseText "";
                waitUntil {cameraView == "GUNNER" && !visibleMap};
            };
        };
        _ctrl ctrlsetstructuredtext parseText "";
    };
};