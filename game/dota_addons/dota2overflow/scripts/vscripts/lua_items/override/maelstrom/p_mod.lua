if shock_weapon_mod == nil then
	shock_weapon_mod = class({})
end

function shock_weapon_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
 
	return funcs
end

function shock_weapon_mod:IsHidden()
	return true
end

function shock_weapon_mod:OnAttackLanded(keys)
	if IsServer() then
		local hAbility = self:GetAbility()
			if hAbility:GetLevel() < 1 then return end
		if keys.attacker == self:GetParent() then
			if keys.target:IsBuilding() or keys.target:IsMagicImmune() then return end
		local dmg = self:GetAbility():GetSpecialValueFor("bonus")
		if self:GetParent():IsIllusion() then dmg = math.ceil(dmg/2) end
		
		
		
		local armor = keys.target:GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
		local damage = {
			victim = keys.target,
			attacker = self:GetParent(),
			damage = dmg * armor,
			damage_type = hAbility:GetAbilityDamageType(),
			ability = self:GetAbility()
		}
	EmitSoundOnLocationWithCaster( keys.target:GetOrigin(), "Hero_Leshrac.Lightning_Storm", keys.target )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1, 1, 1 ) )
		ParticleManager:SetParticleControl( nFXIndex, 0, keys.target:GetOrigin()+Vector(0,0,100) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		local dmg = ApplyDamage( damage )
		local life_time = 2.0
		local digits = string.len( math.floor( dmg ) ) + 1
		local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, keys.target )
		ParticleManager:SetParticleControl( numParticle, 1, Vector( 0, dmg, 4 ) )
		ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
		ParticleManager:SetParticleControl( numParticle, 3, Vector( 0, 150, 255 ) )
		
		
		end
	end
end


