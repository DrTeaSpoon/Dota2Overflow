if earthshaker_aftershock_lua_passive == nil then
	earthshaker_aftershock_lua_passive = class({})
end

function earthshaker_aftershock_lua_passive:OnCreated( kv )	
	if IsServer() then
	end
end



function earthshaker_aftershock_lua_passive:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ABILITY_EXECUTED 
	}
 
	return funcs
end

function earthshaker_aftershock_lua_passive:OnAbilityExecuted(params)
	if IsServer() then
		--DeepPrintTable(params)
		if params.unit == self:GetParent() and not params.ability.IsProcBanned then
		local hAbility = self:GetAbility()
		if hAbility:IsItem() then return end
		local iAoE = hAbility:GetSpecialValueFor( "aftershock_range" )
		local fDuration = hAbility:GetSpecialValueFor( "tooltip_duration" )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetParent():GetOrigin() )
		--ParticleManager:SetParticleControl( nFXIndex, 1, Vector( hAbility:GetSpecialValueFor( "aftershock_range" ), 1, 1 ) )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( iAoE, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
 
		
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), iAoE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = hAbility:GetAbilityDamage(),
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
	
					ApplyDamage( damage )
					enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "earthshaker_aftershock_lua_stun", { duration = fDuration } )
				end
			end
		end
		end
	end
end

function earthshaker_aftershock_lua_passive:IsHidden()
	return true
end