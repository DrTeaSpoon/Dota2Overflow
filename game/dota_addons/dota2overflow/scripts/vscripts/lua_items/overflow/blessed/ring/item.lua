if item_blessed_ring == nil then
	item_blessed_ring = class({})
end

LinkLuaModifier( "item_blessed_ring_modifier", "lua_items/overflow/blessed/ring/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_ring:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_ring:GetIntrinsicModifierName()
	return "item_blessed_ring_modifier"
end