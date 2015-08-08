if item_lua_blink_staff_blink_modifier == nil then
	item_lua_blink_staff_blink_modifier = class({})
end

--function item_lua_blink_staff_blink_modifier:DeclareFunctions()
--	local funcs = {
--		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
--	}
--	return funcs
--end

function item_lua_blink_staff_blink_modifier:OnCreated( kv )	
	
end

function item_lua_blink_staff_blink_modifier:IsHidden()
	return true
end

--function item_lua_blink_staff_blink_modifier:GetModifierPreAttack_BonusDamage( params )
--	return self.damageBonus
--end