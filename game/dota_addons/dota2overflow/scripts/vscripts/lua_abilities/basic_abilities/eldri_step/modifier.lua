if eldri_step_modifier == nil then
	eldri_step_modifier = class({})
end

function eldri_step_modifier:OnCreated( kv )	
	if IsServer() then
	ProjectileManager:ProjectileDodge(self:GetCaster())
	end
end

function eldri_step_modifier:OnDestroy()
	if IsServer() then
	ProjectileManager:ProjectileDodge(self:GetCaster())
	end
end

function eldri_step_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
MODIFIER_PROPERTY_MOVESPEED_MAX
	}
	return funcs
end

function eldri_step_modifier:GetModifierMoveSpeedBonus_Constant()
local nElder = self:GetParent():FindModifierByName("book_eldri_modifier"):GetStackCount()
	if self:GetParent():HasModifier("element_water") then nElder = nElder*2 end
 return self:GetAbility():GetSpecialValueFor("speed")*nElder
end
function eldri_step_modifier:GetModifierMoveSpeed_Max()
	return self:GetAbility():GetSpecialValueFor("max")
end

function eldri_step_modifier:IsHidden()
	return false
end

function eldri_step_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function eldri_step_modifier:AllowIllusionDuplicate() 
	return false
end


function eldri_step_modifier:GetEffectName()
	return "particles/run_ghost.vpcf"
end

function eldri_step_modifier:CheckState()
	local state = {
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_MAGIC_IMMUNE] = true
	}
	return state
end
--------------------------------------------------------------------------------
 
function eldri_step_modifier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end



