if item_blessed_mantle == nil then
	item_blessed_mantle = class({})
end

LinkLuaModifier( "item_blessed_mantle_modifier", "lua_items/overflow/blessed/mantle/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_mantle:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_mantle:GetIntrinsicModifierName()
	return "item_blessed_mantle_modifier"
end