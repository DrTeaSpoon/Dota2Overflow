if book_curse_modifier == nil then
	book_curse_modifier = class({})
end

function book_curse_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function book_curse_modifier:IsHidden()
	return true
end

function book_curse_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function book_curse_modifier:GetModifierTotalDamageOutgoing_Percentage() return self:GetAbility():GetSpecialValueFor("damage_out") end
function book_curse_modifier:GetModifierIncomingDamage_Percentage() return self:GetAbility():GetSpecialValueFor("damage_in") end