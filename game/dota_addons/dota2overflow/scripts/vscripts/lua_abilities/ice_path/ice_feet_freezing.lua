if aa_ice_feet_freezing == nil then
	aa_ice_feet_freezing = class({})
end

function modifier_lina_fiery_soul_lua:OnIntervalThink()
	if IsServer() then
		local hAbility = self:GetAbility()
		local vOrigin = self:GetParent():GetAbsOrigin()
		local vDist = self.ColdOrigin + vOrigin
		vDist = vDist:Normalized()
		local fDist = vDist:Length2D()
		local nLevel = self:GetAbility():GetLevel()
		if fDist > hAbility:GetLevelSpecialValueFor("break_distance",nLevel) then
			sef:Destroy()
		else
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = hAbility:GetLevelSpecialValueFor("damage", nLevel),
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility()
			}
			ApplyDamage( damage )
		end
	end
end

function aa_ice_feet_freezing:OnDestroy()
	if IsServer() then
		if self.FreezeTime >= GameRules:GetGameTime() then
			local hAbility = self:GetAbility()
			local fDuration = hAbility:GetLevelSpecialValueFor("stun_duration", nLevel)
			hTarget:AddNewModifier( hCaster, hAbility, "aa_ice_feet_stun", { duration = fDuration } )
		end
	end
end

function aa_ice_feet_freezing:OnCreated( kv )
	if IsServer() then
		local hAbility = self:GetAbility()
		local nLevel = hAbility:GetLevel()
		local vOrigin = self:GetParent():GetAbsOrigin()
		local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_marker.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(nFXIndex, 0, vOrigin) 
		ParticleManager:SetParticleControl(nFXIndex, 1, vOrigin) 
		self.ColdOrigin = vOrigin
		self.ColdFx = nFXIndex
		self.FreezeTime = GameRules:GetGameTime() + hAbility:GetLevelSpecialValueFor("duration", nLevel) - 0.1
	end
end

function aa_ice_feet_freezing:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function aa_ice_feet_freezing:DeclareFunctions()
	local funcs = {
	}
 
	return funcs
end

function aa_ice_feet_freezing:IsHidden()
	return false
end


function aa_ice_feet_freezing:IsDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_freezing:IsStunDebuff()
	return false
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_freezing:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet.vpcf"
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_freezing:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
 
 
--------------------------------------------------------------------------------
 
--------------------------------------------------------------------------------
 