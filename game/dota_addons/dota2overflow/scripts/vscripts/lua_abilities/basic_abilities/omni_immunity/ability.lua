if omni_immunity == nil then
	omni_immunity = class({})
end
LinkLuaModifier( "omni_immunity_mod", "lua_abilities/basic_abilities/omni_immunity/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function omni_immunity:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function omni_immunity:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	--hTarget:TriggerSpellReflect( self )
	local info = {
			EffectName = "particles/omni_missile.vpcf",
			Ability = self,
			iMoveSpeed = self:GetSpecialValueFor( "speed" ),
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Item_Desolator.Target", self:GetCaster() )
end

function omni_immunity:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
	return behav
end

function omni_immunity:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function omni_immunity:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) then
		EmitSoundOn( "Hero_Omniknight.Repel", hTarget )
		local omni_immunity_dur = self:GetSpecialValueFor( "duration" )
		
		if GameRules:IsDaytime() then
				hTarget:Heal(self:GetSpecialValueFor( "heal" ), self)
		end
		--particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf
		hTarget:AddNewModifier( self:GetCaster(), self, "omni_immunity_mod", { duration = omni_immunity_dur } )
	end
	
	return true
end