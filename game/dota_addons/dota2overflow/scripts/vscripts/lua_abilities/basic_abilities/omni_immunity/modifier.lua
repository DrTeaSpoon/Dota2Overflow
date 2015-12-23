if omni_immunity_mod == nil then
	omni_immunity_mod = class({})
end

function omni_immunity_mod:CheckState()
	local state = {
	[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
	return state
end

function omni_immunity_mod:IsHidden()
	return false
end

function omni_immunity_mod:IsPurgable() 
	return true
end

function omni_immunity_mod:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function omni_immunity_mod:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end