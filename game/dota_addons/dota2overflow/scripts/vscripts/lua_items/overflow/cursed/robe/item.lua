if item_cursed_robe == nil then
	item_cursed_robe = class({})
end

LinkLuaModifier( "custom_invisibility_modifier", "lua_mods/custom_invis.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_cursed_robe_modifier", "lua_items/overflow/cursed/robe/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_cursed_robe:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_cursed_robe:GetIntrinsicModifierName()
	return "item_cursed_robe_modifier"
end

function item_cursed_robe:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end