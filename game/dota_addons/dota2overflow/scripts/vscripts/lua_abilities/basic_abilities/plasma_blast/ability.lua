if plasma_blast == nil then
	plasma_blast = class({})
end
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )

function plasma_blast:OnSpellStart()
	local hCaster = self:GetCaster()
	local nSpeed = self:GetSpecialValueFor( "speed" )
	local vDirection = self:GetCursorPosition() - hCaster:GetOrigin()
	local nDistance = self:GetSpecialValueFor("distance")
	vDirection = vDirection:Normalized()
	
	local info = {
		EffectName = "particles/plasma_blast.vpcf",
		Ability = self,
		vSpawnOrigin = hCaster:GetOrigin(), 
		fStartRadius = 50,
		fEndRadius = 50,
		vVelocity = vDirection * nSpeed,
		fDistance = nDistance,
		Source = hCaster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = true,
		bProvidesVision = true,
		iVisionRadius = 55,
		iVisionTeamNumber = hCaster:GetTeamNumber()
	}
	ProjectileManager:CreateLinearProjectile( info )
	EmitSoundOn( "Hero_VengefulSpirit.MagicMissile", self:GetCaster() )
end

function plasma_blast:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CHANNELLED
	return behav
end

function plasma_blast:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function plasma_blast:OnProjectileHit( hTarget, vLocation )
	return true
end