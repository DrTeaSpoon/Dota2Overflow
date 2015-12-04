if judgement == nil then
	judgement = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function judgement:GetCooldown(iLevel)
	local cooldown = self.BaseClass.GetCooldown( self, iLevel )
	if self:GetCaster():HasScepter() then cooldown = self:GetSpecialValueFor("cooldown_scepter") end
	return cooldown
end

function judgement:OnSpellStart()
	local hCaster = self:GetCaster()
	local nTeam = hCaster:GetTeam()
	local tHeroes = HeroList:GetAllHeroes()
	self.points = {}
	for k,v in pairs(tHeroes) do
		if v:GetTeam() ~= nTeam then
			local vPoint = v:GetAbsOrigin()
			table.insert(self.points,vPoint)
		end
	end
	
	local particleName = "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf"
	if #self.points < 1 then return end
	
	local channel_particleName = "particles/units/heroes/hero_wisp/wisp_overcharge.vpcf"
	self.ChfxIndex = ParticleManager:CreateParticle( channel_particleName, PATTACH_WORLDORIGIN, hCaster )
	ParticleManager:SetParticleControl( self.ChfxIndex, 0, hCaster:GetAbsOrigin() + Vector(0,0,100) )
	
	for k,v in pairs(self.points) do
	local fxIndex = ParticleManager:CreateParticleForTeam( particleName, PATTACH_WORLDORIGIN, hCaster, hCaster:GetTeam() )
	ParticleManager:SetParticleControl( fxIndex, 0, v )
	ParticleManager:SetParticleControl( fxIndex, 1, Vector(self:GetSpecialValueFor("radius"),0,0) )
	EmitSoundOnLocationForAllies(v , "Hero_Invoker.SunStrike.Charge", hCaster)
	AddFOWViewer(self:GetCaster():GetTeam(), v, self:GetSpecialValueFor("radius")+40, 4, false) 
	end
	self.start_time = GameRules:GetGameTime()
end


function judgement:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED
	return behav
end

function judgement:OnChannelFinish( bInterrupted )
	if self.ChfxIndex then
		ParticleManager:DestroyParticle(self.ChfxIndex, false)
		ParticleManager:ReleaseParticleIndex(self.ChfxIndex) 
		self.ChfxIndex = nil
	end
	if #self.points < 1 then return end
		self.end_time = GameRules:GetGameTime()
		local mult = self.end_time - self.start_time + 1
		--print(mult)
		local hCaster = self:GetCaster()
		local particleName = "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf"
		for k,v in pairs(self.points) do
			local expl = ParticleManager:CreateParticle( particleName, PATTACH_WORLDORIGIN, hCaster )
			ParticleManager:SetParticleControl( expl, 0, v )
			ParticleManager:SetParticleControl( expl, 1, Vector(self:GetSpecialValueFor("radius"),0,0) )
			ParticleManager:ReleaseParticleIndex(expl) 
			local dmg = math.floor(self:GetSpecialValueFor("fire_damage") * mult)
			local aoe = self:GetSpecialValueFor("radius")
						local damage = {
							attacker = self:GetCaster(),
							damage = math.floor(self:GetSpecialValueFor("magic_damage") * mult),
							damage_type = self:GetAbilityDamageType(),
							ability = self
						}
			local enemies = FindUnitsInRadius( hCaster:GetTeamNumber(), v, nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
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
	self.points = nil
		EmitGlobalSound("Hero_Invoker.SunStrike.Ignite") 
end
