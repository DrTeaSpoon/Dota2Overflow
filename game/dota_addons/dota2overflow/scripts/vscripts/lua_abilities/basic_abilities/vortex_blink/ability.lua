if vortex_blink == nil then
	vortex_blink = class({})
end


function vortex_blink:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
	return behav
end

function vortex_blink:GetManaCost()
	return self.BaseClass.GetManaCost( self, self:GetLevel() )
end

function vortex_blink:GetCooldown( nLevel )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	else
		return self.BaseClass.GetCooldown( self, nLevel )
	end
end


function vortex_blink:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function vortex_blink:OnSpellStart()
	local hCaster = self:GetCaster() --We will always have Caster.
	local hTarget = hCaster --We might not have target so we make fail-safe so we do not get an error when calling - self:GetCursorTarget()
	local vPoint = self:GetCursorPosition() --We will always have Vector for the point.
	local vOrigin = hCaster:GetAbsOrigin() --Our caster's location
	local nMaxBlink = self:GetSpecialValueFor( "max_blink" ) --How far can we actually blink?
	local nClamp = self:GetSpecialValueFor( "blink_clamp" ) --If we try to over reach we use this value instead. (this is mechanic from blink dagger.)
		local nFlag = self:GetAbilityTargetFlags() or DOTA_UNIT_TARGET_FLAG_NONE
		local nTeam = self:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
		local nType = self:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
		if nTeam == DOTA_UNIT_TARGET_TEAM_CUSTOM then nTeam = DOTA_UNIT_TARGET_TEAM_BOTH end
		if nType == DOTA_UNIT_TARGET_CUSTOM  then nType = DOTA_UNIT_TARGET_ALL  end
		local nRange = self:GetSpecialValueFor("radius")
       local tTargets = FindUnitsInRadius(hCaster:GetTeam(),
           hTarget:GetOrigin(),
           nil,
           nRange,
           nTeam,
           nType,
           nFlag,
           FIND_ANY_ORDER,
           false
       )
	   
		hTarget:EmitSound("DOTA_Item.BlinkDagger.Activate") --Emit sound for the blink
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf", PATTACH_CUSTOMORIGIN, nil );
			ParticleManager:SetParticleControl(nFXIndex, 0, hTarget:GetOrigin())
			ParticleManager:SetParticleControl(nFXIndex, 1, Vector(nRange,0,0)) 
			ParticleManager:ReleaseParticleIndex( nFXIndex );
	   if tTargets and tTargets[1] then
		for k,v in pairs(tTargets) do
				self:Blink(v, vPoint, nMaxBlink, nClamp)
			end
		end
end


function vortex_blink:Blink(hTarget, vPoint, nMaxBlink, nClamp)
	local vOrigin = hTarget:GetAbsOrigin() --Our units's location
	ProjectileManager:ProjectileDodge(hTarget)  --We disjoint disjointable incoming projectiles.
	local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_blink_strike.vpcf", PATTACH_WORLDORIGIN, hTarget) --Create particle effect at our caster.
			ParticleManager:SetParticleControl(nFXIndex, 0, hTarget:GetOrigin() + Vector(0,0,90))
	local vDiff = vPoint - vOrigin --Difference between the points
	if vDiff:Length2D() > nMaxBlink then  --Check caster is over reaching.
		vPoint = vOrigin + (vPoint - vOrigin):Normalized() * nClamp -- Recalculation of the target point.
	end
	hTarget:SetAbsOrigin(vPoint) --We move the caster instantly to the location
	FindClearSpaceForUnit(hTarget, vPoint, false) --This makes sure our caster does not get stuck
			ParticleManager:SetParticleControl(nFXIndex, 1, vPoint + Vector(0,0,90))
			ParticleManager:ReleaseParticleIndex( nFXIndex );
end