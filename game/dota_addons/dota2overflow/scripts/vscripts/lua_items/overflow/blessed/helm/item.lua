if item_blessed_helm == nil then
	item_blessed_helm = class({})
end

LinkLuaModifier( "item_blessed_helm_modifier", "lua_items/overflow/blessed/helm/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_helm:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_blessed_helm:GetIntrinsicModifierName()
	return "item_blessed_helm_modifier"
end