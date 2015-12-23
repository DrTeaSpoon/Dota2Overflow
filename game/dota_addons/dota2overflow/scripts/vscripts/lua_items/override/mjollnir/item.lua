if item_mjollnir_ovf == nil then
	item_mjollnir_ovf = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "item_mjollnir_ovf_mod", "lua_items/override/mjollnir/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_mjollnir_ovf:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_mjollnir_ovf:GetIntrinsicModifierName()
	return "item_mjollnir_ovf_mod"
end

function item_mjollnir_ovf:OnItemEquipped(hItem)
	print("Equipped!" )
end