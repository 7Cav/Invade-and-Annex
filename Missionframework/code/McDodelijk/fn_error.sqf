/*/
File: fn_error.sqf
Author:

	McDodelijk

Last modified:

	02/04/2020 by McDodelijk

Description:

	Log errors and report to server when requested
__________________________________________________/*/

private _msg = format _this;
diag_log _msg;
systemChat _msg;
