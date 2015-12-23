if missile_shock == nil then
	missile_shock = class({})
end
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )

function missile_shock:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function missile_shock:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	--hTarget:TriggerSpellReflect( self )
	local info = {
			EffectName = "particles/shock_missile.vpcf",
			Ability = self,
			iMoveSpeed = self:GetSpecialValueFor( "speed" ),
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Item_Desolator.Target", self:GetCaster() )
end

function missile_shock:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function missile_shock:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) then
		EmitSoundOn( "Item.Maelstrom.Chain_Lightning.Jump", hTarget )
		local stun_dur = self:GetSpecialValueFor( "duration" )
		local magic_damage = self:GetSpecialValueFor( "m_damage" )
		local shk_dmg = self:GetSpecialValueFor("shock_damage")
		hTarget:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = stun_dur , stacking = 1 } )
		local armor = hTarget:GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
		local damage = {
			attacker = self:GetCaster(),
			damage = shk_dmg * armor + magic_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
			victim = hTarget
		}
		ApplyDamage( damage )
	end
	
	return true
end