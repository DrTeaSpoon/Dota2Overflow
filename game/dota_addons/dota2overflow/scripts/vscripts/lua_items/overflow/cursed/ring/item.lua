if item_cursed_ring == nil then
	item_cursed_ring = class({})
end

LinkLuaModifier( "item_cursed_ring_modifier", "lua_items/overflow/cursed/ring/modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function item_cursed_ring:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_cursed_ring:GetIntrinsicModifierName()
	return "item_cursed_ring_modifier"
end

function item_cursed_ring:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end