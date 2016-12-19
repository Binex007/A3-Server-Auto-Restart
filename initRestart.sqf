private["_restartTime", "_remainingTime"];

// AUTORESTART TIME IN MINUTES
// 60 = 1hr
// 120 = 2hr
// 180 = 3hr
// 240 = 4hr
// ...
_restartTime = 240;

// REMAINING TIME NEEDED TO LOCK THE SERVER
// EX: 15 => THE SERVER WILL LOCK 15 MINUTES BEFORE IT RESTARTS
// 0: disabled
_lockRemainingTime = 15;

// BY DEFAULT, SHOWS A HINT MESSAGE TO EVERY CONNECTED PLAYERS.
// BUT YOU'RE FREE TO ADAPT TO YOUR SERVER.
notifyPlayers = {
	params["_message"];
	_msg = parseText format["<t size='1.4' color='#ff00ff'>%1</t>", _message];
	_msg remoteExec ["hint"];
};

// Don't change any line below, unless you known what are you doing

if (_restartTime < 60) exitWith { diag_log format ["%1 %2", time, "Restart time is less than 1 hour, disabling..."]; };
if (_restartTime % 60 != 0) exitWith { diag_log format ["%1 %2", time, "Restart time needs to be multiple of 60."]; };

for "_x" from _restartTime to 0 step -1 do
{
	if (_x <= 0) exitWith { serverCommand "#restartserver"; };
	if (_x == _lockRemainingTime) then { serverCommand "#lock"; ["Server locked! No one can join it anymore."] call notifyPlayers; };
	
	if (_x % 60 == 0) then { _msg = format["The server will restart in %1 hour(s).", (_x / 60)]; [_msg] call notifyPlayers; };
	if (_x == 30) then { ["The server will restart in 30 minutes."] call notifyPlayers; };
	if (_x == 15) then { ["The server will restart in 15 minutes."] call notifyPlayers; };
	if (_x == 10) then { ["The server will restart in 10 minutes."] call notifyPlayers; };
	if (_x == 5) then { ["The server will restart in 5 minutes."] call notifyPlayers; };
	if (_x == 4) then { ["The server will restart in 4 minutes."] call notifyPlayers; };
	if (_x == 3) then { ["The server will restart in 3 minutes."] call notifyPlayers; };
	if (_x == 2) then { ["The server will restart in 2 minutes."] call notifyPlayers; };
	if (_x == 1) then { ["The server will restart in 1 minute."] call notifyPlayers; };
	
	sleep 60;
};
