if teleport_basic == nil then
	teleport_basic = class({})
end

function teleport_basic:OnSpellStart()
	self.point = self:GetCursorPosition() 
	--create effect at point
	--particles/items2_fx/teleport_end.vpcf
	--particles/items2_fx/teleport_start.vpcf
	local particleName = "particles/units/heroes/hero_wisp/wisp_relocate_channel.vpcf"
	local hCaster = self:GetCaster()
	self.end_fx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	ParticleManager:SetParticleControl( self.end_fx, 0, self.point )
	self.start_fx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	ParticleManager:SetParticleControl( self.start_fx, 0, hCaster:GetAbsOrigin()  )
		EmitSoundOnLocationWithCaster(self:GetCaster():GetAbsOrigin() , "Hero_Wisp.Relocate", hCaster )
		EmitSoundOnLocationWithCaster(self.point, "Hero_Wisp.Relocate", hCaster )
		self:StartCooldown(self:GetCooldown(self:GetLevel()))
end

function teleport_basic:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
	return behav
end

function teleport_basic:OnChannelFinish( bInterrupted )
	if not bInterrupted then
		--teleport!
		EmitSoundOnLocationWithCaster(self:GetCaster():GetAbsOrigin() , "Hero_Furion.Teleport_Disappear", hCaster )
		EmitSoundOnLocationWithCaster(self.point, "Hero_Furion.Teleport_Disappear", hCaster )
		self:GetCaster():SetAbsOrigin( self.point ) --We move the caster instantly to the location
		FindClearSpaceForUnit(self:GetCaster(), self.point , false)
		--soundevents/game_sounds_heroes/game_sounds_furion.vsndevts
		--soundevents/game_sounds_heroes/game_sounds_wisp.vsndevts
		--Hero_Furion.Teleport_Disappear
		--Hero_Wisp.Relocate
	end
	--end effect
	ParticleManager:DestroyParticle(self.end_fx, false) 
	ParticleManager:DestroyParticle(self.start_fx, false) 
	self.point = nil
end