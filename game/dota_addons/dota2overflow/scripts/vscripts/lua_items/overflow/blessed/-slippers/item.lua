if item_blessed_slippers == nil then
	item_blessed_slippers = class({})
end

LinkLuaModifier( "item_blessed_slippers_modifier", "lua_items/overflow/blessed/slippers/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_slippers:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_slippers:GetIntrinsicModifierName()
	return "item_blessed_slippers_modifier"
end