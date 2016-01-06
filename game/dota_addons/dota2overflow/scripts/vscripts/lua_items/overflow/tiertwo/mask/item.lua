if item_ovf_mask == nil then
	item_ovf_mask = class({})
end

LinkLuaModifier( "item_ovf_mask_modifier", "lua_items/overflow/tiertwo/mask/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_ovf_mask:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ovf_mask:GetIntrinsicModifierName()
	return "item_ovf_mask_modifier"
end