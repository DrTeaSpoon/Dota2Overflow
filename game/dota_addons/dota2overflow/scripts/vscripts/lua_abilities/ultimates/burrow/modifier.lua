if ult_burrow_modifier == nil then
	ult_burrow_modifier = class({})
end

function ult_burrow_modifier:OnCreated( kv )	
	if IsServer() then
	end
end

function ult_burrow_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
MODIFIER_PROPERTY_MODEL_CHANGE,
MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function ult_burrow_modifier:GetModifierModelChange() return "models/heroes/nerubian_assassin/mound.vmdl" end
function ult_burrow_modifier:GetModifierIgnoreCastAngle() return 1 end
function ult_burrow_modifier:GetModifierTotalDamageOutgoing_Percentage() return self:GetAbility():GetSpecialValueFor("damage_out") end
function ult_burrow_modifier:GetModifierIncomingDamage_Percentage() return self:GetAbility():GetSpecialValueFor("damage_in") end

function ult_burrow_modifier:CheckState()
	local hAbility = self:GetAbility()
	local invis = false
	if self:GetElapsedTime() > hAbility:GetSpecialValueFor("fade_time") then invis = true end
	local state = {
	[MODIFIER_STATE_INVISIBLE] = invis,
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_DISARMED] = true
	}
	return state
end

function ult_burrow_modifier:IsHidden()
	return false
end

function ult_burrow_modifier:IsPurgable() 
	return false
end

function ult_burrow_modifier:IsPurgeException()
	return false
end

function ult_burrow_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function ult_burrow_modifier:AllowIllusionDuplicate() 
	return false
end

function ult_burrow_modifier:GetEffectName()
return "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_inground.vpcf"
end
--------------------------------------------------------------------------------
 
function ult_burrow_modifier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end