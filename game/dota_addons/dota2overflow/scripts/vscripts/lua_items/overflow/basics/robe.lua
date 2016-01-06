if item_ovf_robe == nil then
	item_ovf_robe = class({})
end

LinkLuaModifier( "basic_stats_modifier", "lua_items/overflow/basics/basic_stats.lua", LUA_MODIFIER_MOTION_NONE )

function item_ovf_robe:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ovf_robe:GetIntrinsicModifierName()
	return "basic_stats_modifier"
end