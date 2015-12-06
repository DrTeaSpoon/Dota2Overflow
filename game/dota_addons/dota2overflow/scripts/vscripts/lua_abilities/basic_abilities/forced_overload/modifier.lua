if forced_overload_mod == nil then
	forced_overload_mod = class({})
end

function forced_overload_mod:OnCreated( kv )	
	if IsServer() then
		self:SetStackCount(1)
	end
end

function forced_overload_mod:OnRefresh(kv)
	if IsServer() then
		local nStacks = self:GetStackCount()
		self:SetStackCount(nStacks + 1)
	end
end
 
function forced_overload_mod:IsHidden()
	return false
end

function forced_overload_mod:IsPurgable() 
	return true
end

function forced_overload_mod:GetEffectName()
	return "particles/units/heroes/hero_disruptor/disruptor_kf_wall_constant_electric_arc.vpcf"
end

function forced_overload_mod:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function forced_overload_mod:OnDestroy()
	if IsServer() then
		EmitSoundOn( "Hero_StormSpirit.Overload", self:GetParent())
		local nShck = self:GetAbility():GetSpecialValueFor("stack_shock_damage")
		local nStacks = self:GetStackCount() * self:GetStackCount()
		local shk_dmg = nShck * nStacks
		self:NearbyShock(shk_dmg)
		if self:GetParent():IsAlive() then
		self:DamageParent(shk_dmg)
		end
	end
end


function forced_overload_mod:NearbyShock(shk_dmg)
	local hAbility = self:GetAbility()
	local hTarget = self:GetParent()
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", PATTACH_ABSORIGIN, hTarget )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetAbsOrigin() )
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), nil, hAbility:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsInvulnerable() ) and enemy ~= hTarget then
					local armor = enemy:GetPhysicalArmorValue()
					if armor < 1 then armor = 1 end
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = shk_dmg * armor,
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					local dmg = ApplyDamage( damage )
					local life_time = 2.0
					local digits = string.len( math.floor( dmg ) ) + 1
					local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, enemy )
					ParticleManager:SetParticleControl( numParticle, 1, Vector( 0, dmg, 4 ) )
					ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 3, Vector( 0, 150, 255 ) )
				end
			end
		end
end


function forced_overload_mod:DamageParent(shk_dmg)
	if IsServer() then
		local armor = self:GetParent():GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = shk_dmg * armor,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility()
		}
		local dmg = ApplyDamage( damage )
		local life_time = 2.0
		local digits = string.len( math.floor( dmg ) ) + 1
		local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( numParticle, 1, Vector( 0, dmg, 4 ) )
		ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
		ParticleManager:SetParticleControl( numParticle, 3, Vector( 0, 150, 255 ) )
	end
end

function forced_overload_mod:IsPurgable()
	return true
end