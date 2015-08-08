if item_bug_staff_effect_modifier == nil then
	item_bug_staff_effect_modifier = class({})
end

--function item_bug_staff_effect_modifier:DeclareFunctions()
--	local funcs = {
--		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
--	}
--	return funcs
--end

function item_bug_staff_effect_modifier:OnCreated( kv )	
	if IsServer() then
			local nFXIndex = ParticleManager:CreateParticle("particles/generic_target_overhead_1.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
			ParticleManager:SetParticleControl( nFXIndex, 15, Vector(255,255,255))
			self:AddParticle( nFXIndex, false, false, -1, false, false )
	end
end


function item_bug_staff_effect_modifier:OnDestroy( kv )	
end

function item_bug_staff_effect_modifier:IsHidden()
	return false
end

--function item_bug_staff_effect_modifier:GetEffectName()
--	return "particles/blink_staff.vpcf"
--end
--
--function item_bug_staff_effect_modifier:GetEffectAttachType()
--	return PATTACH_OVERHEAD_FOLLOW
--end

--function item_bug_staff_effect_modifier:GetControlPoints()
--	local cp = {
--					[15] =	{100, 100, 250}
--	}
--	return cp
--end
--function item_bug_staff_effect_modifier:GetModifierPreAttack_BonusDamage( params )
--	return self.damageBonus
--end