if item_lua_blink_staff_stats_modifier == nil then
	item_lua_blink_staff_stats_modifier = class({})
end

function item_lua_blink_staff_stats_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function item_lua_blink_staff_stats_modifier:OnCreated( kv )	
	local hAbility = self:GetAbility()
	self.damageBonus = hAbility:GetSpecialValueFor( "bonus_damage" )
	self.speedBonus = hAbility:GetSpecialValueFor( "bonus_attack_speed" )
	self.intBonus = hAbility:GetSpecialValueFor( "bonus_mana_regen" )
	self.regenBonus = hAbility:GetSpecialValueFor( "bonus_int" )
end

function item_lua_blink_staff_stats_modifier:IsHidden()
	return true
end

function item_lua_blink_staff_stats_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damageBonus
end

function item_lua_blink_staff_stats_modifier:GetModifierBonusStats_Intellect( params )
	return self.intBonus
end

function item_lua_blink_staff_stats_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.speedBonus
end

function item_lua_blink_staff_stats_modifier:GetModifierPercentageManaRegen ( params )
	return self.regenBonus
end