if heroes_base_mod == nil then
	heroes_base_mod = class({})
end

function heroes_base_mod:IsHidden()
	return true
end

function heroes_base_mod:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MOVESPEED_MAX
	}
 
	return funcs
end

function heroes_base_mod:GetModifierMoveSpeed_Max()
	return 90000
end

function heroes_base_mod:CheckState()
	local state = {
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
 
	return state
end

function heroes_base_mod:GetAttributes() 
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end