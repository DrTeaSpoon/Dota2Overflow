if book_bless_modifier == nil then
	book_bless_modifier = class({})
end

function book_bless_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MANA_BONUS
	}
	return funcs
end

function book_bless_modifier:IsHidden()
	return true
end

function book_bless_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function book_bless_modifier:GetModifierManaBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("mana_bonus")
	end
end