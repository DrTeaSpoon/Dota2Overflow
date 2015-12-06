if hex_6_gon_effect_modifier == nil then
	hex_6_gon_effect_modifier = class({})
end

function hex_6_gon_effect_modifier:OnCreated( kv )	
	if IsServer() then
		self.model = kv.model
	end
end

function hex_6_gon_effect_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MODEL_CHANGE,
MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
MODIFIER_PROPERTY_MOVESPEED_MAX
	}
 
	return funcs
end

function hex_6_gon_effect_modifier:GetModifierModelChange ()
	return self.model
end

function hex_6_gon_effect_modifier:CheckState()
	local state = {
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_MUTED] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_PASSIVES_DISABLED] = true
	}
	return state
end

function hex_6_gon_effect_modifier:IsHidden()
	return false
end

function hex_6_gon_effect_modifier:IsPurgable() 
	return true
end

function hex_6_gon_effect_modifier:GetModifierMoveSpeedOverride() return self:GetAbility():GetSpecialValueFor("move_speed") end
function hex_6_gon_effect_modifier:GetModifierMoveSpeedMax() return self:GetAbility():GetSpecialValueFor("move_speed") end