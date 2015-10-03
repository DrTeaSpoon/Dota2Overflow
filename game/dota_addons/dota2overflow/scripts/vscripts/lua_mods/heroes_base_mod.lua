if heroes_base_mod == nil then
	heroes_base_mod = class({})
end

function heroes_base_mod:IsHidden()
	return true
end

function heroes_base_mod:OnCreated(kv)
	self.gain_agi = kv.gain_agi
	self.gain_str = kv.gain_str
	self.gain_int = kv.gain_int
end

function heroes_base_mod:GetAttributes() 
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end



function heroes_base_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
 
	return funcs
end

function heroes_base_mod:GetModifierBonusStats_Intellect() return self.gain_int * (self:GetParent():GetLevel()-1) end
function heroes_base_mod:GetModifierBonusStats_Agility()   return self.gain_agi * (self:GetParent():GetLevel()-1) end
function heroes_base_mod:GetModifierBonusStats_Strength()  return self.gain_str * (self:GetParent():GetLevel()-1) end