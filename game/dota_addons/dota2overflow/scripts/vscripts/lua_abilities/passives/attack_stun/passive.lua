if attack_stun == nil then
	attack_stun = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "attack_stun_mod", "lua_abilities/passives/attack_stun/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function attack_stun:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function attack_stun:GetIntrinsicModifierName() return "attack_stun_mod" end