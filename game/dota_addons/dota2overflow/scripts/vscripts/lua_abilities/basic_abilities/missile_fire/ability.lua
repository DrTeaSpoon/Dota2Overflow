if missile_fire == nil then
	missile_fire = class({})
end
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function missile_fire:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end
function missile_fire:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	--hTarget:TriggerSpellReflect( self )
	local info = {
			EffectName = "particles/fire_missile.vpcf",
			Ability = self,
			iMoveSpeed = self:GetSpecialValueFor( "speed" ),
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Item_Desolator.Target", self:GetCaster() )
end

function missile_fire:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function missile_fire:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) then
		EmitSoundOn( "Item.LotusOrb.Destroy", hTarget )
		local stun_dur = self:GetSpecialValueFor( "duration" )
		local fire_dmg = self:GetSpecialValueFor( "fire_damage" )
		local magic_damage = self:GetSpecialValueFor( "m_damage" )

		hTarget:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = stun_dur } )
       hTarget:AddNewModifier(self:GetCaster(), self, "element_fire", {
            stacks = fire_dmg
        })
		local damage = {
			attacker = self:GetCaster(),
			damage = magic_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
			victim = hTarget
		}
		ApplyDamage( damage )
	end
	
	return true
end