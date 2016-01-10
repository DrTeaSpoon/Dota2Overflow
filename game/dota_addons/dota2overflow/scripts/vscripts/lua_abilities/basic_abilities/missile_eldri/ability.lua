if missile_eldri == nil then
	missile_eldri = class({})
end
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "book_eldri_modifier", "lua_items/overflow/basics/eldri_book.lua", LUA_MODIFIER_MOTION_NONE )

function missile_eldri:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function missile_eldri:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	--hTarget:TriggerSpellReflect( self )
	local info = {
			EffectName = "particles/eldri_missile.vpcf",
			Ability = self,
			iMoveSpeed = self:GetSpecialValueFor( "speed" ),
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
end

function missile_eldri:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function missile_eldri:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) then
		EmitSoundOnLocationWithCaster( hTarget:GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
		local stun_dur = self:GetSpecialValueFor( "duration" )
		local magic_damage = self:GetSpecialValueFor( "m_damage" ) * self:GetCaster():GetIntellect() 
		local nDev = self:GetCaster():FindModifierByName("book_eldri_modifier"):GetStackCount()
		local devotion_damage = self:GetSpecialValueFor( "d_damage" ) * nDev
		hTarget:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = stun_dur , stacking = 1 } )
		local damage = {
			attacker = self:GetCaster(),
			damage = magic_damage + devotion_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
			victim = hTarget
		}
		ApplyDamage( damage )
	end
	
	return true
end


function missile_eldri:OnUpgrade()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "book_eldri_modifier", { stacks = 2 } )
end