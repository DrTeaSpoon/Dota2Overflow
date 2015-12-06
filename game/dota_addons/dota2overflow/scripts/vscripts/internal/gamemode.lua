-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:AbilityChoise(choises)
	if not GameRules.PlayerAbs then
	GameRules.PlayerAbs = {}
	GameRules.PlayerCustomHero = {}
	end
	local pID = choises.PlayerID
	GameRules.PlayerAbs[pID] = {}
	--DeepPrintTable(choises)
	GameRules.PlayerAbs[pID][1] = choises.ability_q
	GameRules.PlayerAbs[pID][2] = choises.ability_w
	GameRules.PlayerAbs[pID][3] = choises.ability_e
	GameRules.PlayerAbs[pID][4] = choises.ability_d
	GameRules.PlayerAbs[pID][5] = choises.ability_f
	GameRules.PlayerAbs[pID][6] = choises.ability_r
	GameRules.PlayerCustomHero[pID] = {}
	GameRules.PlayerCustomHero[pID].points =	choises.hero_points
	--GameRules.PlayerCustomHero[pID].pri =	choises.hero_pri
	GameRules.PlayerCustomHero[pID].str =	choises.hero_str
	GameRules.PlayerCustomHero[pID].str_g =	choises.hero_str_g
	GameRules.PlayerCustomHero[pID].agi =	choises.hero_agi
	GameRules.PlayerCustomHero[pID].agi_g =	choises.hero_agi_g
	GameRules.PlayerCustomHero[pID].int =	choises.hero_int
	GameRules.PlayerCustomHero[pID].int_g =	choises.hero_int_g
	local tAbTempList = GameRules.AbilityListing
	for i = 1,6 do
		if not GameRules.PlayerAbs[pID] then GameRules.PlayerAbs[pID] = {} end
			if not GameRules.PlayerAbs[pID][i] or GameRules.PlayerAbs[pID][i] == "random" then
				GameRules.PlayerAbs[pID][i] = GameMode:RandomSkill(pID,i)
			end
			PrecacheItemByNameAsync(GameRules.PlayerAbs[pID][i], function()
		end)
	end
end

function GameMode:CustomChat(keys)
	local TO_WHO_MSG_HELP = -3
	local TO_WHO_MSG_TEAM = -2
	local TO_WHO_MSG_ALL = -1
	local pID = keys.PlayerID
	local team = PlayerResource:GetTeam(pID)
	local player = PlayerResource:GetPlayer(pID) 
	--print("server recieve and send")
	local Msg = keys.msg
	local nToWho = TO_WHO_MSG_TEAM
	if string.find(Msg, "/all ") then
		local i, j = string.find(Msg, "/all ")
		if i == 1 then
		print(Msg)
		Msg = string.sub(Msg, j)
		print(Msg)
		nToWho = TO_WHO_MSG_ALL
		end
	elseif string.find(Msg, "/help") then
		local i, j = string.find(Msg, "/help")
		if i == 1  and string.len(Msg) == 5 then
		nToWho = TO_WHO_MSG_HELP
		end
	end
	if nToWho == TO_WHO_MSG_ALL then
		Msg = "All> " .. Msg
		CustomGameEventManager:Send_ServerToAllClients('custom_chat_stc', {player=pID, msg=Msg}) 
	elseif nToWho == TO_WHO_MSG_TEAM then
		Msg = "Team> " .. Msg
		CustomGameEventManager:Send_ServerToTeam(team,'custom_chat_stc', {player=pID, msg=Msg})
	elseif nToWho == TO_WHO_MSG_HELP then
		Msg = "by default this chat sends to allies only. You can use '/all <text>' to chat with your foes."
		CustomGameEventManager:Send_ServerToPlayer(player,'custom_chat_stc', {player=pID, msg=Msg})
	end
end



function GameMode:TeamComStat(keys)
	local pID = keys.PlayerID
	local team = PlayerResource:GetTeam(pID)
	--print("server recieve and send")
	CustomGameEventManager:Send_ServerToTeam(team, 'team_hero_kit_stats', {player=pID, change=keys.change, target=keys.target, gold=keys.gold}) 
end
function GameMode:TeamComSkill(keys)
	local pID = keys.PlayerID
	local team = PlayerResource:GetTeam(pID)
	--print("server recieve and send")
	--print("skill: " .. keys.change)
	--print("to slot: " .. keys.target)
	CustomGameEventManager:Send_ServerToTeam(team ,"team_hero_kit_skills", {player=pID, change=keys.change, target=keys.target}) 
end


function GameMode:RandomSkill(pID,slot)
	local tList = {}
	local found = false
	if slot < 3 then
		tList = GameRules.AbilityListing
	elseif slot < 4 then
		tList = GameRules.EitherListing
	elseif slot < 6 then
		tList = GameRules.TraitListing
	else
		tList = GameRules.UltimateListing
	end
	local nRand = RandomInt(1,#tList)
	local sAbility = tList[nRand]
	while not found do
		local check = false
		for i = 1,6 do
			if GameRules.PlayerAbs[pID][i] and GameRules.PlayerAbs[pID][i] == sAbility then
				nRand = RandomInt(1,#tList)
				sAbility = tList[nRand]
				check = true
			end
		end
		if not check then found = true end
	end
	print("randoming: " .. sAbility)
	return sAbility
end
function GameMode:_InitGameMode()
  -- Setup rules
  GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
  GameRules:SetUseUniversalShopMode( UNIVERSAL_SHOP_MODE )
  GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
  GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
  GameRules:SetPreGameTime( PRE_GAME_TIME)
  GameRules:SetPostGameTime( POST_GAME_TIME )
  GameRules:SetTreeRegrowTime( TREE_REGROW_TIME )
  GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
  GameRules:SetGoldPerTick(GOLD_PER_TICK)
  GameRules:SetGoldTickTime(GOLD_TICK_TIME)
  GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
  GameRules:SetUseBaseGoldBountyOnHeroes(USE_STANDARD_HERO_GOLD_BOUNTY)
  GameRules:SetHeroMinimapIconScale( MINIMAP_ICON_SIZE )
  GameRules:SetCreepMinimapIconScale( MINIMAP_CREEP_ICON_SIZE )
  GameRules:SetRuneMinimapIconScale( MINIMAP_RUNE_ICON_SIZE )

  GameRules:SetFirstBloodActive( ENABLE_FIRST_BLOOD )
  GameRules:SetHideKillMessageHeaders( HIDE_KILL_BANNERS )


  -- This is multiteam configuration stuff
  if USE_AUTOMATIC_PLAYERS_PER_TEAM then
    local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
    local count = 0
    for team,number in pairs(TEAM_COLORS) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, num)
      end
      count = count + 1
    end
  else
    local count = 0
    for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, number)
      end
      count = count + 1
    end
  end

  if USE_CUSTOM_TEAM_COLORS then
    for team,color in pairs(TEAM_COLORS) do
      SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
    end
  end
  DebugPrint('[BAREBONES] GameRules set')

  --InitLogFile( "log/barebones.txt","")

  -- Event Hooks
  -- All of these events can potentially be fired by the game, though only the uncommented ones have had
  -- Functions supplied for them.  If you are interested in the other events, you can uncomment the
  -- ListenToGameEvent line and add a function to handle the event
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GameMode, 'OnPlayerLevelUp'), self)
  ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(GameMode, 'OnAbilityChannelFinished'), self)
  ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(GameMode, 'OnPlayerLearnedAbility'), self)
  ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), self)
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), self)
  ListenToGameEvent('player_disconnect', Dynamic_Wrap(GameMode, 'OnDisconnect'), self)
  ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(GameMode, 'OnItemPurchased'), self)
  ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(GameMode, 'OnItemPickedUp'), self)
  ListenToGameEvent('last_hit', Dynamic_Wrap(GameMode, 'OnLastHit'), self)
  ListenToGameEvent('dota_non_player_used_ability', Dynamic_Wrap(GameMode, 'OnNonPlayerUsedAbility'), self)
  ListenToGameEvent('player_changename', Dynamic_Wrap(GameMode, 'OnPlayerChangedName'), self)
  ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(GameMode, 'OnRuneActivated'), self)
  ListenToGameEvent('dota_player_take_tower_damage', Dynamic_Wrap(GameMode, 'OnPlayerTakeTowerDamage'), self)
  ListenToGameEvent('tree_cut', Dynamic_Wrap(GameMode, 'OnTreeCut'), self)
  ListenToGameEvent('entity_hurt', Dynamic_Wrap(GameMode, 'OnEntityHurt'), self)
  ListenToGameEvent('player_connect', Dynamic_Wrap(GameMode, 'PlayerConnect'), self)
  ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(GameMode, 'OnAbilityUsed'), self)
  ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), self)
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnNPCSpawned'), self)
  ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GameMode, 'OnPlayerPickHero'), self)
  ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(GameMode, 'OnTeamKillCredit'), self)
  ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, 'OnPlayerReconnect'), self)

  ListenToGameEvent("dota_illusions_created", Dynamic_Wrap(GameMode, 'OnIllusionsCreated'), self)
  ListenToGameEvent("dota_item_combined", Dynamic_Wrap(GameMode, 'OnItemCombined'), self)
  ListenToGameEvent("dota_player_begin_cast", Dynamic_Wrap(GameMode, 'OnAbilityCastBegins'), self)
  ListenToGameEvent("dota_tower_kill", Dynamic_Wrap(GameMode, 'OnTowerKill'), self)
  ListenToGameEvent("dota_player_selected_custom_team", Dynamic_Wrap(GameMode, 'OnPlayerSelectedCustomTeam'), self)
  ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(GameMode, 'OnNPCGoalReached'), self)
  CustomGameEventManager:RegisterListener("ability_choise", Dynamic_Wrap(GameMode, 'AbilityChoise'))
  CustomGameEventManager:RegisterListener("hero_kit_stats", Dynamic_Wrap(GameMode, 'TeamComStat'))
  CustomGameEventManager:RegisterListener("hero_kit_skill", Dynamic_Wrap(GameMode, 'TeamComSkill'))
  
  CustomGameEventManager:RegisterListener("custom_chat_cts", Dynamic_Wrap(GameMode, 'CustomChat'))
  
  --ListenToGameEvent("dota_tutorial_shop_toggled", Dynamic_Wrap(GameMode, 'OnShopToggled'), self)

  --ListenToGameEvent('player_spawn', Dynamic_Wrap(GameMode, 'OnPlayerSpawn'), self)
  --ListenToGameEvent('dota_unit_event', Dynamic_Wrap(GameMode, 'OnDotaUnitEvent'), self)
  --ListenToGameEvent('nommed_tree', Dynamic_Wrap(GameMode, 'OnPlayerAteTree'), self)
  --ListenToGameEvent('player_completed_game', Dynamic_Wrap(GameMode, 'OnPlayerCompletedGame'), self)
  --ListenToGameEvent('dota_match_done', Dynamic_Wrap(GameMode, 'OnDotaMatchDone'), self)
  --ListenToGameEvent('dota_combatlog', Dynamic_Wrap(GameMode, 'OnCombatLogEvent'), self)
  --ListenToGameEvent('dota_player_killed', Dynamic_Wrap(GameMode, 'OnPlayerKilled'), self)
  --ListenToGameEvent('player_team', Dynamic_Wrap(GameMode, 'OnPlayerTeam'), self)

  --[[This block is only used for testing events handling in the event that Valve adds more in the future
  Convars:RegisterCommand('events_test', function()
      GameMode:StartEventTest()
    end, "events test", 0)]]

  local spew = 0
  if BAREBONES_DEBUG_SPEW then
    spew = 1
  end
 -- Convars:RegisterConvar('barebones_spew', tostring(spew), 'Set to 1 to start spewing barebones debug info.  Set to 0 to disable.', 0)

  -- Change random seed
  local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
  math.randomseed(tonumber(timeTxt))

  -- Initialized tables for tracking state
  self.bSeenWaitForPlayers = false

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end

mode = nil

-- This function is called as the first player loads and sets up the GameMode parameters
function GameMode:_CaptureGameMode()
  if mode == nil then
    -- Set GameMode parameters
    mode = GameRules:GetGameModeEntity()        
    mode:SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
    mode:SetCameraDistanceOverride( CAMERA_DISTANCE_OVERRIDE )
    mode:SetCustomBuybackCostEnabled( CUSTOM_BUYBACK_COST_ENABLED )
    mode:SetCustomBuybackCooldownEnabled( CUSTOM_BUYBACK_COOLDOWN_ENABLED )
    mode:SetBuybackEnabled( BUYBACK_ENABLED )
    mode:SetTopBarTeamValuesOverride ( USE_CUSTOM_TOP_BAR_VALUES )
    mode:SetTopBarTeamValuesVisible( TOP_BAR_VISIBLE )
    mode:SetUseCustomHeroLevels ( USE_CUSTOM_HERO_LEVELS )
    mode:SetCustomHeroMaxLevel ( MAX_LEVEL )
    mode:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )

    mode:SetBotThinkingEnabled( USE_STANDARD_DOTA_BOT_THINKING )
    mode:SetTowerBackdoorProtectionEnabled( ENABLE_TOWER_BACKDOOR_PROTECTION )

    mode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
    mode:SetGoldSoundDisabled( DISABLE_GOLD_SOUNDS )
    mode:SetRemoveIllusionsOnDeath( REMOVE_ILLUSIONS_ON_DEATH )

    mode:SetAlwaysShowPlayerInventory( SHOW_ONLY_PLAYER_INVENTORY )
    mode:SetAnnouncerDisabled( DISABLE_ANNOUNCER )
    if FORCE_PICKED_HERO ~= nil then
      mode:SetCustomGameForceHero( FORCE_PICKED_HERO )
    end
    mode:SetFixedRespawnTime( FIXED_RESPAWN_TIME ) 
    mode:SetFountainConstantManaRegen( FOUNTAIN_CONSTANT_MANA_REGEN )
    mode:SetFountainPercentageHealthRegen( FOUNTAIN_PERCENTAGE_HEALTH_REGEN )
    mode:SetFountainPercentageManaRegen( FOUNTAIN_PERCENTAGE_MANA_REGEN )
    mode:SetLoseGoldOnDeath( LOSE_GOLD_ON_DEATH )
    mode:SetMaximumAttackSpeed( MAXIMUM_ATTACK_SPEED )
    mode:SetMinimumAttackSpeed( MINIMUM_ATTACK_SPEED )
    mode:SetStashPurchasingDisabled ( DISABLE_STASH_PURCHASING )

    for rune, spawn in pairs(ENABLED_RUNES) do
      mode:SetRuneEnabled(rune, spawn)
    end

    mode:SetUnseenFogOfWarEnabled(USE_UNSEEN_FOG_OF_WAR)

    self:OnFirstPlayerLoaded()
  end 
end