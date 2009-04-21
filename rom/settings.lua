settings = {
	hotkeys = {},
	profile = { options = {}, hotkeys = {}, skills = {}, friends = {} }
};

function settings.load()
	local filename = getExecutionPath() .. "/settings.xml";
	local root = xml.open(filename);
	local elements = root:getElements();

	-- Specific to loading the hotkeys section of the file
	local loadHotkeys = function (node)
		local elements = node:getElements();
		for i,v in pairs(elements) do
			-- If the hotkey doesn't exist, create it.
			settings.hotkeys[ v:getAttribute("description") ] = { };
			settings.hotkeys[ v:getAttribute("description") ].key = key[v:getAttribute("key")];
			settings.hotkeys[ v:getAttribute("description") ].modifier = key[v:getAttribute("modifier")];
		end
	end

	for i,v in pairs(elements) do
		local name = v:getName();

		if( string.lower(name) == "hotkeys" ) then
			loadHotkeys(v);
		end
	end

	function checkHotkeys(name)
		if( not settings.hotkeys[name] ) then
			error("ERROR: Global hotkey not set: " .. name, 0);
		end
	end

	-- Check to make sure everything important is set
	checkHotkeys("MOVE_FORWARD");
	checkHotkeys("MOVE_BACKWARD");
	checkHotkeys("ROTATE_LEFT");
	checkHotkeys("ROTATE_RIGHT");
	checkHotkeys("STRAFF_LEFT");
	checkHotkeys("STRAFF_RIGHT");
	checkHotkeys("JUMP");
	checkHotkeys("CLEAR_TARGET");
	checkHotkeys("TARGET");
end


function settings.loadProfile(name)
	settings.profile = { options = {}, hotkeys = {}, skills = {}, friends = {} } -- Delete old settings.

	local filename = getExecutionPath() .. "/profiles/" .. name .. ".xml";
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

			table.insert(settings.profile.skills, tmp);
		end

		table.sort(settings.profile.skills, skillSort);

	end

	local loadFriends = function(node)
		local elements = node:getElements();

		for i,v in pairs(elements) do
			local name = v:getAttribute("name");
			table.insert(settings.profile.friends, name);
		end
	end

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
		end
	end


	function checkProfileHotkeys(name)
		if( not settings.profile.hotkeys[name] ) then
			error("ERROR: Hotkey not set for this profile: " ..name, 0);
		end
	end

	-- Check to make sure everything important is set
	checkProfileHotkeys("ATTACK");
	if( settings.profile.options.COMBAT_TYPE ~= "ranged" and settings.profile.options.COMBAT_TYPE ~= "melee" ) then
		error("COMBAT_TYPE must be \"ranged\" or \"melee\"", 0);
	end
end