if react_arm_mod == nil then
	react_arm_mod = class({})
end

function react_arm_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONU
	}
 
	return funcs
end

function react_arm_mod:IsHidden()
	return ( self:GetStackCount() == 0 )
end

function react_arm_mod:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 5 )
	end
end

function react_arm_mod:OnIntervalThink()
	if IsServer() then
		if self:GetStackCount() > 0 then
			self:DecrementStackCount()
		end
	end
end

function react_arm_mod:OnTakeDamage(keys)
	if IsServer() then
		if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max") then
			if keys.attacker ~= self:GetParent() and keys.unit == self:GetParent() and  keys.attacker:IsHero()  then
				self:IncrementStackCount()
			end
		end
	end
end

function react_arm_mod:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("p_bonus")
end

function react_arm_mod:GetModifierMagicalResistanceBonus()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("m_bonus")
end