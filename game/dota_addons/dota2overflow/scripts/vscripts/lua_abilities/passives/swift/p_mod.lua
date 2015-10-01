if swift_mod == nil then
	swift_mod = class({})
end

function swift_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
 
	return funcs
end

function swift_mod:IsHidden()
	return true
end

function swift_mod:GetModifierMoveSpeed_Max()
	return self:GetAbility():GetSpecialValueFor("max")
end

function swift_mod:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus")
end