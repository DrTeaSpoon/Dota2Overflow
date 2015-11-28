if damage_bonus_mod == nil then
	damage_bonus_mod = class({})
end

function damage_bonus_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_DISABLE_HEALING
	}
	return funcs
end

function damage_bonus_mod:OnCreated(kv)
	if IsServer() then
		self.damage_bonus = kv.damage
	end
end

function damage_bonus_mod:OnRefesh(kv)
	if IsServer() then
		self.damage_bonus = self.damage_bonus + kv.damage
	end
end

function damage_bonus_mod:IsHidden()
	return false
end

function damage_bonus_mod:GetModifierPreAttack_BonusDamage()
	return self.damage_bonus
end

function damage_bonus_mod:OnTooltip()
	return self.damage_bonus
end

function damage_bonus_mod:GetDisableHealing()
	return 1
end