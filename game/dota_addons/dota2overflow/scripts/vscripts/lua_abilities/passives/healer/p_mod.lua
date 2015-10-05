if healer_mod == nil then
	healer_mod = class({})
end

function healer_mod:IsHidden()
	return true
end

function healer_mod:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function healer_mod:OnIntervalThink()
	if IsServer() then
		if not self:GetParent():IsAlive() then return end
		local hp = self:GetAbility():GetSpecialValueFor("heal")
		if self:GetParent():IsIllusion() then hp = math.ceil(hp/2) end
		local aoe = self:GetAbility():GetSpecialValueFor("radius")
		local allies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #allies > 0 then
			for _,ally in pairs(allies) do
				if ally ~= nil then
					ally:Heal(hp, self:GetAbility())
					ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed_heal_sparkles.vpcf",  PATTACH_ABSORIGIN , self:GetCaster()) 
					
				end
			end
		end
	end
end
