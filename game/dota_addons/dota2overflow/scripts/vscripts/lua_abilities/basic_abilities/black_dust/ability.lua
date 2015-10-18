if black_dust == nil then
	black_dust = class({})
end

LinkLuaModifier( "black_dust_mod", "lua_abilities/basic_abilities/black_dust/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function black_dust:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function black_dust:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "DOTA_Item.SmokeOfDeceit.Activate", self:GetCaster() )
		local nFXIndex = ParticleManager:CreateParticle( "particles/black_dust.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
		local AoE = self:GetSpecialValueFor("radius")
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( AoE, 1, AoE ) )
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					enemy:AddNewModifier( self:GetCaster(), self, "black_dust_mod", { duration = self:GetSpecialValueFor("duration") } )
				end
			end
		end
end