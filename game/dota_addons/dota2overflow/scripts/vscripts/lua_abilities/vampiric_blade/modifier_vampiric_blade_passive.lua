if modifier_vampiric_blade_passive == nil then
	modifier_vampiric_blade_passive = class({})
end

function modifier_vampiric_blade_passive:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	,MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	,MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	,MODIFIER_EVENT_ON_ORDER
	}
	return funcs
end

function modifier_vampiric_blade_passive:OnCreated()
	if IsServer() then
		self.Primary = self:GetParent():GetPrimaryAttribute() 
	end
end

function modifier_vampiric_blade_passive:IsPurgable() return false end
function modifier_vampiric_blade_passive:IsPurgeException() return false end
function modifier_vampiric_blade_passive:IsDebuff() return false end
function modifier_vampiric_blade_passive:RemoveOnDeath() return false end
function modifier_vampiric_blade_passive:IsHidden()
	return true
end

function modifier_vampiric_blade_passive:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_vampiric_blade_passive:GetModifierBonusStats_Strength()
	return self:GetModifierBonusStats_All(0, self:GetParent():GetStrengthGain())
end
function modifier_vampiric_blade_passive:GetModifierBonusStats_Agility()
	return self:GetModifierBonusStats_All(1, self:GetParent():GetAgilityGain())
end
function modifier_vampiric_blade_passive:GetModifierBonusStats_Intellect()
	return self:GetModifierBonusStats_All(2,self:GetParent():GetIntellectGain())
end

function modifier_vampiric_blade_passive:GetModifierBonusStats_All(nType, nBonus)
	local hAbility = self:GetAbility()
	return nBonus * self:GetStackCount()
end

function modifier_vampiric_blade_passive:OnOrder()
	self:IncrementStackCount()
end