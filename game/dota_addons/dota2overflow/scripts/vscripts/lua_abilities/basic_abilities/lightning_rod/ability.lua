if lightning_rod == nil then
	lightning_rod = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
function lightning_rod:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function lightning_rod:OnSpellStart()
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() + Vector(0,0,65)  )
	ParticleManager:SetParticleControl( nFXIndex, 1, self:GetCaster():GetAbsOrigin() + Vector(0,0,65)  )
	ParticleManager:SetParticleControl( nFXIndex, 2, self:GetCaster():GetAbsOrigin() + Vector(0,0,2000)  )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Zuus.GodsWrath.PreCast", self:GetCaster() )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetSpecialValueFor("range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, FIND_CLOSEST, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil and ( not enemy:IsInvulnerable() ) then
				self:BlastThatTarget(enemy)
			end
		end
	end
	--particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf
	--sounds/weapons/hero/zuus/lightning_bolt.vsnd Hero_Zuus.LightningBolt
	--sounds/weapons/hero/zuus/gods_wrath_precast.vsnd Hero_Zuus.GodsWrath.PreCast
	--soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts
	
end

function lightning_rod:BlastThatTarget(hTarget)
		AddFOWViewer(self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), self:GetSpecialValueFor("radius")*2, 3, false) 
		EmitSoundOnLocationWithCaster( hTarget:GetOrigin(), "Hero_Zuus.LightningBolt", self:GetCaster() )
		local nFXIndexLng = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndexLng, 0, hTarget:GetAbsOrigin() + Vector(-200,-200,2000) )
		ParticleManager:SetParticleControl( nFXIndexLng, 1, hTarget:GetAbsOrigin() )
		local nFXIndex = ParticleManager:CreateParticle( "particles/shadow_raze_gen/raze.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetAbsOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 15, Vector( 0, 150, 250 ) )
		local stunDur = self:GetSpecialValueFor("duration")
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		local shk_dmg = self:GetSpecialValueFor("shock_damage")
		local mgc_dmg = self:GetSpecialValueFor("mdamage")
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsInvulnerable() ) then
					enemy:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = stunDur } )
					local armor = enemy:GetPhysicalArmorValue()
					if armor < 1 then armor = 1 end
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = shk_dmg * armor + mgc_dmg,
						damage_type = self:GetAbilityDamageType(),
						ability = self
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
