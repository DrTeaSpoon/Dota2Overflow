if item_overflow_rapier == nil then
	item_overflow_rapier = class({})
end

LinkLuaModifier( "overflow_rapier", "lua_items/override/rapier_m.lua", LUA_MODIFIER_MOTION_NONE )

function item_overflow_rapier:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_overflow_rapier:GetIntrinsicModifierName()
	return "overflow_rapier"
end

function item_overflow_rapier:OnItemEquipped(hItem)
	print("Equipped!" )
end