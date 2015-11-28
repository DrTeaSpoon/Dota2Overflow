if armored_mod == nil then
	armored_mod = class({})
end

function armored_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
 
	return funcs
end

function armored_mod:IsHidden()
	return true
end

function armored_mod:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus")
end