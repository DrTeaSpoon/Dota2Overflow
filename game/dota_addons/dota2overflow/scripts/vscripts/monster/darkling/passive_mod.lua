if darkling_passive_mod == nil then
	darkling_passive_mod = class({})
end

function darkling_passive_mod:OnCreated( kv )	
	if IsServer() then
	end
end



function darkling_passive_mod:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MOVESPEED_MAX,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_MODEL_CHANGE,
	MODIFIER_PROPERTY_MODEL_SCALE
	}
 
	return funcs
end

function darkling_passive_mod:GetModifierMoveSpeed_Max()
	return 10000
end

function darkling_passive_mod:GetModifierMoveSpeedBonus_Percentage ()
	return self:GetAbility():GetSpecialValueFor("speed_bonus")
end

function darkling_passive_mod:IsHidden()
	return true
end

function darkling_passive_mod:GetModifierModelChange()
	return "models/heroes/spectre/spectre.vmdl"
end

function darkling_passive_mod:GetModifierModelScale()
	return 0.5
end