if dev_test_modifier == nil then
	dev_test_modifier = class({})
end



function dev_test_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_EVENT_ON_ATTACK 
	}
	return funcs
end

function dev_test_modifier:OnAttack(kv)
	if IsServer() then
		print("dev_test: Start")
		--DeepPrintTable(kv)
		self:GetParent():SetRangedProjectileName("particles/base_attacks/generic_projectile.vpcf") 
		print("dev_test: End")
	return 1
	end
end

function dev_test_modifier:IsHidden()
	return false
end

function dev_test_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function dev_test_modifier:AllowIllusionDuplicate() 
	return false
end

function dev_test_modifier:GetEffectName()
	return "particles/blink_staff.vpcf"
end
function dev_test_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW 
end

function dev_test_modifier:CheckState()
	local state = {
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
	return state
end