if critical_mod == nil then
	critical_mod = class({})
end

function critical_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	}
 
	return funcs
end

function critical_mod:IsHidden()
	return true
end

function critical_mod:GetModifierPreAttack_CriticalStrike()
	if RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("chance") then
		return self:GetAbility():GetSpecialValueFor("bonus")
	end
end