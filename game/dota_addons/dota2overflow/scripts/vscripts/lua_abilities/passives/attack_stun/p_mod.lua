if attack_stun_mod == nil then
	attack_stun_mod = class({})
end

function attack_stun_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
 
	return funcs
end

function attack_stun_mod:IsHidden()
	return true
end

function attack_stun_mod:OnCreated()
	if IsServer() then
	end
end

function attack_stun_mod:OnAttackLanded(keys)
	if IsServer() then
		local hAbility = self:GetAbility()
			if hAbility:GetLevel() < 1 then return end
		if keys.attacker == self:GetParent() then
			if keys.target:IsBuilding() or keys.target:IsMagicImmune() then return end
			
			if RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("chance") then
			
			EmitSoundOn( "Hero_Tiny.CraggyExterior.Stun", keys.target )
			keys.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = self:GetAbility():GetSpecialValueFor("duration") } )
			local damage = {
				victim = keys.target,
				attacker = self:GetParent(),
				damage = self:GetAbility():GetSpecialValueFor("damage"),
				damage_type = hAbility:GetAbilityDamageType(),
				ability = self:GetAbility()
			}
			ApplyDamage( damage )
			end
		end
	end
end