/*/
File: fn_AIFireMission.sqf
Author:

	Noilliz

Last modified:

	26/11/2018 A3 1.84 by Noilliz

Description:

	Vehicle respawn script

 0 = [
 this,    //Don't touch this, its storing the current vehicle class
 30,      //Respawn delay
 50,      //Reset distance at base (distance base marker and nearest player)
 2000,    //Reset distance not at base (distance base marker and nearest player)
 TRUE,    //If HQ can lock/unlock the vehicle
 FALSE,   //if it's the baseCAS
 TRUE     //if it's locked by default
 ] spawn NL_fnc_vRegister;

__________________________________________________/*/
private [
  "_NL_v", "_NL_delay", "_NL_isLocked", "_NL_resetBase", "_NL_resetField", "_NL_base", "_NL_t", "_NL_vpos", "_NL_vdir", "_NL_isBase",
  "_NL_isBaseAA", "_NL_isBaseAA", "_NL_islockable", "_NL_Worldname", "_NL_isAltis", "_NL_isTanoa", "_NL_isMalden"
 ];

scriptName ("NL_vRespawn - " + typeOf (_this # 0));

if (!isServer) exitWith {};

// ===Initial Vehicle data check
_NL_v = _this select 0;                                     // This vehicle
_NL_delay = _this select 1;                                 // Respawn delay
_NL_isLocked = _this select 2;                              // Respawns locked
_NL_resetBase = 250;                                        // Reset distance at the base
_NL_resetField = 2500;                                      // Reset distance in the field
_NL_base = getMarkerPos "QS_marker_base_marker";            // Gets position of base
_NL_baseLocation = trim markerText "nl_marker_baselocation";// Current base
_NL_t = typeOf _NL_v;                                       // Type of the vehicle
_NL_vpos = getPos _NL_v;                                    // Position of vehicle
_NL_vdir = getDir _NL_v;                                    // Direction vehicle is facing
_NL_isBase = FALSE;
_NL_isBaseAA = FALSE;
_NL_islockable = FALSE;
_NL_Worldname = worldName;
_NL_isAltis = _NL_Worldname isEqualTo 'Altis';
_NL_isTanoa = _NL_Worldname isEqualTo 'Tanoa';
_NL_isMalden = _NL_Worldname isEqualTo 'Malden';

if (!isNil { _NL_v getVariable 'NL_vehicle_base' }) then { _NL_isBase = TRUE };
if (!isNil { _NL_v getVariable 'NL_vehicle_baseAA' }) then { _NL_isBaseAA = TRUE };
if (!isNil { _NL_v getVariable 'QS_vehicle_lockable' }) then { _NL_islockable = TRUE };
diag_log ["NL_vRespawn initial", format["Vic: %1", typeOf (_this # 0)], format["Baselocation: %1", _NL_baseLocation], format ["BaseAA: %1", _NL_isBaseAA], format ["Base: %1", _NL_isBase], format ["Pos: %1", _NL_vpos], format ["Dir: %1", _NL_vdir]];
// === Sets correct spawn location for _baseAA
if (_NL_isBaseAA) then {
  if (_NL_baseLocation == "noillizDefault") then {
    _NL_vpos = [14127.2, 16245.1, 0];
    _NL_vdir = 295;
    sleep 5;
    _NL_v setdir _NL_vdir;
    _NL_v setPos _NL_vpos;
  };
  if (_NL_baseLocation == "knightDefault") then {
    _NL_vpos = [11746.3, 11909.3, 0];
    _NL_vdir = 42.156;
    sleep 5;
    _NL_v setdir _NL_vdir;
    _NL_v setPos _NL_vpos;
  };
  if (_NL_baseLocation == "pavauDefault") then {
    _NL_vpos = [14731.3,16684.1,0];
    _NL_vdir = 133.611;
    sleep 5;
    _NL_v setdir _NL_vdir;
    _NL_v setPos _NL_vpos;
  };
  if (_NL_baseLocation == "AlxTuvanaka") then {
    _NL_vpos = [2334.604,13289.081,0.2];
    _NL_vdir = 50;
    sleep 5;
    _NL_v setdir _NL_vdir;
    _NL_v setPos _NL_vpos;
  };
};

diag_log ["NL_vRespawn after basePos", format["Vic: %1", typeOf (_this # 0)], format["Baselocation: %1", _NL_baseLocation], format ["BaseAA: %1", _NL_isBaseAA], format ["Base: %1", _NL_isBase], format ["Pos: %1", _NL_vpos], format ["Dir: %1", _NL_vdir]];
// === Vehicle Setup
[_NL_v] call (missionNamespace getVariable 'QS_fnc_vSetup');

// === Start respawn loop
for '_x' from 0 to 1 step 0 do {
  // diag_log [str _thisScript, _NL_v, alive _NL_v, getPos _NL_v];
  if (!alive _NL_v) then {

    // ===Checks if wreck is on respawn location, if true removes wreck
    if ((_NL_vpos distance _NL_v) < 10) then { deleteVehicle _NL_v; };

    // === Creates new vehicle
    sleep _NL_delay;
    // diag_log [str _thisScript, "respawning"];
    _NL_v = createVehicle [_NL_t, [(random -1000), (random -1000), (1000 + (random 1000))], [], 0, 'NONE'];
    if (_NL_isBase) then { _NL_v setVariable ['NL_vehicle_base', TRUE, TRUE]; };
    if (_NL_isBaseAA) then { _NL_v setVariable ['NL_vehicle_baseAA', TRUE, TRUE]; };
    if (_NL_islockable) then { _NL_v setVariable ['QS_vehicle_lockable', TRUE, TRUE]; };
    _NL_v setDir _NL_vdir;
    _NL_v setPos _NL_vpos;
    [_NL_v] call (missionNamespace getVariable 'QS_fnc_vSetup');
  };


  // === Adds Vehicle to curator
  {
    _x addCuratorEditableObjects [[_NL_v], TRUE];
  } count allCurators;

  // === Resets vehicle if its to far away from players
  if (isNil { _NL_v getVariable 'NL_vehicle_baseCAS' }) then {
    if (isNil { _NL_v getVariable 'NL_vehicle_baseAA' }) then {
      if ((_NL_base distance _NL_v) < 500) then {
        if ((_NL_vpos distance _NL_v) > 5) then {
          if ({_x distance _NL_v < _NL_resetBase} count allPlayers == 0) then {
            _NL_v EngineOn FALSE;
            _NL_v setDir _NL_vdir;
            _NL_v setPos _NL_vpos;
          };
        };
      } else {
        if ({_x distance _NL_v < _NL_resetField} count allPlayers == 0) then {
          _NL_v EngineOn FALSE;
          _NL_v setDir _NL_vdir;
          _NL_v setPos _NL_vpos;
        };
      };
    };
  };
  sleep 10;

};
