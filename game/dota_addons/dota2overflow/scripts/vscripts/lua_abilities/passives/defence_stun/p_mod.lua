if defence_stun_mod == nil then
	defence_stun_mod = class({})
end

function defence_stun_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED
	}
 
	return funcs
end

function defence_stun_mod:IsHidden()
	return true
end

function defence_stun_mod:OnCreated()
	if IsServer() then
	end
end

function defence_stun_mod:OnAttacked(keys)
	if IsServer() then
		local hAbility = self:GetAbility()
			if hAbility:GetLevel() < 1 then return end
		if keys.attacker ~= self:GetParent() and keys.target == self:GetParent() then
			if RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("chance") then
				if CalcDistanceBetweenEntityOBB(keys.attacker, self:GetCaster()) < self:GetAbility():GetSpecialValueFor("range") then
				
					EmitSoundOn( "Hero_Tiny.CraggyExterior.Stun", keys.attacker )
					keys.attacker:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = self:GetAbility():GetSpecialValueFor("duration") } )
					local damage = {
						victim = keys.attacker,
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
end