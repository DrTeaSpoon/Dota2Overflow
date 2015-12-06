if grow_beard_mod == nil then
	grow_beard_mod = class({})
end

function grow_beard_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
	return funcs
end

function grow_beard_mod:OnCreated()
	if IsServer() then
		self.seconds = 0
		self:SetStackCount(0)
		self:StartIntervalThink( 1 )
	end
end
function grow_beard_mod:IsPurgable() 
	return false
end


function grow_beard_mod:OnIntervalThink()
	if IsServer() then
	if self:GetAbility():GetLevel() > 0  and self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max") then
		self.seconds = self.seconds +1
		if self.seconds > self:GetAbility():GetSpecialValueFor("grow_time") then
		self.seconds = 0
		self:IncrementStackCount()
		end
	end
	end
end

function grow_beard_mod:IsHidden()
	if self:GetAbility():GetLevel() > 0 and self:GetStackCount() > 0 then
	return false
	end
	return true
end

function grow_beard_mod:GetModifierMoveSpeedBonus_Percentage()
	if self:GetAbility():GetLevel() > 0 then
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("speed")
	end
end
function grow_beard_mod:GetModifierTotal_ConstantBlock()
	if self:GetAbility():GetLevel() > 0 then
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("block")
	end
end
	
function grow_beard_mod:OnTooltip()
	if self:GetAbility():GetLevel() > 0 then
	return self:GetStackCount() * self:GetStackCount() * self:GetAbility():GetSpecialValueFor("gold")
	end
end