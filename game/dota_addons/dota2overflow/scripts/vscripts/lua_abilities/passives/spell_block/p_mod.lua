if spell_block_mod == nil then
	spell_block_mod = class({})
end

function spell_block_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSORB_SPELL
	}
	return funcs
end

function spell_block_mod:IsHidden()
	return true
end

function spell_block_mod:GetAbsorbSpell(keys)
	if keys then DeepPrintTable(keys) end
	local hAbility = self:GetAbility()
	if hAbility:IsCooldownReady() then
	hAbility:StartCooldown(hAbility:GetCooldown(hAbility:GetLevel()))
	return 1
	end
	return false
end