-- Skill types
STYPE_DAMAGE = 0
STYPE_HEAL = 1
STYPE_BUFF = 2
STYPE_DOT = 3
STYPE_HOT = 4
STYPE_SUMMON = 5

-- Target types
STARGET_ENEMY = 0
STARGET_SELF = 1
STARGET_FRIENDLY = 2
STARGET_PET = 3

CSkill = class(
	function (self, copyfrom)
		self.Name = "";
		self.aslevel = 0;		-- player level, >= that skill can be used
		self.skilltab = nil;	-- skill tab number
		self.skillnum = nil;	-- number of the skill at that skill tab
		self.Mana = 0;
		self.Rage = 0;
		self.Energy = 0;
		self.Concentration = 0;
		self.Range = 20;
		self.MinRange = 0; -- Must be at least this far away to cast
		self.CastTime = 0;
		self.Cooldown = 0;
		self.LastCastTime = { low = 0, high = 0 }; 	-- getTime() in ms
		self.Type = STYPE_DAMAGE;
		self.Target = STARGET_ENEMY;
		self.InBattle = nil; -- "true" = usable only in battle, false = out of battle
		self.ManaInc = 0; -- Increase in mana per level
		self.Level = 1;

		-- Information about required buffs/debuffs
		self.ReqBuffType = ""; -- Either 'buff' or 'debuff'
		self.ReqBuffCount = 0;
		self.ReqBuffTarget = "player";
		self.ReqBuffName = ""; -- Name of the buff/debuff

		self.AutoUse = true; -- Can be used automatically by the bot

		self.TargetMaxHpPer = 100;	-- Must have less than this % HP to use
		self.TargetMaxHp = 9999999;	-- Must have less than this HP to use
		self.MaxHpPer = 100;	-- Must have less than this % HP to use
		self.MaxManaPer = 100;	-- Must have less than this % Mana to use
		self.MinManaPer = 0;	-- Must have more then this % Mana to use
		self.Toggleable = false;
		self.Toggled = false;
		
		self.pullonly = false;	-- use only in pull phase (only for melees with ranged pull attacks)
		self.maxuse = 0;	-- use that skill only x-times per fight
		self.rebuffcut = 0;	-- reduce cooldown for x seconds to rebuff earlier
		self.used = 0;		-- how often we used that skill in current fight

		self.hotkey = 0;
		self.modifier = 0;

		self.priority = 0; -- Internal use


		if( type(copyfrom) == "table" ) then
			self.Name = copyfrom.Name;
			self.Mana = copyfrom.Mana;
			self.Rage = copyfrom.Rage;
			self.Energy = copyfrom.Energy;
			self.Concentration = copyfrom.Concentration;
			self.Range = copyfrom.Range;
			self.MinRange = copyfrom.MinRange;
			self.CastTime = copyfrom.CastTime;
			self.Cooldown = copyfrom.Cooldown;
			self.Type = copyfrom.Type;
			self.Target = copyfrom.Target;
			self.InBattle = copyfrom.InBattle;
			self.ManaInc = copyfrom.ManaInc;
			self.TargetMaxHpPer = copyfrom.TargetMaxHpPer;
			self.TargetMaxHp = copyfrom.TargetMaxHp;
			self.MaxHpPer = copyfrom.MaxHpPer;
			self.MaxManaPer = copyfrom.MaxManaPer;
			self.MinManaPer = copyfrom.MinManaPer;
			self.Toggleable = copyfrom.Toggleable;
			self.priority = copyfrom.priority;
			self.pullonly = copyfrom.pullonly;
			self.maxuse = copyfrom.maxuse;
			self.rebuffcut = copyfrom.rebuffcut;
			self.aslevel = copyfrom.aslevel;
			self.skilltab = copyfrom.skilltab;
			self.skillnum = copyfrom.skillnum;
			self.ReqBuffType = copyfrom.ReqBuffType;
			self.ReqBuffCount = copyfrom.ReqBuffCount;
			self.ReqBuffTarget = copyfrom.ReqBuffTarget;
			self.ReqBuffName = copyfrom.ReqBuffName;
		end
	end
);


function CSkill:canUse(_only_friendly, target)
	if( target == nil ) then
		player:update();
		target = player:getTarget();
	end
	if( self.hotkey == 0 ) then return false; end; --hotkey must be set!

	-- a local function to make it more easy to insert debuging lines
	-- you have to insert the correspointing options into your profile
	-- at the <onLoad> event to set the right values
	-- 	settings.profile.options.DEBUG_SKILLUSE.ENABLE = true;
	--	settings.profile.options.DEBUG_SKILLUSE.TIMEGAP = true;

	local function debug_skilluse(_reason, _arg1, _arg2, _arg3, _arg4, _arg5, _arg6 )
		
		-- return if debugging / detail  is disabled
		if( not settings.profile.options.DEBUG_SKILLUSE.ENABLE ) then return; end
		if( settings.profile.options.DEBUG_SKILLUSE[_reason] == false ) 	then  return; end;
--		if( _reason == "ONCOOLDOWN"	and  not settings.profile.options.DEBUG_SKILLUSE.ONCOOLDOWN ) 	then  return; end;
--		if( _reason == "NOCOOLDOWN"	and  not settings.profile.options.DEBUG_SKILLUSE.NOCOOLDOWN ) 	then  return; end;
--		if( _reason == "HPLOW" 		and  not settings.profile.options.DEBUG_SKILLUSE.HPLOW ) 		then  return; end;
	
		local function make_printable(_v)
			if(_v == true) then
				_v = "<true>";
			end
			if(_v == false) then
				_v = "<false>";
			end
			if( type(_v) == "table" ) then
				_v = "<table>";
			end
			if( type(_v) == "number" ) then
				_v = sprintf("%d", _v);
			end
			return _v
		end
	
		local hf_arg1, hf_arg2, hf_arg3, hf_arg4, hf_arg5, hf_arg6 = "", "", "", "", "", "";
		if(_arg1) then hf_arg1 = make_printable(_arg1); end;
		if(_arg2) then hf_arg2 = make_printable(_arg2); end;
		if(_arg3) then hf_arg3 = make_printable(_arg3); end;
		if(_arg4) then hf_arg4 = make_printable(_arg4); end;
		if(_arg5) then hf_arg5 = make_printable(_arg5); end;
		if(_arg6) then hf_arg6 = make_printable(_arg6); end;


		local msg = sprintf("[DEBUG] %s %s %s %s %s %s %s %s\n", _reason, self.Name, hf_arg1, hf_arg2, hf_arg3, hf_arg4, hf_arg5, hf_arg6 ) ;
		
		cprintf(cli.yellow, msg);
		
	end

	--local target = player:getTarget();	-- get target fields

	-- only friendly skill types?
	if( _only_friendly ) then
		if( self.Type ~= STYPE_HEAL  and
		    self.Type ~= STYPE_BUFF  and
			self.Type ~= STYPE_SUMMON and
		    self.Type ~= STYPE_HOT ) then
		    debug_skilluse("ONLYFRIENDLY", self.Type);
			return false;
		end;
	end


	-- Still cooling down...
	local prior = getSkillUsePrior();

	if( deltaTime(getTime(), self.LastCastTime) < 
		  (self.Cooldown*1000 - self.rebuffcut*1000 - prior) ) then	-- Cooldown is in sec
		debug_skilluse("ONCOOLDOWN", self.Cooldown*1000-self.rebuffcut*1000 - deltaTime(getTime(), self.LastCastTime) );
		return false;
--	else
--		debug_skilluse("NOCOOLDOWN", deltaTime(getTime(), self.LastCastTime) - self.Cooldown*1000-self.rebuffcut*1000 );
	end


	-- You don't meet the maximum HP percent requirement
	if( player.MaxHP == 0 ) then player.MaxHP = 1; end; -- prevent division by zero
	if( (self.MaxHpPer < 0 and -1 or 1) * (player.HP / player.MaxHP * 100) > self.MaxHpPer ) then
		debug_skilluse("MAXHPPER", player.HP/player.MaxHP*100, self.MaxHpPer);
		return false;
	end

	-- You are not below the maximum Mana Percent
	if( (self.MaxManaPer < 0 and -1 or 1) * (player.Mana/player.MaxMana*100) > self.MaxManaPer ) then
		debug_skilluse("MAXMANAPER", (player.Mana/player.MaxMana*100), self.MaxManaPer);
		return false;
	end

	-- You are not above the minimum Mana Percent
	if( (player.Mana/player.MaxMana*100) < self.MinManaPer ) then
		debug_skilluse("MINMANAPER", (player.Mana/player.MaxMana*100), self.MinManaPer);
		return false;
	end

	-- Not enough rage/energy/concentration
	if(  player.Rage < self.Rage or player.Energy < self.Energy
		or player.Concentration < self.Concentration ) then
		debug_skilluse("NORAGEENERGYCONCEN");
		return false;
	end

	-- This skill cannot be used in battle
--	if( (player.Battling or player.Fighting) and self.InBattle == false ) then
	if( player.Battling  and self.InBattle == false ) then
		debug_skilluse("NOTINBATTLE", player.Battling, player.Fighting);
		return false;
	end

	-- This skill can only be used in battle
	if( not player.Battling and self.InBattle == true ) then
		debug_skilluse("ONLYINBATTLE", player.Battling);
		return false;
	end   

	-- check if hp below our HP_LOW level
	if( self.Type == STYPE_HEAL or self.Type == STYPE_HOT ) then
		local hpper = (player.HP/player.MaxHP * 100);

		if( self.MaxHpPer ~= 100 ) then
			if( hpper > self.MaxHpPer ) then
				return false;
			end
		else
			-- Inherit from settings' HP_LOW
			if( hpper > settings.profile.options.HP_LOW ) then
				debug_skilluse("HPLOW", hpper, "greater as setting", settings.profile.options.HP_LOW );
				return false;
			end
		end
	end


	-- skill with maximum use per fight
	if( self.maxuse > 0 and
	    self.used >= self.maxuse ) then
	    debug_skilluse("MAXUSE", self.used, self.maxuse);
		return false
	end

	-- Needs an enemy target
	if( self.Target == STARGET_ENEMY ) then
		if( not player:haveTarget() ) then
			debug_skilluse("TARGETNOENEMY");
			return false;
		end
	end

	-- DOTs require the enemy to have > X% hp
	if( self.Type == STYPE_DOT ) then
		local hpper = (target.HP / target.MaxHP) * 100;
		if( hpper < settings.profile.options.DOT_PERCENT ) then
			debug_skilluse("DOTHPPER", hpper, settings.profile.options.DOT_PERCENT);
			return false;
		end;
	end

	-- only if target HP % is below given level
	if( target  and  ((self.TargetMaxHpPer < 0 and -1 or 1) * (target.HP/target.MaxHP*100)) > self.TargetMaxHpPer ) then
		debug_skilluse("TARGETHPPER", target.HP/target.MaxHP*100 );
		return false;
	end

	-- only if target HP points is below given level
	if( target  and  ((self.TargetMaxHp < 0 and -1 or 1) * target.HP) > self.TargetMaxHp ) then
		debug_skilluse("TARGEHP", target.HP );
		return false;
	end

	-- Out of range
	if( player:distanceToTarget() > self.Range  and
	    self.Target ~= STARGET_SELF  ) then		-- range check only if no selftarget skill
	    debug_skilluse("OUTOFRANGE", player:distanceToTarget(), self.Range );
		return false;
	end

	-- Too close
	if( player:distanceToTarget() < self.MinRange  and
	    self.Target ~= STARGET_SELF  ) then		-- range check only if no selftarget skill
	    debug_skilluse("MINRANGE", player:distanceToTarget(), self.MinRange );
		return false;
	end

	-- check pullonly skills
	if( self.pullonly == true and
	    not player.ranged_pull ) then
	    debug_skilluse("PULLONLY");
		return false
	end
	
	-- Not enough mana
	if( player.Mana < math.ceil(self.Mana + (self.Level-1)*self.ManaInc) ) then
		debug_skilluse("NOTENOUGHMANA", player.Mana, math.ceil(self.Mana + (self.Level-1)*self.ManaInc));
		return false;
	end

	-- Already have a pet out
	if( self.Type == STYPE_SUMMON and player.PetPtr ~= 0 ) then
		debug_skilluse("PETALREAYDOUT");
		return false;
	end

	if( self.Toggleable and self.Toggled == true ) then
		debug_skilluse("TOGGLED");
		return false;
	end

	-- Check required buffs/debuffs
	if( self.ReqBuffName ~= "" ) then
		local checktab;

		if( self.ReqBuffTarget == "player" ) then
			if( self.ReqBuffType == "buff" ) then
				checktab = player.Buffs;
			else
				checktab = player.Debuffs;
			end;
		elseif( self.ReqBuffTarget == "target" ) then
			if( self.ReqBuffType == "buff" ) then
				checktab = target.Buffs;
			else
				checktab = target.Debuffs;
			end;
		end

		if( self.ReqBuffCount > (checktab[self.ReqBuffName] or 0) ) then
			return false;
		end;
	end

	return true;
end


function CSkill:use()
	local estimatedMana;
	if( self.MinManaPer > 0 ) then
		estimatedMana = math.ceil((self.MinManaPer/100)*player.MaxMana);
	else
		estimatedMana = math.ceil(self.Mana + (self.Level-1)*self.ManaInc);
	end

	local target = player:getTarget();

	if( self.hotkey == nil ) then
		local str = sprintf("Bad skill hotkey name: %s", tostring(self.Name));
		error(str);
	end

	self.used = self.used + 1;	-- count use of skill per fight
--	self.LastCastTime = os.time() + self.CastTime;


	-- set LastCastTime, thats the current key press time plus the casting time (if there is some)
	-- self.CastTime is in sec, hence * 1000
	-- every 1 ms in self.LastCastTime.low ( from getTime() ) is about getTimerFrequency().low
	-- we calculate the value at bot start time
	self.LastCastTime = getTime();
	self.LastCastTime.low = self.LastCastTime.low + self.CastTime*1000 * bot.GetTimeFrequency;
	if self.CastTime > 0 then player.LastSkillCastTime = self.CastTime end
	if self.CastTime > 0 then player.LastSkillType = self.Type end
	-- wait for global cooldown gap (1000ms) between skill use
	-- there are different 'waits' in the bot:
	-- at CPlayer:cast(skill): for the casting flag gone
	-- at CPlayer:checkSkills(): for the casting flag gone
	-- and here to have a minimum delay between the keypresses
	-- 850/900 will work after skills without casting time, but will result in misses 
	-- after skills that have a casting time
	local prior = getSkillUsePrior();

	while( deltaTime(getTime(), bot.LastSkillKeypressTime) < 
		settings.profile.options.SKILL_GLOBALCOOLDOWN - prior ) do
		yrest(10);
	end

	-- debug time gap between casts
	if( settings.profile.options.DEBUG_SKILLUSE.ENABLE  and
		settings.profile.options.DEBUG_SKILLUSE.TIMEGAP ) then 
		local hf_casting = "false";
		if(player.Casting) then hf_casting = "true"; end;
		local msg = sprintf("[DEBUG] gap between skilluse %d, pcasting=%s\n", 
		  deltaTime(getTime(), bot.LastSkillKeypressTime), hf_casting );
		cprintf(cli.yellow, msg);
	end

	-- Make sure we aren't already busy casting something else, thats only neccessary after
	-- skills with a casting timess
	--[[local start_wait = getTime();
	while(player.Casting) do -- this is done in CPlayer:cast()
		if( deltaTime(getTime(), start_wait ) > 6000 ) then break; end;	-- in case there is a client update bug
		-- Waiting for casting to finish...
		yrest(50);
		player:update();
	end]]

	bot.LastSkillKeypressTime = getTime();		-- remember time to check time-lag between casts

	
	if(self.hotkey == "MACRO" or self.hotkey == "" or self.hotkey == nil ) then
	
		-- hopefully skillnames in enus and eneu are the same
		local hf_langu;
		if(bot.ClientLanguage == "ENUS" or bot.ClientLanguage == "ENEU") then
			hf_langu = "en";
		else
			hf_langu = string.lower(bot.ClientLanguage);
		end

		if( database.skills[self.Name][hf_langu] ) then		-- is local skill name available?
			RoMScript("CastSpellByName('"..database.skills[self.Name][hf_langu].."');");
		elseif( self.skilltab ~= nil  and  self.skillnum ~= nil ) then
			RoMScript("UseSkill("..self.skilltab..","..self.skillnum..");");
		else
			cprintf(cli.yellow, "No local skillname in skills_local.xml. Please maintenance the file and send it to the developers.\n", self.Name);	
		end;
	else
		-- use the normal hotkeys
		keyboardPress(self.hotkey, self.modifier);
	end

	if( self.Toggleable ) then
		self.Toggled = true;
	end

end
