if item_blessed_band == nil then
	item_blessed_band = class({})
end

LinkLuaModifier( "item_blessed_band_modifier", "lua_items/overflow/blessed/band/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_band:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_band:GetIntrinsicModifierName()
	return "item_blessed_band_modifier"
end