if item_maelstrom_ovf_mod == nil then
	item_maelstrom_ovf_mod = class({})
end

function item_maelstrom_ovf_mod:DeclareFunctions()
	local funcs = {-
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function item_maelstrom_ovf_mod:OnCreated()
	if IsServer() then
	local hAbility = self:GetAbility()
	self.JumpDelay = hAbility:GetSpecialValueFor("jump_delay")
	self.JumpCount = hAbility:GetSpecialValueFor("jump_count")
	self.JumpRadius = hAbility:GetSpecialValueFor("radius")
	self.iMDamage = hAbility:GetSpecialValueFor( "magic_damage" )
	self.JumpDamage = hAbility:GetSpecialValueFor( "damage" )
	self.JumpDmgType = hAbility:GetAbilityDamageType()
	self.InsProtect = hAbility.JumpCount --We use this so the chain lightning can't circle back.
	end
end

function item_maelstrom_ovf_mod:IsHidden()
	return true
end

function item_maelstrom_ovf_mod:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_maelstrom_ovf_mod:GetModifierPreAttack_BonusDamage()
	if self:GetAbility() then
	return self:GetAbility():GetSpecialValueFor("damage_bonus")
	else
	return 0
	end
end

function item_maelstrom_ovf_mod:OnAttackLanded(keys)
	if IsServer() then
		local hAbility = self:GetAbility()
		if keys.attacker == self:GetParent() then
		local hCaster = keys.attacker
			if keys.target:IsBuilding() or keys.target:IsMagicImmune() then return end
	
		
			local nFXIndex = ParticleManager:CreateParticle( hAbility.Effect, PATTACH_CUSTOMORIGIN, nil );
			ParticleManager:SetParticleControlEnt( nFXIndex, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_attack1", hCaster:GetOrigin() + Vector( 0, 0, 50 ), true );
			ParticleManager:SetParticleControlEnt( nFXIndex, 1, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetOrigin(), true );
			ParticleManager:ReleaseParticleIndex( nFXIndex );
			EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Zuus.ArcLightning.Cast", self:GetCaster() )
			keys.target:AddNewModifier( self:GetCaster(), hAbility, hAbility.MainMod, {
			duration = self.JumpDelay
			,jumps = self.JumpCount
			,radius = self.JumpRadius
			,dmg = self.JumpDamage
			,mdmg = self.iMDamage
			,dmgtype = self.JumpDmgType
			,instance = GameRules:GetGameTime()
			} )
		
		
		end
	end
end