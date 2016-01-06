if item_blessed_staff_modifier == nil then
	item_blessed_staff_modifier = class({})
end

function item_blessed_staff_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function item_blessed_staff_modifier:IsHidden()
	return true
end

function item_blessed_staff_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_blessed_staff_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_blessed_staff_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_blessed_staff_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end

function item_blessed_staff_modifier:OnAttackLanded(keys)
	if IsServer() then
		if self:GetAbility():IsCooldownReady() then
			if keys.attacker == self:GetParent() then
				if keys.target:IsBuilding() or keys.target:IsMagicImmune() then return end
				if RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("chance") then
					EmitSoundOn( "Hero_Tiny.CraggyExterior.Stun", keys.target )
					keys.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = self:GetAbility():GetSpecialValueFor("duration") } )
					self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
				end
			end
		end
	end
end