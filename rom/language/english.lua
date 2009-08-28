language = {
	[0] = "Loaded waypoint path %s\n",
	[1] = "Loaded return path %s\n",
	[2] = "Saved a screenshot to: %s\n",
	[3] = "Died. Resurrecting player...\n",
	[4] = "Returning to waypoints after 1 minute.\n",
	[5] = "Ignoring target (%s): Anti-KS\n",
	[6] = "Moving to waypoint #%d, (%d, %d)\n",
	[7] = "Completed return path. Resuming normal waypoints.\n",
	[8] = "Waypoint movement failed!\n",
	[9] = "Unsticking player... at position %d,%d. Trial %d from maximal %d trials\n",
	[10] = "Use %s: Using HP potion.\n",
	[11] = "Use %s: Using MP potion.\n",
	[12] = "Return path is closer then normal waypoints. Starting with return path!\n",	
	[13] = "Moving to return path waypoint #%d, (%d, %d)\n",
	[14] = "We get aggro. Stop moving to waypoint and wait for target.\n",	

	[20] = "Finished casting\n",
	[21] = "Use %s: %s",
	[22] = "Engaging enemy [%s] in combat.\n",
	[23] = "Target HP changed\n",
	[24] = "Too close. Backing up.\n",
	[25] = "Moving in | Suggested range: %d | Distance: %d\n",
	[26] = "Taking too long to turn... breaking\n",
	[27] = "Fight finished. Target dead/lost (fight #%d / runtime %d minutes)\n",
	[28] = "Stopping waypoint: Target acquired.\n",
	[29] = "Distance break.\n",
	[30] = "Target not attackable: %s\n",
	[31] = "Looting target in distance %d.\n",
	[32] = "Target too far away; not looting.\n",
	[33] = "Clearing target.\n",
	[34] = "Aggro wait time out.\n",
	[35] = "Waiting on aggressive enemies.\n",
	[36] = "Aggro during first strike/cast, abort that cast/target: %s\n",
	[37] = "Select new target %s in distance %d\n",
	[38] = "Resting up to %s to fill up mana and HP.\n",
	[39] = "Stop resting because of aggro.\n",	


	[40] = "Player address changed: 0x%X\n",
	[41] = "Failed to read memory",
	[42] = "RoM windows size is %dx%d, upper left corner at %d,%d\n",
	[43] = "The game may have been updated or altered.\n It is recommended that you run rom/update.lua\n\n",
	[44] = "Attempt to read playerAddress\n",
	[45] = "Multiple RoM windows found. Keep the RoM window to attach this bot to on top, and press %s.\n",
	[46] = "Paused. (%s) to continue, (CTRL+L) exit to shell, (CTRL+C) quit\n",
	[47] = "RoM window not found! RoM must be running first.",
	[48] = "Error while reading memory address for \'%s\'. Game seems to be changed!!! Please run \'rom/bot.lua update\' AND install the new RoM Bot version!",	

	[50] = "%s  Auto-logging out.\n",
	[51] = "Shutting system down.\n",
	[52] = "Window lost (Client crashed or closed?). You must re-start the script.",

	[60] = "Unknown tag %s found in profile %s.xml. Please check your profile!\n",
	[61] = "Invalid option \'%s\' for bot.lua\n\nSyntax: rom/bot.lua [profile:name] [path:name] [retpath:name]\n\nprofile:profname\tforce the use of profile \'profname.xml\'\npath:pathname\t\tforced the use of waypoint file \'pathname.xml\'\nretpath:retname\t\tforced the use of return waypoint path \'retname.xml\'\n",
	
	[70] = "Resting finished after %s seconds.\n",
	[71] = "Resting for %s seconds.\n",
	
	[80] = "Move in\n",
	[81] = "Unexpected interruption at harvesting begin. We will try it again.\n",
	[82] = "=>   * aborted *\n",
	[83] = "Taking too long to damage target, breaking sequence...\n",
	[84] = "To much tries to come closer. We stop attacking that target\n",
	[85] = "Error in your profile: onLeaveCombat error: %s",
	[86] = "Stopping waypoint: Target acquired before moving.\n",
	[87] = "We ignore %s for %s seconds.\n",
	[88] = "Runes of Magic process successfully closed.\n",
	[89] = "Go to sleep at %s. Press %s to wake up.\n",
	[90] = "Awake from sleep after pressing %s at %s.\n",
	[91] = "Awake from sleep because of aggro at %s.\n",
	[92] = "Mouseclick %s at %d,%d in %dx%d (recalculated from %d,%d by %dx%d)\n",
	[93] = "Mouseclick %s at %d,%d in %dx%d.\n",
	[94] = "The RoM window have to be in the foreground to be able to use the harvesting function. We can't harvest now!\n",
	[95] = "We found %s und will harvest it.\n",
	[96] = "We begin the fight with ranged pulling.\n",
	[97] = "Ranged pulling finished, mob in melee distance.\n",
	[98] = "Ranged pulling after 3 sec wait finished.\n",
	[99] = "Ranged pulling finished. Mob not really moving.\n",
	[100] = "We didn't move to the loot!? Please be sure you set ingame the standard attack to hotkey %s.\n",
	[101] = "Due to technical reasons, we can't use the character/profile name \'%s\' as a profile name. Please use profile name \'%s.xml\' instead or start the bot with a forced profile: \'rom\\bot.lua profile:xyz\'\nBot finished due to errors above.",
	[102] = "We can't find your profile \'%s.xml'\. Please create a valid profile within the folder \'rom\\profiles\' or start the bot with a forced profile: \'rom\\bot.lua profile:xyz\'\nBot finished due to errors above.",
	[103] = "If you want to use automatic resurrection then set option \'RES_AUTOMATIC_AFTER_DEATH = \"true\"\' within your profile.\n",
	[104] = "We will try to resurrect in 10 seconds.\n",
	[105] = "Try to resurrect at the place of death ...\n",
	[106] = "Try to resurrect at the spawnpoint ...\n",
	[107] = "Try to use the ingame resurrect macro ...\n",
	[108] = "You are still dead. There is a problem with automatic resurrection. Did you set your ingame macro \'/script AcceptResurrect();\' to the key %s?\n",
	[109] = "You have died %s times from at most %s deaths/automatic resurrections.\n",
	[111] = "You don't have a defined return path!!! We use the normal waypoint file \'%s\' instead. Please check that.\n",
	[112] = "Using normal waypoint file \'%s\' after resurrection.\n",
	[113] = "Waypoint type RUN, we don't stop and don't fight back\n",
	[114] = "Unsticking player... at position %d,%d. Trial %d.\n",
	[115] = "Error: The key for \'%s\' is empty!\n",
	[116] = "Error: The hotkey \'%s\' for \'%s\' is not a valid key!\n",
	[117] = "Error: The modifier \'%s\' for \'%s\' is not a valid key (VK_SHIFT, VK_ALT, VK_CONTROL)!\n",
	[118] = "Due to technical reasons, we don't support modifiers like CTRL/ALT/SHIFT for hotkeys at the moment. Please change your hotkey %s-%s for \'%s\'\n",
	[119] = "You can't use the player:target_NPC() function until changed!\n",
	[120] = "Please check your settings!",
	[121] = "Error: You assigned the key \'%s%s\' double: for \'%s\' and for \'%s\'.\n",
	[122] = "settings.xml error: %s does not have a valid hotkey!",
	[123] = "We read the hotkey settings from your bindings.txt file %s instead of using the settings.lua file.\n",
	[124] = "Error: There is no ingame hotkey for \'%s\'. Please set ingame a valid key.",
	[125] = "Your bot settings for hotkey \'%s\' in settings.xml don't match your RoM ingame keyboard settings.\nPlease check your settings!",
	[126] = "ERROR: Global hotkey not set: ",
	[127] = "Profile error: Please set a valid key for hotkey %s in your profile file \'%s.xml\'.",
	[128] = "The options \'mana\', \'manainc\', \'rage\', \'energy\', \'concentration\', \'range\', \'cooldown\', \'minrange\', \'type\', \'target\' and \'casttime\' are no valid options for your skill \'%s\' in your profile \'%s.xml\'. Please delete them and restart!\n",
	[129] = "The options \'modifier\' for your skill \'%s\' in your profile \'%s.xml\' is not supported at the moment. Please delete it and restart!\n",
	[130] = "You defined an \'empty\' skill name in your profile \'%s.xml\'. Please delete or correct that line!\n",
	[131] = "You defined an wrong option inbattle=\'%s\' at skill %s in your profile \'%s.xml\'. Please delete or correct that line!\n",
	[132] = "You defined an wrong option pullonly=\'%s\' at skill %s in your profile \'%s.xml\'. Only \'true\' is possible. Please delete or correct that line!\n",
	[133] = "target_NPC(): Please give a NPC name for using that function.\n",
	[134] = "Due to technical reasons, we don't support modifiers like CTRL/ALT/SHIFT for hotkeys at the moment. Please change your hotkey (and ingame key) %s-%s for hotkey TARGET_FRIEND.\n",
	[135] = "We try to find NPC %s: ",
	[136] = "\nWe successfully target NPC %s and try to open the dialog window.\n",
	[137] = "\nSorry, we can't find NPC %s.\n",
	[138] = "We didn't found any NPC! Have you set your ingame \'target friendly\' key to %s?\n",
	[139] = "The RoM window has to be in the foreground to be able to use the mouseclick function. We can't use mouseclick now!\n",
	[140] = "Please check your settings in file settings.xml and in your profile!\n",
	[141] = "Please check your settings: Ingame -> System -> Hotkeys and in your profile\n",
	[142] = "We can't find your waypoint file \'%s'\. Please create a valid waypoint file within the \'waypoints\' folder or enter the right filename.\nBot finished due to errors above.",
	[143] = "We can't find your return path file \'%s'\. Please create a valid return path file within the \'waypoints\' folder or enter the right filename.\nBot finished due to errors above.",

	
	[150] = "Failed to compile and run Lua code for waypoint #%d",
	[151] = "Failed to compile and run Lua code for %s in character profile.",
	
	-- createpath.lua
	[500] = "What do you want to name your path (without .xml)?\nName> ",
	[501] = "RoM waypoint creator\n",
	[502] = "Hotkeys:\n  (%s)\tInsert new waypoint (at player position)\n",
	[503] = "  (%s)\tInsert new harvest waypoint (at player position)\n",
	[504] = "  (%s)\tInsert target/dialog NPC waypoint\n",
	[505] = "  (%s)\tSave waypoints and quit\n",
	[506] = "  (%s)\tSave waypoints and restart\n",
	[507] = "What's the name of the NPC your want to target/dialog?\nName> ",
	[508] = "Recorded [#%3d] %s, Continue to next. Press %s to save and quit\n",
	[509] = "...\n",
	[510] = "...\n",
	
};