if item_blessed_staff == nil then
	item_blessed_staff = class({})
end

LinkLuaModifier( "item_blessed_staff_modifier", "lua_items/overflow/blessed/staff/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_staff:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_staff:GetIntrinsicModifierName()
	return "item_blessed_staff_modifier"
end