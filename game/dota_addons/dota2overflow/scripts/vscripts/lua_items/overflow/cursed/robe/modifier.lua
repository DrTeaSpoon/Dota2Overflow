if item_cursed_robe_modifier == nil then
	item_cursed_robe_modifier = class({})
end

function item_cursed_robe_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_EVENT_ON_ABILITY_EXECUTED
	}
	return funcs
end

function item_cursed_robe_modifier:IsHidden()
	return true
end

function item_cursed_robe_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_cursed_robe_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_cursed_robe_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_cursed_robe_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end


function item_cursed_robe_modifier:OnAbilityExecuted(params)
	if IsServer() then
		if params.unit == self:GetParent() then
			if self:GetAbility():IsCooldownReady() then
				self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
				self:GetParent():AddNewModifier( self:GetParent(), self:GetAbility(), "custom_invisibility_modifier", { duration = self:GetAbility():GetSpecialValueFor("duration") } )
			end
		end
	end
end