if item_cursed_helm_modifier == nil then
	item_cursed_helm_modifier = class({})
end

function item_cursed_helm_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function item_cursed_helm_modifier:IsHidden()
	return true
end

function item_cursed_helm_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_cursed_helm_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_cursed_helm_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_cursed_helm_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end

function item_cursed_helm_modifier:IsAura()
	return true
end

function item_cursed_helm_modifier:GetModifierAura()
	return "item_cursed_helm_modifier_aura"
end

function item_cursed_helm_modifier:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function item_cursed_helm_modifier:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function item_cursed_helm_modifier:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end
