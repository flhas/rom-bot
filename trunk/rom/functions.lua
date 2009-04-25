local updatePattern = string.char(0x5F, 0x5E, 0x5B, 0x8B, 0xE5, 0x5D, 0xC3, 0xA1, 0xFF, 0xFF, 0xFF, 0xFF, 0x53);
local updatePatternMask = "xxxxxxxx????x";

function getUpdatePattern()
	return updatePattern;
end

function getUpdatePatternMask()
	return updatePatternMask;
end

function checkExecutableCompatible()
	if( findPatternInProcess(getProc(), updatePattern, updatePatternMask,
	patternstart_address, 1) == 0 ) then
		return false;
	end

	return true;
end

if(DEBUG_ASSERT == nil ) then DEBUG_ASSERT = false; end;
function debugAssert(args)
	if( DEBUG_ASSERT ) then
		if( not args ) then
			error("Error in memory reading", 2);
		else
			return args;
		end
	else
		return args;
	end
end


function getWin()
	local skey = 0;

	if( getVersion() < 100 ) then
		skey = startKey;
	else
		skey = getStartKey();
	end

	if( __WIN == nil or not windowValid(__WIN) ) then
		local winlist = findWindowList("Runes of Magic");

		if( #winlist == 0 ) then
			error("RoM window not found! RoM must be running first.", 0);
		end

		if( #winlist > 1 ) then
			cprintf(cli.yellow, "Multiple RoM windows found. Keep the RoM "
				.. "window to attach this bot to on top, and press %s.\n",
				getKeyName(skey));

			while( not keyPressed(skey) ) do
				yrest(10);
			end
			while( keyPressed(skey) ) do
				yrest(10);
			end

			__WIN = foregroundWindow();
		else
			__WIN = winlist[1];
		end
	end


	return __WIN;
end

function getProc()
	if( __PROC == nil or not windowValid(__WIN) ) then
		if( __PROC ) then closeProcess(__PROC) end;
		__PROC = openProcess( findProcessByWindow(getWin()) );
	end

	return __PROC;
end

function angleDifference(angle1, angle2)
  if( math.abs(angle2 - angle1) > math.pi ) then
    return (math.pi * 2) - math.abs(angle2 - angle1);
  else
    return math.abs(angle2 - angle1);
  end
end

function distance(x1, y1, x2, y2)
	if( x1 == nil or y1 == nil or x2 == nil or y2 == nil ) then
		error("Error: nil value passed to distance()", 2);
	end

	return math.sqrt( (y2-y1)*(y2-y1) + (x2-x1)*(x2-x1) );
end

function pauseCallback()
	local skey = 0;

	if( getVersion() < 100 ) then
		skey = startKey;
	else
		skey = getStartKey();
	end

	-- If settings haven't been loaded...skip the cleanup.
	if( not settings ) then
		printf("Paused. Press %s again to continue.\n", getKeyName(skey));
		return;
	end;


	if( settings.hotkeys.MOVE_FORWARD) then
		keyboardRelease(settings.hotkeys.MOVE_FORWARD.key);
	end

	if( settings.hotkeys.MOVE_BACKWARD ) then
		keyboardRelease(settings.hotkeys.MOVE_BACKWARD.key);
	end

	if( settings.hotkeys.ROTATE_LEFT ) then
		keyboardRelease(settings.hotkeys.ROTATE_LEFT.key);
	end

	if( settings.hotkeys.ROTATE_RIGHT) then
		keyboardRelease(settings.hotkeys.ROTATE_RIGHT.key);
	end

	if( settings.hotkeys.STRAFF_LEFT ) then
		keyboardRelease(settings.hotkeys.STRAFF_LEFT.key);
	end

	if( settings.hotkeys.STRAFF_RIGHT ) then
		keyboardRelease(settings.hotkeys.STRAFF_RIGHT.key);
	end


	printf("Paused. Press %s again to continue.\n", getKeyName(skey));
end
atPause(pauseCallback);



function pauseOnDeath()
	local sk = startKey;
	if( getVersion() >= 100 ) then sk = getStartKey(); end;
	cprintf(cli.red, "You have died... Sorry.\n");
	printf("Script paused until you revive yourself. Press %s when you\'re ready to continue.\n",
		getKeyName(sk))
	logMessage("Player died.\n");
	stopPE();
end