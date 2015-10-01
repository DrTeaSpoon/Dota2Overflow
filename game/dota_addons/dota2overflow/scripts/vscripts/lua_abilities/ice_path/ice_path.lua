if ice_path == nil then
	ice_path = class({})
end

--[[
	Author: Ractidous
	Re-Worked for Lua Ability by DrTeaSpoon
]]

LinkLuaModifier( "ice_path_stun", "lua_abilities/ice_path/ice_path_stun.lua", LUA_MODIFIER_MOTION_NONE )
function ice_path:GetCastAnimation()
	return ACT_DOTA_ATTACK
end

function ice_path:GetPlaybackRateOverride()
	return 0.5
end

function ice_path:OnSpellStart()
	local hCaster		= self:GetCaster()
	local pathLength	= self:GetSpecialValueFor( "range" ) --self:GetCastRange( self:GetCursorPosition(), nil)
	--local vForward = self:GetCursorPosition() - hCaster:GetAbsOrigin()
	--vForward = vForward:Normalized() 
	local pathDelay		= self:GetSpecialValueFor( "path_delay" )
	local pathDuration	= self:GetSpecialValueFor( "duration" )
	local pathRadius	= self:GetSpecialValueFor( "path_radius" )
	--local startPos = hCaster:GetAbsOrigin()
	--local endPos = startPos + vForward * pathLength
	--local endPosFx = startPos + vForward * (pathLength+100)
	--local endPosSnd = startPos + vForward * (pathLength/2)
	
	local midPos = self:GetMidpointPosition()
	local vForward = self:GetDirectionVector()
	local endPos = midPos + vForward * (pathLength/2)
	local startPos = midPos + (vForward*-1) * (pathLength/2+50)
	local endPosFx = midPos + vForward * (pathLength/2+50)
	
	--local endPos = startPos + vForward * pathLength
	--local endPosFx = startPos + vForward * (pathLength+100)
	--local endPosSnd = startPos + vForward * (pathLength/2)
	
	self.ice_path_stunStart	= GameRules:GetGameTime() + pathDelay
	self.ice_path_stunEnd = GameRules:GetGameTime() + pathDelay + pathDuration
	self.ice_path_startPos = startPos * 1
	self.ice_path_endPos = endPos * 1
	self.ice_path_startPos.z = 0
	self.ice_path_endPos.z = 0
	--sound sounds/weapons/hero/jakiro/ice_path.vsnd
	EmitSoundOnLocationWithCaster(midPos, "Hero_Jakiro.IcePath", hCaster )
	-- Create ice_path
	local particleName = "particles/jakiro_ice_path_blob.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	ParticleManager:SetParticleControl( pfx, 0, startPos )
	ParticleManager:SetParticleControl( pfx, 1, endPosFx )
	ParticleManager:SetParticleControl( pfx, 2, Vector( pathDelay + pathDuration, 5+self:GetLevel()*2, 0 ) )
	ParticleManager:SetParticleControl( pfx, 9, startPos )

	self.pfxIcePath = pfx

	--Create ice_path_b
	particleName = "particles/units/heroes/hero_jakiro/jakiro_ice_path_b.vpcf"
	pfx_b = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	ParticleManager:SetParticleControl( pfx_b, 0, startPos )
	ParticleManager:SetParticleControl( pfx_b, 1, endPosFx )
	ParticleManager:SetParticleControl( pfx_b, 2, Vector( pathDelay + pathDuration, 0, 0 ) )
	ParticleManager:SetParticleControl( pfx_b, 9, startPos )

	-- Generate projectiles
	if pathRadius < 32 then
		--print( "Set the proper value of path_radius in ice_path_datadriven." )
		return
	end

	local projectileRadius = pathRadius * math.sqrt(2)
	local numProjectiles = math.floor( pathLength / (pathRadius*2) ) + 1
	local stepLength = pathLength / ( numProjectiles - 1 )

	for i=1, numProjectiles do
		local projectilePos = startPos + vForward * (i-1) * stepLength
		--DebugDrawCircle(projectilePos, Vector(255,255,255), 1, pathRadius, false, pathDelay + pathDuration ) 
		ProjectileManager:CreateLinearProjectile( {
			Ability				= self,
			vSpawnOrigin		= projectilePos,
			fDistance			= 64,
			fStartRadius		= projectileRadius,
			fEndRadius			= projectileRadius,
			Source				= hCaster,
			bHasFrontalCone		= false,
			bReplaceExisting	= false,
			iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_MECHANICAL,
			fExpireTime			= self.ice_path_stunEnd,
			bDeleteOnHit		= false,
			vVelocity			= Vector( 0, 0, 0 ),	-- Don't move!
			bProvidesVision		= true,
			iVisionRadius		= 150,
			iVisionTeamNumber	= hCaster:GetTeamNumber(),
		} )
	end
	
end


function ice_path:OnProjectileHit( hTarget, vLocation )
	local hCaster = self:GetCaster()
	local stun_remaining = self.ice_path_stunEnd - GameRules:GetGameTime()
	if hTarget then
		hTarget:AddNewModifier( hCaster, self, "ice_path_stun", { duration = stun_remaining } )
		local nDamageType = DAMAGE_TYPE_MAGICAL
		local damage = {
			victim = hTarget,
			attacker = hCaster,
			damage = self:GetSpecialValueFor( "damage" ),
			damage_type = nDamageType,
			ability = self
		}
		ApplyDamage( damage )
	end
end

--function ice_path:ApplyDummyModifier()
--	local hCaster		= self:GetCaster()
--	local target = event.target
--	local modifierName = event.modifier_name
--
--	local duration = self.ice_path_stunEnd - GameRules:GetGameTime()
--
--	self:ApplyDataDrivenModifier( hCaster, target, modifierName, { duration = duration } )
--end

--function ice_path:CheckIcePath()
--	local hCaster		= self:GetCaster()
--	local target		= event.target
--	local pathRadius	= event.path_radius
--
--	local stunModifierName	= "modifier_ice_path_stun_datadriven"
--
--	if GameRules:GetGameTime() < self.ice_path_stunStart then
--		-- Not yet.
--		return
--	end
--
--	if target:HasModifier( stunModifierName ) then
--		-- Already stunned.
--		return
--	end
--
--	local targetPos = target:GetAbsOrigin()
--	targetPos.z = 0
--
--	local distance = DistancePointSegment( targetPos, self.ice_path_startPos, self.ice_path_endPos )
--	if distance < pathRadius then
--		local duration = self.ice_path_stunEnd - GameRules:GetGameTime()
--		self:ApplyDataDrivenModifier( hCaster, target, stunModifierName, { duration = duration } )
--	end
--end
--
--function ice_path:DistancePointSegment( p, v, w )
--	local l = w - v
--	local l2 = l:Dot( l )
--	t = ( p - v ):Dot( w - v ) / l2
--	if t < 0.0 then
--		return ( v - p ):Length2D()
--	elseif t > 1.0 then
--		return ( w - p ):Length2D()
--	else
--		local proj = v + t * l
--		return ( proj - p ):Length2D()
--	end
--end

function ice_path:OnUpgrade()
	if not self.isVectorTarget then
		VectorTarget:WrapAbility(self, {

            PointOfCast = "midpoint"
		})
	end
end