if item_blessed_branch == nil then
	item_blessed_branch = class({})
end

LinkLuaModifier( "item_blessed_branch_modifier", "lua_items/overflow/blessed/branch/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_branch:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_branch:GetIntrinsicModifierName()
	return "item_blessed_branch_modifier"
end