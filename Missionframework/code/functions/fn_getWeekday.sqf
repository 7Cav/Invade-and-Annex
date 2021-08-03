/*/
File: fn_getWeekday.sqf
Author:

	Grumpy Old Man
	
Last Modified:
	
	10/09/2016 ArmA 3 1.62 by Quiksilver
	
Description:

	Get Day of Week
____________________________________________________/*/

params [['_date',date],['_type','SHORT']];
_date params ['_year','_m','_q'];
_weekday = '';
_yeararray = _year call (missionNamespace getVariable 'BIS_fnc_numberDigits');
_yeararray params ['_y0','_y1','_y2','_y3'];
_J = (_y0 * 10) + _y1;
_K = (_y2 * 10) + _y3;
if (_m < 3) then {_m = _m + 12};
_hgreg = 0;
_dayNames = ['Saturday','Sunday','Monday','Tuesday','Wednesday','Thursday','Friday'];
if (_type isEqualTo 'SHORT') exitWith {((_dayNames select _hgreg) select [0,3])};
(_dayNames select _hgreg);