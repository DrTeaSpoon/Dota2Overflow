if vampiric_mod == nil then
	vampiric_mod = class({})
end

function vampiric_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
 
	return funcs
end

function vampiric_mod:IsHidden()
	return true
end

function vampiric_mod:OnTakeDamage (keys)
	if IsServer() then
	if keys.attacker == self:GetParent() and not self:GetParent():IsIllusion() then
	self:GetParent():Heal(self:GetAbility():GetSpecialValueFor("vamp")/100 * keys.damage, self:GetAbility())
		self.nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(self.nFXIndex, 0, self:GetCaster():GetOrigin()) 
		ParticleManager:SetParticleControl(self.nFXIndex, 1, self:GetCaster():GetOrigin()) 
		ParticleManager:ReleaseParticleIndex(self.nFXIndex)
	end
	end
end