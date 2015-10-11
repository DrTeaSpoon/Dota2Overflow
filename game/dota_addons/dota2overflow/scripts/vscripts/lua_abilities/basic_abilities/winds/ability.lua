if winds == nil then
	winds = class({})
end

function winds:GetCastAnimation()
	return ACT_DOTA_ATTACK
end

function winds:GetPlaybackRateOverride()
	return 0.5
end

function winds:OnSpellStart()
	local vDirection = self:GetDirectionVector()
	local sSound = "Hero_Invoker.Tornado.Cast"
	EmitSoundOnLocationWithCaster(self:GetInitialPosition(), sSound, hCaster )
	local projectileName = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf"
	local range = self:GetSpecialValueFor( "range" )
	local speed = self:GetSpecialValueFor( "speed" )
	local radius = self:GetSpecialValueFor( "radius" )
	local hCaster = self:GetCaster()
	local projectileTable =
	{
		EffectName = projectileName,
		Ability = self,
		vSpawnOrigin = self:GetInitialPosition(),
		vVelocity = Vector( vDirection.x * speed,
			vDirection.y * speed, 0 ),
		fDistance = range,
		fStartRadius = radius,
		fEndRadius = radius,
		Source = self,
		bHasFrontalCone = false,
		bReplaceExisting = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iVisionRadius = radius,
		iVisionTeamNumber = hCaster:GetTeamNumber()
	}
	nProjectile = ProjectileManager:CreateLinearProjectile( projectileTable )
	self.vPoint = Vector( self:GetInitialPosition().x + vDirection.x * range,
			self:GetInitialPosition().y + vDirection.y * range, 0 )
end

function winds:OnProjectileHit( hTarget, vLocation )
	if hTarget and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) then
	local caster_location = hTarget:GetAbsOrigin()
	local speed = self:GetSpecialValueFor("speed") * 0.03
	local distance = (self.vPoint - caster_location):Length2D()
	local direction = (self.vPoint - caster_location):Normalized()
	local traveled_distance = 0

	Timers:CreateTimer(0, function()
		if traveled_distance < distance then
			caster_location = caster_location + direction * speed
			local pos = GetGroundPosition(caster_location, hTarget)
			pos.z = pos.z + (distance - traveled_distance)/10
			hTarget:SetAbsOrigin(pos)
			traveled_distance = traveled_distance + speed
			return 0.03
		else
			FindClearSpaceForUnit(hTarget, hTarget:GetAbsOrigin(), true) 
		end

	end)
	end
	return
end

function winds:OnUpgrade()
	if not self.isVectorTarget then
		VectorTarget:WrapAbility(self, {
            PointOfCast = "initial"
		})
	end
end