if item_cursed_helm == nil then
	item_cursed_helm = class({})
end

LinkLuaModifier( "item_cursed_helm_modifier_aura", "lua_items/overflow/cursed/helm/aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_cursed_helm_modifier", "lua_items/overflow/cursed/helm/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_cursed_helm:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_cursed_helm:GetIntrinsicModifierName()
	return "item_cursed_helm_modifier"
end

function item_cursed_helm:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end