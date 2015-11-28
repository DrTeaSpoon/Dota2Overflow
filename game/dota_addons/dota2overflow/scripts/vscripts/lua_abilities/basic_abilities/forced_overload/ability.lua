if forced_overload == nil then
	forced_overload = class({})
end
LinkLuaModifier( "forced_overload_mod", "lua_abilities/basic_abilities/forced_overload/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function forced_overload:OnSpellStart()
	local hCaster = self:GetCaster()
	local nSpeed = self:GetSpecialValueFor( "speed" )
	local nRadius = self:GetSpecialValueFor( "wave_radius" )
	local vDirection = self:GetCursorPosition() - hCaster:GetOrigin()
	local nDistance = self:GetSpecialValueFor("distance")
	vDirection = vDirection:Normalized()
	
	local info = {
		EffectName = "particles/forced_overload.vpcf",
		Ability = self,
		vSpawnOrigin = hCaster:GetOrigin(), 
		fStartRadius = nRadius,
		fEndRadius = nRadius,
		vVelocity = vDirection * nSpeed,
		fDistance = nDistance,
		Source = hCaster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = false,
		bProvidesVision = true,
		iVisionRadius = nRadius,
		iVisionTeamNumber = hCaster:GetTeamNumber()
	}
	ProjectileManager:CreateLinearProjectile( info )
	EmitSoundOn( "Hero_ShadowShaman.EtherShock", self:GetCaster() )
end

function forced_overload:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_POINT
	return behav
end

function forced_overload:OnProjectileHit( hTarget, vLocation )
	if hTarget then
	local nDuration = self:GetSpecialValueFor( "duration" )
	EmitSoundOn( "Hero_StormSpirit.StaticRemnantPlant", hTarget )
	hTarget:AddNewModifier( self:GetCaster(), self, "forced_overload_mod", { duration = nDuration } )
	else
	return true
	end
end