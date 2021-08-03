/*/
File: fn_vMsg.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Posts a message to the vehicle channel
	Uses systemChat instead, if not in a vehicle
__________________________________________________/*/
params ["_veh", "_msg"];
if(_veh == (vehicle player)) then {
	_veh vehicleChat _msg;
} else {
	systemChat _msg;
};