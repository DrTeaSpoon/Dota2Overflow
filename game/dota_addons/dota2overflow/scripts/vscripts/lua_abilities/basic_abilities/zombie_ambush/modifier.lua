if zombie_ambush_modifier == nil then
	zombie_ambush_modifier = class({})
end

function zombie_ambush_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function zombie_ambush_modifier:GetEffectName()
	return "particles/items_fx/ghost.vpcf"
end
 
--------------------------------------------------------------------------------
 
function zombie_ambush_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end


function zombie_ambush_modifier:CheckState()
	local state = {
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_DOMINATED] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	[MODIFIER_STATE_FLYING] = true
	}
 
	return state
end

function zombie_ambush_modifier:OnCreated( kv )	
end

function zombie_ambush_modifier:IsHidden()
	return false
end

function zombie_ambush_modifier:OnDestroy()
	if IsServer() then
	local hTarget = self:GetParent()
	local vPoint = hTarget:GetAbsOrigin()
	GridNav:DestroyTreesAroundPoint(vPoint, 5, true) 
	end
end

function zombie_ambush_modifier:GetModifierPreAttack_BonusDamage( params )
	return self:GetAbility():GetSpecialValueFor("zombie_damage")
end

function zombie_ambush_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end