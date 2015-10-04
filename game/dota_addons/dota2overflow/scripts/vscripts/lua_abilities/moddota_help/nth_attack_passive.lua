if nth_attack_modifier == nil then
	nth_attack_modifier = class({})
end

function nth_attack_modifier:OnCreated( kv )	
	if IsServer() and self:GetAbility():GetLevel() > 0 then
		local hAbility = self:GetAbility()
		local hCaster = self:GetCaster()
	end
end

function nth_attack_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function nth_attack_modifier:OnAttackLanded( kv )
	if IsServer() then
		local hAbility = self:GetAbility()
		local hCaster = self:GetCaster()
		local nMaxStacks = hAbility:GetSpecialValueFor("attacks_to_proc")
		if kv.attacker == hCaster then
			if self:GetStackCount() < 1 then
			self:ProcSpecial(kv.target)
			self:SetStackCount(nMaxStacks)
			end 
			self:DecrementStackCount()
			self:ForceRefresh()
		end
	end
end

function nth_attack_modifier:OnRefresh(old)
	self.UpdateNeeded = true
	self.UpdateDone = false
end

function nth_attack_modifier:ProcSpecial(hTarget)
	if IsServer() then
		local hAbility = self:GetAbility()
		if hAbility:GetLevel() > 0 then
		local hCaster = self:GetCaster()
		local vPoint = hAbility:GetCursorPosition()
		local nMaxStacks = hAbility:GetSpecialValueFor("attacks_to_proc")
		--Hero_Abaddon.DeathCoil.Cast
		local iAoE = hAbility:GetSpecialValueFor( "radius" )
		local fDuration = hAbility:GetSpecialValueFor( "stun_duration" )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( iAoE, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_EarthShaker.EchoSlamSmall", self:GetCaster() )
		
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), hTarget:GetOrigin(), self:GetParent(), iAoE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = hAbility:GetAbilityDamage(),
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
	
					ApplyDamage( damage )
					enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = fDuration } )
				end
			end
		end
	end
	end
end

function  nth_attack_modifier:IsPurgable() 
	return false
end

function nth_attack_modifier:IsHidden()
	local hAbility = self:GetAbility()
	if self.UpdateNeeded or hAbility:GetLevel()  < 1 then
		if hAbility:GetLevel()  < 1 then
			if self.UpdateDone then
				self.UpdateNeeded = false
			end
			if self.UpdateNeeded then
				self.UpdateDone = true
			end
		end
		return true
	else
		return false
	end
end

function nth_attack_modifier:GetTexture()
		if self:GetStackCount() < 1 then
	return	"nth_attack_ready"
		else
	return	"nth_attack_n_ready"
		end
end