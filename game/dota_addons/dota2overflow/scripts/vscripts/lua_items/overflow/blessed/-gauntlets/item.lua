if item_blessed_gauntlets == nil then
	item_blessed_gauntlets = class({})
end

LinkLuaModifier( "item_blessed_gauntlets_modifier", "lua_items/overflow/blessed/gauntlets/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_gauntlets:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_gauntlets:GetIntrinsicModifierName()
	return "item_blessed_gauntlets_modifier"
end