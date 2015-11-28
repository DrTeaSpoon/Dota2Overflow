if overflow_rapier == nil then
	overflow_rapier = class({})
end

function overflow_rapier:DeclareFunctions()
	local funcs = {-
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
	return funcs
end

function overflow_rapier:OnCreated()
	if IsServer() then
		local hCaster = self:GetParent()
		if self:GetAbility() and hCaster:HasModifier("overflow_rapier") then
			
		end
	end
end

function overflow_rapier:OnDestroy()
	if IsServer() then
		local hCaster = self:GetParent()
		if not self:GetAbility() and hCaster:HasModifier("overflow_rapier") then
			local hUpgrade = hCaster:FindAbilityByName("item_overflow_rapier")
			hUpgrade:SetLevel(hUpgrade:GetLevel() + 1)
		end
	end
end

function overflow_rapier:IsHidden()
	return true
end

function overflow_rapier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function overflow_rapier:GetModifierPreAttack_BonusDamage()
	if self:GetAbility() then
	return self:GetAbility():GetSpecialValueFor("damage_bonus")
	else
	return 0
	end
end
function overflow_rapier:GetModifierDamageOutgoing_Percentage()
	if self:GetAbility() then
	return self:GetAbility():GetSpecialValueFor("damage_mult")
	else
	return 0
	end
end