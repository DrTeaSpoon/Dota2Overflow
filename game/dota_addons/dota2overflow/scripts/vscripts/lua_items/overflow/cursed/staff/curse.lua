if item_cursed_staff_modifier_curse == nil then
	item_cursed_staff_modifier_curse = class({})
end

function item_cursed_staff_modifier_curse:OnCreated( kv )	
	if IsServer() then
	end
end
 

function item_cursed_staff_modifier_curse:OnDestroy()
	if IsServer() then
	end
end


function item_cursed_staff_modifier_curse:CheckState()
	local state = {
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_ATTACK_IMMUNE] = true
	}
	return state
end

 
function item_cursed_staff_modifier_curse:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function item_cursed_staff_modifier_curse:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_weak")
end

function item_cursed_staff_modifier_curse:IsHidden()
	return false
end

function item_cursed_staff_modifier_curse:IsPurgable() 
	return true
end

function item_cursed_staff_modifier_curse:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function item_cursed_staff_modifier_curse:AllowIllusionDuplicate() 
	return true
end

function item_cursed_staff_modifier_curse:GetEffectName()
	return "particles/items_fx/ghost.vpcf"
end
 
--------------------------------------------------------------------------------
 
function item_cursed_staff_modifier_curse:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function item_cursed_staff_modifier_curse:GetStatusEffectName()
	return "particles/status_fx/status_effect_ghost.vpcf"
end

--------------------------------------------------------------------------------

function item_cursed_staff_modifier_curse:StatusEffectPriority()
	return 1005
end
