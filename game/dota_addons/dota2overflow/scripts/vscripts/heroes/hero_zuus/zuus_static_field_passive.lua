if zuus_static_field_lua_passive == nil then
	zuus_static_field_lua_passive = class({})
end

function zuus_static_field_lua_passive:OnCreated( kv )	
	if IsServer() then
	end
end



function zuus_static_field_lua_passive:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ABILITY_EXECUTED 
	}
 
	return funcs
end

function zuus_static_field_lua_passive:OnAbilityExecuted(params)
	if IsServer() then
		if params.unit == self:GetParent() and not params.ability.IsProcBanned then
		local hAbility = self:GetAbility()
		if hAbility:IsItem() then return end
		local iAoE = hAbility:GetSpecialValueFor( "radius" )
		local iDamage = hAbility:GetSpecialValueFor( "damage" )
		local iMDamage = hAbility:GetSpecialValueFor( "magic_damage" )
		--sounds/weapons/hero/zuus/static_field.vsnd
		
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), iAoE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
		local armor = enemy:GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = iDamage * armor + iMDamage,
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_WORLDORIGIN, nil )
					--ParticleManager:SetParticleControlEnt( nFXIndex, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetOrigin(), true );
					ParticleManager:SetParticleControl( nFXIndex, 1, Vector( iAoE, 1, 1 ) )
					ParticleManager:SetParticleControl( nFXIndex, 0, enemy:GetOrigin()+Vector(0,0,100) )
					ParticleManager:ReleaseParticleIndex( nFXIndex )
					ApplyDamage( damage )
				end
			end
		end
		end
	end
end

function zuus_static_field_lua_passive:IsHidden()
	return true
end