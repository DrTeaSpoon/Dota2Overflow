if aura_speed_mod == nil then
	aura_speed_mod = class({})
end

function aura_speed_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
 
	return funcs
end

function aura_speed_mod:IsHidden()
	if self:GetCaster() ~= self:GetParent() and self:GetAbility():GetLevel() > 0 then
	return false
	else
	return true
	end
end

function aura_speed_mod:OnCreated( kv )
	if IsServer() then
		self.aura_radius = self:GetAbility():GetSpecialValueFor("radius")
	end
end

function aura_speed_mod:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed")
end
function aura_speed_mod:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("move_speed")
end


---AURA?!?!

--------------------------------------------------------------------------------

function aura_speed_mod:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end

--------------------------------------------------------------------------------

function aura_speed_mod:GetModifierAura()
	return "aura_speed_mod"
end

--------------------------------------------------------------------------------

function aura_speed_mod:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function aura_speed_mod:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function aura_speed_mod:GetAuraRadius()
	return self.aura_radius
end
