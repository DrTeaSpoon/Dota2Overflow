if double_step_modifier == nil then
	double_step_modifier = class({})
end

function double_step_modifier:OnCreated( kv )	
	if IsServer() then
	ProjectileManager:ProjectileDodge(self:GetCaster())
	end
end

function double_step_modifier:OnDestroy()
	if IsServer() then
	ProjectileManager:ProjectileDodge(self:GetCaster())
	end
end

function double_step_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
MODIFIER_PROPERTY_MOVESPEED_MAX
	}
	return funcs
end

function double_step_modifier:GetModifierMoveSpeedBonus_Constant() return self:GetAbility():GetSpecialValueFor("speed") end
function double_step_modifier:GetModifierMoveSpeed_Max()
	return self:GetAbility():GetSpecialValueFor("max")
end

function double_step_modifier:IsHidden()
	return false
end

function double_step_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function double_step_modifier:AllowIllusionDuplicate() 
	return false
end


function double_step_modifier:GetEffectName()
	return "particles/run_ghost.vpcf"
end

function double_step_modifier:CheckState()
	local state = {
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_MAGIC_IMMUNE] = true
	}
	return state
end
--------------------------------------------------------------------------------
 
function double_step_modifier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end



