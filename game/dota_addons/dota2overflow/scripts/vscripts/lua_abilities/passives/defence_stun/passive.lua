if defence_stun == nil then
	defence_stun = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "defence_stun_mod", "lua_abilities/passives/defence_stun/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function defence_stun:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function defence_stun:GetIntrinsicModifierName() return "defence_stun_mod" end