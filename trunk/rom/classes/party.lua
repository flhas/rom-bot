include("pawn.lua");
include("player.lua");

local _timexx, _firsttimes, partyleader, leaderobj, leaderpawn, stop, healer

function Party(heal)
	if heal then healer = true end
	eventParty("start")
	_timexx = os.time()
	while(true) do
		if memoryReadBytePtr(getProc(),addresses.loadingScreenPtr, addresses.loadingScreen_offset) ~= 0 then
			repeat
				printf("loading screen has appeared, waiting for it to end.\n")
				yrest(1000)
			until memoryReadBytePtr(getProc(),addresses.loadingScreenPtr, addresses.loadingScreen_offset) == 0
		end
		PartyTable()
		yrest(200)
		player:update()
		local playericon = player:GetPartyIcon()
		if not player.Mounted then
			player:checkSkills(true);
			player:checkPotions();
				
			if playericon and playericon >= 4 then
				--=== If character has icon 4,5,6 or 7 then ===--
				--=== Kill leaders target ===--
				local mob = getTarget(getPartyLeaderName())
				if mob and mob.Type == PT_MONSTER then
					player:target(mob.Address)
					if heal then
						healfight()
					else
						player:fight()
					end
				end
			elseif settings.profile.options.ICON_FIGHT == true then
				--=== Find mobs with I icon and kill them ===--
				player:target(player:findEnemy(nil,nil,icontarget,nil)) 
				if player:haveTarget() then
					if heal then
						healfight()
					else
						player:fight()
					end
				end
			elseif not heal then
				player:target(player:findEnemy(nil, nil, evalTargetDefault, player.IgnoreTarget));
				if player:haveTarget() then
					player:fight();
				end		
			end	
			
			if heal then
				for i,v in ipairs(partymemberpawn) do
					player:target(partymemberpawn[i])
					player:update()
					partymemberpawn[i]:update()
					partymemberpawn[i]:updateBuffs()
					local target = player:getTarget();
					if target.HP/target.MaxHP*100 > 10 then
						player:checkSkills(true);
					end
				end
			end
			if player.Battling then
				player:target(player:findEnemy(true, nil, evalTargetDefault));
				if player:haveTarget() then
					if heal then
						healfight()
					else
						player:fight()
					end
				end				
			end
		end
		if (not player.Battling) then
			if settings.profile.options.LOOT == true and
				settings.profile.options.LOOT_ALL == true then 
				local Lootable = player:findEnemy(nil, nil, evalTargetLootable)
				if not Lootable then			
					getNameFollow()   --includes mount/dismount code
				else
					player:target(Lootable)
					player:update()
					if player.TargetPtr ~= 0 then
						player:lootAll()
					end
				end
			else
				getNameFollow()
			end
		end	
		Mount(true) -- check to (dismount only) even while in combat.
		partyCommands()
	end
end

function icontarget(address) -- looks for icon I on mobs
	local pawn = CPawn(address);
	local icon = pawn:GetPartyIcon()
	pawn:update()
	if icon == 1 then 
		return true
	end
end

function PartyTable()
		if _timexx == nil then
			_timexx = os.time()
		end
		partymemberpawn={}
		local partymemberName={}
		local partymemberObj={}

		table.insert(partymemberName,1, player.Name)  -- need to insert player name.
		table.insert(partymemberObj,1, player:findNearestNameOrId(player.Name))
		table.insert(partymemberpawn,1, CPawn(player.Address))
	for i = 1, 5 do
		if _firsttimes == nil then -- post party names when bot started
			if GetPartyMemberName(i) ~= nil then
				cprintf(cli.yellow,"Party member "..i.." has the name of ")
				cprintf(cli.red, GetPartyMemberName(i).."\n")
				_firsttimes = true
			end
		end
	
		if os.time() - _timexx >= 60  then --only post party names every 60 seconds
			if GetPartyMemberName(i) ~= nil then
				cprintf(cli.yellow,"Party member "..i.." has the name of ")
				cprintf(cli.red, GetPartyMemberName(i).."\n")
			_timexx = os.time()
			end
		end

		if GetPartyMemberName(i) then
			table.insert(partymemberName,i + 1, GetPartyMemberName(i))
			table.insert(partymemberObj,i + 1, player:findNearestNameOrId(partymemberName[i + 1]))
			if partymemberObj[i + 1] then
				table.insert(partymemberpawn,i + 1, CPawn(partymemberObj[i + 1].Address))
			end
		end
	end
end

function getPartyLeaderpawn()
	partyleader = getPartyLeaderName()	
	leaderobj = player:findNearestNameOrId(partyleader)
	if leaderobj then
		leaderpawn = CPawn(leaderobj.Address)
	end
end

function Mount(_dismount)
	local mounted
	getPartyLeaderpawn()
	if partyleader and leaderobj then
		local attackableFlag = memoryReadRepeat("int", getProc(), leaderobj.Address + addresses.pawnAttackable_offset) or 0;
		mounted = bitAnd(attackableFlag, 0x10000000)
		if not _dismount then
			if not player.Mounted then
				if mounted then 
					player:mount() 
				end
			end
		end
		if not mounted then
			if player.Mounted then
				player:dismount()
			end
		end
	end	
end

function getNameFollow()
	if stop then return end
	if ( settings.profile.options.PARTY_FOLLOW_NAME ) then
		for i = 1,5 do
			if GetPartyMemberName(i) == settings.profile.options.PARTY_FOLLOW_NAME  then RoMScript("FollowUnit('party"..i.."');"); Mount() return  end
		end	
		RoMScript("FollowUnit('party1');");
	else 
		RoMScript("FollowUnit('party1');");		
	end
	Mount()
end

function checkparty(_dist)
	local proc = getProc();
	local partyX, partyZ
	local _dist = _dist or 200
	PartyTable()
	local _go = true
	local partynum = RoMScript("GetNumPartyMembers()")
	if partynum == #partymemberpawn then
		player:update()
		for i = 2,#partymemberpawn do		
			partyX = memoryReadRepeat("float", proc, partymemberpawn[i].Address + addresses.pawnX_offset) or partymemberpawn[i].X
			partyZ = memoryReadRepeat("float", proc, partymemberpawn[i].Address + addresses.pawnZ_offset) or partymemberpawn[i].Z			
			if partyX ~= nil then 
				if distance(partyX,partyZ,player.X,player.Z) > _dist then
					_go = false
				end
			else
				_go = false
			end
		end
	else
		_go = false
	end
	return _go
end

function checkEventParty()
	repeat
		local time, moreToCome, name, msg = EventMonitorCheck("pm1", "4,1")
		if msg and name ~= player.Name then
			return msg, name
		end
	until msg == nil
end

function eventParty(_startstop)
	if _startstop == "stop" then
		print("Party Monitor stopped.")
		EventMonitorStop("pm1")
	else
		print("Party Monitor started.")
		EventMonitorStart("pm1", "CHAT_MSG_PARTY")
	end
end

function sendPartyChat(_msg)
	RoMScript("SendChatMessage('".._msg.."', 'PARTY')")
	cprintf(cli.blue,_msg.."\n")
end

function getPartyLeaderName()
	--local name = memoryReadString(getProc(), addresses.partyLeader_address)
	local name = memoryReadString(getProc(), 0x9FBF18)
	if( bot.ClientLanguage == "RU" ) then
		name = utf82oem_russian(name)
	else
		name = utf8ToAscii_umlauts(name)
	end		
	return name	
end

function getTarget(name)
	local ll = player:findNearestNameOrId(name)
	local leader
	if ll then
		leader = CPawn(ll.Address)
	end
	if leader then
		local target = CPawn(leader.TargetPtr)
		return target
	end
end

function getQuestNameStatus(_name)

	i = 0
	repeat
		i = i + 1
		local index, catalogID, name, track, level, daily, bDaily_num, iQuestType, 
		questID, completed, QuestGroup = RoMScript("GetQuestInfo("..i..")")
		if name ~= nil then 
			if string.find(string.lower(name),string.lower(_name)) then 
				return name, completed
			end
		end
	until name == nil
	return nil
end

function partyCommands()

	local _message , _name = checkEventParty()
	if _message then
		--=== check type of command ===--
		local _npc, _quest, _command, _choice
		_quest = string.match(_message,"quest\"(.*)\"")
		_npc = string.match(_message,"npc\"(.*)\"")
		_command = string.match(_message,"com\"(.*)\"")
		if _quest then _quest = string.lower(_quest) end
		if _npc then _npc = string.lower(_npc) end
		if _command then _command = string.lower(_command) end
		
		if _quest then
			local quest, status = getQuestNameStatus(_quest)
			if quest == nil then 
				sendPartyChat("no quest with that name")
			else
				if status then 
					sendPartyChat("quest: "..quest.." ,completed") 
				else
					sendPartyChat("quest: "..quest.." ,incomplete")
				end
			end
		elseif _npc == "sell" then
			local npc = getTarget(_name)
			if npc then
				player:merchant(npc.Name)
				sendPartyChat("finished with NPC")
			else
				sendPartyChat("npc: No target")
			end
		elseif _npc == "accept" or _npc == "complete" then
			local npc = getTarget(_name)
			if npc then
				player:target_NPC(npc.Name)
				CompleteQuestByName()
				player:target_NPC(npc.Name)
				AcceptQuestByName()
				sendPartyChat("finished with NPC")
			else
				sendPartyChat("npc: No target")
			end
		elseif _npc then
			local npc = getTarget(_name)
			if npc then
				player:target_NPC(npc.Name)			
				if ChoiceOptionByName(_npc) then
					sendMacro('StaticPopup_OnClick(StaticPopup1, 1);')
					waitForLoadingScreen(10)
					sendPartyChat("ok choice option done")
				else
					sendPartyChat("no option available by that name")
				end
			else
				sendPartyChat("npc: No target")			
			end
		elseif _command == "nofollow" then
			keyboardPress(settings.hotkeys.MOVE_FORWARD.key);
			stop = true
			sendPartyChat("stopped following")
		elseif _command == "follow" then
			stop = false
			sendPartyChat("following")
		elseif _command == "farm" then
			if not healer then 
				settings.profile.options.ICON_FIGHT = false
				sendPartyChat("Set to farm mobs")
			end
		elseif _command == "icon" then
				settings.profile.options.ICON_FIGHT = true
				sendPartyChat("Set to kill icon I")
		elseif _command == "portal" then
			if GoThroughPortal then 
				if GoThroughPortal(200) == true then
					sendPartyChat("I should be through the portal now")
				else
					sendPartyChat("I didn't see a loadingscreen, please check I went through portal")
				end
			else
				sendPartyChat("please get GoThroughPortal to make that work")
			end
		end
	end
end

function PartyHeals() -- backward compatible
	Party(true)
 end

function PartyDPS() -- backward compatible
	Party()
end	

function healfight()
	if not settings.profile.options.HEAL_FIGHT then return end
	player:update();
	if( not player:haveTarget() ) then
		return false;
	end
	local mob = player:getTarget();
	player.Fighting = true;
	cprintf(cli.green, language[22], mob.Name);	-- engagin x in combat
	player.lastHitTime = os.time();
	local lastTargetHP = mob.HP;
	local move_closer_counter = 0;	-- count move closer trys
	player.Cast_to_target = 0;		-- reset counter cast at enemy target
	player.ranged_pull = false;		-- flag for timed ranged pull for melees
	local hf_start_dist = 0;		-- distance to mob where we start the fight
	local break_fight = false;	-- flag to avoid kill counts for breaked fights
	BreakFromFight = false -- For users to manually break from fight using player:breakFight()
	while( mob.Alive or mob.HP > 1 ) do
		player:update();
		-- If we die, break
		if( player.HP < 1 or player.Alive == false ) then
			player.Fighting = false;
			break_fight = true;
			break;
		end;
		if BreakFromFight == true then
			break_fight = true;
			break;
		end
		if( mob.HP ~= lastTargetHP ) then
			player.lastHitTime = os.time();
			lastTargetHP = mob.HP;
		end
		--=== heal party before attacking ===--
		for i,v in ipairs(partymemberpawn) do
			player:target(partymemberpawn[i])
			player:update()
			partymemberpawn[i]:update()
			local party = player:getTarget();
			if party.HP/party.MaxHP*100 > 10 then
				player:checkSkills(true);
			end
		end	
		-- Long time break: Exceeded max fight time (without hurting enemy) so break fighting
		if( os.difftime(os.time(), player.lastHitTime) > settings.profile.options.MAX_FIGHT_TIME ) then
			printf(language[83]);			-- Taking too long to damage target
			player.Last_ignore_target_ptr = player.TargetPtr;	-- remember break target
			player.Last_ignore_target_time = os.time();		-- and the time we break the fight
			player:clearTarget();

			if( player.Battling ) then
				yrest(1000);
			   keyboardHold( settings.hotkeys.MOVE_BACKWARD.key);
			   yrest(1000);
			   keyboardRelease( settings.hotkeys.MOVE_BACKWARD.key);
			   player:update();
			end
			break_fight = true;
			break;
		end
		local dist = distance(player.X, player.Z, mob.X, mob.Z);
		if( hf_start_dist == 0 ) then		-- remember distance we start the fight
			hf_start_dist = dist;
		end
		-- Move closer to the target if needed
		local suggestedRange = settings.options.MELEE_DISTANCE;
		if( suggestedRange == nil ) then suggestedRange = 45; end;
		if( settings.profile.options.COMBAT_TYPE == "ranged" or
		  player.ranged_pull == true ) then
			if( settings.profile.options.COMBAT_DISTANCE ~= nil ) then
				suggestedRange = settings.profile.options.COMBAT_DISTANCE;
			else
				suggestedRange = 155;
			end
		end
		if( dist > suggestedRange and not player.Casting ) then
			-- count move closer and break if to much
			move_closer_counter = move_closer_counter + 1;		-- count our move tries
			if( move_closer_counter > 3  and
			  (settings.profile.options.COMBAT_TYPE == "ranged" or
			  player.ranged_pull == true) ) then
				cprintf(cli.green, language[84]);	-- To much tries to come closer
				player:clearTarget();
				break_fight = true;
				break;
			end
			printf(language[25], suggestedRange, dist);
			-- move into distance
			local success, reason;
			if dist > suggestedRange then -- move closer
				success, reason = player:moveTo(mob, true, nil, suggestedRange);
			end
			yrest(500);
		end
		if mob then 
			player:target(mob) -- make sure to target mob again after healing
			if( settings.profile.options.QUICK_TURN ) then
				local angle = math.atan2(mob.Z - player.Z, mob.X - player.X);
				local yangle = math.atan2(mob.Y - player.Y, ((mob.X - player.X)^2 + (mob.Z - player.Z)^2)^.5 );
				player:faceDirection(angle, yangle);
				camera:setRotation(angle);
				yrest(50);
			end		
			if( player:checkPotions() or player:checkSkills() ) then
				player.LastDistImprove = os.time();
			end
		end
		mob:update()
		yrest(100);
	end
	player:resetSkills();
	player.Cast_to_target = 0;	-- reset cast to target counter
	-- check if onLeaveCombat event is used in profile
	if( type(settings.profile.events.onLeaveCombat) == "function" ) then
		local status,err = pcall(settings.profile.events.onLeaveCombat);
		if( status == false ) then
			local msg = sprintf(language[85], err);
			error(msg);
		end
	end
	player.Fighting = false;
	yrest(200);
end