if earthshaker_echo_slam_lua_modifier == nil then
	earthshaker_echo_slam_lua_modifier = class({})
end

function earthshaker_echo_slam_lua_modifier:OnCreated( kv )	
	if IsServer() then
		local hAbility = self:GetAbility()
		local iAoE = hAbility:GetSpecialValueFor( "echo_slam_echo_range" )
		local iDamage = hAbility:GetSpecialValueFor( "echo_slam_echo_damage" )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( iAoE, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
 
		
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), iAoE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = iDamage,
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
	
					ApplyDamage( damage )
				end
			end
		end
	end
end

function earthshaker_echo_slam_lua_modifier:IsHidden()
	return true
end

function 