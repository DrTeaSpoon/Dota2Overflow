if chi_strike_mod == nil then
	chi_strike_mod = class({})
end

function chi_strike_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
 
	return funcs
end

function chi_strike_mod:IsHidden()
	return true
end

function chi_strike_mod:OnAttackStart( keys )
	if IsServer() then
		local hAbility = self:GetAbility()
		if hAbility:GetLevel() < 1 then return end
	if keys.attacker == self:GetParent() and not self:GetParent():IsIllusion() then
			if hAbility:IsCooldownReady() then
			end
		end
	end
end

function chi_strike_mod:OnAttack (keys)
	if IsServer() then
	local hAbility = self:GetAbility()
	
		if hAbility:GetLevel() < 1 then return end
	if keys.attacker == self:GetParent() and not self:GetParent():IsIllusion() and hAbility:IsCooldownReady() then
		hAbility.original_target = keys.target
		self:DoProjectile()
		hAbility:StartCooldown(hAbility:GetCooldown(hAbility:GetLevel()))
	end
	end
end

function chi_strike_mod:OnAttackLanded(keys)
	if IsServer() then
	local hAbility = self:GetAbility()
		if hAbility:GetLevel() < 1 then return end
	if keys.attacker == self:GetParent() and not self:GetParent():IsIllusion() and hAbility:IsCooldownReady() then
	end
	end
end

function chi_strike_mod:DoProjectile()
	local hCaster = self:GetParent()
	EmitSoundOnLocationWithCaster(hCaster:GetAbsOrigin(), "Hero_Magnataur.ShockWave.Cast", hCaster) 
	local hAbility = self:GetAbility()
	local range = hAbility:GetSpecialValueFor("range")
	local speed = hAbility:GetSpecialValueFor("speed")
	local info = 
	{
		Ability = hAbility,
        EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
        vSpawnOrigin = hCaster:GetAbsOrigin(),
        fDistance = range,
        fStartRadius = 100,
        fEndRadius = 100,
        Source = hCaster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_BUILDING,
        fExpireTime = GameRules:GetGameTime() + 10,
		bDeleteOnHit = false,
		vVelocity = hCaster:GetForwardVector() * speed,
		bProvidesVision = true,
		iVisionRadius = 50,
		iVisionTeamNumber = hCaster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end