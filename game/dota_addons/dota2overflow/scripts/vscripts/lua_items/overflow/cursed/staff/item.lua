if item_cursed_staff == nil then
	item_cursed_staff = class({})
end

LinkLuaModifier( "item_cursed_staff_modifier", "lua_items/overflow/cursed/staff/modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_cursed_staff_modifier_curse", "lua_items/overflow/cursed/staff/curse.lua", LUA_MODIFIER_MOTION_NONE )

function item_cursed_staff:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function item_cursed_staff:GetIntrinsicModifierName()
	return "item_cursed_staff_modifier"
end

function item_cursed_staff:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	hTarget:AddNewModifier( self:GetCaster(), self, "item_cursed_staff_modifier_curse", { duration = self:GetSpecialValueFor("duration") } )
end

function item_cursed_staff:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end