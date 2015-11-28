if fire_weapon == nil then
	fire_weapon = class({})
end

LinkLuaModifier( "fire_weapon_mod", "lua_abilities/passives/fire_weapon/p_mod.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function fire_weapon:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function fire_weapon:GetIntrinsicModifierName() return "fire_weapon_mod" end