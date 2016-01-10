if item_cursed_band == nil then
	item_cursed_band = class({})
end

LinkLuaModifier( "item_cursed_band_modifier", "lua_items/overflow/cursed/band/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_cursed_band:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_cursed_band:GetIntrinsicModifierName()
	return "item_cursed_band_modifier"
end

function item_cursed_band:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end