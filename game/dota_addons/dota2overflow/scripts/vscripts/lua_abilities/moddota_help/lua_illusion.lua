if modifer_lua_illusion == nil then
	modifer_lua_illusion = class({})
end

function modifer_lua_illusion:OnCreated( kv )	
	if IsServer() then
		local hTarget = self:GetParent()
	end
end

--function GetStatusEffectName()
--		return "particles/status_test/status_effect_test.vpcf"
--end

function modifer_lua_illusion:IsHidden()
	return true
end

function modifer_lua_illusion:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_IS_ILLUSION,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
 
	return funcs
end

function modifer_lua_illusion:GetModifierIncomingDamage_Percentage()
	return 300
end

function modifer_lua_illusion:GetModifierDamageOutgoing_Percentage_Illusion()
	return 20
end

function modifer_lua_illusion:GetIsIllusion()
	return true
end

function modifer_lua_illusion:OnDestroy()
	self:GetParent():Kill()
end
