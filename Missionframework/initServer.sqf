/*
File: initServer.sqf
Author:

	Quiksilver

Last modified:

	24/12/2014 ArmA 1.36 by Quiksilver

Description:

	Server Init
____________________________________________________________________*/

if (!(_this select 0)) exitWith {}; // Not server
[] call compile PreprocessFileLineNumbers "@invade_and_annex\init.sqf";
{
     if (!isNull (getAssignedCuratorUnit _x)) then {
          _x addCuratorEditableObjects [allplayers,true];
     };
} count allCurators;

[] spawn NL_fnc_jet;
