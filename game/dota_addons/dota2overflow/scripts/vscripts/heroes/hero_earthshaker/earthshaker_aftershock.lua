if earthshaker_aftershock_lua == nil then
	earthshaker_aftershock_lua = class({})
end

LinkLuaModifier( "earthshaker_aftershock_lua_passive", "heroes/hero_earthshaker/earthshaker_aftershock_passive.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "earthshaker_aftershock_lua_stun", "heroes/hero_earthshaker/earthshaker_aftershock_stun.lua", LUA_MODIFIER_MOTION_NONE )

function earthshaker_aftershock_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function earthshaker_aftershock_lua:GetIntrinsicModifierName()
	return "earthshaker_aftershock_lua_passive"
end