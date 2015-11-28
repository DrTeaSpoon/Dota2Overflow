if cursed_power_mod == nil then
	cursed_power_mod = class({})
end

function cursed_power_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_DISABLE_HEALING
	}
	return funcs
end

function cursed_power_mod:OnCreated(kv)
	if IsServer() then
		self:SetStackCount(kv.stack)
	end
end

function cursed_power_mod:OnRefresh(kv)
	if IsServer() then
		local nMax = self:GetAbility():GetSpecialValueFor("max")
		local nStacks = self:GetStackCount()
		if nStacks <  nMax then
			self:SetStackCount(nStacks + kv.stack)
		end
	end
end

function cursed_power_mod:IsHidden()
	return false
end

function cursed_power_mod:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("bonus")
end

function cursed_power_mod:OnTooltip()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("bonus")
end

function cursed_power_mod:GetDisableHealing()
	return 1
end

function cursed_power_mod:GetEffectName()
	return "particles/cursed_power.vpcf"
end

function cursed_power_mod:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end