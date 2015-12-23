if aura_vampire_mod == nil then
	aura_vampire_mod = class({})
end

function aura_vampire_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
 
	return funcs
end

function aura_vampire_mod:IsHidden()
	if self:GetCaster() ~= self:GetParent() and self:GetAbility():GetLevel() > 0 then
	return false
	else
	return true
	end
end

function aura_vampire_mod:OnAttackLanded (keys)
	if IsServer() then
	local hAbility = self:GetAbility()
	
		if hAbility:GetLevel() < 1 then return end
		if keys.attacker == keys.target then return end
		if keys.attacker == self:GetParent() and not self:GetParent():IsIllusion() then
		if keys.target:IsBuilding() or keys.target:IsIllusion() then return end
		if self:GetCaster() ~= self:GetParent() or GameRules:IsDaytime() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/vampire_vamp_day.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
		self:GetParent():Heal(self:GetAbility():GetSpecialValueFor("vamp_day")/100 * keys.damage, self:GetAbility())
		else
		self.nFXIndex = ParticleManager:CreateParticle( "particles/vampire_vamp.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
		self:GetParent():Heal(self:GetAbility():GetSpecialValueFor("vamp")/100 * keys.damage, self:GetAbility())
		end
		ParticleManager:SetParticleControlEnt(self.nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true) 
		ParticleManager:SetParticleControlEnt(self.nFXIndex, 1, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true) 
		ParticleManager:ReleaseParticleIndex(self.nFXIndex)
	end
	end
end

function aura_vampire_mod:OnCreated( kv )
	if IsServer() then
		self.aura_radius = self:GetAbility():GetSpecialValueFor("radius")
		if self:GetCaster() == self:GetParent() then
			self:StartIntervalThink(0.5)
		end
	end
end


function aura_vampire_mod:OnIntervalThink()
	if IsServer() then
	local hAbility = self:GetAbility()
		if hAbility:GetLevel() < 1 then return end
		if self:GetParent():HasModifier("element_water") and self:GetParent():IsAlive() then
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetParent(),
				damage = self:GetAbility():GetSpecialValueFor("water_damage"),
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility()
			}
			local nFXIndex = ParticleManager:CreateParticle( "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_wings_smoke.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
			ParticleManager:SetParticleControlEnt(nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true) 
			ParticleManager:SetParticleControlEnt(nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true) 
			ParticleManager:SetParticleControlEnt(nFXIndex, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true) 
			ParticleManager:ReleaseParticleIndex(nFXIndex)
			
			ApplyDamage( damage )
		end
	end
end
---AURA?!?!

--------------------------------------------------------------------------------

function aura_vampire_mod:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end

--------------------------------------------------------------------------------

function aura_vampire_mod:GetModifierAura()
	return "aura_vampire_mod"
end

--------------------------------------------------------------------------------

function aura_vampire_mod:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function aura_vampire_mod:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function aura_vampire_mod:GetAuraRadius()
	return self.aura_radius
end
