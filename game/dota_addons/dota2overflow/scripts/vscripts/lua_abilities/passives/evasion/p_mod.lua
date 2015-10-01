if evasion_mod == nil then
	evasion_mod = class({})
end

function evasion_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
 
	return funcs
end

function evasion_mod:IsHidden()
	return true
end

function evasion_mod:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus")
end