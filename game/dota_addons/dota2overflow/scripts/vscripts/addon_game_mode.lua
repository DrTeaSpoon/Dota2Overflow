-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
require("libraries.vector_target")

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  --DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  --PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
  --PrecacheResource("particle_folder", "particles/test_particle", context)

  -- Models can also be precached by folder or individually
  -- PrecacheModel should generally used over PrecacheResource for individual models
  --PrecacheResource("model_folder", "particles/heroes/antimage", context)
  --PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
  --PrecacheModel("models/heroes/viper/viper.vmdl", context)

  -- Sounds can precached here like anything else
  --PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  --PrecacheItemByNameSync("example_ability", context)
  --PrecacheItemByNameSync("item_multicast", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context)
  PrecacheResource("particle", "particles/units/heroes/hero_chaos_knight/chaos_knight_bolt_msg.vpcf", context)
  PrecacheResource("particle", "particles/econ/courier/courier_trail_hw_2012/courier_trail_hw_2012.vpcf", context)
	PrecacheResource("particle", "particles/base_attacks/generic_projectile.vpcf", context)
	PrecacheResource("particle","particles/econ/generic/generic_buff_1/generic_buff_1.vpcf", context)
	PrecacheResource("model","models/heroes/oracle/crystal_ball.vmdl",context)
	PrecacheResource("model","models/props_teams/banner_radiant.vmdl",context)
	PrecacheResource("model","models/particle/legion_duel_banner.vmdl",context)
	PrecacheResource("particle","particles/dark_smoke_test.vpcf", context)
	PrecacheResource("particle","particles/econ/courier/courier_flopjaw/courier_flopjaw_ambient_water.vpcf",context)
	PrecacheResource("particle","particles/flag_carry_blue.vpcf", context)
	PrecacheResource("particle","particles/flag_carry_red.vpcf", context)
	
	
  

    VectorTarget:Precache( context )
  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  --PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
  --PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end