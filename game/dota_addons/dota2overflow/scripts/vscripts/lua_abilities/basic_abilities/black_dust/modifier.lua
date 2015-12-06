if black_dust_mod == nil then
	black_dust_mod = class({})
end

function black_dust_mod:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE
	}
 
	return funcs
end

function black_dust_mod:CheckState()
	local state = {
	[MODIFIER_STATE_BLIND] = true
	}
	return state
end


function black_dust_mod:IsHidden()
	return false
end
function black_dust_mod:IsPurgable() 
	return true
end

function black_dust_mod:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("slow")
end

function black_dust_mod:GetEffectName()
	return "particles/black_dust_debuff.vpcf"
end
function black_dust_mod:GetBonusVisionPercentage() return -100 end
--------------------------------------------------------------------------------
 
function black_dust_mod:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
