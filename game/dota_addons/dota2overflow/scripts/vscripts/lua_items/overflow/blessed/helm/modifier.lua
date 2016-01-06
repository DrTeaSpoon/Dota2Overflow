if item_blessed_helm_modifier == nil then
	item_blessed_helm_modifier = class({})
end

function item_blessed_helm_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function item_blessed_helm_modifier:IsHidden()
	return true
end



function item_blessed_helm_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_blessed_helm_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_blessed_helm_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_blessed_helm_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end

function item_blessed_helm_modifier:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		if self:GetAbility():IsCooldownReady() then
			return self:GetAbility():GetSpecialValueFor("regen")
		else
			return 0
		end
	end
end

function item_blessed_helm_modifier:OnTakeDamage(kv)
	if IsServer() then
		if kv.attacker ~= self:GetParent() and kv.unit == self:GetParent() and kv.attacker:IsHero()  then
			self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
		end
	end
end