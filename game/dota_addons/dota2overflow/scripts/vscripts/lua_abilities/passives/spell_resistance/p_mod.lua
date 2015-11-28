if spell_resistance_mod == nil then
	spell_resistance_mod = class({})
end

function spell_resistance_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
 
	return funcs
end

function spell_resistance_mod:IsHidden()
	return true
end

function spell_resistance_mod:GetModifierMagicalResistanceBonus()
	if self:GetAbility():GetLevel() > 0 then
		return self:GetAbility():GetSpecialValueFor("bonus")
	end
end