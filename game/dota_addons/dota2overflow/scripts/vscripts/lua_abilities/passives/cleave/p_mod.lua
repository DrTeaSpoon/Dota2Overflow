if cleave_mod == nil then
	cleave_mod = class({})
end

function cleave_mod:IsHidden()
	return true
end

function cleave_mod:GetModifierMoveSpeed_Max()
	return self:GetAbility():GetSpecialValueFor("max")
end

function cleave_mod:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus")
end
--------------------------------------------------------------------------------

function cleave_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

--------------------------------------------------------------------------------

function cleave_mod:OnAttackLanded( params )
	if IsServer() then
	if self:GetAbility():GetLevel() > 0 then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			if self:GetParent():PassivesDisabled() then
				return 0
			end
			local cleaveDamage = self:GetAbility():GetSpecialValueFor("cleave")
			local cleaveRadius = self:GetAbility():GetSpecialValueFor("radius")
			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local calcDamage = ( cleaveDamage * params.damage ) / 100.0
				DoCleaveAttack( self:GetParent(), target, self:GetAbility(), calcDamage, cleaveRadius, "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf" )
			end
		end
	end
	end
	return 0
end
