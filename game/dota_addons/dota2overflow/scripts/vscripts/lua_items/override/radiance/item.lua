if item_radiance_ovf == nil then
	item_radiance_ovf = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "item_radiance_ovf_mod", "lua_items/override/radiance/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_radiance_ovf:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_radiance_ovf:GetIntrinsicModifierName()
	return "item_radiance_ovf_mod"
end

function item_radiance_ovf:OnItemEquipped(hItem)
	print("Equipped!" )
end