settings_default = {
	hotkeys = {
		MOVE_FORWARD = {key = _G.key.VK_W, modifier = nil},
		MOVE_BACKWARD = {key = _G.key.VK_S, modifier = nil},
		ROTATE_LEFT = {key = _G.key.VK_A, modifier = nil},
		ROTATE_RIGHT = {key = _G.key.VK_D, modifier = nil},
		STRAFF_LEFT = {key = _G.key.VK_Q, modifier = nil},
		STRAFF_RIGHT = {key = _G.key.VK_E, modifier = nil},
		JUMP = {key = _G.key.VK_SPACE, modifier = nil},
		TARGET = {key = _G.key.VK_TAB, modifier = nil},
		TARGET_FRIEND = {key = _G.key.J, modifier = nil},
		START_BOT = {key = _G.key.VK_DELETE, modifier = nil},
		STOP_BOT = {key = _G.key.VK_END, modifier = nil}
	},
	options = {
		ENABLE_FIGHT_SLOW_TURN = false,
		MELEE_DISTANCE = 45,
		LANGUAGE = "english",
		USE_CLIENT_LANGUAGE = true,		-- automatic use client language after loading the bot
		DEBUGGING = false,
		DEBUGGING_MACRO = false,		
		ROMDATA_PATH = nil,
	},
	profile = {
		options = {
			-- common options
			HP_LOW = 85,
			MP_LOW_POTION = 50,
			HP_LOW_POTION = 40,
			COMBAT_TYPE = "melee",
			COMBAT_RANGED_PULL = "true",	-- only for melee classes , use ranged skill to pull
			COMBAT_DISTANCE = 200,
			ANTI_KS = true,
			WAYPOINTS = "demo.xml",
			RETURNPATH = nil,
			PATH_TYPE = "waypoints",
			WANDER_RADIUS = 500,
			WAYPOINT_DEVIATION = 0,
			LOOT = true,
			LOOT_TIME = 2000,
			LOOT_IN_COMBAT = true,
			LOOT_DISTANCE = nil,
			LOOT_PAUSE_AFTER = 10,	-- probability for short pause after loot to look more human
			MAX_FIGHT_TIME = 12,
			DOT_PERCENT = 90,
			LOGOUT_TIME = 0,
			LOGOUT_SHUTDOWN = false,
			LOGOUT_WHEN_STUCK = true,
			MAX_UNSTICK_TRIALS = 10,
			TARGET_LEVELDIF_BELOW = 99,
			TARGET_LEVELDIF_ABOVE = 99,
			QUICK_TURN = false,
			MP_REST = 15,
			HP_REST = 15,
			RES_AUTOMATIC_AFTER_DEATH = false,	-- automatic resurrect after death true|false,
			HEALING_POTION = 0,				-- shopping options, how many to buy/have in inventory
			MANA_POTION = 0,				-- shopping options, how many to buy/have in inventory
			ARRAY_QUIVER = 0,				-- shopping options, how many to buy/have in inventory
			THROWN_BAG = 0,					-- shopping options, how many to buy/have in inventory
			POISON = 0,						-- shopping options, how many to buy/have in inventory
			RELOAD_AMMUNITION = false,		-- false|arrow|thrown

			
			-- expert options
			MAX_TARGET_DIST = 999,			-- miximum distance to select a target (helpfull to limit at small places)
			AUTO_ELITE_FACTOR = 4,			-- mobs with x * your HP value counts as 'Elite' and we will not target it
			SKILL_USE_PRIOR = 300,			-- cast x ms before cooldown is finished
			PK_COUNTS_AS_DEATH = true,		-- count playerkill's as death
			POTION_COOLDOWN = 15,			-- always 15
			POTION_COOLDOWN_HP = 0,			-- will only be used if not 0, if 0 POTION_COOLDOWN will be used
			POTION_COOLDOWN_MANA = 0,		-- will only be used if not 0, if 0 POTION_COOLDOWN will be used
			SIT_WHILE_RESTING = false,		-- sit while using the rest function
			USE_MANA_POTION = "best",		-- which mana potion type to use: best | minstack
			USE_HP_POTION = "best",			-- which HP potion type to use: best | minstack 			
			WAYPOINTS_REVERSE = false,		-- use the waypoint file in reverse order
			MAX_DEATHS = 10,				-- maximal death if automatic resurrect befor logout
			WAIT_TIME_AFTER_RES = 8000,		-- time to wait after resurrection, needs more on slow PCs
			RETURNPATH_SUFFIX = "_return",	-- suffix for default naming of returnpath
			HARVEST_SCAN_WIDTH = 5,		-- steps horizontal
			HARVEST_SCAN_HEIGHT = 5,		-- steps vertical
			HARVEST_SCAN_STEPSIZE = 60,		-- wide of every step
			HARVEST_SCAN_TOPDOWN = false,	-- true = top->down  false = botton->up
			HARVEST_SCAN_XMULTIPLIER = 1.0,	-- multiplier for scan width
			HARVEST_SCAN_YMULTIPLIER = 1.1,	-- multiplier for scan line height
			HARVEST_SCAN_YREST = 10,		-- scanspeed
			HARVEST_SCAN_YMOVE = 1.1,		-- move scan area top/down ( 1=middle of screen )
			USE_SLEEP_AFTER_RESUME = false, -- enter sleep mode after pressing pause/resume key
			IGNORE_MACRO_ERROR = false, 	-- ignore missing MACRO hotkey error (only temporary option while beta)
			DEBUG_INV = false,	 			-- to help to find the item use error (only temporary option while beta)
			DEBUG_LOOT = false,	 			-- debug loot issues
			DEBUG_TARGET = false, 			-- debug targeting issues
			DEBUG_HARVEST = false, 			-- debug harvesting issues
			
			-- debug skill use issues
			DEBUG_SKILLUSE = {
				ENABLE 		= false,
				TIMEGAP		= true,		-- show the time gap between cast starts
				ONCOOLDOWN	= true,		-- show the time in ms that we are before the cooldown
				NOCOOLDOWN	= true,		-- show the time in ms that we are over the cooldown
				HPLOW		= true 
				},
			
			-- expert inventar
			INV_MAX_SLOTS = 60,	 			-- maximal slots to update in the inventory:update()
			INV_UPDATE_INTERVAL = 300,	 	-- full inventory update every x seconds (only used indirect atm)
			INV_AUTOSELL_ENABLE = false,	-- autosell items at merchant true|false
			INV_AUTOSELL_FROMSLOT = 0,		-- autosell from slot #
			INV_AUTOSELL_TOSLOT = 0,		-- autosell to slot #
			INV_AUTOSELL_QUALITY = "white, green",	-- itemcolors to sell
			INV_AUTOSELL_IGNORE = nil,		-- itemnames never so sell

			
		},	
		hotkeys = {  }, 
		skills = {}, 
		friends = {},
		mobs = {},
		events = {
			onDeath = nil,
			onLoad = nil,
			onLeaveCombat = nil,
			onSkillCast = nil,
			onLevelup = nil,
		}
	},
};

bot =	{ 		-- global bot values
		ClientLanguage,		-- ingame language of the game [ de|ru|fr| en (for enus and eneu) ]
		GetTimeFrequency,	-- calculated CPU frequency for calculating with the getTime() function
		};		

settings = settings_default;

check_keys = { name = { } };
function checkKeySettings( _name, _key, _modifier)
-- args are the VK in stringform like "VK_CONTROL", "VK_J", ..

	local hf_check_where;
	if( bindings ) then	-- keys are from bindings.txt
		hf_check_where = language[141];		-- Datei settings.xml
	else
		hf_check_where = language[140];		-- Ingame -> System -> Tastenbelegung
	end
	
	local msg = nil;
	-- no empty keys pls
	if( _key == nil) then
		msg = sprintf(language[115], _name);	-- key for \'%s\' is empty!
		msg = msg .. hf_check_where;
	end

	-- check if all keys are valid virtual keys (VK)
	if( _key ) then
		if( key[_key]  == nil ) then
			msg = sprintf(language[116], _key, _name);	-- The hotkey ... is not a valid key
			msg = msg .. hf_check_where;
		end
	end;

	-- no modifiers allowed at the moment
	if( _modifier ) then
		if( key[_modifier]  == nil ) then
			msg = sprintf(language[117], _modifier, _name);	-- The modifier ... is not a valid key
			msg = msg .. hf_check_where;
		end
	end;

	-- now we check for double key settings
	-- we translate the strings "VK..." to the VK numbers
	_key = key[_key];
	_modifier = key[_modifier];

	-- check the using of modifiers
	-- they are not usable at the moment
	if( _modifier ~= nil) then
		msg = sprintf(language[118], -- we don't support modifiers
		   getKeyName(_modifier), getKeyName(_key), _name);

	end

	-- error output
	if( msg ~= nil) then
		-- only a warning for TARGET_FRIEND / else an error
		if(_name == "TARGET_FRIEND") then
			cprintf(cli.yellow, msg .. language[119]);	-- can't use the player:target_NPC() function
		else
			error(msg, 0);
		end
	end

	-- check for double key settings
	for i,v in pairs(check_keys) do
		if( v.name ~= _nil and	-- empty entries from deleted settings.xml entries
		    v.key == _key  and
		    v.modifier == _modifier ) then
			local modname;

			if( v.modifier ) then 
				modname = getKeyName(v.modifier).."+";
			else
				modname = "";
			end;

			local errstr = sprintf(language[121],	-- assigned the key \'%s%s\' double
				modname, 
				getKeyName(v.key), 
				v.name, _name) .. 
				hf_check_where;
			error(errstr, 0);
		end
	end;

	check_keys[_name] = {};
	check_keys[_name].name = _name;
	check_keys[_name].key = _key;
	check_keys[_name].modifier = _modifier;

end


function settingsPrintKeys()
-- That function prints the loaded key settings to the MM window and to the log

	local msg;
	msg ="QUICK_TURN = "..tostring(settings.profile.options.QUICK_TURN);	-- we wander around
	logMessage(msg);		-- log keyboard settings
	
	if( bindings ) then		-- we read from bindings.txt
		msg = sprintf(language[167], "bindings.txt");	-- Keyboard settings are from
	else				-- we read settings.xml
		msg = sprintf(language[167], "settings.xml");	-- Keyboard settings are from
	end

--	cprintf(cli.green, msg.."\n");	-- Keyboard settings are from
	logMessage(msg);		-- log keyboard settings

	for i,v in pairs(check_keys) do

		if(v.name) then

			msg = string.sub(v.name.."                               ", 1, 30);	-- function name

			local modname;
			if( v.modifier ) then 
				modname = getKeyName(v.modifier).."+";	-- modifier name
			else
				modname = "";
			end;
			msg = msg..modname..getKeyName(v.key);	-- add key name
--			printf(msg.."\n");			-- print line
			logMessage(msg);			-- log keyboard settings
		
		end;
	end;

end


function settings.load()
	local filename = getExecutionPath() .. "/settings.xml";
	local root = xml.open(filename);
	local elements = root:getElements();
	check_keys = { };	-- clear table, because of restart from createpath.lua

	-- Specific to loading the hotkeys section of the file
	local loadHotkeys = function (node)
		local elements = node:getElements();
		for i,v in pairs(elements) do
			-- If the hotkey doesn't exist, create it.
			settings.hotkeys[ v:getAttribute("description") ] = { };
			settings.hotkeys[ v:getAttribute("description") ].key = key[v:getAttribute("key")];
			settings.hotkeys[ v:getAttribute("description") ].modifier = key[v:getAttribute("modifier")];

			if( key[v:getAttribute("key")] == nil ) then
				local err = sprintf(language[122],	-- does not have a valid hotkey!
				  v:getAttribute("description"));
				error(err, 0);
			end

			checkKeySettings( v:getAttribute("description"),
			  v:getAttribute("key"), 
			  v:getAttribute("modifier") );
		end
	end

	local loadOptions = function (node)
		local elements = node:getElements();
		for i,v in pairs(elements) do
			settings.options[ v:getAttribute("name") ] = v:getAttribute("value");
		end
	end

	-- Load RoM keyboard bindings.txt file
	local function load_RoM_bindings_txt()
		local filename, file;
		
		local userprofilePath = os.getenv("USERPROFILE");
		local documentPaths = {
			userprofilePath .. "\\My Documents\\" .. "Runes of Magic", -- English
			userprofilePath .. "\\Eigene Dateien\\" .. "Runes of Magic", -- German
			userprofilePath .. "\\Mes Documents\\" .. "Runes of Magic", -- French
			userprofilePath .. "\\Omat tiedostot\\" .. "Runes of Magic", -- Finish
			userprofilePath .. "\\Belgelerim\\" .. "Runes of Magic", -- Turkish
			userprofilePath .. "\\Mina Dokument\\" .. "Runes of Magic", -- Swedish
			userprofilePath .. "\\Dokumenter\\" .. "Runes of Magic", -- Danish
			userprofilePath .. "\\Documenti\\" .. "Runes of Magic", -- Italian
			userprofilePath .. "\\Mijn documenten\\" .. "Runes of Magic", -- Dutch
			userprofilePath .. "\\Moje dokumenty\\" .. "Runes of Magic", -- Polish
			userprofilePath .. "\\Mis documentos\\" .. "Runes of Magic", -- Spanish
		};

		-- Use a user-specified path from settings.xml
		if( settings.options.ROMDATA_PATH ) then
			table.insert(documentPaths, settings.options.ROMDATA_PATH);
		end

		-- Select the first path that exists
		for i,v in pairs(documentPaths) do
			if( string.sub(v, -1 ) ~= "\\" and string.sub(v, -1 ) ~= "/" ) then
				v = v .. "\\"; -- Append the trailing backslash if necessary.
			end

			local filename = v .. "bindings.txt"
			if( fileExists(filename) ) then
				file = io.open(filename, "r");
				local tmp = filename;
				cprintf(cli.green, language[123], filename);	-- read the hotkey settings from your bindings.txt
			end
		end

		-- If we wern't able to locate a document path, return.
		if( file == nil ) then
			return;
		end

		-- delete hotkeys from settings.xml in check table to avoid double entries / wrong checks
		check_keys["MOVE_FORWARD"] = nil;
		check_keys["MOVE_BACKWARD"] = nil;
		check_keys["ROTATE_LEFT"] = nil;
		check_keys["ROTATE_RIGHT"] = nil;
		check_keys["STRAFF_LEFT"] = nil;
		check_keys["STRAFF_RIGHT"] = nil;
		check_keys["JUMP"] = nil;
		check_keys["TARGET"] = nil;
		check_keys["TARGET_FRIEND"] = nil;
		
		-- Load bindings.txt into own table structure
		bindings = { name = { } };
		-- read the lines in table 'lines'
		for line in file:lines() do
			for name, key1, key2 in string.gfind(line, "(%w*)%s([%w+]*)%s*([%w+]*)") do
				bindings[name] = {};
				bindings[name].key1 = key1;
				bindings[name].key2 = key2;

				--settings.hotkeys[name].key = 
			end
		end

		local function bindHotkey(bindingName)
			local links = { -- Links forward binding names to hotkey names
				MOVEFORWARD = "MOVE_FORWARD",
				MOVEBACKWARD = "MOVE_BACKWARD",
				TURNLEFT = "ROTATE_LEFT",
				TURNRIGHT = "ROTATE_RIGHT",
				STRAFELEFT = "STRAFF_LEFT",
				STRAFERIGHT = "STRAFF_RIGHT",
				JUMP = "JUMP",
				TARGETNEARESTENEMY = "TARGET",
				TARGETNEARESTFRIEND = "TARGET_FRIEND",	
			};

			local hotkeyName = bindingName;
			if(links[bindingName] ~= nil) then
				hotkeyName = links[bindingName];
			end;


			if( bindings[bindingName] ~= nil ) then
				if( bindings[bindingName].key1 ~= nil ) then
					-- Fix key names
					bindings[bindingName].key1 = string.gsub(bindings[bindingName].key1, "CTRL", "CONTROL");

					if( string.find(bindings[bindingName].key1, '+') ) then
						local parts = explode(bindings[bindingName].key1, '+');
						-- parts[1] = modifier
						-- parts[2] = key

						settings.hotkeys[hotkeyName].key = key["VK_" .. parts[2]];
						settings.hotkeys[hotkeyName].modifier = key["VK_" .. parts[1]];
						checkKeySettings(hotkeyName, "VK_" .. parts[2], "VK_" .. parts[1] );
					else
						settings.hotkeys[hotkeyName].key = key["VK_" .. bindings[bindingName].key1];
						checkKeySettings(hotkeyName, "VK_" .. bindings[bindingName].key1 );
					end
					
				else
					local err = sprintf(language[124], bindingName);	-- no ingame hotkey for
					error(err, 0);
				end
			end
		end

		bindHotkey("MOVEFORWARD");
		bindHotkey("MOVEBACKWARD");
		bindHotkey("TURNLEFT");
		bindHotkey("TURNRIGHT");
		bindHotkey("STRAFELEFT");
		bindHotkey("STRAFERIGHT");
		bindHotkey("JUMP");
		bindHotkey("TARGETNEARESTENEMY");
		bindHotkey("TARGETNEARESTFRIEND");
	end

	-- check ingame settings
	-- only if we can find the bindings.txt file
	local function check_ingame_settings( _name, _ingame_key)
	-- no more needed, because we take the keys from the file if we found the file
		
		if( not bindings ) then		-- no bindings.txt file loaded
			return
		end;
		
		if( settings.hotkeys[_name].key ~= key["VK_"..bindings[_ingame_key].key1] and
		settings.hotkeys[_name].key ~= key["VK_"..bindings[_ingame_key].key2] ) then
			local msg = sprintf(language[125], _name);	-- settings.xml don't match your RoM ingame
			error(msg, 0);
		end
	end


	function checkHotkeys(_name, _ingame_key)
		if( not settings.hotkeys[_name] ) then
			error(language[126] .. _name, 0);	-- Global hotkey not set
		end
		
		-- check if settings.lua hotkeys match the RoM ingame settings
		-- check_ingame_settings( _name, _ingame_key);
	end


	for i,v in pairs(elements) do
		local name = v:getName();

		if( string.lower(name) == "hotkeys" ) then
			loadHotkeys(v);
		elseif( string.lower(name) == "options" ) then
			loadOptions(v);
		end
	end


-- TODO: don't work at the moment, becaus MACRO hotkey not available at this time
-- will first be available after reading profile file
	-- read language from client if not set in settings.xml
--	if( not settings.options.LANGUAGE ) then
--		local hf_language = RoMScript("GetLanguage();");	-- read clients language
--		if( hf_language == "DE" ) then
--			settings.options.LANGUAGE = "deutsch";
--		elseif(hf_language == "ENEU" ) then
--			settings.options.LANGUAGE = "english";
--		elseif(hf_language == "FR" ) then
--			settings.options.LANGUAGE = "french";
--		else
--			settings.options.LANGUAGE = "english";		
--		end
--	end

	-- Load language files
	-- Load "english" first, to fill in any gaps in the users' set language.
	local function setLanguage(name)
		include(getExecutionPath() .. "/language/" .. name .. ".lua");
	end

	local lang_base = {};
	setLanguage("english");
	for i,v in pairs(language) do lang_base[i] = v; end;
	setLanguage(settings.options.LANGUAGE);
	for i,v in pairs(lang_base) do
		if( language[i] == nil ) then
			language[i] = v;
		end
	end;
	lang_base = nil; -- Not needed anymore, destroy it.
	logMessage("Language: " .. settings.options.LANGUAGE);


	load_RoM_bindings_txt();	-- read bindings.txt from RoM user folder

	-- Check to make sure everything important is set
	--           bot hotkey name    RoM ingame key name         
	checkHotkeys("MOVE_FORWARD",   "MOVEFORWARD");
	checkHotkeys("MOVE_BACKWARD",  "MOVEBACKWARD");
	checkHotkeys("ROTATE_LEFT",    "TURNLEFT");
	checkHotkeys("ROTATE_RIGHT",   "TURNRIGHT");
	checkHotkeys("STRAFF_LEFT",    "STRAFELEFT");
	checkHotkeys("STRAFF_RIGHT",   "STRAFERIGHT");
	checkHotkeys("JUMP",           "JUMP");
	checkHotkeys("TARGET",         "TARGETNEARESTENEMY");
	checkHotkeys("TARGET_FRIEND",  "TARGETNEARESTFRIEND");
	
end


function settings.loadProfile(_name)
	-- Delete old profile settings (if they even exist), restore defaults
	settings.profile = settings_default.profile;

	local filename = getExecutionPath() .. "/profiles/" .. _name .. ".xml";
	local root = xml.open(filename);
	local elements = root:getElements();

	local loadOptions = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do
			settings.profile.options[v:getAttribute("name")] = v:getAttribute("value");
		end
	end

	local loadHotkeys = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do
			settings.profile.hotkeys[v:getAttribute("name")] = {};
			settings.profile.hotkeys[v:getAttribute("name")].key = key[v:getAttribute("key")];
			settings.profile.hotkeys[v:getAttribute("name")].modifier = key[v:getAttribute("modifier")];

			if( key[v:getAttribute("key")] == nil ) then
				local err = sprintf(language[127], tostring(v:getAttribute("name")), _name );	-- Please set a valid key
				error(err, 0);
			end

			checkKeySettings(v:getAttribute("name"),
			  v:getAttribute("key"), 
			  v:getAttribute("modifier") );

		end
	end

	local loadOnLoadEvent = function(node)
		local luaCode = node:getValue();
		if( luaCode == nil ) then return; end;

		if( string.len(luaCode) > 0 and string.find(luaCode, "%w") ) then
			settings.profile.events.onLoad = loadstring(luaCode);
			assert(settings.profile.events.onLoad, sprintf(language[151], "onLoad"));

			if( type(settings.profile.events.onLoad) ~= "function" ) then
				settings.profile.events.onLoad = nil;
			end;
		end
	end

	local loadOnDeathEvent = function(node)
		local luaCode = node:getValue();
		if( luaCode == nil ) then return; end;

		if( string.len(luaCode) > 0 and string.find(luaCode, "%w") ) then
			settings.profile.events.onDeath = loadstring(luaCode);
			
			assert(settings.profile.events.onDeath, sprintf(language[151], "onDeath"));

			if( type(settings.profile.events.onDeath) ~= "function" ) then
				settings.profile.events.onDeath = nil;
			end;
		end
	end

	local loadOnLeaveCombatEvent = function(node)
		local luaCode = node:getValue();
		if( luaCode == nil ) then return; end;

		if( string.len(luaCode) > 0 and string.find(luaCode, "%w") ) then
			settings.profile.events.onLeaveCombat = loadstring(luaCode);
			assert(settings.profile.events.onLeaveCombat, sprintf(language[151], "onLeaveCombat"));

			if( type(settings.profile.events.onLeaveCombat) ~= "function" ) then
				settings.profile.events.onLeaveCombat = nil;
			end;
		end
	end

	local loadOnLevelupEvent = function(node)
		local luaCode = node:getValue();
		if( luaCode == nil ) then return; end;

		if( string.len(luaCode) > 0 and string.find(luaCode, "%w") ) then
			settings.profile.events.onLevelup = loadstring(luaCode);
			assert(settings.profile.events.onLevelup, sprintf(language[151], "onLevelup"));

			if( type(settings.profile.events.onLevelup) ~= "function" ) then
				settings.profile.events.onLevelup = nil;
			end;
		end
	end

	local loadOnSkillCastEvent = function(node)
		local luaCode = node:getValue();
		if( luaCode == nil ) then return; end;

		if( string.len(luaCode) > 0 and string.find(luaCode, "%w") ) then
			settings.profile.events.onSkillCast= loadstring(luaCode);
			assert(settings.profile.events.onSkillCast, sprintf(language[151], "onSkillCast"));

			if( type(settings.profile.events.onSkillCast) ~= "function" ) then
				settings.profile.events.onSkillCast = nil;
			end;
		end
	end


	local skillSort = function(tab1, tab2)
		if( tab2.priority < tab1.priority ) then
			return true;
		end;

		return false;
	end

	local loadSkills = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do
			local name, hotkey, modifier, level;
			name = v:getAttribute("name");
			hotkey = key[v:getAttribute("hotkey")];
			modifier = key[v:getAttribute("modifier")];
			level = v:getAttribute("level");

			checkKeySettings( v:getAttribute("name"),
			  v:getAttribute("hotkey"), 
			  v:getAttribute("modifier") );

			-- Over-ride attributes
			local priority, maxhpper, maxmanaper, cooldown, inbattle, pullonly, maxuse, autouse, rebuffcut;
			priority = v:getAttribute("priority");
			maxhpper = tonumber(v:getAttribute("hpper"));
			maxmanaper = tonumber(v:getAttribute("manaper"));
			cooldown = tonumber(v:getAttribute("cooldown"));
			inbattle = v:getAttribute("inbattle");
			pullonly = v:getAttribute("pullonly");
			maxuse = tonumber(v:getAttribute("maxuse"));
			rebuffcut = tonumber(v:getAttribute("rebuffcut"));
			autouse = v:getAttribute("autouse");
		-- Ensure that autouse is a proper type.
			if( not (autouse == true or autouse == false) ) then
				autouse = true;
			end;


			-- check if 'wrong' options are set
			if( v:getAttribute("mana")      or
			    v:getAttribute("manainc")   or
			    v:getAttribute("rage")      or
			    v:getAttribute("energy")    or
			    v:getAttribute("concentration")      or
			    v:getAttribute("range")     or
--			    v:getAttribute("cooldown")  or
			    v:getAttribute("minrange")  or
			    v:getAttribute("type")      or
			    v:getAttribute("target")    or
			    v:getAttribute("casttime") ) then
					local msg = sprintf(language[128], name, _name);	-- are no valid options for your skill
					error(msg, 0);
			end;
			if( v:getAttribute("modifier") ) then
				local msg = sprintf(language[129], name, _name);	-- modifier not supported

				error(msg, 0);
			end;

			if( name == nil) then
				local msg = sprintf(language[130], _name);	-- empty\' skill name
				error(msg, 0);
			end;

			if( inbattle ~= nil ) then
				if( inbattle == "true" or 
					inbattle == true ) then
					inbattle = true;
				elseif( inbattle == "false"  or
					inbattle == false ) then
					inbattle = false;
				else
					local msg = sprintf(language[131], inbattle, name, _name);	-- wrong option inbattle

					error(msg, 0);
				end;
			end

			if( pullonly ~= nil ) then
				if( pullonly == "true" or
					pullonly == true ) then
					pullonly = true;
				else
					local msg = sprintf(language[132], pullonly, name, _name);	-- wrong option pullonly

					error(msg, 0);
				end;
			end

			if( level == nil or level < 1 ) then
				level = 1;
			end

			local baseskill = database.skills[name];
			if( not baseskill ) then
				local err = sprintf("ERROR: \'%s\' is not defined in the database!", name);
				error(err, 0);
			end

			local tmp = CSkill(database.skills[name]);
			tmp.hotkey = hotkey;
			tmp.modifier = modifier;
			tmp.Level = level;

			if( toggleable ) then tmp.Toggleable = toggleable; end;
			if( priority ) then tmp.priority = priority; end
			if( maxhpper ) then tmp.MaxHpPer = maxhpper; end;
			if( maxmanaper ) then tmp.MaxManaPer = maxmanaper; end;
			if( cooldown ) then tmp.Cooldown = cooldown; end;
			if( inbattle ~= nil ) then tmp.InBattle = inbattle; end;
			if( pullonly == true ) then tmp.pullonly = pullonly; end;
			if( maxuse ) then tmp.maxuse = maxuse; end;
			if( rebuffcut ) then tmp.rebuffcut = rebuffcut; end;
			if( autouse == false ) then tmp.AutoUse = false; end;

			table.insert(settings.profile.skills, tmp);
		end

		table.sort(settings.profile.skills, skillSort);
	end

	local loadFriends = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do

			local name = v:getAttribute("name");
			
			if( name ) then name = trim(name); end;

			if( name ) then 
		
				-- fix, because getAttribute seems not to recognize the escape characters
				-- for special ASCII characters
				name = string.gsub (name, "\\132", string.char(132));	-- �
				name = string.gsub (name, "\\142", string.char(142));	-- �
				name = string.gsub (name, "\\148", string.char(148));	-- �
				name = string.gsub (name, "\\153", string.char(153));	-- �
				name = string.gsub (name, "\\129", string.char(129));	-- �
				name = string.gsub (name, "\\154", string.char(154));	-- �
				name = string.gsub (name, "\\225", string.char(225));	-- �

				table.insert(settings.profile.friends, name);
			end
		end
	end

	local loadMobs = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do
		
			local name = v:getAttribute("name");

			if( name ) then name = trim(name); end;

			if( name ) then 
				
				-- fix, because getAttribute seems not to recognize the escape characters
				-- for special ASCII characters
				name = string.gsub (name, "\\132", string.char(132));	-- �
				name = string.gsub (name, "\\142", string.char(142));	-- �
				name = string.gsub (name, "\\148", string.char(148));	-- �
				name = string.gsub (name, "\\153", string.char(153));	-- �
				name = string.gsub (name, "\\129", string.char(129));	-- �
				name = string.gsub (name, "\\154", string.char(154));	-- �
				name = string.gsub (name, "\\225", string.char(225));	-- �

				table.insert(settings.profile.mobs, name);
			end
		end
	end

	local hf_temp = _name;	-- remember profile name shortly

	for i,v in pairs(elements) do
		local name = v:getName();

		if( string.lower(name) == "options" ) then
			loadOptions(v);
		elseif( string.lower(name) == "hotkeys" ) then
			loadHotkeys(v);
		elseif( string.lower(name) == "skills" ) then
			loadSkills(v);
		elseif( string.lower(name) == "friends" ) then
			loadFriends(v);
		elseif( string.lower(name) == "mobs" ) then
			loadMobs(v);
		elseif( string.lower(name) == "onload" ) then
			loadOnLoadEvent(v);
		elseif( string.lower(name) == "ondeath" ) then
			loadOnDeathEvent(v);
		elseif( string.lower(name) == "onleavecombat" ) then
			loadOnLeaveCombatEvent(v);
		elseif( string.lower(name) == "onlevelup" ) then
			loadOnLevelupEvent(v);
		elseif( string.lower(name) == "onskillcast" ) then
			loadOnSkillCastEvent(v);
		elseif( string.lower(name) == "skills_warrior"  and
		        player.Class1 == CLASS_WARRIOR ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_scout"  and
		        player.Class1 == CLASS_SCOUT ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_rogue"  and
		        player.Class1 == CLASS_ROGUE ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_mage"  and
		        player.Class1 == CLASS_MAGE ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_priest"  and
		        player.Class1 == CLASS_PRIEST ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_knight"  and
		        player.Class1 == CLASS_KNIGHT ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_warden"  and
		        player.Class1 == CLASS_WARDEN ) then
			loadSkills(v);
		elseif( string.lower(name) == "skills_druid"  and
		        player.Class1 == CLASS_DRUID ) then
			loadSkills(v);
		else		-- warning for other stuff and misspellings
			if ( string.lower(name) ~= "skills_warrior"     and
			     string.lower(name) ~= "skills_scout"       and
		 	     string.lower(name) ~= "skills_rogue"       and
	 		     string.lower(name) ~= "skills_mage"        and
			     string.lower(name) ~= "skills_priest"      and
			     string.lower(name) ~= "skills_knight"      and
			     string.lower(name) ~= "skills_warden"  and
			     string.lower(name) ~= "skills_druid" )     then
				cprintf(cli.yellow, tostring(language[60]), string.lower(tostring(name)),
					tostring(hf_temp));
			end;
		end
	end

	-- Check if the player has any ranged damage skills
	local rangedSkills = false;
	for i,v in pairs(settings.profile.skills) do

		if( v.Range > 100  and
			( v.Type == STYPE_DAMAGE or
			  v.Type == STYPE_DOT ) ) then
			rangedSkills = true;
			printf(language[176], v.Name);		-- Ranged skill found
			break;
		end
	end

	if( rangedSkills == false and settings.profile.options.COMBAT_RANGED_PULL ) then
		printf(language[200]);
		settings.profile.options.COMBAT_RANGED_PULL = false;
	end


	function checkProfileHotkeys(name)
		if( not settings.profile.hotkeys[name] ) then
			error("ERROR: Hotkey not set for this profile: " ..name, 0);
		end
	end

	-- Check to make sure everything important is set
--	checkProfileHotkeys("ATTACK");
-- no more needed because of using RoMScript("UseSkill(1,1);"); instead

	-- default combat type if not in profile defined
	if( settings.profile.options.COMBAT_TYPE ~= "ranged" and 
	    settings.profile.options.COMBAT_TYPE ~= "melee" ) then
		if( player.Class1 == CLASS_WARRIOR or
		    player.Class1 == CLASS_ROGUE   or
		    player.Class1 == CLASS_WARDEN  or
		    player.Class1 == CLASS_KNIGHT  ) then
			settings.profile.options.COMBAT_TYPE  = "melee";
		elseif(
		    player.Class1 == CLASS_PRIEST  or
		    player.Class1 == CLASS_SCOUT   or
		    player.Class1 == CLASS_DRUID   or
		    player.Class1 == CLASS_MAGE    ) then
			settings.profile.options.COMBAT_TYPE  = "ranged";
		else
			error("undefined player.Class1 in settings.lua", 0);
		end;
	end

	-- print error if new macro option isn't defined
	if( not settings.profile.hotkeys.MACRO ) then
		cprintf(cli.yellow, language[900]);
		cprintf(cli.yellow, language[901]);
		cprintf(cli.yellow, language[902]);
		cprintf(cli.yellow, language[903]);
		cprintf(cli.yellow, language[904], "VK_0"); -- TODO: Change VK_0 to the actual hotkey we should use
		local msg = sprintf(language[905], _name);
		if( not settings.profile.options.IGNORE_MACRO_ERROR) then -- only temporary, can be deleted later
			error(msg, 0);
		end
	end

	-- check if new macro option is working / ingame macro defined and assigned
	-- check it with a function with defined return values
	settings.options.DEBUGGING_MACRO = true;
	local hf_return = RoMScript("1234;ChatFrame1:AddMessage(\"MACRO test: send value 1234 to macro place 2\");");
	if( hf_return ~= 1234 ) then	-- return values not found
		 	RoMScript("ChatFrame1:AddMessage(\"MACRO test: test failed !!! No return values found!\");");	-- overwrite return values
			cprintf(cli.yellow, language[906] );	-- Define ingame an empty macro 

			if ( settings.profile.hotkeys.MACRO.key) then
				hf_temp = getKeyName(settings.profile.hotkeys.MACRO.key);
			else
				local hf_temp ="<UNKNOWN>";	-- if ignore, key must not be set, so give value
			end

			local msg = sprintf(language[904], hf_temp );

			if( settings.profile.options.IGNORE_MACRO_ERROR == true ) then	-- only temporary, can be deleted later
				cprintf(cli.yellow, msg);		
			else							-- ignore MACRO error
				error(msg, 0);
			end
	else								-- return values found, clear it and send message
		RoMScript("xxxx; ChatFrame1:AddMessage(\"MACRO test: successful\");");	-- overwrite values
	end
	settings.options.DEBUGGING_MACRO = false;

end