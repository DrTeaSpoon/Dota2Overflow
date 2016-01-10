if item_cursed_helm_modifier_aura == nil then
	item_cursed_helm_modifier_aura = class({})
end

function item_cursed_helm_modifier_aura:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
	return funcs
end

function item_cursed_helm_modifier_aura:GetModifierHealthRegenPercentage () 
	return self:GetAbility():GetSpecialValueFor("regen")
end