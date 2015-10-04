-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    --DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')


--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  --DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  GameRules.AbilityListing = {}
  local tAbilityListTemp = LoadKeyValues("scripts/kv/abilities.txt")
  local n = 1
  for k,v in pairs(tAbilityListTemp) do
	GameRules.AbilityListing[n] = v
	CustomNetTables:SetTableValue( "ability_list", tostring(k), { name = tostring(v) } )
	n = n + 1
  end
  
  GameRules.TraitListing = {}
  local tTraitsListTemp = LoadKeyValues("scripts/kv/traits.txt")
  n = 1
  for k,v in pairs(tTraitsListTemp) do
	GameRules.TraitListing[n] = v
	CustomNetTables:SetTableValue( "trait_list", tostring(k), { name = tostring(v) } )
	n = n + 1
  end
  
  GameRules.UltimateListing = {}
  local tUltsListTemp = LoadKeyValues("scripts/kv/ults.txt")
  n = 1
  for k,v in pairs(tUltsListTemp) do
	GameRules.UltimateListing[n] = v
	print(v)
	CustomNetTables:SetTableValue( "ult_list", tostring(k), { name = tostring(v) } )
	n = n + 1
  end
	LinkLuaModifier( "heroes_base_mod", "lua_mods/heroes_base_mod.lua", LUA_MODIFIER_MOTION_NONE )
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  --DebugPrint("[BAREBONES] All Players have loaded into the game")
	--print(":::GAME_RULES:::")
	--DeepPrintTable(GameRules)
	--print(":::GAME_RULES:::")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
	DebugPrint("[ARCHIVIST] Hero spawned in game for first time -- " .. hero:GetUnitName())

	local pID = hero:GetPlayerID()
	if hero:IsRealHero() and pID then
	hero:SetGold(700, false)
	--STATS
	if GameRules.PlayerCustomHero and GameRules.PlayerCustomHero[pID] then
	hero:SetGold(100 * GameRules.PlayerCustomHero[pID].points, true)
	hero:SetBaseStrength(GameRules.PlayerCustomHero[pID].str)
	hero:SetBaseAgility(GameRules.PlayerCustomHero[pID].agi) 
	hero:SetBaseIntellect(GameRules.PlayerCustomHero[pID].int) 
	--hero:SetPrimaryAttribute(GameRules.PlayerCustomHero[pID].pri) 
	hero:AddNewModifier( hero, nil, "heroes_base_mod", {gain_agi = GameRules.PlayerCustomHero[pID].agi_g,gain_str = GameRules.PlayerCustomHero[pID].str_g,gain_int = GameRules.PlayerCustomHero[pID].int_g} ) 
	end
	-- AddDarkCheck(hero)
	local tAbTempList = GameRules.AbilityListing
	for i = 1,6 do
		if not GameRules.PlayerAbs[pID] then GameRules.PlayerAbs[pID] = {} end
			if not GameRules.PlayerAbs[pID][i] or GameRules.PlayerAbs[pID][i] == "random" then
				GameRules.PlayerAbs[pID][i] = self:RandomSkill(hero,i)
			end
		print("Adding to hero: " .. GameRules.PlayerAbs[pID][i])
		Timers:CreateTimer(0.5*i, -- Start this timer 30 game-time seconds later
		function()
			PrecacheItemByNameAsync(GameRules.PlayerAbs[pID][i], function()
				hero:AddAbility(GameRules.PlayerAbs[pID][i])
                local ab = hero:FindAbilityByName(multV)
                if ab then
                    ab:SetActivated(true)
                end
			end)
		end)
	end
		--Timers:CreateTimer(10, -- Start this timer 30 game-time seconds later
		--function()
		--	PrecacheItemByNameAsync(GameRules.PlayerAbs[pID][7], function()
		--		hero:AddAbility("lua_attribute")
		--	end)
		--end)
	end
end
function GameMode:RandomSkill(hero,slot)
	local pID = hero:GetPlayerID()
	local tList = {}
	local found = false
	if slot < 4 then
		tList = GameRules.AbilityListing
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
--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
 -- --DebugPrint("[BAREBONES] The game has officially begun")
 --
 -- Timers:CreateTimer(30, -- Start this timer 30 game-time seconds later
 --   function()
 --     --DebugPrint("This function is called 30 seconds after the game begins, and every 30 seconds thereafter")
 --     return 30.0 -- Rerun this timer every 30 game-time seconds 
 --   end)
end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  --DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

  -- Call the internal function to set up the rules/behaviors specified in constants.lua
  -- This also sets up event hooks for all event handlers in events.lua
  -- Check out internals/gamemode to see/modify the exact code
  GameMode:_InitGameMode()
  VectorTarget:Init({ kv = "scripts/kv/vector_target.txt" })
  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  --Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

--  --DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end

-- This is an example console command
--function GameMode:ExampleConsoleCommand()
--  print( '******* Example Console Command ***************' )
--  local cmdPlayer = Convars:GetCommandClient()
--  if cmdPlayer then
--    local playerID = cmdPlayer:GetPlayerID()
--    if playerID ~= nil and playerID ~= -1 then
--      -- Do something here for the player who called this command
--      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
--    end
--  end
--
--  print( '*********************************************' )
--end