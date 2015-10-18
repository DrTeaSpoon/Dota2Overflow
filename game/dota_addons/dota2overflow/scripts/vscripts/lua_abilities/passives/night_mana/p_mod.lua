if night_mana_mod == nil then
	night_mana_mod = class({})
end

function night_mana_mod:IsHidden()
	return true
end

function night_mana_mod:OnCreated()
	if IsServer() then
	end
end

function night_mana_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,
	}
	return funcs
end

function night_mana_mod:GetModifierPercentageManaRegen()
	--if IsServer() then
		if not GameRules:IsDaytime()then
			return self:GetAbility():GetSpecialValueFor("mana")
			else
			return self:GetAbility():GetSpecialValueFor("penalty")
		end
	--end

end