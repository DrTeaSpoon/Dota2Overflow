if zuus_arc_lightning_lua == nil then
	zuus_arc_lightning_lua = class({})
end

LinkLuaModifier( "zuus_arc_lightning_lua_modifier", "heroes/hero_zuus/zuus_arc_lightning_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "zuus_arc_lightning_lua_protect", "heroes/hero_zuus/zuus_arc_lightning_protect.lua", LUA_MODIFIER_MOTION_NONE )

function zuus_arc_lightning_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function zuus_arc_lightning_lua:OnSpellStart()
	self.JumpDelay = self:GetSpecialValueFor("jump_delay")
	self.JumpCount = self:GetSpecialValueFor("jump_count")
	self.JumpRadius = self:GetSpecialValueFor("radius")
	self.iMDamage = self:GetSpecialValueFor( "magic_damage" )
	self.JumpDamage = self:GetSpecialValueFor( "damage" )
	self.JumpDmgType = self:GetAbilityDamageType()
	self.InsProtect = self.JumpCount --We use this so the chain lightning can't circle back.
	
	local hCaster = self:GetCaster()
	local hTarget = false
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	if hTarget then
		--hTarget:TriggerSpellReflect( self )
		local absorb = hTarget:TriggerSpellAbsorb( self )
		if not absorb then
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
			,mdmg = self.iMDamage
			,dmgtype = self.JumpDmgType
			,instance = GameRules:GetGameTime()
			} )
		else
		print("absorb")
		print(absorb)
		end
	end
end

function zuus_arc_lightning_lua:OnUpgrade()
	self.Sound = "Hero_Zuus.ArcLightning.Cast"
	self.Effect = "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf"
	self.MainMod = "zuus_arc_lightning_lua_modifier"
	self.ProtectMod = "zuus_arc_lightning_lua_protect"
end