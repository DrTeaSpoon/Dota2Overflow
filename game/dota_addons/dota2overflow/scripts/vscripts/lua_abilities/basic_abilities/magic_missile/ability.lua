if magic_missile == nil then
	magic_missile = class({})
end
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )

function magic_missile:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function magic_missile:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	--hTarget:TriggerSpellReflect( self )
	local info = {
			EffectName = "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
			Ability = self,
			iMoveSpeed = self:GetSpecialValueFor( "speed" ),
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Hero_VengefulSpirit.MagicMissile", self:GetCaster() )
end

function magic_missile:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
	return behav
end

function magic_missile:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function magic_missile:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) and ( not hTarget:IsMagicImmune() ) then
		EmitSoundOn( "Hero_VengefulSpirit.MagicMissileImpact", hTarget )
		local magic_missile_stun = self:GetSpecialValueFor( "stun" )
		local magic_missile_damage = self:GetSpecialValueFor( "damage" )

		local damage = {
			attacker = self:GetCaster(),
			damage = magic_missile_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}

		local nFlag = self:GetAbilityTargetFlags() or DOTA_UNIT_TARGET_FLAG_NONE
		local nTeam = self:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
		local nType = self:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
		if nTeam == DOTA_UNIT_TARGET_TEAM_CUSTOM then nTeam = DOTA_UNIT_TARGET_TEAM_BOTH end
		if nType == DOTA_UNIT_TARGET_CUSTOM  then nType = DOTA_UNIT_TARGET_ALL  end
		local nRange = self:GetSpecialValueFor("radius")
       local tTargets = FindUnitsInRadius(self:GetCaster():GetTeam(),
           hTarget:GetOrigin(),
           nil,
           nRange,
           nTeam,
           nType,
           nFlag,
           FIND_ANY_ORDER,
           false
       )
	   if tTargets and tTargets[1] then
		for k,v in pairs(tTargets) do
			if v ~= hTarget then
				local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf", PATTACH_CUSTOMORIGIN, nil );
				ParticleManager:SetParticleControlEnt( nFXIndex, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin() + Vector( 0, 0, 96 ), true );
				ParticleManager:SetParticleControlEnt( nFXIndex, 1, v, PATTACH_POINT_FOLLOW, "attach_hitloc", v:GetOrigin() + Vector( 0, 0, 96 ), true );
				Timers:CreateTimer(0.25, 
				function()
					magic_missile:Blink(v, hTarget:GetOrigin(), nRange, nRange)
				end)
			end
			
				damage.victim = v
				ApplyDamage( damage )
			end
		end
		--particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf
		hTarget:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = magic_missile_stun } )
	end
	
	return true
end

function magic_missile:Blink(hTarget, vPoint, nMaxBlink, nClamp)
	local vOrigin = hTarget:GetAbsOrigin() --Our units's location
	ProjectileManager:ProjectileDodge(hTarget)  --We disjoint disjointable incoming projectiles.
	ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_start_ti4.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
	hTarget:EmitSound("DOTA_Item.BlinkDagger.Activate") --Emit sound for the blink
	local vDiff = vPoint - vOrigin --Difference between the points
	if vDiff:Length2D() > nMaxBlink then  --Check caster is over reaching.
		vPoint = vOrigin + (vPoint - vOrigin):Normalized() * nClamp -- Recalculation of the target point.
	end
	hTarget:SetAbsOrigin(vPoint) --We move the caster instantly to the location
	FindClearSpaceForUnit(hTarget, vPoint, false) --This makes sure our caster does not get stuck
	ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
end