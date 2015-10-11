if sun_ray == nil then
	sun_ray = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
function sun_ray:OnSpellStart()
	self.point = self:GetCursorPosition() 
	local hCaster = self:GetCaster()
	local particleName = "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf"
	self.end_fx = ParticleManager:CreateParticleForTeam( particleName, PATTACH_ABSORIGIN, hCaster, hCaster:GetTeam() )
	ParticleManager:SetParticleControl( self.end_fx, 0, self.point )
	ParticleManager:SetParticleControl( self.end_fx, 1, Vector(self:GetSpecialValueFor("radius"),0,0) )
	EmitSoundOnLocationForAllies(self:GetCursorPosition() , "Hero_Invoker.SunStrike.Charge", hCaster)
	AddFOWViewer(self:GetCaster():GetTeam(), self.point, self:GetSpecialValueFor("radius")+40, 4, false) 
	--Add temporary vision for a given team ( nTeamID, vLocation, flRadius, flDuration, bObstructedVision) 
end

function sun_ray:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function sun_ray:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_AOE
	return behav
end

function sun_ray:OnChannelFinish( bInterrupted )
	if not bInterrupted then
		--teleport!
		local hCaster = self:GetCaster()
		local particleName = "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf"
		local expl = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
		ParticleManager:SetParticleControl( expl, 0, self.point )
	ParticleManager:SetParticleControl( expl, 1, Vector(self:GetSpecialValueFor("radius"),0,0) )
		EmitSoundOnLocationWithCaster(self.point, "Hero_Invoker.SunStrike.Ignite", hCaster )
		local dmg = self:GetSpecialValueFor("fire_damage")
		local aoe = self:GetSpecialValueFor("radius")
					local damage = {
						attacker = self:GetCaster(),
						damage = self:GetSpecialValueFor("magic_damage"),
						damage_type = self:GetAbilityDamageType(),
						ability = self
					}
		local enemies = FindUnitsInRadius( hCaster:GetTeamNumber(), self.point, nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
				
					enemy:AddNewModifier(self:GetCaster(), self, "element_fire", {
						stacks = dmg
					})
					damage.victim = enemy
					ApplyDamage( damage )
				end
			end
		end
	end
	--end effect
	ParticleManager:DestroyParticle(self.end_fx, false) 
	self.point = nil
end