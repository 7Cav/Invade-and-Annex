/*/
File: fn_clientServiceVehicle.sqf
Author:

	Quiksilver

Last modified:

	07/02/2020 A3 1.82 by McDodelijk

Description:

	Client vehicle service
__________________________________________________/*/

/* 
setVehicleAmmoDef
is bugged. Needs a rework or bohemia fix.
It removes passengers items in vests and backpacks.
This does not apply to the driver or turret owners of the vehicle.
For now switching to setVehicleAmmo might be ok,
as the ammo is never set to 0 by the framework anymore
*/

scriptName "QS_fnc_clientServiceVehicle";
private ['_v','_c','_rt','_nearestServiceSite','_fuel'];
_v = cameraOn;
if !((local _v) || ((isNull (driver _v) && assignedVehicleRole player isEqualTo ["Turret", [0]]))) exitWith {50 cutText ['Try getting in as the driver/pilot.','PLAIN DOWN',0.5];};
if (_v getVariable ["McD_noService", false]) exitWith {50 cutText ['Vehicle can not be serviced.','PLAIN DOWN',0.5];};
if ( ((_v getVariable ["QS_under_service", 0]) > time)) exitWith {50 cutText ['Vehicle currently being serviced.','PLAIN DOWN',0.5];};
if (missionNamespace getVariable 'QS_repairing_vehicle') exitWith {50 cutText ['Already servicing a vehicle.','PLAIN DOWN',0.5];};

/*/=========================================== SORT INTO BASE OR FIELD SERVICE/*/

private _baseService = FALSE;
private _fieldService = FALSE;
private _containerService = FALSE;
private _nearestServiceSite = '';
{
	if ((_v distance2D (markerPos _x)) < 12) then {
		_baseService = TRUE;
		_fieldService = FALSE;
		_nearestServiceSite = _x;
	};
} count (missionNamespace getVariable 'QS_veh_baseservice_mkrs');
{
	if ((_v distance2D (markerPos _x)) < 12) then {
		_baseService = FALSE;
		_fieldService = TRUE;
		_nearestServiceSite = _x;
	};
} count (missionNamespace getVariable 'QS_veh_fieldservice_mkrs');

if (['all', _v] call QS_fnc_checkServiceVehicles) then {
	_containerService = TRUE;
};

private _isCarrier = FALSE;
if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
	if (['INPOLYGON',_v] call (missionNamespace getVariable 'QS_fnc_carrier')) then {
		_nearestServiceSite = '';
		_fieldService = TRUE;
		_isCarrier = TRUE;
	};
};
if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
	if (['INPOLYGON',_v] call (missionNamespace getVariable 'QS_fnc_destroyer')) then {
		_nearestServiceSite = '';
		_fieldService = TRUE;
		_isCarrier = TRUE;
	};
};

/*/=========================================== BASE SERVICE/*/
private _isDepot = [_v] call (missionNamespace getVariable 'QS_fnc_isNearRepairDepot');
if (_isDepot) then {
	_fieldService = FALSE;
	_baseService = TRUE
};
private _isQualified = TRUE;
if ((_baseService) || (_isDepot)) exitWith {
	if (!alive _v) exitWith {
		50 cutText ['Even duct tape cannot save this vehicle, sorry','PLAIN DOWN',0.5];
	};
	/*/=========================================== QUALIFY BY VEHICLE TYPE/*/
	if ((_baseService) && (!(_isDepot))) then {
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_landservice_mkrs')) then {
			if (!(_v isKindOf 'LandVehicle')) then {
				_isQualified = FALSE;
				50 cutText ['This service area is for Land Vehicles only, soldier!','PLAIN DOWN',0.5];
			};
		};
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_planeservice_mkrs')) then {
			if (!(_v isKindOf 'Plane')) then {
				_isQualified = FALSE;
				50 cutText ['This service area is for Planes/VTOL only, soldier!','PLAIN DOWN',0.5];
			};
		};
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_heliservice_mkrs')) then {
			if (!(_v isKindOf 'Helicopter')) then {
				_isQualified = FALSE;
				50 cutText ['This service area is for Helicopters (not VTOL) only, soldier!','PLAIN DOWN',0.5];
			};
		};
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_airservice_mkrs')) then {
			if (!(_v isKindOf 'Air')) then {
				_isQualified = FALSE;
				50 cutText ['This service area is for Aircraft only, soldier!','PLAIN DOWN',1];
			};
		};
	};
	//if (!(local _v)) then {_isQualified = FALSE;};
	if (!(_isQualified)) exitWith {};
	/*
	if ((!(player isEqualTo (effectiveCommander _v))) && (!(_isUAV))) exitWith {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,7.5,-1,'At base, you must be the vehicle commander/driver to commence service!',[],-1];
	};
	*/
	// Special menu for air vehicles
	if(_v isKindOf "Air") exitWith {
		if(unitIsUAV _v) then {
			TRUE call (missionNamespace getVariable 'NL_fnc_showUAVFWLoadout');
		} else {
			if(_v isKindOf "Plane") then {
				TRUE call (missionNamespace getVariable 'NL_fnc_showJetLoadout');
			} else {
				TRUE call (missionNamespace getVariable 'NL_fnc_showHeliLoadout');
			};
		};
		/*private _cargoSeats = getNumber (configFile >> 'CfgVehicles' >> (typeOf _v) >> 'transportSoldier');
		if (_cargoSeats > 0) then {
			clearBackpackCargoGlobal _v;
			_v addBackpackCargoGlobal ['B_Parachute',_cargoSeats];
			_v vehicleChat "Adding parachutes";
		};*/
	};
	// None air vehicles
	_rt = 0;
	private _services = [];
	if(damage _v > 0) then {
		_services pushBack 'repair';
		_rt = _rt + 10 + (60 * (damage _v));
	};
	if(fuel _v < 0.99) then {
		_services pushBack 'refuel';
		_rt = _rt + 5 + (40 * (1 - (fuel _v)));
	};
	if(_v call McD_fnc_vGroundNeedRearm) then {
		_services pushBack 'rearm';
		_rt = _rt + 45;
	};

	// Abort, when no servies are needed
	if!(_rt > 0) exitWith {50 cutText ['Vehicle does not need any services.','PLAIN DOWN',0.5];};

	// Start service
	missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
	_v setVariable ["QS_under_service", (time + 120), true];
	_fuel = fuel _v;
	_v setFuel 0;

	_onCompleted = {
		params ['_v'];
		50 cutText ['Vehicle service finished','PLAIN DOWN',0.5];
		
		_v setDamage [0,FALSE];
		
		if (local _v) then {
			_v setFuel 1;
		} else {
			['setFuel',_v,1] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
		};

		if ((count (crew _v)) > 0) then {
			[_v,1] remoteExecCall ['setVehicleAmmo',
				((((allTurrets [_v, FALSE]) + [[-1]]) apply {_v turretUnit _x}) select {!isNull _x})
			,FALSE];
		} else {
			[_v,1] remoteExecCall ['setVehicleAmmo',_v,FALSE];
		};

		if (['APS_VEHICLE', _v] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams')) then {
			[_v] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
		};

		if ((['medical',(typeOf _v),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',(typeOf _v),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
			_v setVariable ['QS_medicalVehicle_reviveTickets',(getNumber (configFile >> 'CfgVehicles' >> (typeOf _v) >> 'transportSoldier')),TRUE];
		};

		_v setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];

		if (!((attachedObjects _v) isEqualTo [])) then {
			private _static = objNull;
			{
				_static = _x;
				if (alive _static) then {
					if (local _static) then {
						_static setVehicleAmmo 1;
						if (!((fuel _static) isEqualTo 1)) then {
							_static setFuel 1;
						};
					} else {
						['setVehicleAmmo',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
						if (!((fuel _static) isEqualTo 1)) then {
							['setFuel',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
						};
					};
					if (!((damage _static) isEqualTo 0)) then {
						_static setDamage [0,FALSE];
					};
				};
			} forEach (attachedObjects _v);
		};
		
		missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
		_v setVariable ["QS_under_service", nil, true];
	};

	_onCancelled = {
		params ['_v','_position','_fuel'];
		private _c = FALSE;
		if (!alive player) then {_c = TRUE;};
		if ((_v distance2D _position) > 10) then {_c = TRUE;};
		if ((!((vehicle player) isEqualTo _v)) && (!(unitIsUav cameraOn))) then {_c = TRUE;};
		if (!(player isEqualTo player)) then {_c = TRUE;};
		if (!alive _v) then {_c = TRUE;};
		if ((isEngineOn _v) && (!(unitIsUav cameraOn))) then {
			50 cutText ['Engine must be off to service vehicle','PLAIN DOWN',0.3];
			_c = TRUE;
		};
		if (_c) then {
			if (local _v) then {
				_v setFuel _fuel;
			} else {
				['setFuel',_v,_fuel] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
			};
			missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
			_v setVariable ["QS_under_service", nil, true];
		};
		_c;
	};
	[
		'Servicing vehicle ...',
		_rt,
		0,
		[[_v],{FALSE}],							/*/onProgress/*/
		[[_v,(position _v),_fuel],_onCancelled],/*/onCancelled/*/
		[[_v],_onCompleted],					/*/onCompleted/*/
		[[],{FALSE}]							/*/onFailed/*/
	] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
	[_v,_rt,_services] spawn {
		params ['_vehicle','_rt', '_array'];
		_position = getPosASL _vehicle;
		{
			playSound3D [
				(format ['A3\Sounds_F\sfx\ui\vehicles\vehicle_%1.wss',_x]),
				_vehicle,
				FALSE,
				_position,
				2,
				1,
				25
			];
			uiSleep 10;
		} forEach _array;
	};
};

/*/=========================================== FIELD SERVICE/*/

if (_fieldService || _containerService) then {
	if (!alive _v) exitWith {
		50 cutText ['Even duct tape cannot save this vehicle, sorry','PLAIN DOWN',0.5];
	};
	/*/=========================================== QUALIFY BY VEHICLE TYPE/*/
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_landservice_mkrs')) then {
		if (!(_v isKindOf 'LandVehicle')) then {
			_isQualified = FALSE;
			50 cutText ['This service area is for Land Vehicles only, soldier!','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_planeservice_mkrs')) then {
		if (!(_v isKindOf 'Plane')) then {
			_isQualified = FALSE;
			50 cutText ['This service area is for Planes / VTOL only, soldier!','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_heliservice_mkrs')) then {
		if (!(_v isKindOf 'Helicopter')) then {
			_isQualified = FALSE;
			50 cutText ['This service area is for Helicopters (not VTOL) only, soldier!','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_airservice_mkrs')) then {
		if (!(_v isKindOf 'Air')) then {
			_isQualified = FALSE;
			50 cutText ['This service area is for Aircraft only, soldier!','PLAIN DOWN',1];
		};
	};
	if (_isCarrier || _containerService) then {
		_isQualified = TRUE;
	};
	//if (!(local _v)) then {_isQualified = FALSE;};
	if (!(_isQualified)) exitWith {};
	if ((_v isKindOf 'LandVehicle') || {(_v isKindOf 'Ship')} || {(_v isKindOf 'Air')}) then {

		private _isRepairAvailable = FALSE;
		private _isRefuelAvailable = FALSE;
		private _isAmmoAvailable = FALSE;

		if (!(_isCarrier)) then {
			if (['rearm', _v] call QS_fnc_checkServiceVehicles) then {
				_isAmmoAvailable = TRUE;
			};
			if (['repair', _v] call QS_fnc_checkServiceVehicles) then {
				_isRepairAvailable = TRUE;
			};
			if (['refuel', _v] call QS_fnc_checkServiceVehicles) then {
				_isRefuelAvailable = TRUE;
			};
			if (_fieldService) then {
				if ((missionNamespace getVariable ['QS_module_fob_services_ammo', FALSE])) then {
					_isAmmoAvailable = TRUE;
				};
				if ((missionNamespace getVariable ['QS_module_fob_services_repair', FALSE])) then {
					_isRepairAvailable = TRUE;
				};
				if ((missionNamespace getVariable ['QS_module_fob_services_fuel', FALSE])) then {
					_isRefuelAvailable = TRUE;
				};
			};
		};

		// Special menu for air vehicles
		if(_v isKindOf "Air") exitWith {
			if(unitIsUAV _v) then {
				[FALSE, _isAmmoAvailable, _isRefuelAvailable, _isRepairAvailable] call (missionNamespace getVariable 'NL_fnc_showUAVFWLoadout');
			} else {
				if(_v isKindOf "Plane") then {
					[FALSE, _isAmmoAvailable, _isRefuelAvailable, _isRepairAvailable] call (missionNamespace getVariable 'NL_fnc_showJetLoadout');
				} else {
					[FALSE, _isAmmoAvailable, _isRefuelAvailable, _isRepairAvailable] call (missionNamespace getVariable 'NL_fnc_showHeliLoadout');
				};
			};
		};

		_rt = 0;
		private _services = [];
		if(damage _v > 0) then {
			if(_isRepairAvailable) then {
				_services pushBack 'repair';
				_rt = _rt + 10 + (60 * (damage _v));
			} else {
				//(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'REPAIR service is not available here.',[],-1];
				systemChat 'REPAIR service is not available here.';
			};
		};
		if(fuel _v < 0.99) then {
			if(_isRefuelAvailable) then {
				_services pushBack 'refuel';
				_rt = _rt + 5 + (40 * (1 - (fuel _v)));
			} else {
				//(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'REFUEL service is not available here.',[],-1];
				systemChat 'REFUEL service is not available here.';
			};
		};
		if(_v call McD_fnc_vGroundNeedRearm) then {
			if(_isAmmoAvailable) then {
				_services pushBack 'rearm';
				_rt = _rt + 45;
			} else {
				//(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'REARM service is not available here.',[],-1];
				systemChat 'REARM service is not available here.';
			};
		};


		// Abort, when no servies are needed
		if!(_rt > 0) exitWith {50 cutText ['Vehicle does not need any services.','PLAIN DOWN',0.5];};

		missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
		_v setVariable ["QS_under_service", (time + 120), true];
		_fuel = fuel _v;
		_v setFuel 0;

		_onCompleted = {
			params ['_v','_fuel','_isCarrier','_services'];
			50 cutText ['Vehicle service finished','PLAIN DOWN',0.5];

			if ('repair' in _services) then {
				_v setDamage [0,FALSE];
			};
			if (local _v) then {
				_v setFuel ([_fuel,1] select ('refuel' in _services));
			} else {
				['setFuel',([_fuel,1] select ('refuel' in _services)),1] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
			};
			if ('rearm' in _services) then {
				if ((count (crew _v)) > 0) then {
					[_v,1] remoteExecCall ['setVehicleAmmo',
						((((allTurrets [_v, FALSE]) + [[-1]]) apply {_v turretUnit _x}) select {!isNull _x})
					,FALSE];
				} else {
					if (local _v) then {
						_v setVehicleAmmo 1;
					} else {
						[_v,1] remoteExecCall ['setVehicleAmmo',_v,FALSE];
					};
				};
				if (['APS_VEHICLE', _v] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams')) then {
					[_v] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
				};
			};

			if (!((attachedObjects _v) isEqualTo [])) then {
				private _static = objNull;
				{
					_static = _x;
					if (alive _static) then {
						if (('rearm' in _services)) then {
							if (local _static) then {
								_static setVehicleAmmo 1;
							} else {
								['setVehicleAmmo',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];;
							};
						};
						if (('refuel' in _services)) then {
							if (local _static) then {
								if (!((fuel _static) isEqualTo 1)) then {
									_static setFuel 1;
								};
							} else {
								if (!((fuel _static) isEqualTo 1)) then {
									['setFuel',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
								};
							};
						};
						if (('repair' in _services) && !((damage _static) isEqualTo 0)) then {
							_static setDamage [0,FALSE];
						};
					};
				} forEach (attachedObjects _v);
			};
			
			missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
			_v setVariable ["QS_under_service", nil, true];
		};

		_onCancelled = {
			params ['_v','_position','_fuel'];
			private _c = FALSE;
			if (!alive player) then {_c = TRUE;};
			if (((position _v) distance2D _position) > 10) then {_c = TRUE;};
			if ((!((vehicle player) isEqualTo _v)) && (!(unitIsUav cameraOn))) then {_c = TRUE;};
			if (!(player isEqualTo player)) then {_c = TRUE;};
			if (!alive _v) then {_c = TRUE;};
			if (isEngineOn _v) then {
				50 cutText ['Engine must be off to service vehicle','PLAIN DOWN',0.3];
				_c = TRUE;
			};
			if (_c) then {
				if (local _v) then {
					_v setFuel _fuel;
				} else {
					['setFuel',_v,_fuel] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
				};
				missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
				_v setVariable ["QS_under_service", nil, true];
			};
			_c;
		};
		[
			'Servicing vehicle ...',
			_rt,
			0,
			[[],{FALSE}],									/*/onProgress/*/
			[[_v,(position _v),_fuel],_onCancelled],		/*/onCancelled/*/
			[[_v,_fuel,_isCarrier,_services],_onCompleted],	/*/onCompleted/*/
			[[],{FALSE}]									/*/onFailed/*/
		] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
		[_v,_rt,_services] spawn {
			params ['_vehicle','_rt', '_array'];
			_position = getPosASL _vehicle;
			{
				playSound3D [
					(format ['A3\Sounds_F\sfx\ui\vehicles\vehicle_%1.wss',_x]),
					_vehicle,
					FALSE,
					_position,
					2,
					1,
					25
				];
				uiSleep 10;
			} forEach _array;
		};
	};
};
