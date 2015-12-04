if wield_flame_mod == nil then
	wield_flame_mod = class({})
end

function wield_flame_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function wield_flame_mod:OnCreated(kv)
	if IsServer() then
		
		local armor =  self:GetParent():GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", {
            stacks = armor
        })
	end
end

function wield_flame_mod:IsHidden()
	return false
end

function wield_flame_mod:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("buff")
end

function wield_flame_mod:GetEffectName()
	return "particles/wield_flame.vpcf"
end

function wield_flame_mod:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end