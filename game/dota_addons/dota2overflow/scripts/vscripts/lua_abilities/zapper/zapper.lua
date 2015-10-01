if zapper == nil then
	zapper = class({})
end

LinkLuaModifier( "zapper_modifier", "lua_abilities/zapper/zapper_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "zapper_protect", "lua_abilities/zapper/zapper_protect.lua", LUA_MODIFIER_MOTION_NONE )

function zapper:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET | DOTA_ABILITY_BEHAVIOR_AUTOCAST | DOTA_ABILITY_BEHAVIOR_ATTACK
	return behav
end

function zapper:OnSpellStart()
	self.JumpDelay = self:GetSpecialValueFor("jump_delay")
	self.JumpCount = self:GetSpecialValueFor("jump_count")
	self.JumpRadius = self:GetSpecialValueFor("radius")
	self.JumpDamage = self:GetAbilityDamage()
	self.JumpDmgType = self:GetAbilityDamageType()
	self.InsProtect = self.JumpCount --We use this so the chain lightning can't circle back.
	
	local hCaster = self:GetCaster()
	local hTarget = false
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	if hTarget then
	
	local nFXIndex = ParticleManager:CreateParticle( self.Effect, PATTACH_CUSTOMORIGIN, nil );
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_attack1", hCaster:GetOrigin() + Vector( 0, 0, 50 ), true );
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
	ParticleManager:ReleaseParticleIndex( nFXIndex );
	--EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), self.SoundA, self:GetCaster() )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Zuus.ArcLightning.Cast", self:GetCaster() )
	hTarget:AddNewModifier( self:GetCaster(), self, self.MainMod, {
	duration = self.JumpDelay
	,jumps = self.JumpCount
	,radius = self.JumpRadius
	,dmg = self.JumpDamage
	,dmgtype = self.JumpDmgType
	,instance = GameRules:GetGameTime()
	} )
	end
end

function zapper:OnUpgrade()
	self.Sound = "Hero_Zuus.ArcLightning.Cast"
	self.Effect = "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf"
	self.MainMod = "zapper_modifier"
	self.ProtectMod = "zapper_protect"
end