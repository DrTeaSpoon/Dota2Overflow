if illusion_lua_modifier == nil then
	illusion_lua_modifier = class({})
end

function illusion_lua_modifier:OnCreated( kv )	
	if IsServer() then
	end
end
 
function illusion_lua_modifier:IsHidden()
	return false
end

function illusion_lua_modifier:OnDestroy()
	if IsServer() then
	end
end

function illusion_lua_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,
MODIFIER_PROPERTY_ILLUSION_LABEL,
MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
MODIFIER_PROPERTY_IS_ILLUSION
	}
 
	return funcs
end

function illusion_lua_modifier:GetModifierDamageOutgoing_Percentage_Illusion()
return 100
end
function illusion_lua_modifier:GetModifierIllusionLabel()
return 1
end
function illusion_lua_modifier:GetModifierIncomingDamage_Percentage()
return 100
end
function illusion_lua_modifier:GetIsIllusion()
return true
end