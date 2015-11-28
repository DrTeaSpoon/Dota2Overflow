if soul_reaver == nil then
	soul_reaver = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "soul_reaver_mod", "lua_abilities/ultimates/soul_reaver/ultimate_mod.lua", LUA_MODIFIER_MOTION_NONE )

function soul_reaver:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function soul_reaver:GetPlaybackRateOverride()
	return 1.0
end

function soul_reaver:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function soul_reaver:OnAbilityPhaseStart()
		self.nFXIndex = ParticleManager:CreateParticle( "particles/transformation.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControl(self.nFXIndex, 0, self:GetCaster():GetOrigin()) 
		return true
end

function soul_reaver:OnAbilityPhaseInterrupted() 
		ParticleManager:ReleaseParticleIndex(self.nFXIndex)
end

function soul_reaver:GetManaCost(iLevel)
	local cost = self.BaseClass.GetManaCost( self, iLevel )
	local hCaster = self:GetCaster()
	local nHPerc = hCaster:GetHealthPercent()
	if self:GetCaster():HasModifier("soul_reaver_mod") then
			cost = 0
		if self:GetSpecialValueFor("treshold") > nHPerc then
		cost = self:GetSpecialValueFor("treshold_penalty")
		end
		if self:GetCaster():HasScepter() then
			cost = 0
		end
	end
	return cost
end

function soul_reaver:GetCooldown(iLevel)
	local cooldown = self.BaseClass.GetCooldown( self, iLevel )
	return cooldown
end

function soul_reaver:OnSpellStart()
		ParticleManager:ReleaseParticleIndex(self.nFXIndex)
	if self:GetCaster():HasModifier("soul_reaver_mod") then
		self:GetCaster():RemoveModifierByName("soul_reaver_mod")
		self:GetCaster():StartGesture(ACT_DOTA_SPAWN)
	else
		EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Warlock.RainOfChaos_buildup", self:GetCaster() )
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "soul_reaver_mod",{} )
	end
	self:MarkAbilityButtonDirty() 
end