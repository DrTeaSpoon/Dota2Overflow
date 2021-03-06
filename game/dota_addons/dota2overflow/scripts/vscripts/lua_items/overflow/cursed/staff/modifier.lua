if item_cursed_staff_modifier == nil then
	item_cursed_staff_modifier = class({})
end

function item_cursed_staff_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function item_cursed_staff_modifier:IsHidden()
	return true
end

function item_cursed_staff_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_cursed_staff_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_cursed_staff_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_cursed_staff_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end