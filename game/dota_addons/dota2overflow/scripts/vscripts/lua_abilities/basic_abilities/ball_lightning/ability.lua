if ball_lightning == nil then
	ball_lightning = class({})
end

function ball_lightning:GetCastAnimation()
	return ACT_DOTA_ATTACK
end

function ball_lightning:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT
	return behav
end

function ball_lightning:GetPlaybackRateOverride()
	return 0.5
end

function ball_lightning:OnSpellStart()
	local hCaster = self:GetCaster()
	local vDirection = hCaster:GetForwardVector() 
	local sSound = "Hero_Invoker.Tornado.Cast"
	EmitSoundOnLocationWithCaster(self:GetCaster():GetAbsOrigin(), sSound, hCaster )
	local projectileName = "particles/econ/generic/generic_projectile_linear_1/generic_projectile_linear_1.vpcf"
	local range = self:GetSpecialValueFor( "range" )
	local speed = self:GetSpecialValueFor( "speed" )
	local radius = self:GetSpecialValueFor( "radius" )
	local projectileTable =
	{
		EffectName = projectileName,
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
		vVelocity = Vector( vDirection.x * speed,
			vDirection.y * speed, 0 ),
		fDistance = range,
		fStartRadius = radius,
		fEndRadius = radius,
		Source = self,
		bHasFrontalCone = false,
		bReplaceExisting = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iVisionRadius = radius,
		iVisionTeamNumber = hCaster:GetTeamNumber()
	}
	nProjectile = ProjectileManager:CreateLinearProjectile( projectileTable )
end

function ball_lightning:OnProjectileHit( hTarget, vLocation )
	if hTarget then
		if not hTarget:IsMagicImmune() and not hTarget:IsInvulnerable() then
			local iAoE = self:GetSpecialValueFor( "radius" )
			local iDamage = self:GetSpecialValueFor( "damage" )
			local iMDamage = self:GetSpecialValueFor( "magic_damage" )
			local armor = hTarget:GetPhysicalArmorValue()
			if armor < 1 then armor = 1 end
			local damage = {
				victim = hTarget,
				attacker = self:GetCaster(),
				damage = iDamage * armor + iMDamage,
				damage_type = self:GetAbilityDamageType(),
				ability = self
			}
			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_WORLDORIGIN, nil )
			--ParticleManager:SetParticleControlEnt( nFXIndex, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
			ParticleManager:SetParticleControl( nFXIndex, 1, Vector( iAoE, 1, 1 ) )
			ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetOrigin()+Vector(0,0,100) )
			ParticleManager:ReleaseParticleIndex( nFXIndex )
			ApplyDamage( damage )
		end
	end
	return
end