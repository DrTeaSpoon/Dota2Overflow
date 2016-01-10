if eldri_6_gon == nil then
	eldri_6_gon = class({})
end

LinkLuaModifier( "eldri_6_gon_effect_modifier", "lua_abilities/dev/eldri_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function eldri_6_gon:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function eldri_6_gon:GetManaCost()
	return self.BaseClass.GetManaCost( self, 1 )
end

function eldri_6_gon:GetCooldown( nLevel )
	return self.BaseClass.GetCooldown( self, nLevel )
end

function eldri_6_gon:OnSpellStart()
	local hCaster = self:GetCaster() --We will always have Caster.
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	local mod = "eldri_6_gon_effect_modifier"
	if hTarget then
		--hTarget:TriggerSpellReflect( self )
		local absorb = hTarget:TriggerSpellAbsorb( self )
		if absorb then return end
		local fDuration = self:GetSpecialValueFor("duration")
		local sModel = "models/items/furion/treant/shroomling_treant/shroomling_treant.vmdl"
		hTarget:AddNewModifier( hCaster, self, mod, {duration = fDuration, model = sModel} ) 
		local nFXIndex = ParticleManager:CreateParticle("particles/basic_projectile/basic_projectile_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 3, hTarget:GetOrigin() )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		EmitSoundOnLocationWithCaster( hTarget:GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
	end
end