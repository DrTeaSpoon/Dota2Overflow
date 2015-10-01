if zuus_static_field_lua == nil then
	zuus_static_field_lua = class({})
end

LinkLuaModifier( "zuus_static_field_lua_passive", "heroes/hero_zuus/zuus_static_field_passive.lua", LUA_MODIFIER_MOTION_NONE )

function zuus_static_field_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function zuus_static_field_lua:GetIntrinsicModifierName()
	return "zuus_static_field_lua_passive"
end