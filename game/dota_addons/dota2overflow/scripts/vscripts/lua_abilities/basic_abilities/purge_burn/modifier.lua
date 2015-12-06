if purge_burn_mod == nil then
	purge_burn_mod = class({})
end

function purge_burn_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSORB_SPELL,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function purge_burn_mod:OnCreated(kv)
	if IsServer() then
		--self.nFXIndex = ParticleManager:CreateParticle( "particles/purge_burn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		--ParticleManager:SetParticleControl( self.nFXIndex, 0, self:GetParent():GetAbsOrigin() + Vector( 0, 0, 100) )
		--ParticleManager:SetParticleControl( self.nFXIndex, 1, Vector( 100, 100, 100) )
		--ParticleManager:SetParticleControl( self.nFXIndex, 2, Vector( 100, 100, 100) )
		--ParticleManager:SetParticleControl( self.nFXIndex, 4, Vector( 100, 100, 100) )
		--ParticleManager:SetParticleControl( self.nFXIndex, 5, Vector( 100, 100, 100) )
		--self:AddParticle( self.nFXIndex, false, false, -1, false, false )
		self.stacker = 1
		self:IncrementStackCount()
	end
end

function purge_burn_mod:GetAbsorbSpell(kv)
	if IsServer() then
	local hAbility = self:GetAbility()
		self.stacker = self.stacker + 1
		self:IncrementStackCount()
		self:GetParent():Purge(true, true, false, true, false) 
		self:SetDuration(self:GetDuration()+hAbility:GetSpecialValueFor("duration"), true) 
		return 1
	end
end

function purge_burn_mod:OnDestroy()
	if IsServer() then
		--self.stacker = self.stacker + self:GetPurgableCount()
		self:GetParent():Purge(false, true, false, true, false) 
		self:EndProc(self.stacker)
	end
end

function purge_burn_mod:IsHidden()
	return false
end

function purge_burn_mod:IsPurgable() 
	return false
end

function purge_burn_mod:GetModifierMagicalResistanceBonus()
	return 500
end

function purge_burn_mod:EndProc(dmg_stack)
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_ShadowDemon.DemonicPurge.Damage", self:GetCaster() )
	local hAbility = self:GetAbility()
	local hTarget = self:GetParent()
		local enemies = FindUnitsInRadius( hTarget:GetTeamNumber(), hTarget:GetOrigin(), nil, hAbility:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		local dmg = hAbility:GetSpecialValueFor("damage")*dmg_stack
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsInvulnerable() ) then
				enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", { stacks = dmg })
				local nFXIndex = ParticleManager:CreateParticle( "particles/shadow_raze_gen/raze.vpcf", PATTACH_ABSORIGIN, hTarget )
				ParticleManager:SetParticleControl( nFXIndex, 0, enemy:GetAbsOrigin() )
				ParticleManager:SetParticleControl( nFXIndex, 15, Vector( 255, 150, 0 ) )
				ParticleManager:ReleaseParticleIndex(nFXIndex)
				--	local damage = {
				--		victim = enemy,
				--		attacker = self:GetCaster(),
				--		damage = hAbility:GetSpecialValueFor("damage")*stacks,
				--		damage_type = hAbility:GetAbilityDamageType(),
				--		ability = self:GetAbility()
				--	}
				--	ApplyDamage( damage )
				end
			end
		end
end
