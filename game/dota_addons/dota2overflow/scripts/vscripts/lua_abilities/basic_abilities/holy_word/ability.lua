if holy_word == nil then
	holy_word = class({})
end


function holy_word:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function holy_word:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.Purification", self:GetCaster() )

		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
		local AoE = self:GetSpecialValueFor("radius")
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( AoE*2.5, AoE, AoE/1.5 ) )
		local allies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		local heal_n = self:GetSpecialValueFor("heal")
		if GameRules:IsDaytime() then heal_n = heal_n * 2 end
		if #allies > 0 then
			for _,ally in pairs(allies) do
				if ally ~= nil then
					ally:Heal(heal_n, self)
				end
			end
		end
		self:GetCaster():Heal(heal_n, self)
end